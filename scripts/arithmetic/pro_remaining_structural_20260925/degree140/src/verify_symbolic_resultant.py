"""Universal, parameter-free polynomial check of the closed resultant formula."""
from laurent import LP
LP.nv=8
a,b,c,d,Q,q,l,v=[LP.var(i) for i in range(8)]
Delta=b**2+a*c
Tb=2*a**5*Q-b**5
Hb=2*a**2*d+b**3-a*b*c
U0=Tb*Hb-Delta**4+4*a**7*q
U1=Delta**2*Hb-Tb*Delta
G0=a**3*U0+l*v*(Tb**2+Delta**5)
G1=a**3*U1+2*l*v*Tb*Delta**2
R=a**5*Q**2-b**5*Q+c**5
S=a**2*d**2+b**3*d-a*b*c*d+2*b**2*c**2+a*c**3
K=b**4*c**2+4*a*b**2*c**3+a**2*c**4+3*b**5*d+2*a**3*Q*Hb
L=Tb**2+Delta**5
res=a**3*(R*S+3*(Tb*Hb-Delta**4)*q+a**7*q**2)+3*l*v*(R*K+q*L)+l**2*v**2*R**2
check=G0**2-Delta*G1**2-a**10*res
assert not check
assert Tb**2-Delta**5==4*a**5*R
assert Hb**2-Delta**3==4*a**2*S
assert Tb*Hb+Delta**4==a**2*K
print('Universal closed-resultant polynomial identity: PASS (zero terms in difference).')
print('Auxiliary identities Tb^2-Delta^5, Hb^2-Delta^3, Tb*Hb+Delta^4: PASS.')
