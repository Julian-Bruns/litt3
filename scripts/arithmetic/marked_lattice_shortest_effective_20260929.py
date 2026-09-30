#!/usr/bin/env python3
"""Exact rational enumeration for the marked effective-pole gauge.

This computes a minimum in the supplied relation lattice. Its scope is
exact for an independently established exact Jacobian kernel, and only a
necessary-condition bound otherwise. It inherits conditional status from
its input. No floating point or expanded high-degree function is used.
"""
import argparse, hashlib, json, math, time
from fractions import Fraction as F
from pathlib import Path

p=argparse.ArgumentParser()
p.add_argument('lattice',type=Path);p.add_argument('output',type=Path)
p.add_argument('--signed',action='store_true',help='Allow poles at all thirteen marked points.')
args=p.parse_args();start=time.monotonic()
inp=json.loads(args.lattice.read_text())
B=[[int(a) for a in row] for row in inp['basis_rows']]
n=len(B);assert n==8 and all(len(r)==8 for r in B)
def dot(a,b):return sum(x*y for x,y in zip(a,b))
def effective_gauge(h):
 return sum(h[i]+h[i+4]+3*max(0,-h[i],-h[i+4]) for i in range(4))
def signed_gauge(h):
 triples=[sorted((0,h[i],h[i+4])) for i in range(4)]
 A=sum(t[2]for t in triples);B=sum(t[1]for t in triples);C=sum(t[0]for t in triples)
 possible=[]
 for S in range(-2,3):
  if (S-A-B-C)%3:continue
  D=(S+2*A-B-C)//3
  P=max(D,0)+max(D-A+B,0)+max(D-A+C,0)
  possible.append(P+max(-S,0))
 return min(possible)
gauge=signed_gauge if args.signed else effective_gauge
orth=[];d=[];mu=[[F(0) for _ in range(n)]for _ in range(n)]
for i,row in enumerate(B):
 v=list(map(F,row))
 for j in range(i):
  mu[i][j]=F(dot(row,orth[j]),d[j])
  v=[a-mu[i][j]*b for a,b in zip(v,orth[j])]
 orth.append(v);d.append(dot(v,v));assert d[-1]>0
for i in range(n):
 for j in range(n):
  assert F(dot(B[i],B[j]))==sum(
   d[k]*(F(1)if i==k else mu[i][k]if i>k else F(0))*
   (F(1)if j==k else mu[j][k]if j>k else F(0))for k in range(n))
upper=min(gauge([sgn*a for a in row])for row in B for sgn in [-1,1])
radius_factor=5 if args.signed else 2
radius2=radius_factor*upper*upper
best=upper;solutions=[];leaf_count=0;node_count=0;w=[0]*n
digest=hashlib.sha256()
def ceildiv(a,b):return -((-a)//b)
def walk(i,remaining):
 global best,leaf_count,node_count,solutions
 node_count+=1
 if i<0:
  if not any(w):return
  h=[sum(w[j]*B[j][k]for j in range(n))for k in range(n)]
  assert dot(h,h)<=radius2
  leaf_count+=1;N=gauge(h)
  digest.update((','.join(map(str,h))+':'+str(N)+'\n').encode())
  if N<best:best=N;solutions=[]
  if N==best:solutions.append({'coordinates':w[:],'relation':h,'pole':N})
  return
 center=sum(F(w[j])*mu[j][i] for j in range(i+1,n))
 a,b=center.numerator,center.denominator
 bound=remaining/d[i]*b*b
 if bound<0:return
 floor_root=math.isqrt(bound.numerator//bound.denominator)
 lo=ceildiv(-floor_root-a,b);hi=(floor_root-a)//b
 for val in range(lo,hi+1):
  w[i]=val
  rest=remaining-d[i]*(F(val)+center)**2
  assert rest>=0
  walk(i-1,rest)
 w[i]=0
walk(n-1,F(radius2))
assert solutions
is_exact=bool(inp.get('exact_kernel',False))
assert not (is_exact and inp['conditional'])
rec={'scope':(('exact least degree of a non-x-invariant thirteen-point supported rational function' if args.signed else
               'exact least pole of a nonpolynomial marked-support function') if is_exact else
              'minimum of the selected gauge in a necessary relation lattice; not an exact actual threshold'),
 'exact_kernel':is_exact,
 'gauge':'signed_thirteen_point' if args.signed else 'effective_twelve_point',
 'conditional':inp['conditional'],'lattice_input':str(args.lattice),
 'lattice_sha256':hashlib.sha256(args.lattice.read_bytes()).hexdigest(),
 'gram_schmidt_norms':[str(x)for x in d],
 'gram_schmidt_mu':[[str(x)for x in r]for r in mu],
 'initial_upper_bound':upper,'enumerated_squared_radius':radius2,
 'reason_for_radius':('If degree(h)<=U then ||h||_2^2<=5U^2, using the diameter of the thirteen-point coefficient polytope.' if args.signed else
 'If N(h)<=U then ||h||_2^2<=2U^2, using the least nonnegative twelve-point representative.'),
 'nonzero_vectors_in_ball':leaf_count,'recursion_nodes':node_count,
 'enumeration_sha256':digest.hexdigest(),'least_effective_pole':best,
 'supported_function_invariance_through':best-1,
 'minimizers':solutions,'seconds':time.monotonic()-start}
args.output.parent.mkdir(parents=True,exist_ok=True)
args.output.write_text(json.dumps(rec,indent=2)+'\n')
print('conditional',rec['conditional'],'least pole',best,'minimizers',len(solutions),
      'vectors',leaf_count,'seconds',rec['seconds'])
