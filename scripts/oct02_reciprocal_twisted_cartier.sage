#!/usr/bin/env sage
"""Universal two-leg twisted-Cartier endpoint classification, exact F5 algebra."""
import json,time
from pathlib import Path
started=time.time()
R=PolynomialRing(GF(5),names=('x','c','d','S'))
x,c,d,S=R.gens()
F=(x**4-1)*(x-S);a=c+d*x
X,Y=R.one(),R.zero()
for n in range(4):
 X,Y=F*X.derivative(x)+(-n-3)*F.derivative(x)*X-a*F*Y, F*Y.derivative(x)-n*F.derivative(x)*Y-a*X
assert X.coefficient({x:15})==2*S+3*d**2
assert Y.coefficient({x:11})==3*c*d**2+3*d*S**2+2*d**3*S
I=R.ideal(c,d**2-S)
assert I.reduce(X)==0 and I.reduce(Y)==0
# Universal primitives: do not specialize S to a backup parameter.
Q=PolynomialRing(GF(5),names=('z','s'));z,s=Q.gens()
S0=-s**2;F0=(z**4-1)*(z-S0)
A=2*z**5+S0*z**4+2*S0;B=s*z**2
assert A**2-B**2*F0==4*(z**5-S0)**2
assert A.derivative(z)==s*z*B
assert B.derivative(z)*F0+B*F0.derivative(z)/2==s*z*A
# Differentiate qO=2h^2(sz^2-v), multiply by v/h^2.
# Above expansion: 4sx(sx^2-v)+2(2sx v-F'/2), v terms cancel.
assert 4*s**2*z**3-F0.derivative(z)==1
# qx=h^2/(2s): (dqx)v/h^2=x.
assert 2*s*z/(2*s)==z
# For D=d/dQ_O, the fourth derivative of ell=h^2 is 3s^2/h^5.
# After clearing ell^3, its two polynomial coefficients give:
assert F0.derivative(z,2)+s**2*z**2==3*s*B
assert -4*s*F0-s*z*F0.derivative(z)==3*s*A
# The moving-branch contact numerator has divisor 5P_s+W_S-6O.
Za=2*s*z**2*(z-S0);Zb=-S0/2
assert Za**2-Zb**2*F0==S0*(z-S0)*(z**5-S0)
out={'scope':'all smooth S(S^4-1)!=0, exact characteristic-five polynomial identities',
 'X4_x15':str(X.coefficient({x:15})), 'Y4_x11':str(Y.coefficient({x:11})),
 'full_N4_remainder_mod_c_d2_minus_S':[str(I.reduce(X)),str(I.reduce(Y))],
 'universal_h_norm_and_log_derivative':True,'universal_primitives':True,
 'intrinsic_plane_D4_ell_equals_3s2_over_h5':True,
 'moving_branch_contact_norm':True,
 'seconds':time.time()-started,'sage_version':version()}
dest=Path('../litt3-computation-data/oct02_reciprocal_twisted_cartier')
dest.mkdir(exist_ok=True);(dest/'certificate.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
