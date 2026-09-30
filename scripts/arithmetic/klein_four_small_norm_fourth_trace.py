#!/usr/bin/env python3
"""Univariate gcd test for balanced scalars with epsilon*bar(epsilon) in F5.

Run under Sage. No field-point scan: each polynomial gcd retains all
roots and all degree-zero coefficients in its stated norm sector.
"""
import argparse
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing


def main(output):
    start=time.time()
    p=PolynomialRing(GF(5),'z')
    K=GF(5**14,'z',modulus=p([1,2,4,0,4,4,3,1,3,4,4,0,4,2,1]))
    z=K.gen();beta=K([1,1,0,0,4,3,3,1,1,3,1,2,1,1])
    c=lambda n:K(n%5)+(n//5)*beta
    assert beta**2==beta+3 and z**29==1 and beta**25==beta
    R=PolynomialRing(K,'E');E=R.gen()
    kappa=c(17);kb=kappa**5;a=c(12);b=c(8)
    phases=[];seen=set()
    for i in range(29):
        if i not in seen:
            orbit=sorted({i*pow(25,j,29)%29 for j in range(7)})
            seen.update(orbit);phases.append((i,orbit))
    assert len(phases)==5 and len(seen)==29
    out=dict(status='RUNNING',scope='All balanced phases with epsilon^(5^7+1) in F5*',
             exponent=4*(5**7+1),cases=[],phase_orbits=phases)
    output.write_text(json.dumps(out,indent=2)+'\n')
    for i,orbit in phases:
        phi=z**i
        for norm in range(1,5):
            N=K(norm)
            if norm==1:
                F=kappa*phi**5-E*(1-phi**(-8))-kb
            else:
                F=(a*E+4)*(1-N)-b*(E*phi**12+E**626*(kb*phi**7-kappa)-E*N-kb*phi**25+E**5*(1-phi**18)+N*kappa)
            assert F
            F=F.monic()
            if F.degree()==0:
                remainder=R.zero();g=R.one()
            else:
                # Binary powering modulo the degree-at-most626 obstruction.
                r=R.one();power=E%F;n=5**7+1
                while n:
                    if n&1:r=(r*power)%F
                    n//=2
                    if n:power=(power*power)%F
                remainder=(r-N)%F;g=F.gcd(remainder).monic()
            row=dict(phase=i,norm=norm,obstruction_degree=int(F.degree()),gcd_degree=int(g.degree()),
                     gcd_coefficients=[list(map(int,x.polynomial().list())) for x in g.list()],seconds=time.time()-start)
            out['cases'].append(row);output.write_text(json.dumps(out,indent=2)+'\n')
            print('phase',i,'norm',norm,'degree',F.degree(),'gcd',g.degree(),'seconds',round(time.time()-start,2),flush=True)
    out.update(status='COMPLETE',seconds=time.time()-start)
    output.write_text(json.dumps(out,indent=2)+'\n')


if __name__=='__main__':
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--output',type=Path,required=True)
    main(ap.parse_args().output)
