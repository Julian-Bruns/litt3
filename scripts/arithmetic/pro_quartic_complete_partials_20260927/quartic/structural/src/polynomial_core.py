"""Small, dependency-free F25 polynomial arithmetic for pencil certificates.

A polynomial is a dict {exponent triple: F25 code}. Code [a+5b] denotes
 a+b*beta, beta^2=beta+3.  These are not integer residues modulo five.
"""
from __future__ import annotations
from itertools import permutations
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
from exact_fields import F25,code,to_code,Field
ADD=[[to_code(code(a)+code(b)) for b in range(25)] for a in range(25)]
NEG=[to_code(-code(a)) for a in range(25)]
MUL=[[to_code(code(a)*code(b)) for b in range(25)] for a in range(25)]
INV=[0]+[to_code(code(a).inverse()) for a in range(1,25)]
ZERO=(0,0,0)

def clean(p): return {m:c for m,c in p.items() if c}
def const(c): return {ZERO:c} if c else {}
def var(j):
 m=[0,0,0];m[j]=1;return {tuple(m):1}
def add(p,q):
 r=dict(p)
 for m,c in q.items():r[m]=ADD[r.get(m,0)][c]
 return clean(r)
def neg(p):return {m:NEG[c] for m,c in p.items()}
def sub(p,q):return add(p,neg(q))
def scale(p,c):return {m:MUL[v][c] for m,v in p.items() if MUL[v][c]}
def mul(p,q):
 r={}
 for a,c in p.items():
  for b,d in q.items():
   m=tuple(x+y for x,y in zip(a,b));r[m]=ADD[r.get(m,0)][MUL[c][d]]
 return clean(r)
def power(p,n):
 r=const(1)
 while n:
  if n&1:r=mul(r,p)
  n//=2
  if n:p=mul(p,p)
 return r

def sum_poly(ps):
 r={}
 for p in ps:r=add(r,p)
 return r

def determinant(A):
 n=len(A);out={}
 for perm in permutations(range(n)):
  term=const(1)
  for i,j in enumerate(perm):term=mul(term,A[i][j])
  inversions=sum(perm[i]>perm[j] for i in range(n) for j in range(i+1,n))
  out=add(out,neg(term) if inversions%2 else term)
 return out

ROWS={'C':[20,1,7,19], 'E':[8,1,15,0], 'U':[12,18,8,6], 'V':[4,17,2,0]}
DELTA=20
T=Field(F25,[-code(20),F25.zero,F25.zero,F25.zero,F25.one],'T_theta')
def row(name,i):return T.row([code(n)*pow(2,i*j,5) for j,n in enumerate(ROWS[name])])
X=[var(0),var(1),var(2),const(1)]
def epsilon_times(A):
 out=[{} for _ in range(4)]
 for j in range(4):
  ej=T.row([F25.zero]*j+[F25.one]);v=ej*A
  for k in range(4):out[k]=add(out[k],scale(X[j],to_code(v.c[k])))
 return out

def transporter(A,B):
 prod=epsilon_times(A)
 # det(1,B,epsilon,epsilon*A) in ascending theta basis.
 return determinant([[const(to_code(B.c[j])),X[j],prod[j]] for j in range(1,4)])

def quadrics(d):
 return [transporter(row('E',0),row('C',d)),
         transporter(row('C',0),row('E',d)),
         transporter(row('U',0),row('V',0)),
         transporter(row('V',d),row('U',d))]

def norm_polynomial():
 # Norm = (x0^2 + delta*x2^2 - 2delta*x1*x3)^2
 #        -delta*(2*x0*x2-x1^2-delta*x3^2)^2; x3=1.
 A=sub(add(power(X[0],2),scale(power(X[2],2),DELTA)),scale(X[1],MUL[2][DELTA]))
 B=sub(sub(scale(mul(X[0],X[2]),2),power(X[1],2)),const(DELTA))
 return sub(power(A,2),scale(power(B,2),DELTA))

def residuals_d2():
 # h0=x0-(beta+2)x2^2+beta*x2-beta-1
 # h1=x1-(2beta+2)x2^2+x2+beta+1
 h0=sum_poly([X[0],scale(power(X[2],2),NEG[7]),scale(X[2],5),const(NEG[6])])
 h1=sum_poly([X[1],scale(power(X[2],2),NEG[12]),X[2],const(6)])
 f=sum_poly([power(X[2],3),scale(power(X[2],2),6),scale(X[2],7),const(11)])
 return {'h0':h0,'h1':h1,'cubic':f}

def monomials(degree):
 return [(a,b,c) for total in range(degree+1)
         for a in range(total,-1,-1) for b in range(total-a,-1,-1)
         for c in [total-a-b]]

def shift(p,m):return {tuple(a+b for a,b in zip(n,m)):c for n,c in p.items()}
def evaluate(p,values):
 out=0
 for mon,c in p.items():
  term=c
  for n,x in zip(mon,values):
   for _ in range(n):term=MUL[term][x]
  out=ADD[out][term]
 return out

def serial(p):return [[*m,c] for m,c in sorted(p.items())]
def unserial(rows):
 out={}
 for a,b,c,v in rows:
  if min(a,b,c)<0 or not (1<=v<25):raise ValueError('Malformed polynomial record')
  m=(a,b,c)
  if m in out:raise ValueError('Duplicate monomial')
  out[m]=v
 return out

def degree(p):return max((sum(m) for m in p),default=-1)

def representation(generators,target,multiplier_degree):
 """Solve target=sum h_i*g_i with deg h_i<=bound, exactly over F25.

This is linear coefficient matching, not point or endpoint enumeration.
It raises ValueError if this particular multiplier bound is insufficient.
 """
 mons=monomials(multiplier_degree)
 columns=[shift(g,m) for g in generators for m in mons]
 rows=sorted(set(target).union(*(set(c) for c in columns)))
 aug=[[col.get(m,0) for col in columns]+[target.get(m,0)] for m in rows]
 nr=len(aug);nc=len(columns);piv=[];k=0
 for j in range(nc):
  pivot=next((i for i in range(k,nr) if aug[i][j]),None)
  if pivot is None:continue
  aug[k],aug[pivot]=aug[pivot],aug[k]
  inv=INV[aug[k][j]];aug[k]=[MUL[v][inv] for v in aug[k]]
  nz=[l for l in range(j,nc+1) if aug[k][l]]
  for i in range(nr):
   if i==k or not aug[i][j]:continue
   factor=NEG[aug[i][j]]
   for l in nz:aug[i][l]=ADD[aug[i][l]][MUL[factor][aug[k][l]]]
  piv.append(j);k+=1
  if k==nr:break
 if any(not any(r[:-1]) and r[-1] for r in aug):
  raise ValueError('Coefficient system inconsistent at the proposed bound')
 sol=[0]*nc
 for i,j in enumerate(piv):sol[j]=aug[i][-1]
 hs=[{m:sol[i*len(mons)+j] for j,m in enumerate(mons) if sol[i*len(mons)+j]}
     for i in range(len(generators))]
 assert sum_poly(mul(h,g) for h,g in zip(hs,generators))==target
 return hs,{'rows':nr,'columns':nc,'rank':len(piv),'multiplier_bound':multiplier_degree,
            'nonzero_multiplier_terms':sum(len(h) for h in hs)}
