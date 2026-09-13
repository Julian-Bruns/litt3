"""Verify the exact reduced solution algebra used in the oper census.

The proposed polynomial P is NOT squarefreed. The check uses the original
normalized differential identities, not the candidate Groebner basis.
This stage constructs distinct solutions. The full census verifier proves
completeness afterwards by exhausting the independent global length.
"""
import argparse, hashlib, json, sys, time
from pathlib import Path

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('input')
parser.add_argument('--output',required=True)
args=parser.parse_args()
data=json.loads(Path(args.input).read_text())
R=PolynomialRing(GF(5),'z',implementation='FLINT');z=R.gen()
P=R(data['P']);assert P.is_monic() and P.degree()==19290
K=R.quotient(P,'u');u=K.gen()
coordinates={name:K(R(h)) for name,h in data['coordinate_polynomials'].items()}
assert coordinates[data['separator']]==u
a=coordinates['zeta'];assert a*a+4*a+2==0
S=PolynomialRing(K,'x');x=S.gen()
F=(x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6
   +4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2+(4*a+2)*x+2*a+1)
Fp=F.derivative();Fpp=F.derivative(2)
Chat=x**4+sum(coordinates[f'c{i}']*x**i for i in range(4))
Ahat=x**10+sum(coordinates[f'a{i}']*x**i for i in range(10))
base=2*Fpp*F+2*Fp**2+2*x**8*F

def L(n,j):
    return F**2*n.derivative(2)+(4*j-4)*F*Fp*n.derivative()+(2*j-2)*F*Fpp*n+(2*j-2)*(2*j-3)*Fp**2*n

def monic_division(n,d):
    # Valid over the nonreduced algebra K; do not invoke field-only division.
    assert d.leading_coefficient()==1
    q=S.zero();r=n
    while r and r.degree()>=d.degree():
        term=r.leading_coefficient()*x**(r.degree()-d.degree())
        q+=term;r-=term*d
    return q,r

started=time.monotonic()
T,rem=monic_division(L(Ahat,2)-base*Ahat-3*F**2*Chat**2,F)
assert not rem
B,e2=monic_division(T,Ahat)
assert B.degree()<=7
print('reconstructed B; checking normalized identities',flush=True)
n0=base+F*B
W=F*(Chat*F).derivative(2)-n0*Chat
assert W.degree()<=20
lam=2*W[20]
e1=W-3*lam*Ahat**2
e0,rem=monic_division(L(n0,0)-3*n0**2,F**2)
assert not rem
e0-=lam*Chat*Ahat
assert not e0 and not e1 and not e2
assert R(lam.lift()).gcd(P)==1
assert P.gcd(P.derivative())==1
print('PASS all original normalized identities and nonzero cubic scale',flush=True)
# These are exactly the44 coefficient relations of normalized_oper_quotient.sage.
# The separator maps to u. This gives a surjection onto the candidate
# algebra; its identification with the whole scheme is a later conclusion.
result={
    'status':'VERIFIED_reduced_normalized_solution_algebra',
    'dimension_F5':int(P.degree()),'dimension_F25':int(P.degree()//2),
    'source_reconstruction':str(Path(args.input).resolve()),
    'source_sha256':hashlib.sha256(Path(args.input).read_bytes()).hexdigest(),
    'certificate':'Original normalized identities vanish modulo squarefree P; coefficient field polynomial vanishes; separator is u and cubic scale is a unit.',
    'completeness':'Not asserted by this construction alone. The full fixed_x_oper_enumeration proof exhausts global length29375 using these points and invariant local quotients.',
    'P':[int(c) for c in P.list()],
    'coordinates':data['coordinate_polynomials'],
    'B':[[int(v) for v in c.lift().list()] for c in B.list()],
    'lambda':[int(c) for c in lam.lift().list()],
    'elapsed_seconds':time.monotonic()-started,
    'common_cover_problem':'UNSOLVED; this certifies only the normalized rank-two candidate algebra'}
Path(args.output).write_text(json.dumps(result,separators=(',',':'),default=int)+'\n')
print('VERIFIED 9645 distinct normalized solutions; completeness is a separate census step',flush=True)
