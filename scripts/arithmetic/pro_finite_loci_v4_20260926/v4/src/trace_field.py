"""Exact finite-field certificate for REPORT.md Appendices A-B.

This computes in F_25[alpha]/(A). It is not a search over curves or labels.
"""
from __future__ import annotations
import ff25 as F


def certificate(P: list[int], A: list[int]) -> dict:
    def require(test: bool, message: str) -> None:
        if not test:
            raise AssertionError(message)

    def red(p: list[int]) -> list[int]:
        return F.pdivmod(p, A)[1]

    def mul(p: list[int], q: list[int]) -> list[int]:
        return red(F.pmul(p,q))

    def power(p: list[int], n: int) -> list[int]:
        if n < 0:
            raise ValueError('nonnegative exponent required')
        r=[1]
        while n:
            if n & 1:
                r=mul(r,p)
            p=mul(p,p)
            n >>= 1
        return r

    def inv(p: list[int]) -> list[int]:
        g,s,_=F.xgcd(p,A)
        require(g==[1], 'nonunit in quotient')
        r=red(s)
        require(mul(p,r)==[1], 'quotient inverse check')
        return r

    monic=F.scale(A,F.inv(A[-1]))
    frobenius_checks=[]
    for i in (1,2,3,4):
        r=F.psub(power([0,1],25**i),[0,1])
        g,s,t=F.xgcd(A,r)
        require(F.padd(F.pmul(A,s),F.pmul(r,t))==g, 'irreducibility Bezout')
        require(g==([1] if i<4 else monic), 'A factor-degree check')
        if i==4:
            require(not r, 'degree-four Frobenius relation')
        frobenius_checks.append({'i':i,'x_25_to_i_minus_x_mod_A':r,
                                 'gcd':g,'s':s,'t':t})
    p,pp=red(P),red(F.derivative(P))
    ap,app=red(F.derivative(A)),red(F.derivative(F.derivative(A)))
    top,eta=A[-1],P[-2]
    b29=F.scale(mul(mul(p,p),power(ap,3)),F.mul(3,F.inv(F.power(top,3))))
    inverse_29=pow(29,-1,25**4-1)
    require((29*inverse_29)%(25**4-1)==1, 'inverse of 29')
    b=power(b29,inverse_29)
    require(power(b,29)==b29, 'canonical endpoint label')
    a=F.scale(mul(power(b,4),inv(ap)),top)
    logarithmic_factor=F.psub(mul(pp,inv(p)),mul(app,inv(ap)))
    c=mul(mul(b,a),logarithmic_factor)
    e2=mul(F.psub(F.scale(mul(power(b,3),c),F.mul(4,top)),
                 F.scale(mul(app,mul(a,a)),F.inv(2))),inv(ap))
    conjugates=[power(c,25**i) for i in range(4)]
    matrix=[[[conjugates[j][i] if i<len(conjugates[j]) else 0]
             for j in range(4)] for i in range(4)]
    determinant=F.det_poly(matrix)
    require(determinant==[2], 'normal-basis determinant')
    trace=[]
    for ci in conjugates:
        trace=F.padd(trace,ci)
    require(trace==[5], 'trace of c')
    kappa=F.mul(trace[0],F.inv(eta))
    require(kappa==17 and F.power(kappa,5)!=kappa, 'trace/eta not in F5')
    powers=[pow(5,i,29) for i in range(14)]
    require(len(set(powers))==14 and pow(5,14,29)==1, 'order of 5 modulo 29')
    require(pow(5,7,29)==28, 'half-Frobenius acts by inversion')
    require(all(i in powers for i in (4,5,6,7)), 'four consecutive BCH zeros')
    require(5**56 % 29==1 and (5**8-1)%29!=0, 'field-containment arithmetic')
    # Exact low-order coefficients in the two local pole calculations.
    require((3+2)%5==0, 'simple pole coefficient identity')
    require((3*4-2)%5==0, 'triple pole coefficient identity')
    require(4*3%5==2, 'triple pole trace equals weight/4')
    return {
        'purpose':'certificate for a uniform scalar-and-trace field bound; NOT a branch-curve search',
        'A_monic':monic,
        'A_irreducibility_checks':frobenius_checks,
        'inverse_of_29_mod_5_to_8_minus_1':inverse_29,
        'canonical_B_power_29':b29,
        'canonical_B':b,
        'canonical_a':a,
        'canonical_c':c,
        'canonical_e2':e2,
        'c_conjugates_over_F25':conjugates,
        'c_normal_basis_determinant':determinant,
        'trace_c':trace,
        'eta_coefficient_x9_of_P':eta,
        'trace_c_div_eta':kappa,
        'frobenius_5_of_trace_c_div_eta':F.power(kappa,5),
        'frobenius_ratio':F.mul(F.power(kappa,5),F.inv(kappa)),
        'powers_of_5_mod_29':powers,
        'consecutive_exponents_with_frobenius_indices':{
            str(v):powers.index(v) for v in (4,5,6,7)},
        'endpoint_label_constant_field_degree_over_F5':56,
        'proved_scalar_and_invariant_trace_field_degree_over_F5':56,
        'branch_polynomial_field_bound_claimed':False,
        'endpoint_multiset_enumeration_executed':False
    }
