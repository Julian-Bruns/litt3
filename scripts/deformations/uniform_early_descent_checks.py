"""Exact local arithmetic checks used in the uniform early-descent argument.

Requires Python 3 and sympy.  No numerical or floating-point arithmetic.
These check local identities and valuation bounds, not global descent.
"""
from math import factorial
import sympy as sp

p, t, z, u, a, b, c, d = sp.symbols('p t z u a b c d')
r = sp.Function('r')(t)
B = sp.Matrix([[0, p**2 * r], [1, 0]])
C = sp.Matrix([[0, r], [1, 0]])
Dp = sp.diag(p, 1)
K = L = sp.eye(2)
for j in range(1, 8):
    K = (p * K.diff(t) + B * K).applyfunc(sp.expand)
    L = (L.diff(t) + C * L).applyfunc(sp.expand)
    assert (K - Dp * p**j * L * Dp.inv()).applyfunc(sp.simplify) == sp.zeros(2)
    if j == 5:
        assert sp.simplify(K[1, 0] - p**4 * (r**2 + 3*sp.diff(r,t,2))) == 0
print('PASS: Rees-conjugation recurrence for j=1,...,7 and exact K_5 entry')

# The actual fractional-linear graph transformation, without polarization.
F = (c + d*z*u)/(a + b*z*u)
coef5 = sp.expand(sp.series(F,z,0,6).removeO()).coeff(z,5)
assert sp.simplify(coef5 - (a*d-b*c)*b**4*u**5/a**6) == 0
print('PASS: exact quintic graph coefficient (ad-bc)b^4 u^5/a^6')

# Independent test of the scalar-normalization quintic coefficient.
s = z * sp.Function('u')(t)
H = sp.Matrix([1, s])
nabla = lambda v: v.diff(t) + C*v
V = nabla(H)
D = sp.det(sp.Matrix.hstack(H,V))
Num = sp.det(sp.Matrix.hstack(nabla(V),V))
assert sp.expand(D - (1+sp.diff(s,t)-r*s**2)) == 0
uu = sp.Function('u')(t)
AA = sp.diff(r,t)*uu + 3*r*sp.diff(uu,t) - sp.diff(uu,t,3)/2
BB = 3*sp.diff(r,t)*uu*sp.diff(uu,t) + 3*r*sp.diff(uu,t)**2 - r**2*uu**2 + sp.diff(r,t,2)*uu**2/2
assert sp.expand(Num-sp.diff(D,t,2)/2-r-z*AA-z**2*BB) == 0
print('PASS: scalar-normalization numerator has integral (at 5) degree <=2')

# Exhaustive finite check, plus the proof uses Legendre's formula for all j.
def v5fact(n):
    v = 0
    while n:
        n //= 5
        v += n
    return v
for j in range(1, 1001):
    for ell in range(j+1):
        v = j-1-v5fact(ell)-v5fact(j-ell)
        assert v >= 0
        if j >= 3:
            assert v >= 2
print('PASS: all 501500 mixed factorial bounds through j=1000')

# Exact arithmetic in Z[w]/(w^2-2), an unramified quadratic 5-adic order.
def add(x,y): return (x[0]+y[0],x[1]+y[1])
def mul(x,y): return (x[0]*y[0]+2*x[1]*y[1],x[0]*y[1]+x[1]*y[0])
def scale(c,x): return (c*x[0],c*x[1])
def power(x,n):
    r=(1,0)
    while n:
        if n&1: r=mul(r,x)
        x=mul(x,x); n>>=1
    return r
phi=lambda x:(x[0],-x[1])
x=(1,1)
assert power(x,5)==(41,29)
for m in range(1,9):
    inp=scale(5**(m+1),x)
    num=add(phi(inp),scale(-1,power(inp,5)))
    assert all(v%5==0 for v in num)
    lhs=tuple(v//5 for v in num)
    rhs=add(scale(5**m,phi(x)),scale(-5**(5*m+4),power(x,5)))
    assert lhs==rhs
print('PASS: weighted Witt-delta identity for m=1,...,8 on 1+w, Phi(w)=-w')

# Sharp fifth-degree graph term at m=1, tested modulo 5^5.
mod=5**5
trunc=(0,0)
for deg in range(1,6):
    trunc=add(trunc,scale((-5)**(deg-1),power(x,deg)))
# (1+5x) * trunc = x modulo 5^5.
error=add(mul(add((1,0),scale(5,x)),trunc),scale(-1,x))
assert all(v%mod==0 for v in error)
print('PASS: u/(1+5u) = u-5u^2+25u^3-125u^4+625u^5 mod 5^5')
