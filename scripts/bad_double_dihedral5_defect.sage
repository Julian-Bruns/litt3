#!/usr/bin/env sage
"""Actual dihedral degree-ten carrier: bounded characteristic-five diagnostic.

C: kappa^2=u(u-3), gamma^2=(u-1)(u-2)(u-t). Pull back the unique
geometric etale cyclic-five cover of E:gamma^2=(u-1)(u-2)(u-t).
The involution tau:(kappa,gamma)->(-kappa,-gamma) gives D10 over Y.
This is NOT the AS pullback from Y in bad_double_cyclic5_defect.sage.

The commuting elliptic-quotient involution kappa->-kappa splits the
30-dimensional tangent calculation into blocks of dimensions10 and20.
All arithmetic is exact. No higher-Witt or common-span claim is made.
"""
import argparse
import json
import time
from pathlib import Path

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--precision',type=int,default=160)
parser.add_argument('--symbolic',action='store_true')
parser.add_argument('--iterates',type=int)
parser.add_argument('--output',type=Path)
args=parser.parse_args()
started=time.monotonic()
Fp=GF(5)
PT=PolynomialRing(Fp,'T');T=PT.gen()
k0=GF(5**4,'t',modulus=T**4+4*T**3+T**2+4*T+3)
t0=k0.gen()

def coeff(f,exponent):
    # Work around exact-constant out-of-range PARI indexing (see C10 script).
    if f.precision_absolute()!=Infinity:
        return f[exponent]
    if not f:
        return f.base_ring().zero()
    index=exponent-int(f.valuation());v=f.list()
    return v[index] if 0<=index<len(v) else f.base_ring().zero()

def setup(k,t,precision):
    PR=PolynomialRing(k,'u');u=PR.gen()
    S=(u-1)*(u-2)*(u-t)
    LS=LaurentSeriesRing(k,'z',default_prec=precision);z=LS.gen()
    # At E's infinity use z=u/gamma, so 1/u=z^2*S(u)/u^3.
    w=z**2+O(z**precision)
    for _ in range(12):
        w-=(w-z**2*sum(S[3-i]*w**i for i in range(4)))/(1-z**2*sum(i*S[3-i]*w**(i-1) for i in range(1,4)))
    uf=1/w;gf=uf/z
    assert (gf**2-sum(S[i]*uf**i for i in range(4))).valuation()>precision-12
    powers={}
    def reduce_affine(f):
        f=LS(f);affine=LS(0)
        if not f:
            return f,affine
        for exponent in range(min(0,int(f.valuation())),1):
            if exponent==-1:
                continue
            c=coeff(f,exponent)
            if c:
                pole=-exponent
                if pole not in powers:
                    powers[pole]=(uf**(pole//2) if pole%2==0 else gf*uf**((pole-3)//2))
                term=c*powers[pole]
                f-=term;affine+=term
        return f,affine
    return PR,u,S,LS,z,uf,gf,reduce_affine

if args.symbolic:
    kt=PolynomialRing(Fp,'t');k=kt.fraction_field();t=k.gen()
    PR,u,S,LS,z,uf,gf,reduce_affine=setup(k,t,args.precision)
    hasse=coeff(reduce_affine(z**(-5))[0],-1)
    assert hasse==t**2+2*t+3
    c=k(1);shift=1/z;as_linear=hasse
else:
    PR,u,S,LS,z,uf,gf,reduce_affine=setup(k0,t0,args.precision)
    hasse=coeff(reduce_affine(z**(-5))[0],-1)
    assert hasse
    PC=PolynomialRing(k0,'c');cvar=PC.gen()
    extension=lcm([f.degree() for f,m in (hasse*cvar**4-1).factor()])
    k=GF(5**(4*extension),'a');t=k0.embeddings(k)[0](t0)
    PR,u,S,LS,z,uf,gf,reduce_affine=setup(k,t,args.precision)
    hasse=coeff(reduce_affine(z**(-5))[0],-1)
    PC=PolynomialRing(k,'c');cvar=PC.gen()
    c=(hasse*cvar**4-1).roots(multiplicities=False)[0]
    shift=c/z;as_linear=k(1)
rem,fu=reduce_affine(shift**5-as_linear*shift)
assert rem.valuation()>=1
assert (shift**5-as_linear*shift-fu-rem).valuation()>args.precision-12
assert (fu-c**5*gf*(uf+2*S[2])).valuation()>args.precision-12
assert all(not coeff(fu,i) for i in range(int(fu.valuation()),10) if i%2==0)
# w_O=w_U-shift; w_U^5-as_linear*w_U=fu. The O-chart RHS is regular.
assert (fu-shift**5+as_linear*shift).valuation()>=0
print(json.dumps(dict(stage='actual_AS_cover',symbolic=args.symbolic,
    AS_linear=str(as_linear),AS_shift='('+str(c)+')*z^-1',
    affine_AS_pole=int(-fu.valuation()))),flush=True)

d=None if args.symbolic else int(k.degree())
def encode(a):
    if args.symbolic:
        return str(a)
    out=a.polynomial().list()
    return [int(x) for x in out]+[int(0)]*(d-len(out))

R=uf*(uf-3)
A=(t+1)**2*uf*(uf-1)*(uf-2)*(uf-3)
receipt=dict(field_degree=d,field_modulus=None if args.symbolic else [int(x) for x in k.modulus()],
    parameter=encode(t),precision=int(args.precision),AS_shift=encode(c),blocks=[])
iterations=args.iterates if args.iterates is not None else (1 if args.symbolic else 6)

for frame,orders,threshold,multiplier,tau_frame_sign in [
    ('D0',[-1,1],2,A,1),
    ('kappa_D0',[-1,1,2,3],4,A*R**2,-1)]:
    def normal(f):
        rem,_=reduce_affine(f)
        canonical=sum(coeff(rem,e)*z**e for e in orders)
        tail=rem-canonical
        assert tail.valuation()>=threshold,('BASE_LATTICE',frame,tail.valuation())
        return canonical,tail
    base=matrix(k,len(orders),len(orders),lambda i,j:coeff(normal(multiplier*z**(5*orders[j]))[0],orders[i]))
    print(json.dumps(dict(stage='base',frame=frame,dimension=len(orders),
        rank=int(base.rank()),iterate2_rank=int((base*base.apply_map(lambda x:x**5)).rank()))),flush=True)

    def reduce_vector(vec):
        vec=list(vec)
        for j in range(4,-1,-1):
            canonical,tail=normal(vec[j])
            assert tail.precision_absolute()>j+threshold
            # Remove tail*w_O^j = tail*(w_U-shift)^j, using the
            # local AS convention corresponding to the computed fu.
            for i in range(j):
                vec[i]-=binomial(j,i)*(-shift)**(j-i)*tail
            vec[j]=canonical
        return vector(k,[coeff(vec[j],e) for j in range(5) for e in orders])

    dim=5*len(orders)
    columns=[]
    for j in range(5):
        for exponent in orders:
            columns.append(reduce_vector([multiplier*z**(5*exponent)*binomial(j,i)*as_linear**i*fu**(j-i)
                if i<=j else LS(0) for i in range(5)]))
    psi=matrix(k,columns).transpose()
    deckcols=[]
    for j in range(5):
        for exponent in orders:
            deckcols.append(reduce_vector([binomial(j,i)*z**exponent if i<=j else LS(0) for i in range(5)]))
    deck=matrix(k,deckcols).transpose();eye=identity_matrix(k,dim)
    delta=matrix(k,dim,dim)
    for j in range(1,5):
        for ii in range(len(orders)):
            delta[(j-1)*len(orders)+ii,j*len(orders)+ii]=j
    tau=diagonal_matrix(k,[tau_frame_sign*(-1)**(exponent+j) for j in range(5) for exponent in orders])
    assert delta**5==0 and delta.rank()==4*len(orders)
    assert delta*psi==as_linear*psi*delta
    assert tau**2==eye and tau*delta*tau==-delta
    if not args.symbolic:
        assert deck**5==eye and (deck-eye).rank()==4*len(orders)
        assert tau*deck*tau==deck**4
        assert deck*psi==psi*deck.apply_map(lambda x:x**5)
    assert tau*psi==psi*tau
    iterate=eye;ranks=[]
    for j in range(1,iterations+1):
        iterate=iterate*psi.apply_map(lambda x:x**(5**(j-1)))
        ranks.append(int(iterate.rank()))
    # Dimensions over the perfect closure: delta and tau have F5 entries,
    # so the coefficient-Frobenius inverse need not be computed explicitly.
    defect=dim-psi.rank()
    fixed_dimension=dim-psi.stack(delta).rank()
    plus=dim-psi.stack(tau-eye).rank()
    minus=dim-psi.stack(tau+eye).rank()
    assert plus+minus==defect
    item=dict(frame=frame,dimension=int(dim),base_rank=int(base.rank()),rank=int(psi.rank()),
        defect=int(defect),iterate_ranks=ranks,
        deck_fixed_kernel_dimension=int(fixed_dimension),
        tau_kernel_plus=int(plus),tau_kernel_minus=int(minus),
        psi=[[encode(x) for x in row] for row in psi],
        deck=None if args.symbolic else [[encode(x) for x in row] for row in deck],
        translation_derivative=[[encode(x) for x in row] for row in delta])
    if args.symbolic:
        pivot_columns=list(psi.pivots())
        pivot_rows=list(psi.matrix_from_columns(pivot_columns).transpose().pivots())
        pivot_minor=psi.matrix_from_rows_and_columns(pivot_rows,pivot_columns).det()
        item['rank_minor_rows']=[int(x) for x in pivot_rows]
        item['rank_minor_columns']=[int(x) for x in pivot_columns]
        item['rank_minor_factorization']=str(pivot_minor.factor())
        item['rank_minor_numerator_degree']=int(pivot_minor.numerator().degree())
        item['coefficient_denominators']=str(lcm([x.denominator() for x in psi.list()]).factor())
    receipt['blocks'].append(item)
    print(json.dumps({key:value for key,value in item.items() if key not in ['psi','deck','translation_derivative']}),flush=True)

receipt.update(status='PASS',source_genus=int(11),defect=int(sum(b['defect'] for b in receipt['blocks'])),
    seconds=float(time.monotonic()-started))
if args.output:
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
print('PASS actual dihedral cover diagnostic',receipt['defect'],receipt['seconds'],flush=True)
