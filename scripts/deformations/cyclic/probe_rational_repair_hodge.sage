#!/usr/bin/env sage
"""Exact primary Hodge repair on the F625 cyclic genus-six cover.

This computes the actual characteristic-five Cech map, not the next
mixed-characteristic obstruction. The latter remains a separate task.
Laurent reduction follows cyclic5_witt_obstruction.sage, with the
nonconstant additive coefficient chi retained in w^5=chi*w+v*A.
"""
import argparse
import json
from pathlib import Path

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--precision',type=int,default=160)
ap.add_argument('--output',type=Path)
ap.add_argument('--cover-orbit',choices=['rational','nonrational'],default='rational')
args=ap.parse_args()
k0=GF(5**4,'tau',modulus=[3,4,1,4,1]); a0=k0.gen()
if args.cover_orbit=='rational':k=k0;a=a0
else:
    k=GF(5**20,'a');a=k0.embeddings(k)[0](a0)
field_degree=int(k.degree())
root_exponent=5**(field_degree-1)
PR=PolynomialRing(k,'u');u=PR.gen()
f=u*(u-1)*(u-2)*(u-3)*(u-a)
F00=4*a*a+a+2;F01=3*a+3
F10=a**3+3*a*a+3;F11=4*a*a+1
if args.cover_orbit=='rational':slope=a
else:
    SP=PolynomialRing(k,'slope');ss=SP.gen()
    six=F01*ss**6-F11*ss**5+F00*ss-F10
    other=six//(ss-a)
    assert (six%(ss-a))==0 and other.degree()==5
    slope=other.roots()[0][0]
    assert slope**625!=slope and slope**(625**5)==slope
chi=F00+F01*slope**5
N0=f**7+slope**5*f**2*u**20-chi*f*u**24-chi*slope*u**28
AP,remain=N0.quo_rem(u**30)
assert remain.degree()<=27
LS=LaurentSeriesRing(k,'z',default_prec=args.precision);z=LS.gen()
q=z**2+O(z**args.precision)
for _ in range(12):
    eq=q-z**2*sum(f[5-i]*q**i for i in range(6))
    deq=1-z**2*sum(i*f[5-i]*q**(i-1) for i in range(1,6))
    q-=eq/deq
uf=1/q;vf=uf**2/z
shift=z**-3+slope*z**-1
fu=vf*AP(uf)
assert (shift**5-chi*shift-fu).valuation()==1

def coeff(v,e):
    if v.precision_absolute()!=Infinity:return v[e]
    if not v:return k.zero()
    i=e-int(v.valuation()); cs=v.list()
    return cs[i] if 0<=i<len(cs) else k.zero()

powers={}
def affine_monomial(n):
    if n not in powers:
        if n%2==0:powers[n]=uf**(n//2)
        else:
            assert n>=5
            powers[n]=vf*uf**((n-5)//2)
    return powers[n]

def reduce_base(v):
    v=LS(v);aff=LS(0)
    if not v:return v,aff
    for e in range(min(0,int(v.valuation())),1):
        if e in [-3,-1]:continue
        c=coeff(v,e)
        if c:
            term=c*affine_monomial(-e);v-=term;aff+=term
    return v,aff

orders=[-3,-1,1]
def reduce_vector(vec):
    vec=list(vec)
    for j in range(4,-1,-1):
        rem,_=reduce_base(vec[j])
        assert rem.precision_absolute()>3*j+2,'Insufficient certified Laurent tail'
        canonical=sum(coeff(rem,e)*z**e for e in orders)
        tail=rem-canonical
        assert not tail or tail.valuation()>=2
        # Subtract the regular term tail*(w_U-shift)^j.
        for i in range(j):vec[i]-=binomial(j,i)*(-shift)**(j-i)*tail
        vec[j]=canonical
    return vector(k,[coeff(vec[j],e) for j in range(5) for e in orders])

h=4*a+3
mu=(uf-a)*(uf-h)**2/(4+4*a)
rho=vector(k,[1+4*a+2*a*a,1+a+a**3,a+2*a*a+2*a**3]+[0]*12)
cols=[]
for j in range(5):
    for e in orders:
        vec=[mu*z**(5*e)*binomial(j,i)*chi**i*fu**(j-i)
             if i<=j else LS(0) for i in range(5)]
        cols.append(reduce_vector(vec))
psi=matrix(k,cols).transpose()
assert psi.rank()==13
assert psi.augment(matrix(k,15,1,list(rho))).rank()==13

# Lift of the hyperelliptic involution: (u,v,w)->(u,-v,-w).
# In the tangent frame eta^-1 the cohomology signs are (-1)^j.
reflection=diagonal_matrix(k,[(-1)**j for j in range(5) for _ in orders])
assert reflection*psi==psi*reflection
plus=[3*j+i for j in [0,2,4] for i in range(3)]
minus=[3*j+i for j in [1,3] for i in range(3)]
plus_psi=psi.matrix_from_rows_and_columns(plus,plus)
minus_psi=psi.matrix_from_rows_and_columns(minus,minus)
assert plus_psi.rank()==8 and minus_psi.rank()==5
plus_rhs=vector(k,[rho[i] for i in plus])
solution_plus=plus_psi.solve_right(plus_rhs)
solution=vector(k,15)
for i,x in zip(plus,solution_plus):solution[i]=x
assert psi*solution==rho
actual=vector(k,[x**root_exponent for x in solution])
assert psi*vector(k,[x**5 for x in actual])==rho
kernel_actual=[vector(k,[x**root_exponent for x in row])
               for row in psi.right_kernel().basis()]
plus_kernel=[vector(k,[x**root_exponent for x in row])
             for row in plus_psi.right_kernel().basis()]
assert len(plus_kernel)==1

# Independent direct replay from the actual preimage, not the stored matrix.
vec=[LS(0) for _ in range(5)]
for j in range(5):
    term=sum(actual[3*j+i]**5*z**(5*orders[i]) for i in range(3))
    for i in range(j+1):vec[i]+=mu*term*binomial(j,i)*chi**i*fu**(j-i)
assert reduce_vector(vec)==rho

# The geometric cyclic action is only defined over F625^2.
kk=GF(5**(2*field_degree),'b');emb=k.embeddings(kk)[0]
PP=PolynomialRing(kk,'s');s=PP.gen()
lam=(s**4-emb(chi)).roots()[0][0]
deck=zero_matrix(kk,15)
for j in range(5):
    for e in range(3):
        for i in range(j+1):deck[3*i+e,3*j+e]=binomial(j,i)*lam**(j-i)
psi_ext=matrix(kk,[[emb(c) for c in row] for row in psi])
assert deck**5==identity_matrix(kk,15)
assert deck*psi_ext==psi_ext*deck.apply_map(lambda c:c**5)
ref_ext=matrix(kk,[[emb(c) for c in row] for row in reflection])
assert ref_ext*deck*ref_ext==deck**-1
ker_ext=matrix(kk,[[emb(c) for c in row] for row in kernel_actual])
act=[]
for row in ker_ext:
    act.append(ker_ext.transpose().solve_right(deck*vector(kk,row)))
deck_kernel=matrix(kk,act).transpose()
assert (deck_kernel-identity_matrix(kk,2)).rank()==1
assert (deck_kernel-identity_matrix(kk,2))**2==zero_matrix(kk,2)
ob_difference=deck*vector(kk,[emb(c) for c in actual])-vector(kk,[emb(c) for c in actual])
assert ob_difference!=0
assert psi_ext*vector(kk,[c**5 for c in ob_difference])==0
# The primary solution torsor has no fixed point, since a fixed vector
# is a pullback from the base, whose obstruction is nonzero.
fix=deck-identity_matrix(kk,15)
all_eq=psi_ext.stack(fix.apply_map(lambda c:c**5))
all_rhs=vector(kk,[emb(c) for c in rho]+[0]*15)
assert all_eq.augment(matrix(kk,30,1,list(all_rhs))).rank()>all_eq.rank()

base_weights=vector(k,[3*a*a+a+1,3*a+4,3])
trace_row=vector(k,[0]*12+list(-chi*base_weights))
assert trace_row*psi==0
dual_other=next(row for row in psi.left_kernel().basis()
                if matrix(k,[trace_row,row]).rank()==2)
enc=lambda c:[int(c[i]) for i in range(field_degree)]
receipt={'status':'PASS','scope':'Actual primary Hodge map and invariant repair only; no higher-Witt obstruction or full BT group constructed.',
 'cover_orbit':args.cover_orbit,'field_degree':field_degree,
 'field_modulus':[int(c) for c in k.modulus()],
 'tau':enc(a),'shift_coefficients':[enc(k(1)),enc(slope)],
 'H':enc(chi),'affine_Q_coefficients':[enc(c) for c in AP],
 'precision':int(args.precision),
 'basis':[[int(j),int(e)] for j in range(5) for e in orders],
 'psi':[[enc(c) for c in row] for row in psi],
 'rho':[enc(c) for c in rho],
 'preimage':[enc(c) for c in actual],
 'kernel':[[enc(c) for c in row] for row in kernel_actual],
 'obstruction_dual_rows':[[enc(c) for c in row] for row in [trace_row,dual_other]],
 'reflection_invariant_indices':[int(i) for i in plus],
 'reflection_invariant_kernel':[enc(c) for c in plus_kernel[0]],
 'rank':13,'defect':2,'invariant_rank':8,'invariant_defect':1,
 'anti_invariant_rank':5,'anti_invariant_defect':1,
 'cyclic_kernel_block_sizes':[2], 'fixed_primary_solution':False}
if args.output:
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
print('PASS:',args.cover_orbit,'orbit; field degree',field_degree,
      '; primary repair, invariant affine line, defect2 block, no cyclic-fixed repair.',flush=True)
