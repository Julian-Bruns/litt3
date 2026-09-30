#!/usr/bin/env sage
"""Focused independent check of the new sparse Frobenius multiplication.

At three complete degree-twelve H fibres, compare every selected tail
with literal truncated exponentiation in Sage. No roots of J are chosen.
This supplements, and does not replace, the exact function-field identity.
"""
import json,sys,time
from pathlib import Path
import numpy as np
d=Path(sys.argv[1]);co=load(str(d.parent/'coordinates.sobj'))
K=co['root'].parent();a=K.gen();beta=-(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
model=json.load(open(d/'model.json'));raw=json.load(open(d/'fourier.residual.json'))['coefficients']
tail=json.load(open(d/'sparse.tails.json'))['tails']
def bucket(coeff):
 v=np.asarray(coeff,dtype=np.int64);ix=np.arange(len(v),dtype=np.int64)%24;rows=[]
 for j in range(8):
  rows.append(np.bincount(ix,weights=v%5,minlength=24).astype(np.int64)%5);v//=5
 return [sum(K(int(rows[2*i][j]))*a**i+K(int(rows[2*i+1][j]))*beta*a**i for i in range(4)) for j in range(24)]
def prepare(r):
 assert not any(r['b'])
 return (bucket(r['a']),r['den'])
def value(b,z):return sum(c*z**j for j,c in enumerate(b))
pb=[bucket(p) for p in model['poles']]
jb=[prepare(r) for r in model['J_monic_H']]
rb=[[prepare(r) for r in row] for row in raw[67:]]
tb=[[prepare(r) for r in row] for row in tail]
start=time.time();checks=[]
for z in [K(2),K(3),beta]:
 poles=[value(p,z) for p in pb];assert all(poles)
 def ev(r):return value(r[0],z)/prod(p**int(e) for p,e in zip(poles,r[1]))
 R=PolynomialRing(K,'h');h=R.gen();j=R([ev(r) for r in jb]);assert j.degree()==12
 Q=R.quotient(j,'hbar');hb=Q.gen()
 def mr(row):return sum(Q(ev(r))*hb**i for i,r in enumerate(row))
 T=PowerSeriesRing(Q,'T',default_prec=74);t=T.gen()
 aa=T([mr(row) for row in reversed(rb)]).add_bigoh(74)
 direct=aa**63
 for i,row in enumerate(tb):assert direct[71+i]==mr(row)
 checks.append({'node':str(z),'full_fibre_degree':12,'tails':[71,72,73]})
 print('INDEPENDENT_SPARSE_TAILS_PASS',z,time.time()-start,flush=True)
(d/'sparse_independent_checks.json').write_text(json.dumps({'status':'PASS','checks':checks,'scope':'New sparse algorithm checked against literal Sage truncated exponentiation on three full fibres','seconds':time.time()-start},indent=2,default=int)+'\n')
