#!/usr/bin/env sage-python
"""Check a rational msolve parametrization against the original atlas equations.

This checks explicit algebraic solutions and their distinctness. Exhaustiveness
uses the separate exact permutation count and chart coverage, not solver status.
Generated number-field data are written beside the supplied parametrization.
"""
from sage.all import QQ, PolynomialRing
from pathlib import Path
import ast
import hashlib
import json
import sys
import time


def encoded(poly):
    return [str(c) for c in poly.list()]


def main():
    root=Path(sys.argv[1])
    if hasattr(sys,'set_int_max_str_digits'): sys.set_int_max_str_digits(0)
    raw=(root/'parametrization.ms').read_text().strip()
    assert raw.endswith(':')
    data=ast.literal_eval(raw[:-1])
    assert data[0]==0
    characteristic,nvars,degree,names,form,param=data[1]
    assert characteristic==0 and param[0]==1
    w_data,d_data,coordinate_data=param[1]
    U=PolynomialRing(QQ,'z');z=U.gen()
    w=U(w_data[1]);den=U(d_data[1])
    assert w.degree()==w_data[0]==degree
    assert den.degree()==d_data[0]
    assert w.gcd(w.derivative())==1 and w.gcd(den)==1
    assert len(coordinate_data)==nvars-1
    numerators=[-U(entry[0][1])/QQ(entry[1]) for entry in coordinate_data]
    assert all(p.degree()<degree for p in numerators)
    factors=w.factor()
    assert all(e==1 for _,e in factors)
    print('square-free degree',degree,'rational factor degrees',
          [f.degree() for f,e in factors],flush=True)
    (root/'factor_polynomials.json').write_text(json.dumps([
        {'degree':int(f.degree()),'polynomial':encoded(f)} for f,e in factors
    ],indent=2)+'\n')
    source=(root/'linear.ms').read_text().splitlines()
    source_names=source[0].split(',')
    ring=PolynomialRing(QQ,names=source_names)
    equations=[ring(p) for p in '\n'.join(source[2:]).split(',') if p.strip()]
    reports=[]
    for number,(factor,_) in enumerate(factors,1):
        started=time.time()
        K=U.quotient(factor,'theta');theta=K.gen()
        values=[K(p)/K(den) for p in numerators]+[theta]
        named=dict(zip(names,values))
        hom=ring.hom([named[n] for n in source_names],K)
        assert all(hom(e)==0 for e in equations)
        # This also checks the selected linear form, so different parameter
        # roots give different coefficient tuples.
        P=PolynomialRing(K,'x');x=P.gen()
        B=x**4+sum(named['b'+str(i)]*x**i for i in range(4))
        c3=K(0) if '--c3-zero' in sys.argv else K(1)
        c0=K(1) if '--c3-zero' in sys.argv else named['c0']
        C=x**4+c3*x**3+named['c2']*x**2+named['c1']*x+c0
        A=(2*B+4*x*B.derivative())*C-5*x*B*C.derivative()
        numerator=C**5+named['s']*x**2*B**4
        F,remainder=numerator.quo_rem(A**2)
        assert remainder==0 and F.degree()==4 and F[4]==QQ(1)/4
        assert named['s']*named['b0']*c0*B.resultant(C)!=0
        if '--c3-zero' in sys.argv:
            assert named['b1']==named['b3']==named['c1']==0
        payload={'degree':int(factor.degree()),'polynomial':encoded(factor),
                 'coordinates':{n:encoded(v.lift()) for n,v in named.items()},
                 'source_quartic':[encoded(c.lift()) for c in F.list()]}
        (root/('factor_%02d.json'%number)).write_text(json.dumps(payload,indent=2)+'\n')
        print('factor',number,'degree',factor.degree(),
              'all original equations and full square identity: PASS;',
              round(time.time()-started,2),'seconds',flush=True)
        reports.append({'factor':number,'degree':int(factor.degree()),
                        'equations':True,'square_identity':True})
    report={'degree':int(degree),'factors':reports,'distinctness':'specified linear form verified',
            'parametrization_sha256':hashlib.sha256(raw.encode()).hexdigest(),
            'scope':'Exact characteristic-zero solutions; completeness requires the separate chart and permutation count.'}
    (root/'verification_summary.json').write_text(json.dumps(report,indent=2)+'\n')


if __name__=='__main__':main()
