#!/usr/bin/env sage
"""Bounded exact Cech tensor for the actual genus-two Hermitian oper.

No polynomial-system solver. Local frames are columns, local=affine*G.
The only expansions used are exact finite-field Laurent series.
"""
import json
import sys
from pathlib import Path
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'r')([2,4,1])); a=k.gen()
beta=next(b for b in k if b**6==2)
R=PolynomialRing(k,'z'); z=R.gen(); F=1+beta*z+beta**5*z**5
Frac=R.fraction_field(); oldt=beta+1/Frac(z)
rz=(4*oldt**4/(oldt**6+3)**2+oldt/(oldt**6+3))/z**4
P=R(F*rz-2*beta**2/F)
def basis(n):
    return sorted([(i,j) for j in range(2) for i in range(n//2+1)
                   if 2*i+5*j<=n],key=lambda m:2*m[0]+5*m[1])
def mul(u,v):
    return (u[0]*v[0]+F*u[1]*v[1],u[0]*v[1]+u[1]*v[0])
def delta(u): return (F*u[1].derivative()+beta*u[1]/2,u[0].derivative())
def sub(u,v): return tuple(x-y for x,y in zip(u,v))
def poly(v,mons): return tuple(sum((c*z**i for c,(i,h) in zip(v,mons) if h==j),R.zero()) for j in range(2))
def columns(images):
    degree=max(f.degree() for v in images for f in v)
    return matrix(k,[[v[j][i] for v in images] for j in range(2) for i in range(degree+1)])
def kernel(n):
    mons=basis(n)
    polys=[poly(v,mons) for v in identity_matrix(k,len(mons)).rows()]
    images=[sub(delta(delta(u)),mul((P,R.zero()),u)) for u in polys]
    return [poly(v,mons) for v in columns(images).right_kernel().basis()]
S14,S29=kernel(14),kernel(29)
assert (len(S14),len(S29))==(4,10)
f1=f2=None
for trial in range(80):
    coeff=vector(k,[list(k)[int((trial+1)**(i+1)%25)] for i in range(4)])
    u=tuple(sum((coeff[i]*S14[i][j] for i in range(4)),R.zero()) for j in range(2))
    images=[sub(mul(u,delta(v)),mul(v,delta(u))) for v in S29]
    M=columns(images); rhs=vector(k,M.nrows()); rhs[0]=1
    try: sol=M.solve_right(rhs)
    except ValueError: continue
    f1=u; f2=tuple(sum((sol[i]*S29[i][j] for i in range(10)),R.zero()) for j in range(2))
    break
assert f1 is not None
assert sub(mul(f1,delta(f2)),mul(f2,delta(f1)))==(R.one(),R.zero())

precision=next((int(arg.split('=')[1]) for arg in sys.argv if arg.startswith('--precision=')),500)
assert precision>=500
PS=PowerSeriesRing(k,'q',default_prec=precision); q=PS.gen()
s=beta**5*q**2+O(q**precision)
for _ in range(12):
    s-=(s-q**2*(beta**5+beta*s**4+s**5))/(1-q**2*(4*beta*s**3))
assert (s-q**2*(beta**5+beta*s**4+s**5)).valuation()>=precision
LS=LaurentSeriesRing(k,'q',default_prec=precision); q=LS.gen()
zz=1/LS(s); ww=zz**2/q; dq=ww/zz.derivative()
assert (ww**2-(1+beta*zz+beta**5*zz**5)).valuation()>400
d=dq[-2]; c=-d
assert d==2*beta**(-5)
def series(u): return u[0](zz)+u[1](zz)*ww
H=matrix(LS,[[series(f1),series(f2)],[series(delta(f1)),series(delta(f2))]])
assert (H.det()-1).valuation()>350
Hi=matrix(LS,[[H[1,1],-H[0,1]],[-H[1,0],H[0,0]]])
Top=matrix(LS,[[q,0],[dq,q**(-1)]])
B0=Hi*q**(-5)*Top
def car_root(f):
    last=int(f.precision_absolute())
    return sum((f[e]**5*q**(e//5) for e in range(int(f.valuation()),last)
                if e%5==0 and f[e]),LS.zero()).add_bigoh((last+4)//5)
G0=B0.apply_map(car_root); epsilon=q**2*G0.det()
assert epsilon.valuation()==0
G=G0*diagonal_matrix(LS,[1/epsilon,1]); Gi=q**2*matrix(LS,[[G[1,1],-G[0,1]],[-G[1,0],G[0,0]]])
assert min(f.valuation() for f in G.list())>=-7
assert min(f.valuation() for f in Gi.list())>=-5
GK=matrix(LS,[[1,c/q],[0,q**2]])
GKi=matrix(LS,[[1,-c/q**3],[0,q**(-2)]])
def frob(f):
    if f.precision_absolute()==Infinity: return f**5
    last=int(f.precision_absolute())
    return sum((f[e]**5*q**(5*e) for e in range(int(f.valuation()),last) if f[e]),LS.zero()).add_bigoh(5*last)
# Cartier projection changes the local basis by an integral invertible
# matrix. B0 itself need not be horizontal; projection is intentional.
Topi=matrix(LS,[[q**(-1),0],[-dq,q]])
cartier_change=Topi*q**5*H*G0.apply_map(frob)
assert all(f.precision_absolute()>0 and f.valuation()>=0 for f in cartier_change.list())
assert cartier_change.det().valuation()==0
J=H.transpose(); Ji=Hi.transpose()
JO=q**4*G.apply_map(frob).transpose()*J*GK
assert min(f.valuation() for f in JO.list())>=0
assert JO.det().valuation()==0
print('frame PASS; P=',P,'beta=',beta,'c=',c,flush=True)

# Cech quotient: remove affine monomials, then quotient the bounded
# remainder by columns of the local lattice. Inverse pole bound b
# implies q^b R^rank is already in the lattice.
reducers={2*i+5*j:zz**i*ww**j for i,j in basis(160)}
reduction_stats={'max_input_pole':0,'minimum_precision_margin':100000}
def rem(f,upper):
    f=LS(f)
    assert f.precision_absolute()>=upper
    assert f.valuation()>=-160
    reduction_stats['max_input_pole']=max(reduction_stats['max_input_pole'],-int(f.valuation())) if f else reduction_stats['max_input_pole']
    for pole in sorted(reducers,reverse=True):
        if -pole<f.valuation(): continue
        v=f[-pole]
        if v: f-=v*reducers[pole]/reducers[pole][-pole]
    assert f.precision_absolute()>=upper
    if f.precision_absolute()!=Infinity:
        reduction_stats['minimum_precision_margin']=min(reduction_stats['minimum_precision_margin'],int(f.precision_absolute())-int(upper))
    assert all(not f[e] for e in range(-160,1) if e not in [-1,-3])
    return f
class Cech:
    def __init__(self,lattice,inverse_bound,pole_bound):
        self.rank=lattice.nrows(); self.upper=inverse_bound
        self.exps=[-1,-3]+list(range(1,inverse_bound))
        self.ambient=VectorSpace(k,self.rank*len(self.exps))
        cols=[self.raw(lattice.column(h)*q**j) for h in range(self.rank)
              for j in range(inverse_bound+pole_bound)]
        self.relations=self.ambient.subspace(cols)
        self.space=self.ambient.quotient(self.relations)
    def raw(self,vec):
        rr=[rem(f,self.upper) for f in vec]
        return self.ambient([f[e] for f in rr for e in self.exps])
    def project(self,vec): return vector(k,self.space(self.raw(vec)))
    def lift(self,vec):
        raw=self.space.lift(self.space(vec)); m=len(self.exps)
        return vector(LS,[sum((raw[h*m+i]*q**e for i,e in enumerate(self.exps)),LS.zero()) for h in range(self.rank)])
BD=Gi.transpose()
B=Cech(BD,7,5)
# Column-major Hom(V,K): each column of a 2x2 matrix is one block.
HL=BD.tensor_product(GK)
HH=Cech(HL,10,6)
assert B.space.dimension()==4
assert HH.space.dimension()==12
alphas=[B.lift(v) for v in B.space.basis()]

# H0 Hom(V,M): p is an affine row, and q^4*p*G must be regular.
mons=basis(9); candidates=[]
for h in range(2):
    for i,j in mons:
        row=vector(LS,[0,0]); row[h]=zz**i*ww**j
        candidates.append(row)
local=[q**4*row*G for row in candidates]
low=min(f.valuation() for row in local for f in row)
Amat=matrix(k,[[row[h][e] for row in local] for h in range(2) for e in range(int(low),0)])
akernel=Amat.right_kernel().basis_matrix()
assert akernel.nrows()==4
ps=[sum((coeff*row for coeff,row in zip(v,candidates)),vector(LS,[0,0])) for v in akernel.rows()]
print('dimensions A,B,H=4,4,12 PASS',flush=True)
def flatten(mat): return vector(LS,[mat[i,j] for j in range(2) for i in range(2)])
Icols=[]
for alpha in alphas:
    Icols.append(HH.project(vector(LS,[alpha[0],0,alpha[1],0])))
Imat=matrix(k,Icols).transpose()
assert Imat.rank()==4
# D(alpha)=-J^-1 alpha^[5], hence Ialpha-L(p,Dalpha)=Ialpha+...
tensor=[]
for p in ps:
    tensor.append([])
    for alpha in alphas:
        col=Ji*alpha.apply_map(frob)
        tensor[-1].append(HH.project(flatten(col.column()*p.row())))
# Exact independence from every bounded generator of the B coboundaries.
# Frobenius is semilinear, so checking a basis checks their complete span.
for rel in B.relations.basis():
    m=len(B.exps)
    alpha=vector(LS,[sum((rel[h*m+i]*q**e for i,e in enumerate(B.exps)),LS.zero()) for h in range(2)])
    assert not HH.project(vector(LS,[alpha[0],0,alpha[1],0]))
    col=Ji*alpha.apply_map(frob)
    for p in ps:
        assert not HH.project(flatten(col.column()*p.row()))
# ell(alpha,p): pullback along u_p=(p2,-p1), modulo omega's q^-2 lattice.
omega=Cech(matrix(LS,[[q**(-2)]]),0,2)
assert omega.space.dimension()==1
kappaclass=omega.project(vector(LS,[c/q**3]))[0]
assert kappaclass
ell=matrix(k,[[omega.project(vector(LS,[alpha[0]*p[1]-alpha[1]*p[0]]))[0]/kappaclass for alpha in alphas] for p in ps])
assert ell.rank()==4
for rel in B.relations.basis():
    m=len(B.exps)
    alpha=vector(LS,[sum((rel[h*m+i]*q**e for i,e in enumerate(B.exps)),LS.zero()) for h in range(2)])
    assert all(not omega.project(vector(LS,[alpha[0]*p[1]-alpha[1]*p[0]])) for p in ps)
print('intrinsic192 coefficients and perfect ell PASS',flush=True)
def encvec(v): return [str(c) for c in v]
result={'field':'F5[a]/(a^2+4a+2)','beta':str(beta),'odd_curve':str(F),
        'scalar_P':str(P),'uniformizer':'q=z^2/w','K_offdiagonal_coefficient':str(c),
        'dimensions':{'A':int(4),'B':int(4),'H':int(12)},
        'f1':[str(f) for f in f1],'f2':[str(f) for f in f2],
        'B_exponents':[int(e) for e in B.exps],
        'alpha_basis':[encvec(B.space.lift(v)) for v in B.space.basis()],
        'p_monomial_basis':[[int(i),int(j)] for i,j in mons],
        'p_basis_affine_component_blocks':[encvec(row) for row in akernel.rows()],
        'H_exponents':[int(e) for e in HH.exps],
        'H_relations':[encvec(row) for row in HH.relations.basis()],
        'I':[encvec(row) for row in Imat.rows()],
        'tensor_plus_Jinverse_alpha5_p':[[encvec(v) for v in block] for block in tensor],
        'ell':[encvec(row) for row in ell.rows()],
        'equations':'I*alpha+sum p_i*alpha_j^5*tensor[i][j]=0; p^T*ell*alpha=1',
        'B_coboundary_generators_checked':int(B.relations.dimension()),
        'reduction_checks':{key:int(value) for key,value in reduction_stats.items()},
        'precision':int(precision),'status':'exact finite Laurent computation; no solver run'}
Path('Research/computations/genus_two_intrinsic_tensor.json').write_text(json.dumps(result,indent=2)+'\n')
