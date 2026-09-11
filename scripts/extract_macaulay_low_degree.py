#!/usr/bin/env python3
"""A18-style relation extraction on an exact backup Macaulay span.

Eliminate high monomials only, keeping low-degree polynomial consequences.
Each published consequence has a row-DAG witness for independent replay.
"""
import argparse
import hashlib
import heapq
import json
import pickle
import time
from pathlib import Path
from sage.all import GF,PolynomialRing

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('peeling',type=Path)
p.add_argument('out',type=Path);p.add_argument('--degree',type=int,default=2)
p.add_argument('--seconds',type=float,default=60)
p.add_argument('--max-nonzeros',type=int,default=2000000)
p.add_argument('--certificates',type=int,default=3,
               help='Maximum saved consequence witnesses; zero saves every new relation')
p.add_argument('--consequence-form',choices=['raw','echelon','sparsest'],default='raw')
p.add_argument('--engine',choices=['python','cython'],default='python')
p.add_argument('--pivot-rule',choices=['column','markowitz'],default='column')
p.add_argument('--pivot-window',type=int,default=24,
               help='Number of low-incidence columns inspected by the fill-in-aware rule')
p.add_argument('--resume',type=Path,
               help='Trusted local checkpoint written by this script, never an external pickle')
p.add_argument('--save-checkpoint',action='store_true',
               help='Also retain the exact row DAG after a completed pass for later certificates')
p.add_argument('--pivot-limit',type=int,default=0,
               help='Optional deterministic profiling checkpoint after this many additional pivots')
p.add_argument('--sample-window',type=int,default=0,
               help='Report separate row-loop timings every this many additional pivots')
p.add_argument('--low-provenance',choices=['expanded','dag'],default='expanded',
               help='Track low-row operations lazily instead of expanding every dependent witness')
args=p.parse_args();args.out.mkdir(exist_ok=False)
start=time.monotonic();raw=args.source.read_bytes();data=json.loads(raw)
peel=json.loads(args.peeling.read_text());assert peel['preserve_degree']==args.degree
P=PolynomialRing(GF(5),'z');K=GF(5**data['field_degree'],'a',modulus=P(data['field_modulus']))
monomials=[tuple(e) for e in data['monomials']];indices={e:i for i,e in enumerate(monomials)}
protected={i for i,e in enumerate(monomials) if sum(e)<=args.degree}
equations=[[(tuple(e),K(c)) for e,c in f] for f in data['equations']]
all_rows=[]
for m in data['multipliers']:
    for f in equations:
        all_rows.append({indices[tuple(a+b for a,b in zip(e,m))]:c for e,c in f})
rows={i:dict(all_rows[i]) for i in peel['remaining_row_indices']}
low={i:rows.pop(i) for i in list(rows) if set(rows[i])<=protected}
operations=[];npivots=updates=0;previous_seconds=0.0
if args.resume:
    with args.resume.open('rb') as stream:checkpoint=pickle.load(stream)
    assert checkpoint['source_sha256']==hashlib.sha256(raw).hexdigest()
    assert checkpoint['degree']==args.degree and checkpoint['pivot_rule']==args.pivot_rule
    assert checkpoint['pivot_window']==args.pivot_window
    rows=checkpoint['rows'];low=checkpoint['low'];operations=checkpoint['operations']
    npivots=checkpoint['pivots'];updates=checkpoint['updates']
    previous_seconds=checkpoint['cumulative_elimination_seconds']
    assert all(c.parent() is K for row in rows.values() for c in row.values())
    print(json.dumps(dict(stage='trusted_checkpoint_resumed',pivots=npivots,updates=updates,
        high_rows=len(rows),low_rows=len(low),prior_seconds=previous_seconds)),flush=True)
columns=[set() for _ in monomials]
for i,row in rows.items():
    for j in row:columns[j].add(i)
heap=[(len(c),j) for j,c in enumerate(columns) if c and j not in protected];heapq.heapify(heap)
nnz=sum(map(len,rows.values()));lastreport=start
status='complete'
initial_pivots=npivots;initial_updates=updates
trace_stream=(args.out/'progress.jsonl').open('w')
def record(event):
    trace_stream.write(json.dumps(event,separators=(',',':'))+'\n');trace_stream.flush()
    print(json.dumps(event),flush=True)
def state_event(stage):
    return dict(stage=stage,pivots=npivots,updates=updates,
        high_rows=len(rows),high_columns=sum(bool(c) for j,c in enumerate(columns) if j not in protected),
        high_nonzeros=sum(len(c) for j,c in enumerate(columns) if j not in protected),
        nonzeros=nnz,low_rows=len(low),seconds=time.monotonic()-start)
initial_state=state_event('elimination_start');record(initial_state)
row_loop_started=time.monotonic()
if args.engine=='cython':
    assert args.pivot_rule=='column','Compiled kernel implements only the validated column pivot rule'
    import importlib,pyximport,tempfile
    compile_started=time.monotonic()
    # This kernel has no Sage C-library dependency. Sage's cython() helper
    # unnecessarily probes every optional library (including fflas-ffpack).
    # Build the ordinary CPython extension instead; coefficients remain the
    # very same exact Sage field objects supplied by the caller.
    pyximport.install(language_level=3,build_dir=str(Path(tempfile.gettempdir())/'litt3-macaulay-pyx'))
    kernel=importlib.import_module('macaulay_sparse_kernel')
    compiled_seconds=time.monotonic()-compile_started
    # Compilation is a one-off cost, not part of the row-loop budget.
    start+=compiled_seconds
    print(json.dumps(dict(stage='compiled_kernel_ready',seconds=compiled_seconds)),flush=True)
    def compiled_record(event):
        event['pivots']+=initial_pivots;event['updates']+=initial_updates;record(event)
    row_loop_started=time.monotonic()
    status,new_pivots,new_updates,nnz,new_operations=kernel.eliminate(rows,low,columns,heap,protected,
        K,args.seconds,start,args.max_nonzeros,compiled_record,args.pivot_limit,args.sample_window)
    npivots+=new_pivots;updates+=new_updates;operations.extend(new_operations)
while rows and args.engine=='python':
    if time.monotonic()-row_loop_started>args.seconds or nnz>args.max_nonzeros or (args.pivot_limit and npivots-initial_pivots>=args.pivot_limit):
        status='bounded_partial';break
    candidates=[];seen_columns=set()
    window=1 if args.pivot_rule=='column' else args.pivot_window
    while heap and len(candidates)<window:
        count,j=heapq.heappop(heap)
        if not count or count!=len(columns[j]) or j in seen_columns:continue
        seen_columns.add(j)
        i=min(columns[j],key=lambda r:(len(rows[r]),r))
        candidates.append((count,j,i))
    if not candidates:break
    if args.pivot_rule=='column':count,j,i=candidates[0]
    else:
        count,j,i=min(candidates,key=lambda t:
            ((t[0]-1)*(len(rows[t[2]])-1),len(rows[t[2]]),t[0],t[1],t[2]))
    for other_count,other_j,other_i in candidates:
        if other_j!=j:heapq.heappush(heap,(other_count,other_j))
    original=rows.pop(i);scale=original[j]**(-1)
    pivot={q:c*scale for q,c in original.items() if q!=j};npivots+=1;nnz-=len(original)
    for q in original:columns[q].remove(i)
    touched=set(original)
    for r in list(columns[j]):
        row=rows[r];factor=row.pop(j);columns[j].remove(r);nnz-=1
        operations.append((r,i,factor*scale))
        for q,c in pivot.items():
            before=row.get(q,K.zero());after=before-factor*c;updates+=1
            if after:
                row[q]=after
                if not before:columns[q].add(r);nnz+=1
            elif before:del row[q];columns[q].remove(r);nnz-=1
            touched.add(q)
        if not row:del rows[r]
        elif set(row)<=protected:
            low[r]=rows.pop(r);nnz-=len(row)
            for q in row:columns[q].remove(r)
    for q in touched:
        if q not in protected and columns[q]:heapq.heappush(heap,(len(columns[q]),q))
    if len(heap)>4*len(columns):
        heap=[(len(c),j) for j,c in enumerate(columns) if c and j not in protected];heapq.heapify(heap)
    if time.monotonic()-lastreport>5:
        record(state_event('extract'));lastreport=time.monotonic()

row_loop_seconds=time.monotonic()-row_loop_started
elimination_seconds=time.monotonic()-start
ending_state=state_event('elimination_'+status)
record(ending_state);trace_stream.close()
checkpoint_seconds=0.0
if status=='bounded_partial' or args.save_checkpoint:
    checkpoint=dict(source_sha256=hashlib.sha256(raw).hexdigest(),degree=args.degree,
        pivot_rule=args.pivot_rule,pivot_window=args.pivot_window,rows=rows,low=low,
        operations=operations,pivots=npivots,updates=updates,
        cumulative_elimination_seconds=previous_seconds+elimination_seconds)
    checkpoint_started=time.monotonic()
    with (args.out/'checkpoint.pickle').open('wb') as stream:
        pickle.dump(checkpoint,stream,protocol=pickle.HIGHEST_PROTOCOL)
    checkpoint_seconds=time.monotonic()-checkpoint_started
    print(json.dumps(dict(stage='trusted_local_checkpoint_saved',
        bytes=(args.out/'checkpoint.pickle').stat().st_size,
        seconds=checkpoint_seconds)),flush=True)

# Exact sparse low-column elimination tests whether a consequence is new
# relative to ALL original low-degree rows in this same multiplier span.
span={};span_weights={};low_operations=[];span_owner={};span_scale={}
def adjoin(row,row_id):
    row=dict(row)
    weights={row_id:K.one()} if args.low_provenance=='expanded' else None
    while row:
        j=max(row)
        if j not in span:
            c=row[j]**(-1);span[j]={q:a*c for q,a in row.items()}
            span_owner[j]=row_id;span_scale[j]=c
            if weights is not None:span_weights[j]={q:a*c for q,a in weights.items()}
            return j
        factor=row[j]
        if weights is None:low_operations.append((row_id,span_owner[j],factor*span_scale[j]))
        for q,c in span[j].items():
            value=row.get(q,K.zero())-factor*c
            if value:row[q]=value
            elif q in row:del row[q]
        if weights is not None:
            for q,c in span_weights[j].items():
                value=weights.get(q,K.zero())-factor*c
                if value:weights[q]=value
                elif q in weights:del weights[q]
    return None
for i,row in enumerate(all_rows):
    if set(row)<=protected:adjoin(row,i)
old_rank=len(span);selected=[];new_pivots={}
for r,row in sorted(low.items(),key=lambda pair:(len(pair[1]),pair[0])):
    # These source rows were already adjoined above. A DAG identifier must
    # represent one row history, not a second reduction of the same row.
    if args.low_provenance=='dag' and set(all_rows[r])<=protected:continue
    inserted=adjoin(row,r)
    if inserted is not None:selected.append(r);new_pivots[r]=inserted

saved=selected[:args.certificates] if args.certificates else selected
def pivot_weights(j):
    if args.low_provenance=='expanded':return span_weights[j]
    result={span_owner[j]:span_scale[j]}
    for changed,pivot_row,factor in reversed(low_operations):
        if changed in result:
            value=result.get(pivot_row,K.zero())-factor*result[changed]
            if value:result[pivot_row]=value
            elif pivot_row in result:del result[pivot_row]
    return result
def write_certificate(name,weights,expected):
    coefficients=dict(weights)
    for changed,pivot_row,factor in reversed(operations):
        if changed in coefficients:
            value=coefficients.get(pivot_row,K.zero())-factor*coefficients[changed]
            if value:coefficients[pivot_row]=value
            elif pivot_row in coefficients:del coefficients[pivot_row]
    check={}
    for row,c in coefficients.items():
        for j,a in all_rows[row].items():check[j]=check.get(j,K.zero())+c*a
    check={j:c for j,c in check.items() if c};assert check==expected
    encode=lambda c:[int(v) for v in c.polynomial().list()]
    cert=dict(source=str(args.source.resolve()),source_sha256=hashlib.sha256(raw).hexdigest(),
        coefficients=[[i,encode(c)] for i,c in sorted(coefficients.items())],
        polynomial=[[list(monomials[j]),encode(c)] for j,c in sorted(expected.items())],
        scope='Exact polynomial consequence, not a unit or cover exclusion')
    (args.out/name).write_text(json.dumps(cert,separators=(',',':'))+'\n')
use_raw={r:args.consequence_form=='raw' or (args.consequence_form=='sparsest'
         and len(low[r])<=len(span[new_pivots[r]])) for r in saved}
for number,r in enumerate(saved):
    if use_raw[r]:
        write_certificate('consequence%d.json'%number,{r:K.one()},low[r])
    else:
        j=new_pivots[r]
        write_certificate('consequence%d.json'%number,pivot_weights(j),span[j])
constant=indices[(0,)*len(data['variables'])]
unit=constant in span and span[constant]=={constant:K.one()}
if unit:write_certificate('unit.json',pivot_weights(constant),{constant:K.one()})
result=dict(status=status,engine=args.engine,low_provenance=args.low_provenance,degree=args.degree,pivot_rule=args.pivot_rule,
    pivot_window=args.pivot_window,pivots=npivots,updates=updates,
    remaining_rows=len(rows),nonzeros=nnz,low_rows=len(low),
    original_low_rank=old_rank,final_low_rank=len(span),new_independent_consequences=len(selected),
    saved_consequence_terms=[len(low[r]) if use_raw[r] else len(span[new_pivots[r]]) for r in saved],
    saved_forms=['raw' if use_raw[r] else 'echelon' for r in saved],
    raw_consequence_terms=[len(low[r]) for r in saved],consequence_form=args.consequence_form,
    unit_candidate=unit,seconds=time.monotonic()-start,
    elimination_seconds=elimination_seconds,
    row_loop_seconds=row_loop_seconds,setup_seconds=elimination_seconds-row_loop_seconds,
    checkpoint_seconds=checkpoint_seconds,
    sampled_pivots=npivots-initial_pivots,
    initial_high_columns=initial_state['high_columns'],final_high_columns=ending_state['high_columns'],
    cumulative_elimination_seconds=previous_seconds+elimination_seconds,
    resumed_from=str(args.resume.resolve()) if args.resume else None)
(args.out/'result.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2),flush=True)
