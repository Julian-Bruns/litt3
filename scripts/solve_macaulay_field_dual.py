#!/usr/bin/env python3
"""Sparse original-field elimination for one bounded Macaulay ansatz.

Run with sage -python. A dual is converted to original expanded F5
coordinates and must be independently replayed. A target-only row
produces a polynomial-combination candidate from the row-operation DAG;
that candidate also requires independent original-polynomial replay.
"""
import argparse
import heapq
import hashlib
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source',type=Path)
    parser.add_argument('peeling',type=Path)
    parser.add_argument('out',type=Path)
    parser.add_argument('--seconds',type=float,default=60)
    parser.add_argument('--max-nonzeros',type=int,default=2000000)
    args=parser.parse_args();args.out.mkdir(exist_ok=False)
    start=time.monotonic()
    data=json.loads(args.source.read_text());peel=json.loads(args.peeling.read_text())
    d=data['field_degree'];R=PolynomialRing(GF(5),'z')
    K=GF(5**d,name='a',modulus=R(data['field_modulus']))
    powers=[K.gen()**j for j in range(2*d-1)]
    monomials=[tuple(m) for m in data['monomials']]
    index={m:i for i,m in enumerate(monomials)};target=index[(0,)*len(data['variables'])]
    equations=[[(tuple(e),K(c)) for e,c in f] for f in data['equations']]
    all_rows=[]
    for mult in data['multipliers']:
        for f in equations:
            row={index[tuple(a+b for a,b in zip(e,mult))]:c for e,c in f}
            assert all(row.values())
            all_rows.append(row)
    rows={i:dict(all_rows[i]) for i in peel['remaining_row_indices']}
    columns=[set() for _ in monomials]
    for i,row in rows.items():
        for j in row:columns[j].add(i)
    heap=[(len(col),j) for j,col in enumerate(columns) if col and j!=target]
    heapq.heapify(heap);pivots=[];operations=[];nnz=sum(map(len,rows.values()));updates=0
    def report(stage,**kwargs):
        event=dict(stage=stage,pivots=len(pivots),rows=len(rows),nonzeros=nnz,
            updates=updates,seconds=time.monotonic()-start,**kwargs)
        print(json.dumps(event),flush=True)
        return event
    status='time_limit_inconclusive'
    while rows:
        if time.monotonic()-start>args.seconds or nnz>args.max_nonzeros:break
        while heap:
            count,j=heapq.heappop(heap)
            if count and count==len(columns[j]):break
        else:
            status='target_only_row_candidate' if columns[target] else 'dual_found'
            break
        i=min(columns[j],key=lambda r:len(rows[r]))
        original=rows.pop(i);scale=original[j]**(-1)
        pivot={q:c*scale for q,c in original.items() if q!=j}
        pivots.append((j,pivot));nnz-=len(original)
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
                elif before:
                    del row[q];columns[q].remove(r);nnz-=1
                touched.add(q)
            if not row:del rows[r]
            elif len(row)==1 and target in row:
                status='target_only_row_candidate'
                coefficients={r:row[target]**(-1)}
                for changed,pivot_row,factor in reversed(operations):
                    if changed in coefficients:
                        value=coefficients.get(pivot_row,K.zero())-factor*coefficients[changed]
                        if value:coefficients[pivot_row]=value
                        elif pivot_row in coefficients:del coefficients[pivot_row]
                check={}
                for index,c in coefficients.items():
                    for q,a in all_rows[index].items():
                        check[q]=check.get(q,K.zero())+c*a
                assert check[target]==1 and all(q==target or not a for q,a in check.items())
                certificate=dict(scope='Bounded polynomial unit candidate requiring independent field arithmetic replay',
                    source=str(args.source.resolve()),
                    source_sha256=hashlib.sha256(args.source.read_bytes()).hexdigest(),
                    coefficients=[[int(index),[int(v) for v in c.polynomial().list()]]
                                  for index,c in sorted(coefficients.items())])
                with (args.out/'primal.json').open('x') as stream:json.dump(certificate,stream,separators=(',',':'))
                event=report('original_field_primal_constructed',candidate_row=r,coefficient_count=len(coefficients))
                (args.out/'result.json').write_text(json.dumps(event,indent=2)+'\n')
                return
        for q in touched:
            if q!=target and columns[q]:heapq.heappush(heap,(len(columns[q]),q))
        if len(heap)>4*len(columns):
            heap=[(len(col),q) for q,col in enumerate(columns) if col and q!=target];heapq.heapify(heap)
        if len(pivots)%100==0:report('elimination')
    else:status='dual_found'
    if status!='dual_found':
        event=report(status)
        (args.out/'result.json').write_text(json.dumps(event,indent=2)+'\n');return
    gamma=[K.zero() for _ in monomials];gamma[target]=K.one()
    for j,pivot in reversed(pivots):gamma[j]=-sum((c*gamma[q] for q,c in pivot.items()),K.zero())
    # Restore the original FIELD rows, not just their expanded scalar support.
    for i,j in reversed(peel['peeling_order']):
        row=all_rows[i]
        gamma[j]=-sum((c*gamma[q] for q,c in row.items() if q!=j),K.zero())/row[j]
    assert gamma[target]==1
    for i,row in enumerate(all_rows):
        assert sum((c*gamma[q] for q,c in row.items()),K.zero())==0,('field dual',i)
    trace=[int(a.trace()) for a in powers]
    theta=next(powers[i]/K(trace[i]) for i in range(d) if trace[i])
    assert theta.trace()==1
    gamma=[theta*a for a in gamma]
    out=bytearray(data['columns']);cache={K.zero():bytes(d)}
    def swap(j):
        t=data['original_target_column'];last=len(out)-1
        return last if j==t else t if j==last else j
    for m,a in enumerate(gamma):
        if a not in cache:
            coeff=[int(c) for c in a.polynomial().list()];coeff += [0]*(d-len(coeff))
            cache[a]=bytes(sum(coeff[i]*trace[i+j] for i in range(d))%5 for j in range(d))
        for j,c in enumerate(cache[a]):out[swap(m*d+j)]=c
    assert out[-1]==1
    with (args.out/'dual.bin').open('xb') as f:f.write(out)
    event=report('original_field_dual_constructed',field_rows_checked=len(all_rows),
        expanded_columns=len(out),scope='Candidate requires independent original expanded-matrix replay')
    (args.out/'result.json').write_text(json.dumps(event,indent=2)+'\n')


if __name__=='__main__':main()
