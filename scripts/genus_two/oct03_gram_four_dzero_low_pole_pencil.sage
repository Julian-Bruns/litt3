#!/usr/bin/env sage
"""Exact low-pole gauge combinations from saved normal forms only.

No new Groebner basis, coefficient search, sheet inverse or source decision.
"""
import argparse
import json
from pathlib import Path
import signal
import time

parser=argparse.ArgumentParser()
parser.add_argument('--filtration',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(10)
start=time.monotonic()
R,Rx,G,gauges,poles,M,forbidden,top_minors,four_minors=load(args.filtration)
k=R.base_ring();alpha=k.gen();A=1+4*alpha;B=2+4*alpha
def nf(c):return R(c).reduce(G)
def pn(p):return Rx([nf(c) for c in p.list()])
def lin(p,c,q,d):return tuple(pn(c*p[i]+d*q[i]) for i in range(2))
c31=M[0][0];c26=M[1][3]
F=[lin(gauges[j],c26,gauges[3],-M[1][j]) for j in (1,2)]
s=[k.one()]
for n in range(1,20):
    c=B/A if n==1 else (-1/A if n==5 else k.zero())
    s.append((c-sum(s[j]*s[n-j] for j in range(1,n)))/2)
def coefficient(pair,pole):
    E,O=pair
    if pole%2==0:return nf(E[pole//2])
    z=R.zero()
    for j,c in enumerate(O.list()):
        n=(2*j+5-pole)//2
        if 0<=n<len(s):z=nf(z+c*s[n])
    return z
high=[[coefficient(p,n) for n in range(22,32)] for p in F]
assert all(all(c==0 for c in row) for row in high)
low=[[coefficient(p,n) for p in F] for n in (21,16,11,6,1)]
delta=nf(low[0][0]*low[1][1]-low[0][1]*low[1][0])
top4=next(c for rows,c in four_minors if rows==(0,1,2,3))
mapback=nf(c31*delta-c26*top4)
assert mapback==0
out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
save((R,Rx,G,F,c31,c26,high,low,delta,mapback),str(out/'low_pole_pencil.sobj'))
(out/'low_pole_pencil.txt').write_text('F1,F2 polynomial pairs = '+str(F)+'\n'+
    'pole rows21,16,11,6,1; odd sqrt(A) suppressed = '+str(low)+'\n'+
    'independence minor = '+str(delta)+'\n'+
    'mapback c31*minor-c26*top4 = '+str(mapback)+'\n')
summary={'scope':'two exact low-pole gauges only; actual divisor and rank-open hypotheses separate',
         'threads':1,'recomputed_groebner_basis':False,'all_poles_22_through_31_zero':True,
         'gauge_pair_degrees':[[int(z.degree()) for z in p] for p in F],
         'lower_independence_minor_nonzero_polynomial':bool(delta),
         'independence_minor_degree':int(delta.total_degree()) if delta else -1,
         'independence_minor_terms':len(delta.monomials()),'determinant_mapback':'PASS',
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
