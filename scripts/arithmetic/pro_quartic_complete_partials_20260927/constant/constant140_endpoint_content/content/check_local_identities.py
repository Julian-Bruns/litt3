#!/usr/bin/env python3
"""Exact checks of the two local identities and the fifth-power scheme lemma.

The universal resultant is already checked by the retained verifier. These
calculations verify its stated low-order specializations, not sample values.
"""
from sympy import symbols, Poly, groebner, expand

def mod5(expr, variables):
    return Poly(expand(expr), *variables, modulus=5)

def main():
    tau,a,b,c,d,m,n = symbols('tau a b c d m n')
    variables=(tau,a,b,c,d,m,n)
    def truncate(expr, cutoff):
        p=mod5(expr,variables)
        return expand(sum(int(co)*tau**ex[0]*a**ex[1]*b**ex[2]*c**ex[3]
                          *d**ex[4]*m**ex[5]*n**ex[6]
                          for ex,co in p.terms() if ex[0]<cutoff))
    # Critical b and c both vanish at the endpoint; no unit assumption on a.
    bb=tau*b;cc=tau*c;Q=tau**3*m;C=tau**3*n
    T=cc**5-Q*bb**5+Q**2*a**5
    U=2*Q*a**5-bb**5
    E=a*d-bb*cc;Delta=bb**2+a*cc
    V=-d*bb**5-2*cc**2*bb**4-3*a*bb**2*cc**3-2*a**2*cc**4+Q*(2*a**5*d-a**4*bb*cc+a**3*bb**3)
    W=a**2*d**2-a*bb*cc*d+2*bb**2*cc**2+bb**3*d+a*cc**3
    M=U*(2*a*E+bb*Delta)-a**2*V
    D0=a**3*(T*W+C*M)+C**2*a**10
    assert mod5(truncate(D0,6)-tau**5*a**5*d**2*c**5,variables).is_zero
    print('PASS exact D0 identity modulo tau^6, including a=0')
    # Here b is arbitrary. D2=T^2 starts in order six.
    T=tau**5*c**5-tau**3*m*b**5+tau**6*m**2*a**5
    assert mod5(truncate(T*T,7)-tau**6*m**2*b**10,variables).is_zero
    print('PASS exact D2 identity modulo tau^7, including all degree drops')
    j=symbols('j0:6')
    lower=[sum(j[i]*j[s-i] for i in range(s+1)) for s in range(5)]
    u=2*(j[0]*j[5]+j[1]*j[4]+j[2]*j[3])
    basis=groebner(lower,*j,modulus=5,order='grevlex')
    assert basis.reduce(Poly(u**5,*j,modulus=5).as_expr())[1]==0
    for i in range(3):
        assert basis.reduce(j[i]**5)[1]==0
    print('PASS exact fifth-power odd-content lemma in the polynomial ideal')
    print('No numerical search or finite-field sampling used in these identities.')
if __name__=='__main__':main()
