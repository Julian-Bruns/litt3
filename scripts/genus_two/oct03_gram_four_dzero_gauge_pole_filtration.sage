#!/usr/bin/env sage
"""Small exact P-pole filtration of all four polynomial flat gauges.

No Groebner basis, sample, Mumford inverse or source decision. Reuses
saved normal forms; records all rank minors and exceptional loci.
"""
import argparse
import itertools
import json
from pathlib import Path
import signal
import time
parser=argparse.ArgumentParser()
parser.add_argument('--gauge',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(15)
start=time.monotonic()
R,Rx,G,H,ann,U,N,pair,branch_remainders,norm_quotient,C4,flat,cross=load(args.gauge)
k=R.base_ring();alpha=k.gen();A=1+4*alpha;B=2+4*alpha
def nf(c):return R(c).reduce(G)
def pn(p):return Rx([nf(c) for c in p.list()])
gauges=[]
for E,O in flat:
    parts=[]
    for p in (E,O):
        q,r=p.quo_rem(H);q,r=pn(q),pn(r)
        assert r==0 and pn(H*q-p)==0
        parts.append(q)
    gauges.append(tuple(parts))
# w=rho*zeta^-5*sqrt(1+(B/A)zeta²-zeta^10/A).
# Drop the common nonzero rho in ODD Laurent rows only.
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
maximum=max(max(2*int(E.degree()),2*int(O.degree())+5) for E,O in gauges)
forbidden=[]
for pole in range(11,maximum+1):
    if pole%5!=1:
        forbidden.append((pole,[coefficient(p,pole) for p in gauges]))
poles=[31,26,21,16,11]
M=[[coefficient(p,pole) for p in gauges] for pole in poles]
out=Path(args.output);out.mkdir(parents=True,exist_ok=True)
save((R,Rx,G,gauges,poles,M,forbidden),str(out/'pole_coefficients.sobj'))
def det(A):
    n=len(A);z=R.zero()
    for p in itertools.permutations(range(n)):
        term=R.one()
        for i in range(n):term=nf(term*A[i][p[i]])
        sign=(-1)^sum(p[i]>p[j] for i in range(n) for j in range(i+1,n))
        z=nf(z+sign*term)
    return z
top_minors=[]
for i,j in itertools.combinations(range(4),2):
    top_minors.append(((i,j),nf(M[0][i]*M[1][j]-M[0][j]*M[1][i])))
four_minors=[]
for rows in itertools.combinations(range(5),4):
    four_minors.append((rows,det([M[i] for i in rows])))
save((R,Rx,G,gauges,poles,M,forbidden,top_minors,four_minors),str(out/'pole_filtration.sobj'))
(out/'pole_filtration.txt').write_text('P pole rows, odd rho suppressed = '+str(list(zip(poles,M)))+'\n'+
    'top2 minors = '+str(top_minors)+'\n'+
    'four-row minors = '+str(four_minors)+'\n')
summary={'scope':'four polynomial gauge pole coefficients only; no actual source decision',
         'threads':1,'recomputed_groebner_basis':False,
         'all_H_cancellations':'PASS',
         'forbidden_poles_zero':all(all(c==0 for c in cs) for pole,cs in forbidden),
         'gauge_pair_degrees':[[int(z.degree()) for z in p] for p in gauges],
         'top2_nonzero_minors':[list(ij) for ij,c in top_minors if c],
         'nonzero_four_row_minors':[list(rows) for rows,c in four_minors if c],
         'top_four_rows_determinant_zero':bool(four_minors[0][1]==0),
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n');print(json.dumps(summary,default=int))
