"""Geometric stability: ideal membership in F[x,y]/(y^3-P), not point scanning.
The stated Sigma parametrization is an input. The ideal test works over any
finite extension and decides existence over its algebraic closure.
"""
import json
from pathlib import Path
from finite_field import F25,rank
import ffpoly as p
from exact import P_ROW
ROOT=Path(__file__).resolve().parents[1]

def zeros():return [[],[],[]]
def apoly(triples):
 z=zeros()
 for i,j,c in triples:
  if i<0:raise ValueError('Expected affine polynomial sections')
  z[j]+=[0]*max(0,i+1-len(z[j]));z[j][i]=c
 return [p.trim(a) for a in z]
def add(a,b,F):return [p.add(c,d,F) for c,d in zip(a,b)]
def sub(a,b,F):return [p.sub(c,d,F) for c,d in zip(a,b)]
def scale(c,a,F):return [p.scale(c,b,F) for b in a]
def mul(a,b,F):
 z=zeros()
 for i in range(3):
  for j in range(3):
   v=p.mul(a[i],b[j],F);k=i+j
   if k>=3:v=p.mul(v,P_ROW,F);k-=3
   z[k]=p.add(z[k],v,F)
 return z

def eval_affine(a,x,y,F):
 s=0
 for j,c in enumerate(a):
  v=0
  for d in reversed(c):v=F.add(F.mul(v,x),d)
  s=F.add(s,F.mul(v,F.power(y,j)))
 return s

def module_insert(basis,v,F):
 """POT Groebner basis for a submodule of F[x]^3. One pivot per position."""
 v=[p.trim(c) for c in v]
 while any(v):
  j=max(j for j in range(3) if v[j]);d=len(v[j])-1
  if basis[j] is None:
   inv=F.inv(v[j][-1]);basis[j]=[p.scale(inv,c,F) for c in v];return
  b=basis[j];db=len(b[j])-1
  if d<db:
   inv=F.inv(v[j][-1]);basis[j]=[p.scale(inv,c,F) for c in v];v=b;continue
  c=v[j][-1];shift=d-db
  v=[p.sub(a,[0]*shift+p.scale(c,bb,F) if bb else [],F) for a,bb in zip(v,b)]

def module_remainder(basis,v,F):
 v=[p.trim(c) for c in v]
 while any(v):
  j=max(j for j in range(3) if v[j]);b=basis[j]
  if b is None or len(v[j])<len(b[j]):return v
  shift=len(v[j])-len(b[j]);c=v[j][-1]
  v=[p.sub(a,[0]*shift+p.scale(c,bb,F) if bb else [],F) for a,bb in zip(v,b)]
 return v

def check_stability(xi,F=None):
 F=F or F25()
 if len(xi)!=19 or not any(xi):raise ValueError('Need a nonzero 19-vector')
 dat=json.load(open(ROOT/'data/stability_sections.json'))
 infinity=dat['infinity_fiber']
 if rank(infinity+[list(xi)],F)==2:return {'stable':False,'location':'infinity fiber of Sigma'}
 sections=[(apoly(a),apoly(b)) for a,b in dat['dual_sections']]
 j=next(i for i,c in enumerate(xi) if c)
 vecs=[]
 for i in range(19):
  if i==j:continue
  vecs.append((sub(scale(xi[j],sections[i][0],F),scale(xi[i],sections[j][0],F),F),
               sub(scale(xi[j],sections[i][1],F),scale(xi[i],sections[j][1],F),F)))
 basis=[None,None,None];one=[[1],[],[]]
 for i,(a,b) in enumerate(vecs):
  for c,d in vecs[:i]:
   det=sub(mul(a,d,F),mul(b,c,F),F)
   for yy in range(3):
    ymon=zeros();ymon[yy]=[1]
    module_insert(basis,mul(det,ymon,F),F)
   if not any(module_remainder(basis,one,F)):
    return {'stable':True,'location':'neither affine Sigma nor infinity Sigma','affine_ideal':'unit'}
 return {'stable':False,'location':'affine geometric fiber of Sigma','affine_ideal':'proper'}
