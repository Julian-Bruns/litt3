#!/usr/bin/env python3
"""Exact four-jet certificate for the specified characteristic-five genus-three pair.

Run: sage -python scripts/genus_two/parameterized_bad_double_four_jet.py --output-dir results
Requires Python 3.10+ and SymPy. All matrix operations are entrywise.

The curve is represented by kappa^2=R, ell^2=S, v=kappa*ell.
The Cech basis of H^1(T_C) is
    v/u, v/u^2, v/u^3, ell/u, kappa/u, ell/u^2.
The formal Picard cocycle on C^(1) is exp(X*v'/u'+Y*v'/u'^2+Z*ell'/u').
Only total parameter degrees <=4 are used, so all exponential denominators
are invertible in characteristic five. Coefficient Frobenius is retained:
F_C pulls back the cocycle functions to their fifth powers but fixes X,Y,Z.
The harmless factor (t+1)^2 in A is removed throughout.

The calculation uses Laurent polynomials in u, not truncated numerical
Laurent series. Coefficients are exact polynomials/rational functions over F5.
"""
import time,sys,json
from itertools import product
from sympy.polys.rings import ring
from sympy.polys.fields import field
from sympy.polys.domains import GF
P,t=ring('t',GF(5))
K,T=field('t',GF(5))
zero=P.zero;one=P.one

def conv(a,b):
 d={}
 for i,v in a.items():
  for j,w in b.items():
   c=v*w
   if i+j in d:c+=d[i+j]
   if c:d[i+j]=c
   elif i+j in d:del d[i+j]
 return d

def pad(a,b):
 c=a.copy()
 for j,w in b.items():
  v=c.get(j,zero)+w
  if v:c[j]=v
  elif j in c:del c[j]
 return c

def psc(a,s):return {i:v*s for i,v in a.items() if v*s}

def ppow(a,n):
 c={0:one}
 for _ in range(n):c=conv(c,a)
 return c
R={2:one,1:P(2)}
S=conv(conv({1:one,0:P(4)},{1:one,0:P(3)}),{1:one,0:-t})
F=conv(R,S)
A=conv(R,conv({1:one,0:P(4)},{1:one,0:P(3)}))
factors=[{0:one},R,S,F]

def cz():return ({},{},{},{})
def cmono(index,p,shift=0):
 v=[{},{},{},{}];v[index]={i+shift:a for i,a in p.items()};return tuple(v)
def ca(a,b):return tuple(pad(a[i],b[i]) for i in range(4))
def cn(a):return tuple(psc(a[i],P(4)) for i in range(4))
def cs(a,v):return tuple(psc(a[i],v) for i in range(4))
def cm(a,b):
 c=[{},{},{},{}]
 for i in range(4):
  for j in range(4):
   if a[i] and b[j]:c[i^j]=pad(c[i^j],conv(conv(a[i],b[j]),factors[i&j]))
 return tuple(c)

# Cech tangent cochains: v/u,v/u^2,v/u^3,ell/u,kappa/u,ell/u^2.
basis=[(3,-1),(3,-2),(3,-3),(2,-1),(1,-1),(2,-2)]
limits=[-1,-2,-3,-4]
def split(a):
 p=[a[i].get(j,zero) for i,j in basis]
 r=tuple({j:v for j,v in a[i].items() if j<=limits[i]} for i in range(4))
 return p,r

H=[cmono(i,conv(A,ppow(factors[i],2)),5*j) for i,j in basis]
D=[cmono(3,ppow(F,2),-5),cmono(3,ppow(F,2),-10),cmono(2,ppow(S,2),-5)]

def matrix_jet(d,N=4):
 B=cz()
 for i,c in enumerate(d):B=ca(B,cs(D[i],P(c)))
 powers=[cmono(0,{0:one}),B]
 for n in range(2,N+1):powers.append(cs(cm(powers[-1],B),P(pow(n,-1,5))))
 matrices=[[[zero for j in range(6)] for i in range(6)] for n in range(N+1)]
 for col,h in enumerate(H):
  r=[]
  for n in range(N+1):
   a=h if n==0 else cz()
   if n:
    for k in range(1,n+1):a=ca(a,cn(cm(powers[k],r[n-k])))
   p,rr=split(a);r.append(rr)
   for row in range(6):matrices[n][row][col]=p[row]
 return matrices

def kmatrix(M):return [[K(x) for x in row] for row in M]
def inv(M):
 n=len(M);M=[row[:]+[K(int(i==j)) for j in range(n)] for i,row in enumerate(M)]
 for i in range(n):
  k=next(j for j in range(i,n) if M[j][i]);M[i],M[k]=M[k],M[i]
  z=M[i][i];M[i]=[v/z for v in M[i]]
  for j in range(n):
   if j!=i:
    z=M[j][i];M[j]=[M[j][k]-z*M[i][k] for k in range(2*n)]
 return [row[n:] for row in M]

def mv(M,v):return [sum((a*b for a,b in zip(row,v)),K.zero) for row in M]
def schur(Ms):
 I=[0,1,2,3,5];k=4
 Ms=[kmatrix(m) for m in Ms];Bi=inv([[Ms[0][i][j] for j in I] for i in I])
 vs=[];ans=[]
 for n,M in enumerate(Ms):
  rhs=[M[i][k] for i in I]
  for a in range(1,n+1):
   s=mv([[Ms[a][i][j] for j in I] for i in I],vs[n-a]);rhs=[x+y for x,y in zip(rhs,s)]
  v=[-x for x in mv(Bi,rhs)];vs.append(v)
  val=M[k][k]
  for a in range(n+1):val+=sum((Ms[a][k][j]*vs[n-a][i] for i,j in enumerate(I)),K.zero)
  ans.append(val)
 return ans

def fmt(x):
 import sympy as s
 return str(s.factor(x.as_expr(),modulus=5))


def monomials(n):
 return [(i,j,n-i-j) for i in range(n+1) for j in range(n-i+1)]

def all_matrices(N=4):
 inds=[m for n in range(N+1) for m in monomials(n)]
 DP=[ [cmono(0,{0:one})] for i in range(3)]
 for i in range(3):
  for n in range(1,N+1):DP[i].append(cs(cm(DP[i][-1],D[i]),P(pow(n,-1,5))))
 powers={m:cm(cm(DP[0][m[0]],DP[1][m[1]]),DP[2][m[2]]) for m in inds if sum(m)>0}
 matrices={m:[[zero for j in range(6)] for i in range(6)] for m in inds}
 for col,h in enumerate(H):
  rs={}
  for m in inds:
   a=h if sum(m)==0 else cz()
   for s,power in powers.items():
    if all(s[i]<=m[i] for i in range(3)):
     diff=tuple(m[i]-s[i] for i in range(3))
     a=ca(a,cn(cm(power,rs[diff])))
   p,r=split(a);rs[m]=r
   for row in range(6):matrices[m][row][col]=p[row]
 return matrices

def all_schur(Ms):
 I=[0,1,2,3,5];k=4;origin=(0,0,0)
 Ms={m:kmatrix(mat) for m,mat in Ms.items()}
 Bi=inv([[Ms[origin][i][j] for j in I] for i in I])
 vs={};ans={}
 for m,M in Ms.items():
  rhs=[M[i][k] for i in I]
  for s,mat in Ms.items():
   if sum(s)>0 and all(s[i]<=m[i] for i in range(3)):
    diff=tuple(m[i]-s[i] for i in range(3))
    ss=mv([[mat[i][j] for j in I] for i in I],vs[diff]);rhs=[x+y for x,y in zip(rhs,ss)]
  v=[-x for x in mv(Bi,rhs)];vs[m]=v
  val=M[k][k]
  for s,mat in Ms.items():
   if all(s[i]<=m[i] for i in range(3)):
    diff=tuple(m[i]-s[i] for i in range(3))
    val+=sum((mat[k][j]*vs[diff][i] for i,j in enumerate(I)),K.zero)
  ans[m]=val
 return ans


def canonical(x):
    """A rational function with monic denominator and coefficients in 0,...,4."""
    x=K(x)
    if not x:
        return "0"
    z=P(pow(int(x.denom.LC),-1,5))
    n=x.numer*z; d=x.denom*z
    if d==one:
        return str(n.as_expr())
    return "("+str(n.as_expr())+")/("+str(d.as_expr())+")"


def determinant(M):
    from itertools import permutations
    n=len(M); ans=zero
    for perm in permutations(range(n)):
        term=one
        for i in range(n):
            term*=M[i][perm[i]]
        sign=sum(perm[i]>perm[j] for i in range(n) for j in range(i+1,n))%2
        ans+=-term if sign else term
    return ans


def main():
    import argparse
    from pathlib import Path
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir",default="results")
    args=parser.parse_args()
    out=Path(args.output_dir);out.mkdir(parents=True,exist_ok=True)
    start=time.time()
    Ms=all_matrices(4)
    fs=all_schur(Ms)
    origin=(0,0,0)
    Delta0=T**5-T
    # Fraction-field elements can have noncanonical constant denominators.
    # Test identities by subtraction, never by representation equality.
    assert not(fs[(2,0,0)]-3*Delta0)
    assert not(fs[(0,0,2)]-4*Delta0/(T+1)**2)
    assert not(fs[(0,4,0)]-3)
    assert not(fs[(1,3,0)]-2*T*(T**4+3))
    assert all(not f for m,f in fs.items() if sum(m) in [0,1,3])
    assert all(not fs[m] for m in monomials(2) if m not in [(2,0,0),(0,0,2)])
    assert all(not f for m,f in fs.items() if m[2]%2)
    M0=Ms[origin]
    detI=determinant([r[:3] for r in M0[:3]])
    detA=determinant([[M0[i][j] for j in [3,5]] for i in [3,5]])
    assert not(K(detI)-(T+1)*Delta0)
    assert not(K(detA)-(T-1)*(T-2))

    # An independent short contraction certificate inside the radial 3x3 block.
    radial=[kmatrix(Ms[(0,n,0)]) for n in range(5)]
    I=[3,5];j=4
    B=lambda n:[[radial[n][a][b] for b in I] for a in I]
    b=lambda n:[radial[n][a][j] for a in I]
    c=lambda n:[radial[n][j][a] for a in I]
    d=lambda n:radial[n][j][j]
    dot=lambda a,b:sum((x*y for x,y in zip(a,b)),K.zero)
    Binv=inv(B(0)); v=mv(Binv,b(1))
    assert not(v[0]-1) and not(v[1]-3)
    assert not(d(2)-dot(c(1),v))
    first=d(4)-dot(c(3),v)
    second=dot(c(1),mv(Binv,b(3)))-dot(c(1),mv(Binv,mv(B(2),v)))
    assert not(first-(T**7+3))
    assert not(second-T**7)
    assert not(first-second-3)

    # The small-parameter criterion, exact polynomial remainder in F5[t].
    minimal=t**3+t+1
    exceptional=(t**5-t)*(t**2+2*t+3)
    assert exceptional.rem(minimal)==P(4)*t**2

    jets={",".join(map(str,m)):canonical(f) for m,f in fs.items()}
    mats={",".join(map(str,m)):[[str(v.as_expr()) for v in row] for row in mat]
          for m,mat in Ms.items()}
    metadata={
       "characteristic":5,
       "coordinate_order":["X","Y","Z"],
       "meaning":"total-degree four-jet in the formal Picard exponential coordinates",
       "cocycle_basis":["v_prime/u_prime","v_prime/u_prime^2","ell_prime/u_prime"],
       "normalization":"A=G; the original factor (t+1)^2 is omitted",
       "cohomology_basis":["v/u","v/u^2","v/u^3","ell/u","kappa/u","ell/u^2"],
       "eliminated_indices_zero_based":[0,1,2,3,5],
       "exceptional_index_zero_based":4,
       "scalar_jet":jets,
       "hodge_matrix_jet":mats,
    }
    (out/"full_four_jet.json").write_text(json.dumps(metadata,indent=2)+"\n")
    lines=["All coefficients below are in F5(t). X,Y,Z denote formal Picard coordinates.",
           "A is normalized to G, removing the unit (t+1)^2.",
           "The scalar relation is the actual two-sided Schur complement.",""]
    for m,f in fs.items():
        if f:
            lines.append("X^%d Y^%d Z^%d : %s"%(*m,canonical(f)))
    lines.extend(["", "Quadratic: 3*(t^5-t)*X^2 + 4*(t^5-t)/(t+1)^2*Z^2",
                  "All coefficients of total degree 1 or 3 vanish.",
                  "Radical quartic: 3*Y^4",
                  "Coefficient of X*Y^3: 2*t*(t^4+3)",
                  "Constant good-block determinants: (t+1)*(t^5-t), (t-1)*(t-2)",
                  "Radial quartic contractions: (t^7+3)-t^7 = 3",
                  "Exceptional polynomial mod t^3+t+1: 4*t^2", "ALL ASSERTIONS PASSED"])
    (out/"full_four_jet.txt").write_text("\n".join(lines)+"\n")
    print("\n".join(lines))
    print("Exact symbolic computation completed in %.3f seconds."%(time.time()-start))

if __name__=="__main__":
    main()
