#!/usr/bin/env sage
"""Actual cyclic-five covers of the genus-three bad double.

The anti-invariant tangent module has affine generators kappa and gamma;
its Cech representatives in the kappa*eta^{-1} frame are z,z^2,z^3.
This is a characteristic-five diagnostic, not a higher-Witt certificate.
"""
import argparse
import json
import time
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--precision', type=int, default=160)
parser.add_argument('--field-only', action='store_true')
parser.add_argument('--covers', type=int, default=1)
parser.add_argument('--output', type=Path)
parser.add_argument('--parameter-polynomial',default='3,4,1,4,1',
                    help='irreducible F5 polynomial coefficients, constant first')
args = parser.parse_args()
started = time.monotonic()
Fp = GF(5)
PT = PolynomialRing(Fp, 'T')
T = PT.gen()
minimal = PT([int(c) for c in args.parameter_polynomial.split(',')])
assert minimal.is_irreducible() and minimal.degree()>=2
parameter_degree=int(minimal.degree())
# The optimized Givaro dense-matrix backend disagrees with direct
# multiplication for some custom F25 moduli in this Sage build.
# Use a generic matrix explicitly: apply_map otherwise reselects the
# broken optimized backend even on a generic matrix over a PARI field.
k0 = GF(5**parameter_degree, 't', modulus=minimal,impl='pari_ffelt')
t0 = k0.gen()


def laurent_coefficient(f, exponent):
    """Avoid PARI's incorrect out-of-range indexing of exact constants.

    In this Sage build, (z^-3)[-2] over GF(5^40) incorrectly returns 1,
    although the same series with finite precision correctly returns 0.
    Explicit list bounds handle exact Laurent polynomials; finite series
    retain Sage's precision checks.
    """
    if f.precision_absolute() != Infinity:
        return f[exponent]
    if not f:
        return f.base_ring().zero()
    index = exponent-int(f.valuation())
    coefficients = f.list()
    return coefficients[index] if 0 <= index < len(coefficients) else f.base_ring().zero()


def setup(k, t, precision):
    PR = PolynomialRing(k, 'u')
    u = PR.gen()
    F = u*(u-1)*(u-2)*(u-3)*(u-t)
    LS = LaurentSeriesRing(k, 'z', default_prec=precision)
    z = LS.gen()
    w = z**2+O(z**precision)
    for _ in range(12):
        w -= (w-z**2*sum(F[5-i]*w**i for i in range(6)))/(1-z**2*sum(i*F[5-i]*w**(i-1) for i in range(1,6)))
    uf = 1/w
    vf = uf**2/z
    powers = {}

    def affine_monomial(pole):
        if pole not in powers:
            if pole % 2 == 0:
                powers[pole] = uf**(pole//2)
            else:
                assert pole >= 5
                powers[pole] = vf*uf**((pole-5)//2)
        return powers[pole]

    def affine_reduce(f):
        f = LS(f)
        affine = LS(0)
        if not f:
            return f,affine
        for exponent in range(min(0,int(f.valuation())),1):
            if exponent in (-3,-1):
                continue
            coefficient = laurent_coefficient(f,exponent)
            if coefficient:
                term = coefficient*affine_monomial(-exponent)
                f -= term
                affine += term
        return f,affine

    return PR,u,F,LS,z,uf,vf,affine_reduce


PR,u,F,LS,z,uf,vf,reduce0 = setup(k0,t0,args.precision)
orders = [-3,-1]
Fmat = matrix(k0,2,2,lambda i,j: laurent_coefficient(reduce0(z**(5*orders[j]))[0],orders[i]),implementation='generic')
linear_frob = matrix(k0,[[1,0],[0,1]],implementation='generic')
for i in range(parameter_degree):
    linear_frob *= matrix(k0,2,2,[c**(5**i) for c in Fmat.list()],implementation='generic')
assert all(c**5 == c for c in linear_frob.charpoly()), (parameter_degree,Fmat,linear_frob,linear_frob.charpoly())
field_degree = linear_frob.multiplicative_order()
# The anti-invariant H1(O) is the elliptic Prym with complementary
# branch set {1,2,t,infinity}; include its F5-fixed AS character field.
elliptic=((u-1)*(u-2)*(u-t0))**2
hasse=elliptic[4]
assert hasse
anti_multiplier=prod(hasse**(5**i) for i in range(parameter_degree))
assert anti_multiplier**5==anti_multiplier
field_degree=lcm(field_degree,anti_multiplier.multiplicative_order())
print(json.dumps(dict(stage='field', frobenius_matrix=str(Fmat),
    coefficient_frobenius_charpoly=str(linear_frob.charpoly()),
    parameter_degree=parameter_degree,extension_over_parameter_field=int(field_degree)), default=str),flush=True)
if args.field_only:
    import os
    os._exit(0)

k = GF(5**(parameter_degree*field_degree),'a',impl='pari_ffelt')
t = k0.embeddings(k)[0](t0)
PR,u,F,LS,z,uf,vf,reduce0 = setup(k,t,args.precision)
for ee in [-3,-1,1]:
    ftest=z**ee
    assert all(laurent_coefficient(ftest,i)==k(i==ee) for i in range(-5,4))
    assert all(laurent_coefficient(ftest,i)==(ftest+O(z**10))[i] for i in range(-5,4))
    rtest,_=reduce0(ftest)
    assert (rtest-ftest).valuation()>1, ('INITIAL_BASIS_REDUCTION',ee)
Fmat = matrix(k,2,2,lambda i,j: laurent_coefficient(reduce0(z**(5*orders[j]))[0],orders[i]))
d = k.degree()
basis = [k.gen()**i for i in range(d)]
def coordinates(a):
    aa=a.polynomial().list()
    return aa+[Fp(0)]*(d-len(aa))
columns = []
for j in range(2):
    for b in basis:
        v = vector(k,[0,0]);v[j]=b
        r = Fmat*vector(k,[x**5 for x in v])-v
        columns.append(vector(Fp,coordinates(r[0])+coordinates(r[1])))
fixed = matrix(Fp,columns).transpose().right_kernel().basis()
assert len(fixed)==2
fixed = [vector(k,[sum(k(v[i+j*d])*basis[i] for i in range(d)) for j in range(2)]) for v in fixed]
assert all(Fmat*vector(k,[a**5 for a in v]) == v for v in fixed)
classes = [fixed[0]+c*fixed[1] for c in Fp]+[fixed[1]]

# On Y, D0=eta^{-1}; anti-invariant tangent sections on C are f*kappa*D0.
# The affine scalar module is k[u] + (v/(u(u-3)))*k[u].
# At infinity kappa*D0 has pole4, so its local scalar lattice is z^4.
R=uf*(uf-3)
A=(t+1)**2*uf*(uf-1)*(uf-2)*(uf-3)
coefficient=A*R**2
cohom_orders=[1,2,3]
anti_powers={}
def reduce_anti(f):
    f=LS(f)
    affine=LS(0)
    if not f:
        return f,affine
    for exponent in range(min(0,int(f.valuation())),1):
        cc=laurent_coefficient(f,exponent)
        if cc:
            pole=-exponent
            if pole not in anti_powers:
                anti_powers[pole]=(uf**(pole//2) if pole%2==0 else
                                  vf/R*uf**((pole-1)//2))
            term=cc*anti_powers[pole]
            f-=term
            affine+=term
    return f,affine

base=matrix(k,3,3,lambda i,j:
    laurent_coefficient(reduce_anti(coefficient*z**(5*cohom_orders[j]))[0],cohom_orders[i]))
assert base.rank()==2
assert (base*base.apply_map(lambda c:c**5)).rank()==2
invariant_base=matrix(k,3,3,lambda i,j:
    laurent_coefficient(reduce0(A*z**(5*[-3,-1,1][j]))[0],[-3,-1,1][i]))
assert invariant_base.rank()==3
print(json.dumps(dict(stage='base',genus=int(3),defect=int(1),simple_zero=True,
    anti_matrix=str(base))),flush=True)

def vector_reduce(vec,shift):
    vec=list(vec)
    for j in range(4,-1,-1):
        rem,_=reduce_anti(vec[j])
        assert rem.precision_absolute()>3*j+4
        canonical=sum(laurent_coefficient(rem,e)*z**e for e in cohom_orders)
        tail=rem-canonical
        assert tail.valuation()>=4
        for i in range(j):
            vec[i]-=binomial(j,i)*(-shift)**(j-i)*tail
        vec[j]=canonical
    return vector(k,[laurent_coefficient(vec[j],e) for j in range(5) for e in cohom_orders])

receipt=dict(field_degree=int(d),field_modulus=[int(c) for c in k.modulus()],
    parameter=[int(c) for c in coordinates(t)],precision=int(args.precision),covers=[])
for number,cl in enumerate(classes[:args.covers]):
    shift=sum(cl[i]*z**orders[i] for i in range(2))
    rem,fu=reduce0(shift**5-shift)
    assert all(laurent_coefficient(rem,e)==0 for e in orders) and rem.valuation()>=1
    columns=[]
    for j in range(5):
        for exponent in cohom_orders:
            vv=[coefficient*z**(5*exponent)*binomial(j,i)*fu**(j-i)
                if i<=j else LS(0) for i in range(5)]
            columns.append(vector_reduce(vv,shift))
    psi=matrix(k,columns).transpose()
    defect=15-psi.rank()
    assert defect in [2,4,5],('Unexpected defect',defect)
    deckcols=[]
    for j in range(5):
        for e in cohom_orders:
            deckcols.append(vector_reduce([binomial(j,i)*z**e if i<=j else
                                          LS(0) for i in range(5)],shift))
    deck=matrix(k,deckcols).transpose()
    assert deck**5==identity_matrix(k,15)
    assert (deck-identity_matrix(k,15)).rank()==12
    assert deck*psi==psi*deck.apply_map(lambda c:c**5)
    iterate=identity_matrix(k,15)
    ranks=[]
    for j in range(1,6):
        iterate=iterate*psi.apply_map(lambda c:c**(5**(j-1)))
        ranks.append(int(iterate.rank()))
    if defect<5:
        assert ranks==[10+max(5-j*defect,0) for j in range(1,6)]
    ker=matrix(k,[vector(k,[c**(5**(d-1)) for c in row])
                  for row in psi.right_kernel().basis()]).row_space()
    assert ker.dimension()==defect
    fixed_kernel=ker.intersection((deck-identity_matrix(k,15)).right_kernel())
    assert fixed_kernel.dimension()==1
    encode=lambda c:[int(a) for a in coordinates(c)]
    item=dict(number=int(number),shift=[encode(c) for c in cl],
        rank=int(psi.rank()),defect=int(defect),iterate_ranks=ranks,
        fixed_kernel_dimension=int(fixed_kernel.dimension()),
        psi=[[encode(c) for c in row] for row in psi],
        deck=[[encode(c) for c in row] for row in deck])
    receipt['covers'].append(item)
    print(json.dumps({kk:vv for kk,vv in item.items() if kk not in ('psi','deck','shift')}),
          flush=True)
receipt.update(status='PASS',seconds=float(time.monotonic()-started))
if args.output:
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
print('PASS actual bad-double cyclic-cover diagnostic',receipt['seconds'],flush=True)
