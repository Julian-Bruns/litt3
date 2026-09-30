#!/usr/bin/env sage-python
"""Inspect a prime-field saturation result; this is not a rational certificate."""
from sage.all import GF,PolynomialRing,gcd,lcm
from pathlib import Path
import sys,json,time


def main():
    root=Path(sys.argv[1]);p=int(sys.argv[2])
    ring=PolynomialRing(GF(p),names=('b0','b1','b2','b3','c1','c2','c3','s'),order='degrevlex')
    raw=''.join(line for line in (root/'basis.ms').read_text().splitlines(True) if not line.startswith('#')).strip()
    assert raw.startswith('[') and raw.endswith(']:')
    basis=[ring(x) for x in raw[1:-2].split(',') if x.strip()]
    ideal=ring.ideal(basis);started=time.time()
    assert ideal.dimension()==0
    size=int(ideal.vector_space_dimension())
    print('basis',len(basis),'dimension zero; quotient length',size,flush=True)
    input_lines=(root/'saturation.ms').read_text().splitlines()
    inputs=[ring(x) for x in '\n'.join(input_lines[2:]).split(',') if x.strip()]
    assert all(poly.reduce(basis)==0 for poly in inputs[:-1])
    print('all defining equations reduce to zero: PASS',flush=True)
    # Test the open condition on the finite algebra, independently of its
    # use by the saturation implementation.
    assert ring.ideal(basis+[inputs[-1]]).groebner_basis()==[ring(1)]
    print('saturation factor invertible on computed algebra: PASS',flush=True)
    lex=ideal.transformed_basis('fglm')
    (root/'lex_finite.txt').write_text('\n'.join(map(str,lex))+'\n')
    lr=lex.ring();b0,b1,b2,b3,c1,c2,c3,s=lr.gens()
    univariate=PolynomialRing(GF(p),'v');v=univariate.gen()
    substitutions={g:univariate(0) for g in lr.gens()};substitutions[s]=v
    convert=lambda f:univariate(f.subs(substitutions))
    f=convert(lex[-1]);a=-convert(lex[0]);rho=-convert(lex[6])
    assert f.degree()==124 and gcd(f,f.derivative())==1
    assert lex[6]-c3**2==lr(-rho(s))
    boundary=gcd(f,rho);regular=f//boundary
    assert lex[7]==c3*lex[7].derivative(c3)
    assert convert(lex[7].derivative(c3)).monic()==regular
    assert boundary.degree()==12 and regular.degree()==112
    assert gcd(regular,rho)==1
    bad=lcm(boundary,gcd(f,a*a-1));good=f//bad
    assert bad.degree()==40 and good.degree()==84
    assert 2*bad.degree()-boundary.degree()==68
    print('reduced triangular algebra; 12 boundary and 168 good normalized points: PASS',flush=True)
    (root/'good_s_finite.txt').write_text(str(good)+'\n')
    Q=univariate.quotient(regular,'u');u=Q.gen()
    separating={}
    for name,element in [('s_normalized',u/Q(rho)),('c0_normalized',1/Q(rho)**2)]:
        polynomial=element.minpoly();assert polynomial.degree()==56
        separating[name]=int(polynomial.degree())
        (root/(name+'_minpoly_finite.txt')).write_text(str(polynomial)+'\n')
    Qgood=univariate.quotient(good,'ug');ratio=Qgood(a)
    for name,element,expected in [('b0_ratio',ratio,42),('inversion_trace',ratio+1/ratio,21)]:
        polynomial=element.minpoly();assert polynomial.degree()==expected
        separating[name]=int(polynomial.degree())
        (root/(name+'_minpoly_finite.txt')).write_text(str(polynomial)+'\n')
    print('separating degrees',separating,': PASS',flush=True)
    summary={'characteristic':p,'length':size,'basis_size':len(basis),
             'lex_size':len(lex),'elapsed':time.time()-started,'separating_degrees':separating,
             'scope':'Finite-field probe only; source equations imply this model but no characteristic-zero reconstruction yet.'}
    (root/'finite_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(summary,flush=True)


if __name__=='__main__':main()
