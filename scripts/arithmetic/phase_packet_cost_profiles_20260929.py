#!/usr/bin/env python3
"""Exact integer residue-cost profiles for29 phases, with repetitions."""
import argparse,itertools,json
from pathlib import Path
def comps(n,r):
    if r==1:yield(n,);return
    for i in range(n+1):
        for t in comps(n-i,r-1):yield(i,)+t
def profiles(budget):
    ans={(0,0,0):0}
    classes={min(tuple((v+c)%5 for v in p) for c in range(5)) for p in itertools.product(range(5),repeat=3)}
    for v in classes:
        if v==(0,0,0):continue
        opts=[tuple((u+c)%5 for u in v) for c in range(5)]
        costs=[sum(z) for z in opts]
        if 29*min(costs)>budget:continue
        for counts in comps(29,5):
            cost=sum(a*b for a,b in zip(counts,costs))
            if cost>budget:continue
            C=tuple(sum(counts[j]*opts[j][s] for j in range(5)) for s in range(3))
            m=min(C);red=tuple(c-m for c in C)
            if red==(0,0,0):continue
            ans[red]=min(ans.get(red,10**9),cost)
    return ans
def frob(v):
    w=[0]*12
    for i in range(4):
        for s in range(3):w[3*((i+1)%4)+(s if i<3 else (s+1)%3)]=v[3*i+s]
    return tuple(w)
def canonical(v):
    orbit=[v]
    for _ in range(11):orbit.append(frob(orbit[-1]))
    return min(orbit)
def main():
    p=argparse.ArgumentParser();p.add_argument('budget',type=int);p.add_argument('output',type=Path);args=p.parse_args()
    pp=profiles(args.budget);nonzero=sorted((v,c) for v,c in pp.items() if any(v))
    cases={}
    def extend(i,vec,cost):
        if i==4:
            if not any(vec):return
            v=canonical(tuple(vec));b=(args.budget-cost)//5
            if sum(v)+5*b<=28:return
            cases[v]=max(cases.get(v,-1),b);return
        extend(i+1,vec+[0,0,0],cost)
        for v,c in nonzero:
            if cost+c<=args.budget:extend(i+1,vec+list(v),cost+c)
    extend(0,[],0)
    rec={'budget':args.budget,'single_root_profiles':len(pp),'cases':[
        {'base':v,'blocks':b,'pole_bound':sum(v)+5*b} for v,b in sorted(cases.items())]}
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(rec,indent=2)+'\n')
    print('budget',args.budget,'root profiles',len(pp),'canonical cases',len(cases),
          'max pole',max((sum(v)+5*b for v,b in cases.items()),default=0),flush=True)
if __name__=='__main__':main()
