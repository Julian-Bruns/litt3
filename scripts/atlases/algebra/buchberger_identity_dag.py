#!/usr/bin/env python3
"""Bounded Buchberger search with short local identities, not expanded lifts.

All emitted rows have a sparse polynomial identity in prior rows. A unit
is only accepted after a separate standard-library replay of this DAG.
"""
import argparse,hashlib,heapq,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('out',type=Path)
p.add_argument('--seconds',type=int,default=180)
p.add_argument('--max-nodes',type=int,default=2000)
p.add_argument('--chain-criterion',action='store_true')
args=p.parse_args();args.out.mkdir(exist_ok=False);raw=args.source.read_bytes();data=json.loads(raw)
K=GF(5**data['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(data['field_modulus']))
R=PolynomialRing(K,data['variables'],order='degrevlex')
decode=lambda f:R({tuple(e):K(c) for e,c in f})
encode=lambda f:[[list(e),list(map(int,c.polynomial().list()))] for e,c in f.dict().items()]
source=list(map(decode,data['equations']));allrows=list(source);basis=[];nodes=[];pairs=[]
start=time.monotonic();ops=0;processed=0;status='running';unit_index=None
standard_pairs=set();lead_data={};chain_skips=0
def known_standard(i,j):
    if tuple(sorted((i,j))) in standard_pairs:return True
    return all(min(x,y)==0 for x,y in zip(lead_data[i],lead_data[j]))
def addweight(weights,i,f):
    g=weights.get(i,R.zero())+f
    if g:weights[i]=g
    else:weights.pop(i,None)
def normal(f):
    global ops
    remains=f;rest=R.zero();quot={}
    divisors=sorted(basis,key=lambda t:len(allrows[t[0]].dict()))
    while remains:
        e=tuple(remains.lm().exponents()[0]);c=remains.lc()
        for i,be,bc in divisors:
            if all(x>=y for x,y in zip(e,be)):
                q=R({tuple(x-y for x,y in zip(e,be)):c/bc})
                addweight(quot,i,q);remains-=q*allrows[i];break
        else:
            term=R({e:c});rest+=term;remains-=term
        ops+=1
    return rest,quot
def append(f,weights):
    global unit_index
    if not f:return
    c=f.lc();f=f/c;weights={i:g/c for i,g in weights.items() if g}
    assert f==sum(g*allrows[i] for i,g in weights.items())
    index=len(allrows);allrows.append(f)
    nodes.append(dict(polynomial=encode(f),weights=[[i,encode(g)] for i,g in sorted(weights.items())]))
    e=tuple(f.lm().exponents()[0])
    for j,je,jc in basis:
        lcm=tuple(max(x,y) for x,y in zip(e,je))
        # Buchberger's product criterion; no chain criterion is assumed.
        if all(min(x,y)==0 for x,y in zip(e,je)):continue
        heapq.heappush(pairs,(sum(lcm),len(f.dict())+len(allrows[j].dict()),j,index,lcm))
    basis.append((index,e,K.one()))
    lead_data[index]=e
    if f==1:unit_index=index
def save():
    payload={key:data[key] for key in ('prime','field_degree','field_modulus','variables')}
    payload.update(source=str(args.source.resolve()),source_sha256=hashlib.sha256(raw).hexdigest(),
        nodes=nodes,unit_index=unit_index,status=status,
        scope='Local identity DAG; separate exact replay required; incomplete search gives no verdict')
    (args.out/'dag.json').write_text(json.dumps(payload,separators=(',',':'))+'\n')
    report=dict(status=status,basis_rows=len(basis),nodes=len(nodes),pending_pairs=len(pairs),
                processed_pairs=processed,chain_skips=chain_skips,division_steps=ops,seconds=time.monotonic()-start,unit_index=unit_index)
    (args.out/'result.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report),flush=True)
alarm(args.seconds)
try:
    for i,f in enumerate(source):
        r,q=normal(f);weights={i:R.one()}
        for j,g in q.items():addweight(weights,j,-g)
        append(r,weights)
        if unit_index is not None:break
    while unit_index is None and pairs and len(nodes)<args.max_nodes:
        _,_,i,j,lcm=heapq.heappop(pairs)
        pair=tuple(sorted((i,j)))
        if args.chain_criterion and any(k not in (i,j) and all(x<=y for x,y in zip(ke,lcm))
                and known_standard(i,k) and known_standard(j,k) for k,ke,_ in basis):
            standard_pairs.add(pair);chain_skips+=1;continue
        a,b=allrows[i],allrows[j]
        ai=tuple(a.lm().exponents()[0]);bi=tuple(b.lm().exponents()[0])
        x=R({tuple(v-w for v,w in zip(lcm,ai)):1/a.lc()})
        y=R({tuple(v-w for v,w in zip(lcm,bi)):-1/b.lc()})
        f=x*a+y*b;r,q=normal(f);weights={i:x,j:y}
        for k,g in q.items():addweight(weights,k,-g)
        append(r,weights);processed+=1;standard_pairs.add(pair)
        if processed%20==0:save()
    status='unit_candidate' if unit_index is not None else ('completed_nonunit_basis' if not pairs else 'node_cap_inconclusive')
except (AlarmInterrupt,KeyboardInterrupt):status='time_limit_inconclusive'
finally:cancel_alarm();save()
