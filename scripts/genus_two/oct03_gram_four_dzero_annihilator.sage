#!/usr/bin/env sage
"""New symbolic annihilator chart for the existing complete d=0 family.

Reuse the saved Groebner basis solely for coefficient normal forms.
No Groebner calculation, point replay, effectivity or source decision.
"""
import argparse
import itertools
import json
from pathlib import Path
import signal
import time

parser=argparse.ArgumentParser()
parser.add_argument('--basis',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(15)
start=time.monotonic()
G=load(args.basis)
R=G[0].parent()
k=R.base_ring()
alpha=k.gen()
vs=dict(zip(R.variable_names(),R.gens()))
a0,u,b0,b4=(vs[n] for n in ('a0','a2','b0','b4'))
Rx=PolynomialRing(R,'x')
x=Rx.gen()
A,B,C=1+4*alpha,2+4*alpha,k(-1)
H=A*x^5+B*x^4+C
h=2*B*(A*x^5+C)
zero=(Rx.zero(),Rx.zero())
one=(Rx.one(),Rx.zero())
def add(p,q):return (p[0]+q[0],p[1]+q[1])
def scale(p,z):return (z*p[0],z*p[1])
def mul(p,q):return (p[0]*q[0]+H*p[1]*q[1],p[0]*q[1]+p[1]*q[0])
def D(p):return (H*p[1].derivative()+2*B*x^3*p[1],p[0].derivative())
def conn(v):
    dv=[D(z) for z in v]
    return (add(dv[0],scale(v[1],-2)),add(dv[1],scale(v[2],-3)),
            add(dv[2],scale(v[3],-4)),add(dv[3],mul((h,Rx.zero()),v[0])))
def det(columns):
    n=len(columns)
    result=zero
    for permutation in itertools.permutations(range(n)):
        term=one
        for j in range(n):term=mul(term,columns[j][permutation[j]])
        sign=(-1)^sum(permutation[i]>permutation[j] for i in range(n) for j in range(i+1,n))
        result=add(result,scale(term,sign))
    return result
def normal(p):return Rx([c.reduce(G) for c in p.list()])
a=(a0+b4*x+u*x^2,Rx.zero())
b=add(D(a),(Rx(b0),Rx.zero()))
v=(zero,one,a,b)
columns=[v]
for j in range(2):columns.append(conn(columns[-1]))
cov=[]
for omitted in range(4):
    minor=[tuple(column[i] for i in range(4) if i!=omitted) for column in columns]
    cov.append(scale(det(minor),(-1)^omitted))
ann=[scale(cov[3],1/k(4)),scale(cov[2],1/k(3)),scale(cov[1],1/k(2)),cov[0]]
U=add(add(scale(mul(mul(a,a),a),3),scale(a,2*b0)),D(D(a)))
assert ann[0]==U
ann=[tuple(normal(p) for p in z) for z in ann]
assert ann[0][1]==0
# Exact leading pivot is invertible throughout this branch because u!=0.
assert ann[0][0].degree()==6
assert ann[0][0][6]==3*u^3
# New image-divisor data: the affine norm of every pair with the first
# coordinate must be divisible by U. Use polynomial division only;
# coefficient reductions are against the already saved complete basis.
Umonic=normal(ann[0][0]*((1/k(3))*vs['inv_a2']^3))
assert Umonic.is_monic()
norm_remainders=[]
for even,odd in ann[1:]:
    norm=normal(even^2-H*odd^2)
    remainder=normal(norm.quo_rem(Umonic)[1])
    norm_remainders.append(remainder)
out=Path(args.output)
out.mkdir(parents=True,exist_ok=True)
save((R,Rx,G,H,ann,Umonic,norm_remainders),str(out/'annihilator.sobj'))
(out/'annihilator.txt').write_text('U monic = '+str(Umonic)+'\n'+
    '\n'.join('ann['+str(i)+'] = '+str(z) for i,z in enumerate(ann))+'\n'+
    'norm remainders modulo U = '+str(norm_remainders)+'\n')
summary={'scope':'existing d=0 necessary determinant family; no source or effectivity decision',
         'threads':1,'recomputed_groebner_basis':False,
         'structural_b_equals_Da_plus_b0':True,
         'first_annihilator_coordinate_even_degree':6,
         'first_annihilator_leading_coefficient':'3*a2^3, a2 invertible',
         'annihilator_pair_degrees':[[int(z.degree()) for z in pair] for pair in ann],
         'norm_remainders_zero':[bool(z==0) for z in norm_remainders],
         'elapsed_seconds':time.monotonic()-start}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
