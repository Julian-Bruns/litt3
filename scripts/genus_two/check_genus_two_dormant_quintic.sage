"""Exact universal identities; one core, no point sampling or atlas search."""
R = PolynomialRing(GF(5), names=('u','T','a0','a1','a2','a3','a4','c0','c1'))
u,T,a0,a1,a2,a3,a4,c0,c1 = R.gens()
F = u**5+a4*u**4+a3*u**3+a2*u**2+a1*u+a0
W = T**2+3*a4*T+3*a3
V = -a2+(a4+2*T)*W
Psi = 2*a0-2*a1*T+a2*W-V*W
base = 2*(F.derivative(u)/F)**2-F.derivative(u,2)/F
r0 = base+(2*u**3+T*u**2+c1*u+c0)/F
curv0 = R(F**2*(r0.derivative(u,2)-3*r0**2))
assert curv0.coefficient({u:4}) == a3+a4*T-2*c1+2*T**2
assert curv0.coefficient({u:3}) == -2*a2+2*a4*c1-2*c0-c1*T
r = base+(2*u**3+T*u**2+W*u+V)/F
assert F**2*(r.derivative(u,2)-3*r**2) == Psi*(u+T+3*a4)
assert Psi.coefficient({T:5}) == -2
print('PASS universal triangular elimination and quintic identity')

S = PolynomialRing(GF(5), names=('t','z'))
t,z = S.gens()
ev = R.hom([S(0),z,S(0),t,-t-1,t+1,-t-1,S(0),S(0)], S)
P = ev(Psi)
G = t*(t-1)*(t-2)*(t-3)
assert P.resultant(P.derivative(z),z) == -G**2
print('PASS family resultant: Res(Psi,Psi_prime) = -G(t)^2')
print('Every smooth C_t has five DISTINCT dormant connections.')
print('This is not preservation under arbitrary etale pullback.')
