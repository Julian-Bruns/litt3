"""Division-free Res_(10,2) circuit in characteristic five.
The argument R may be any characteristic-five commutative algebra.
All numeric constants passed as 0..4 are prime-field elements.
"""
def compact_resultant(a,b,c,d,Q,t,v):
    # a=3G2, b=2G3, c=G4, d=G5, and t is the entire constant term t(x)^3*y^10.
    E=4*a*c-b*b
    D=a*d-b*c
    T=2*a*D-b*E
    p6=b**6-a*c*b**4+4*a*a*c*c*b*b+3*a**3*c**3
    L=a**5*Q*Q-b**5*Q+c**5
    NS=a*D*D-b*D*E+c*E*E
    NUS=E*p6-a*D*b**5+a**5*Q*T
    cross=Q*a**3*T-d*b**5+3*b**4*c*c+2*a*b*b*c**3+3*a*a*c**4
    return [a*a*L*NS+a**3*t*NUS+a**10*t*t,
            v*(L*cross+t*((2*a**5*Q-b**5)**2-2*a**5*L)),
            v*v*L*L]
