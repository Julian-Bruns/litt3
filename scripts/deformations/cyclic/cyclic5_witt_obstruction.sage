#!/usr/bin/env sage
"""First-p-cover test for the explicit corank-one higher obstruction.

All calculations are in characteristic five. The construction uses actual
unramified Artin--Schreier covers and triangular Cech reduction on the base.
No higher-Witt calculation on the genus-six cover is guessed or substituted.
"""
import argparse
import json
import time
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--precision', type=int, default=160)
parser.add_argument('--field-only', action='store_true')
parser.add_argument('--output', type=Path)
args = parser.parse_args()
started = time.monotonic()
Fp = GF(5)
PT = PolynomialRing(Fp, 'T')
T = PT.gen()
minimal = T**4+4*T**3+T**2+4*T+3
k0 = GF(5**4, 't', modulus=minimal)
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
Fmat = matrix(k0,2,2,lambda i,j: laurent_coefficient(reduce0(z**(5*orders[j]))[0],orders[i]))
linear_frob = identity_matrix(k0,2)
for i in range(4):
    linear_frob *= Fmat.apply_map(lambda c:c**(5**i))
assert all(c**5 == c for c in linear_frob.charpoly())
field_degree = linear_frob.multiplicative_order()
print(json.dumps(dict(stage='field', frobenius_matrix=str(Fmat),
    coefficient_frobenius_charpoly=str(linear_frob.charpoly()),
    extension_over_F625=int(field_degree)), default=str),flush=True)
if args.field_only:
    import os
    os._exit(0)

k = GF(5**(4*field_degree),'a')
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
h=4*t+3
coefficient=(uf-t)*(uf-h)**2/(4+4*t)
cohom_orders=[-3,-1,1]
rho=vector(k,[1+4*t+2*t**2,1+t+t**3,t+2*t**2+2*t**3])
base = matrix(k,3,3,lambda i,j: laurent_coefficient(reduce0(coefficient*z**(5*cohom_orders[j]))[0],cohom_orders[i]))
assert base.rank()==2 and base.augment(matrix(k,3,1,list(rho))).rank()==3
assert vector(k,[3*t**2+t+1,3*t+4,3])*base==0
expected=matrix(k,[[1+4*t+4*t**2+3*t**3,3+4*t+4*t**2+3*t**3,0],
    [2+2*t,3+4*t+4*t**2+3*t**3,3+4*t+4*t**2+3*t**3],
    [1+3*t+t**2+2*t**3,3+4*t+3*t**2+t**3,2*t+2*t**2+4*t**3]])
assert base==expected, 'Mismatch with the audited higher-matrix variation'
receipt=dict(field_characteristic=int(5),field_degree=int(d),
    field_modulus=[int(c) for c in k.modulus()],parameter=[int(c) for c in coordinates(t)],
    precision=int(args.precision),covers=[])


def vector_reduce(vec,shift):
    vec=list(vec)
    for j in range(4,-1,-1):
        rem,_ = reduce0(vec[j])
        assert rem.precision_absolute()>3*j+2, 'Uncertified Cech tail'
        canonical = sum(laurent_coefficient(rem,e)*z**e for e in cohom_orders)
        tail=rem-canonical
        assert tail.valuation()>=2,(j,[(ee,str(laurent_coefficient(rem,ee))) for ee in range(-5,2)])
        for i in range(j):
            vec[i]-=binomial(j,i)*(-shift)**(j-i)*tail
        vec[j]=canonical
    return vector(k,[laurent_coefficient(vec[j],e) for j in range(5) for e in cohom_orders])


for number,cl in enumerate(classes):
    shift=sum(cl[i]*z**orders[i] for i in range(2))
    rem,fu=reduce0(shift**5-shift)
    assert all(laurent_coefficient(rem,e)==0 for e in [-3,-1]) and rem.valuation()>=1
    # w_U^5-w_U=fu. The O coordinate w_O=w_U-shift satisfies
    # w_O^5-w_O=-rem, regular; hence the projective cover is etale.
    columns=[]
    for j in range(5):
        for exponent in cohom_orders:
            vv=[coefficient*z**(5*exponent)*binomial(j,i)*fu**(j-i) if i<=j else LS(0) for i in range(5)]
            columns.append(vector_reduce(vv,shift))
    psi=matrix(k,columns).transpose()
    defect=15-psi.rank()
    rhs=vector(k,list(rho)+[0]*12)
    augmented_rank=psi.augment(matrix(k,15,1,list(rhs))).rank()
    killed=augmented_rank==psi.rank()
    assert 1<=defect<=5 and killed==(defect<5)
    solution=psi.solve_right(rhs)
    assert psi*solution==rhs
    # Independent direct replay of Psi of this cohomology preimage.
    vv=[LS(0) for i in range(5)]
    for j in range(5):
        c=sum(solution[3*j+i]*z**(5*cohom_orders[i]) for i in range(3))
        for i in range(j+1):
            vv[i]+=coefficient*c*binomial(j,i)*fu**(j-i)
    assert vector_reduce(vv,shift)==rhs
    # Deck action is w_U -> w_U+1. Check nilpotence and equivariance,
    # with Frobenius semilinearity on coefficient scalars retained.
    deckcols=[]
    for j in range(5):
        for e in cohom_orders:
            deckcols.append(vector_reduce([binomial(j,i)*z**e if i<=j else LS(0) for i in range(5)],shift))
    deck=matrix(k,deckcols).transpose()
    assert deck**5==identity_matrix(k,15)
    assert (deck-identity_matrix(k,15)).rank()==12
    assert deck*psi==psi*deck.apply_map(lambda c:c**5)
    encode=lambda c:[int(a) for a in coordinates(c)]
    receipt['covers'].append(dict(number=int(number),shift=[encode(c) for c in cl],
        psi=[[encode(c) for c in row] for row in psi],
        rho=[encode(c) for c in rhs],preimage_fifth_powers=[encode(c) for c in solution],
        rank=int(psi.rank()),defect=int(defect),obstruction_killed=bool(killed)))
    print(json.dumps(dict(stage='cover', number=number,
        rank=int(psi.rank()), defect=int(defect), obstruction_killed=bool(killed),
        precision=int(args.precision),seconds=float(time.monotonic()-started)), default=str),flush=True)
receipt.update(status='PASS',seconds=float(time.monotonic()-started))
if args.output:
    args.output.write_text(json.dumps(receipt,separators=(',',':'))+'\n')
print('PASS: six geometric cyclic-five covers checked by actual Cech cohomology.',flush=True)
