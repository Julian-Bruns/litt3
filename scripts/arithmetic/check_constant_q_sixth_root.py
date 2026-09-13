#!/usr/bin/env python3
"""Test the fixed sixth-root Jacobian obstruction to constant-Q norm solutions.

If P^3+F=R^2, the actual curve z^6=F maps to E:v^2=u^3+1 by
u=P/z^2,v=R/z^3. The map is nonconstant unless P=0, impossible since
F is squarefree. A Frobenius polynomial with no geometric supersingular
elliptic factor therefore excludes every constant-Q norm chart together.
This script computes a candidate polynomial, then checks all cyclotomic
possibilities for eigenvalue5*zeta using the degree44 bound. It does not
silently treat a software output as an independently verified certificate.
"""
import argparse,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,CyclicCover,QQ,ZZ,euler_phi,cyclotomic_polynomial
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('out',type=Path);p.add_argument('--seconds',type=int,default=300)
args=p.parse_args();args.out.mkdir(exist_ok=False);start=time.monotonic()
def report(stage,**kw):
    value=dict(stage=stage,seconds=time.monotonic()-start,**kw)
    print(json.dumps(value),flush=True)
    with (args.out/'progress.jsonl').open('a') as stream:stream.write(json.dumps(value)+'\n')

alarm(args.seconds)
try:
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'z')([2,4,1]));a=k.gen()
    KX=PolynomialRing(k,'x');x=KX.gen()
    f=x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6+4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2+(4*a+2)*x+(2*a+1)
    assert f.gcd(f.derivative())==1
    C=CyclicCover(6,f);assert C.genus()==22
    report('actual_sixth_root_ready',genus=22)
    P=C.frobenius_polynomial();assert P.degree()==44
    report('frobenius_polynomial_candidate',coefficients=[int(c) for c in P.list()])
    QX=PolynomialRing(QQ,'T');T=QX.gen();P=QX(P)
    # A cyclotomic factor has phi(order)<=44. The explicit finite search
    # is bounded via phi(n)>=sqrt(n/2), giving n<=2*44^2.
    possible=[]
    for n in range(1,2*44**2+1):
        if euler_phi(n)>44:continue
        phi=QX(cyclotomic_polynomial(n));factor=QX(5**phi.degree()*phi(T/5))
        if P.gcd(factor).degree()>0:possible.append(n)
    report('geometric_supersingular_factor_test',possible_root_of_unity_orders=possible,
           no_supersingular_elliptic_factor=(not possible))
    (args.out/'result.json').write_text(json.dumps(dict(coefficients=[int(c) for c in P.list()],
        possible_root_of_unity_orders=possible,seconds=time.monotonic()-start,
        status='computed_candidate_requires_independent_arithmetic_review'),indent=2)+'\n')
except AlarmInterrupt:report('time_limit_no_verdict')
finally:cancel_alarm()
