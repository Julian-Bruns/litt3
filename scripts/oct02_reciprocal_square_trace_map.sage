#!/usr/bin/env sage
"""Four tiny polynomial identities for the new global quadratic map."""
import json,time
from pathlib import Path
start=time.time()
R=PolynomialRing(GF(5),names=('s','a','b','n','tau','e0','D'))
s,a,b,n,tau,e0,D=R.gens()
eta=a*e0-b*tau
# Clear the common denominator s^2 from the three target images.
j1=2*a**2*n
jm=-a*b*s*n+3*a*s*n**2
j2=s**2*(3*b**2*n+2*b*n**2+n**3)
def derivative_aug(poly):
    value=poly.derivative(n)*(-tau*n-eta)
    return value-value.subs({n:0})
assert derivative_aug(j1)==-6*tau*j1
assert derivative_aug(jm)==2*s*e0*j1-7*tau*jm
assert derivative_aug(j2)==4*s*e0*jm-8*tau*j2
# r=-2sD/a and (Q_eta+a0^5)/ell=D-b.
left=4*s**2*D**2*j1-4*s*a*D*jm+a**2*j2
right=a**2*s**2*(3*(D-b)**2*n+3*(D-b)*n**2+n**3)
assert left==right
out={'scope':'global quadratic map polynomial connection and calibration identities',
     'checks':{'K1_squared_horizontal':True,'mixed_horizontal':True,
               'K2_squared_horizontal':True,'actual_cubic_calibration':True},
     'seconds':time.time()-start,'sage_version':version()}
dest=Path('../litt3-computation-data/oct02_reciprocal_twisted_cartier')
dest.mkdir(exist_ok=True)
(dest/'square_trace_map.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
