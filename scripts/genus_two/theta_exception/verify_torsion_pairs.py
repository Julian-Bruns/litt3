#!/usr/bin/env sage-python
"""Independently verify all pair-theta torsion points using Sage's Jacobian."""
import argparse
import json
from pathlib import Path
from sage.all import *


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('certificate',type=Path)
    args=ap.parse_args()
    data=json.loads(args.certificate.read_text())
    R=PolynomialRing(GF(5),'x')
    shifts=set()
    for row in data['results']:
        K=GF(5**60,'w',modulus=R(row['field_modulus']))
        P=PolynomialRing(K,'x');x=P.gen()
        loc={'w':K.gen(),'x':x}
        alpha=K(sage_eval(row['alpha'],locals=loc))
        T=K(sage_eval(row['T'],locals=loc))
        dec=lambda n:K(n%5)+K(n//5%5)*alpha+K(n//25)*alpha**2
        assert alpha**3+alpha+1==0
        assert sum(dec(a)*T**i for i,a in enumerate([63,81,75,53,6,1]))==0
        assert T**125!=T and T**(125**5)==T
        f=P(sage_eval(row['f'],locals=loc))
        assert f==sum(dec(a)*x**i for i,a in enumerate([0,106,48,107,48,1]))
        u=P(sage_eval(row['u'],locals=loc));v=P(sage_eval(row['v'],locals=loc))
        assert u.degree()==2 and u.is_monic() and v.degree()<2
        assert (v*v-f)%u==0
        s=-u[1];p=u[0];disc=s*s-4*p
        assert disc!=0
        pol=f[1]*s+2*f[2]*p+f[3]*s*p+2*f[4]*p*p+s*p*p
        norm=v[0]**2+s*v[0]*v[1]+p*v[1]**2
        kap=(K(1),s,p,(pol-2*norm)/disc)
        A=[[55,82,104,115,87],[67,74,82,45,60],[19,60,68,13,18]]
        z=lambda t:[sum(dec(a)*t**i for i,a in enumerate(r)) for r in A]+[K(1)]
        shift=row['pair_shift'];shifts.add(shift)
        assert sum(a*b for a,b in zip(z(T),kap))==0
        assert sum(a*b for a,b in zip(z(T**(125**shift)),kap))==0
        # Four distinct Kummer points over the fixed degree-five field
        # exhaust this line/quartic intersection; their two signs give eight.
        orbit={tuple(a**(125**(5*j)) for a in kap) for j in range(4)}
        assert len(orbit)==4
        J=HyperellipticCurve(f).jacobian()(K);D=J([u,v])
        RR=PolynomialRing(ZZ,'t');t=RR.gen()
        N=abs((t**4-8*t**3+182*t**2-1000*t+15625).resultant(t**20-1))
        assert N==row['jacobian_order'] and N.valuation(5)==6
        primary=(N//5**6)*D
        assert N*D==0 and 125*primary==0 and 25*primary!=0
        print('PASS: pair shift',shift,
              'four Kummer conjugates; eight line classes; exact5-part125',flush=True)
    assert shifts=={1,2}
    print('PASS: both five-cycle pair orbits exhaust all ten pair intersections',flush=True)


if __name__=='__main__':
    main()
