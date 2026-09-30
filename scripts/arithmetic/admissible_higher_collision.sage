"""Necessary finite-pole and selected-sheet collision systems, degree 9--11.

All unknown coefficients are geometric. Matrices are over the finite
field of definition, so a rank obstruction is valid over the algebraic
closure. No polynomial candidate is treated as an etale realization.
"""
import json
import math
import sys
import time
from pathlib import Path

n=int(sys.argv[1]) if len(sys.argv)>1 else 11
assert n in (9,10,11)
m=n-5
start=time.monotonic()
F5=GF(5); RB=PolynomialRing(F5,'B'); BB=RB.gen()
F=GF(25,'beta',modulus=BB**2-BB-3); beta=F.gen()
def dec(a):return F(a%5)+F(a//5)*beta
RF=PolynomialRing(F,'x'); x=RF.gen()
P=RF([dec(a) for a in (11,22,18,5,19,20,15,16,9,22,1)])
Q=RF([dec(a) for a in (0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24)])
A=RF([dec(a) for a in (1,21,14,22,13)])
B0=RF([dec(a) for a in (8,14,19,2,10,19,3,24,18,16)])
LL=RF([dec(a) for a in (18,20,20,15)])
assert (Q-B0**5)%P**2==0 and (Q-LL**5)%A**3==0
columns=[(i,r,e) for i in range(m+1) for r in range(3)
         for e in range((n+12*i)//3+1) if 3*e+10*r<=n+12*i]
rowlabels=[(j,r,e) for j in range(1,m+1) for r in range(3) if r<j
           for e in range(10*math.ceil((j-r)/3))]
rowindex={a:i for i,a in enumerate(rowlabels)}
Mat=matrix(F,len(rowlabels),len(columns))
for col,(i,r,e) in enumerate(columns):
    for j in range(max(1,i),m+1):
        if r>=j:continue
        factor=F(binomial(m-i,j-i))*(-1)**(j-i)
        f=(factor*B0**(j-i)*x**e)%P**math.ceil((j-r)/3)
        for a,c in enumerate(f):Mat[rowindex[(j,r,a)],col]=c
rank=int(Mat.rank()); kernel=Mat.right_kernel().basis_matrix()
dim=kernel.nrows()
print('degree',n,'finite_matrix',Mat.dimensions(),'rank',rank,'nullity',dim,flush=True)
assert rank+dim==len(columns)
if n==9:assert (rank,dim)==(100,28)

# The four roots of A in their actual coefficient field.
K=GF(5**8,'g',impl='pari_ffelt'); RK=PolynomialRing(K,'z'); z=RK.gen()
bK=(z**2-z-3).roots(multiplicities=False)[0]
embed=F.hom([bK],K)
Pk=RK([embed(a) for a in P]); Ak=RK([embed(a) for a in A])
alpha=Ak.roots(multiplicities=False)[0]
roots=[alpha**(25**i) for i in range(4)]
assert len(set(roots))==4
def kpoly(f):return RK([embed(a) for a in f])
def coordinates(a):
    v=list(K(a).polynomial());return v+[F5.zero()]*(8-len(v))
conversion=matrix(F5,[coordinates(alpha**i*bK**j) for i in range(4) for j in range(2)]).transpose().inverse()
def codeF(a):return int(a[0])+5*int(a[1])
def codeK(a):
    v=conversion*vector(F5,coordinates(a))
    return sum((int(v[2*i])+5*int(v[2*i+1]))*25**i for i in range(4))

# For each finite-pole kernel vector reconstruct every N_i.
Ns=[]
for v in kernel.rows():
    N=[[RF.zero() for r in range(3)] for i in range(m+1)]
    for a,(i,r,e) in zip(v,columns):N[i][r]+=a*x**e
    Ns.append(N)
vcoords=[j for j,(i,r,e) in enumerate(columns) if i==0]

# Coefficients of (U^5+Q-L^5) J(U-L), before the constant kappa term.
Cs=[]
for N in Ns:
    J=[[RF.zero() for r in range(3)] for j in range(m+1)]
    for j in range(m+1):
        for i in range(m-j+1):
            factor=F(binomial(m-i,j))*(-LL)**(m-i-j)
            for r in range(3):J[j][r]+=factor*N[i][r]
    C=[[RF.zero() for r in range(3)] for j in range(10)]
    for j in range(10):
        for r in range(3):
            if j<=m:C[j][r]+=(Q-LL**5)*J[j][r]
            if 0<=j-5<=m:C[j][r]+=J[j-5][r]
    Cs.append(C)

# Cache ten-jet coefficient matrices at each root; this uses exact
# polynomial substitution, i.e. Hasse derivatives, not divided factorials.
cache={}
for ri,root in enumerate(roots):
    for j in range(10):
        for r in range(3):
            polys=[kpoly(C[j][r])(z+root) for C in Cs]
            for a in range(10-j):
                cache[(ri,j,r,a)]=[f[a] for f in polys]

patterns=[]
for a in range(3):
    for b in range(3):
        for c in range(3):
            for d in range(3):
                w=(a,b,c,d)
                if sum(w)!=3:continue
                if n==9 and max(w)>1:continue
                patterns.append(w)
assert len(patterns)==(4 if n==9 else 16)
results=[]; exclusions=[]
for w in patterns:
    tB=prod((z-r)**v for r,v in zip(roots,w))
    constant=tB**3*Pk**(n//3)
    cr=n%3
    rows=[]; labels=[]
    for ri,v in enumerate(w):
        if not v:continue
        e=5*v
        kk=constant(z+roots[ri])
        for j in range(e):
            for r in range(3):
                for a in range(e-j):
                    extra=kk[a] if j==0 and r==cr else K.zero()
                    rows.append(cache[(ri,j,r,a)]+[extra])
                    labels.append((ri,j,r,a))
    Cmat=matrix(K,rows)
    rk=int(Cmat.rank()); rk0=int(Cmat[:,:dim].rank())
    result={'weights':list(w),'dimensions':list(Cmat.dimensions()),
            'rank':rk,'rank_without_kappa':rk0,'kernel_dimension':dim+1-rk,
            'kappa_can_be_nonzero':rk==rk0}
    if rk>rk0 and w[0]==2:
        target=vector(K,[0]*dim+[1])
        witness=Cmat.transpose().solve_right(target)
        assert witness*Cmat==target
        exclusions.append({'weights':list(w),'row_labels':labels,
                           'matrix':[[codeK(a) for a in row] for row in Cmat.rows()],
                           'left_witness':[codeK(a) for a in witness]})
    if rk==rk0:
        # Test whether some kernel vector with nonzero kappa can have
        # nonzero leading polynomial v. This is automatic unless every
        # kernel vector projects to v=0, but record the projection rank.
        ker=Cmat.right_kernel().basis_matrix()
        projection=matrix(K,[[sum(row[j]*embed(kernel[j,col]) for j in range(dim))
                              for col in vcoords]+[row[dim]] for row in ker.rows()])
        result['v_and_kappa_projection_rank']=int(projection.rank())
        result['v_projection_rank']=int(projection[:,:len(vcoords)].rank())
    # At O, exactly 5*(n-9) sheets belong to E. Their b has pole
    # at most one; the other sheets have pole at most 2+mult(G).
    # Bound every elementary coefficient of the ORIGINAL polynomial.
    e_infinity=5*(n-9)
    infinity_rows=[]
    infinity_labels=[]
    for j in range(1,n+1):
        bound=n+12*j-max(0,j-(n-e_infinity))
        for r in range(3):
            polys=[]
            for N in Ns:
                ff=RF.zero()
                if j<=m:ff+=N[j][r]
                if 0<=j-5<=m:ff+=Q*N[j-5][r]
                polys.append(kpoly(ff))
            extra=constant if j==n and r==cr else RK.zero()
            maxdeg=max([int(f.degree()) for f in polys]+[int(extra.degree())])
            for a in range(maxdeg+1):
                if 3*a+10*r>bound:
                    infinity_rows.append([f[a] for f in polys]+[extra[a]])
                    infinity_labels.append((j,r,a))
    IC=matrix(K,infinity_rows) if infinity_rows else matrix(K,0,dim+1)
    both=Cmat.stack(IC)
    brank=int(both.rank()); brank0=int(both[:,:dim].rank())
    result.update({'infinity_equations':len(infinity_rows),'combined_rank':brank,
                   'combined_rank_without_kappa':brank0,
                   'combined_kernel_dimension':dim+1-brank,
                   'combined_kappa_can_be_nonzero':brank==brank0})
    results.append(result)
    print(result,flush=True)
result={'n':n,'scope':'necessary geometric coefficient systems, not etale realizations',
        'finite_matrix_dimensions':list(Mat.dimensions()),'finite_rank':rank,
        'finite_nullity':dim,'patterns':results,'seconds':time.monotonic()-start,
        'field_modulus':str(K.modulus()),'beta':str(bK),'alpha':str(alpha)}
if exclusions:
    cols=list(Mat.pivots())
    selected=list(Mat[:,cols].transpose().pivots())
    minor=Mat[selected,cols]
    assert minor.det()!=0
    result['finite_certificate']={'column_labels':columns,'row_labels':rowlabels,
        'matrix':[[codeF(a) for a in row] for row in Mat.rows()],
        'kernel':[[codeF(a) for a in row] for row in kernel.rows()],
        'minor_rows':selected,'minor_columns':cols,'minor_determinant':codeF(minor.det())}
    result['repeated_fiber_certificates']=exclusions
if len(sys.argv)>2:Path(sys.argv[2]).write_text(json.dumps(result,indent=2,default=int)+'\n')
print('complete seconds',result['seconds'],flush=True)
