"""Exact supplementary identities for coreless_exact_form_family; one CPU.
Run: sage scripts/common_covers/coreless_exact_form_family_certificate.sage
No covering existence or core claim is inferred from sampling.
"""
from time import monotonic
started = monotonic()
k = GF(5)
Fz = FunctionField(k, 'z'); z = Fz.gen()
Rw = PolynomialRing(Fz, 'W'); W = Rw.gen()
S = Fz.extension(W**2-z**8-3, 'w'); w = S.gen(); zS = S(z)
x = (zS**5+zS*w)/2; y = (zS*w-zS**5)/2
def D(h):
    coeff = S(h).list()
    c0 = coeff[0] if coeff else Fz(0)
    c1 = coeff[1] if len(coeff)>1 else Fz(0)
    return S(4*(z**8+3)*c1.derivative()+z**7*c1) + 4*c0.derivative()*w
assert x-y == zS**5 and zS**2 == 3*x*y
assert zS == 4*(x-y)/(x*y)**2 and w == (x+y)/zS
assert (x*y)**5-x*y == 2*x*x+2*y*y
assert D(x)==1 and D(y)==1 and D(w)==zS**7
h=zS
for _ in range(4): h=D(h)
assert h==4*(x-y)
assert y**5-2*x**(-5)*y**2-x**(-4)*y-2*x**(-3)==0
print('PASS: seed recovery, both AS identities, exact derivation, D^4 z.')
Fx = FractionField(PolynomialRing(k, 't')); t=Fx.gen()
RT = PolynomialRing(Fx, 'T'); T=RT.gen()
f=T**5-2*t**(-5)*T**2-t**(-4)*T-2*t**(-3)
assert f.derivative()==t**(-5)*(T-t)
assert f(t)==t**5 and f.discriminant()==-t**(-20)
print('PASS: exact degree-five discriminant and derivative.')
# Arithmetic stress checks supplement, but do not replace, the gcd proof.
for n in range(1,1000,2):
    if n%5==0: continue
    a=3*n
    assert all(gcd(a,j)==1 for j in (2,4))
    assert all(gcd(a,j)==3 for j in (6,12))
    assert 2*a + 5*(a-1)+3*(n-1)==8*(a-1)
    assert n*(2+1)-1==a-1
assert 4*3-3==9 and 4*9-3==33 and 1+7*(33-1)==225
print('PASS: tame multiplicities/genus checks for all allowed n<1000.')
print('ALL EXACT CHECKS PASS in %.3fs; geometric proof is separate.' % (monotonic()-started))
