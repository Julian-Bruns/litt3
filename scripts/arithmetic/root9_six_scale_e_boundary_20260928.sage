"""Finite-algebra coordinates for the complete e=0 boundary at six scales.

sage -python THIS.py OUTPUT_DIRECTORY
The generator is u; invertible evaluation matrices prove full coverage.
"""
from sage.all import PolynomialRing, matrix, vector
from pathlib import Path
import json
import runpy
import sys

directory=Path(sys.argv[1]);directory.mkdir(parents=True,exist_ok=True)
sys.argv=[sys.argv[0],str(directory/'curve_geometry.json')]
env=runpy.run_path(str(Path(__file__).with_name('root9_six_scale_curves_20260928.sage')))
globals().update({key:env[key] for key in ['K','F5','alpha','beta','R','q','a0','d','b','c','e','sigmas','code']})

basis=[alpha**i*beta**j for i in range(4) for j in range(2)]
def prime_vector(x):
    co=list(K(x).polynomial())
    return vector(F5,co+[0]*(8-len(co)))
change=matrix(F5,[prime_vector(x) for x in basis]).transpose().inverse()
def encode(x):
    v=change*prime_vector(x)
    return sum((int(v[2*i])+5*int(v[2*i+1]))*25**i for i in range(4))
def encode_row(f):
    return [encode(x) for x in f.list()]

ebar=e//q
assert ebar.degree()==8 and ebar.gcd(ebar.derivative()).degree()==0
M=PolynomialRing(K, names=['z','t'], order='lex');z,t=M.gens()
S=PolynomialRing(K,'v');v=S.gen()
rows=[]
for sc in sigmas:
    a=a0-code(sc)*d
    assert a.gcd(ebar).degree()==0
    assert (b*b-4*a*c).gcd(ebar).degree()==0
    I=M.ideal([ebar(z),a(z)*t*t+b(z)*t+c(z)])
    gb=I.groebner_basis()
    assert len(gb)==2
    univar=[g for g in gb if g.degree(z)==0]
    linear=[g for g in gb if g.degree(z)==1]
    assert len(univar)==len(linear)==1
    modulus=S(univar[0](z=0,t=v)).monic()
    assert modulus.degree()==16 and modulus.gcd(modulus.derivative()).degree()==0
    lin=linear[0]
    assert lin.monomial_coefficient(z)==1
    qrep=-S(lin(z=0,t=v))
    assert lin == z-M(qrep(t))
    assert ebar(qrep)%modulus==0
    assert (a(qrep)*v*v+b(qrep)*v+c(qrep))%modulus==0
    # The original complete intersection has rank 16 over K, since a is
    # invertible modulo ebar.  This invertible matrix proves the map to
    # K[v]/modulus is an isomorphism, not just a selection of solutions.
    cols=[]
    for j in range(2):
        for i in range(8):
            p=(qrep**i*v**j)%modulus
            cols.append(p.list()+[K(0)]*(16-len(p.list())))
    det=matrix(K,cols).transpose().determinant();assert det
    for factor in [q,d,a,ebar//ebar]:
        assert factor(qrep).gcd(modulus).degree()==0
    for qbad in [10149,118020,64426]:
        assert (qrep-code(qbad)).gcd(modulus).degree()==0
    rows.append(dict(sigma=sc,modulus_in_u=encode_row(modulus),q_in_u=encode_row(qrep),
        coverage_determinant=encode(det)))
out=dict(scope='all allowed e(q)=0 ratios on the six fixed-s curves',
    e_without_q=encode_row(ebar.monic()),rows=rows,geometric_ratio_count=96)
(directory/'e_boundary_models.json').write_text(json.dumps(out,indent=2)+'\n')
print('PASS: six exact rank-16 algebras, 96 geometric ratios, no square claim yet.')
