#!/usr/bin/env python3
"""Formal characteristic-five identities used in the repeated-label proof.

All identities are checked symbolically, not at sampled field elements.
Polynomial arithmetic uses the preserved standard-library implementation.
"""
from pathlib import Path
import sys
ROOT = Path(__file__).resolve().parents[1]
sys.dont_write_bytecode = True
sys.path.insert(0, str(ROOT / 'previous' / 'src'))
from formal_checks import ops


def derivative(poly, variable):
    result = {}
    for exponent, coefficient in poly.items():
        if exponent[variable]:
            key = list(exponent)
            c = coefficient * key[variable] % 5
            key[variable] -= 1
            if c:
                result[tuple(key)] = c
    return result


def implicit_variation():
    # Variable order B,Z,t,b,C,D,M. C may have Laurent exponents in identities.
    one, var, add, mul, scale, power = ops(7, 5)
    B,Z,t,b,C,D,M = [var(i) for i in range(7)]
    def product(*polys):
        answer = one
        for poly in polys:
            answer = mul(answer, poly)
        return answer
    def monomial(exponents, coefficient=1):
        return {tuple(exponents): coefficient % 5} if coefficient % 5 else {}
    # P(alpha)^2=2*C^3*b^29. Keep exactly the terms needed through order t.
    first = product(power(add(scale(B,2),Z),3), scale(product(power(C,3),power(b,29)),2),
                    add(one,scale(product(M,C,power(B,4),t),2)))
    inner = add(add(product(C,power(B,4)),scale(product(C,power(B,3),Z),4)),
                product(t,add(scale(product(D,power(B,8)),2),scale(product(D,power(B,7),Z),3))))
    G = add(first, product(power(B,20),power(inner,3)), -1)
    def at_base(poly):
        result = {}
        for exponents, coefficient in poly.items():
            if exponents[1] or exponents[2]:
                continue
            key = list(exponents)
            key[3] += key[0]
            key[0] = 0
            result = add(result, {tuple(key):coefficient})
        return result
    assert at_base(G) == {}
    indices = {'Gz':(1,), 'Gb':(0,), 'Gt':(2,), 'Gbb':(0,0),
               'Gbz':(0,1), 'Gzz':(1,1), 'Gbt':(0,2), 'Gzt':(1,2)}
    computed = {}
    for name, variables in indices.items():
        poly = G
        for v in variables:
            poly = derivative(poly,v)
        computed[name] = at_base(poly)
    expected = {
        'Gz': monomial((0,0,0,31,3,0,0),2),
        'Gb': monomial((0,0,0,31,3,0,0)),
        'Gt': add(monomial((0,0,0,36,4,0,1),2),monomial((0,0,0,36,2,1,0)),-1),
        'Gbb':monomial((0,0,0,30,3,0,0),-1),
        'Gbz':monomial((0,0,0,30,3,0,0)),
        'Gzz':monomial((0,0,0,30,3,0,0),-2),
        'Gbt':add(monomial((0,0,0,35,4,0,1),-1),monomial((0,0,0,35,2,1,0),-1)),
        'Gzt':add(monomial((0,0,0,35,4,0,1),-2),monomial((0,0,0,35,2,1,0),-2)),
    }
    assert computed == expected
    c = add(monomial((0,0,0,5,1,0,1)),monomial((0,0,0,5,-1,1,0),2))
    lam = add(monomial((0,0,0,4,1,0,1)),monomial((0,0,0,4,-1,1,0),2))
    assert add(computed['Gb'],scale(computed['Gz'],2)) == {}
    assert add(computed['Gt'],mul(c,computed['Gz']),-1) == {}
    assert add(add(computed['Gbb'],scale(computed['Gbz'],4)),scale(computed['Gzz'],4)) == {}
    final = add(computed['Gbt'],scale(computed['Gzt'],2))
    final = add(final,mul(c,computed['Gbz']),-1)
    final = add(final,scale(mul(c,computed['Gzz']),2),-1)
    final = add(final,mul(lam,computed['Gz']))
    assert final == {}
    print('PASS formal implicit-equation derivative table, over F5 with indeterminate b,C,D,M.')
    print('PASS formal F_B=2, F_t=-c, F_BB=0, F_Bt=c/b identities; all denominators cleared.')


def same_root_factors():
    one, var, add, mul, scale, power = ops(2,5)
    b,c = var(0),var(1)
    def product(*polys):
        answer=one
        for poly in polys:
            answer=mul(answer,poly)
        return answer
    def S(r):
        answer={}
        for i in range(r+1):
            answer=add(answer,product(power(b,i),power(c,r-i)))
        return answer
    p=derivative(S(3),0);q=derivative(S(3),1)
    Db=add(add(mul(derivative(p,0),power(b,5)),mul(derivative(p,1),power(c,5))),mul(p,power(b,4)))
    Dc=add(add(mul(derivative(q,0),power(b,5)),mul(derivative(q,1),power(c,5))),mul(q,power(c,4)))
    H1=add(mul(p,Dc),mul(q,Db),-1)
    H2=add(mul(p,derivative(S(7),1)),mul(q,derivative(S(7),0)),-1)
    common=product(add(b,scale(c,2),-1),add(b,c),add(b,scale(c,2)))
    expected1=scale(product(common,power(add(b,c,-1),3),add(add(power(b,2),mul(b,c)),power(c,2))),2)
    quartic=add(add(add(add(power(b,4),scale(product(power(b,3),c),2),-1),product(power(b,2),power(c,2))),scale(product(b,power(c,3)),2),-1),power(c,4))
    expected2=product(common,add(b,c,-1),quartic)
    assert H1==expected1
    assert H2==expected2
    print('PASS both exact same-root transverse determinant factorizations over F5[b,c].')


def run():
    implicit_variation()
    same_root_factors()

if __name__=='__main__':
    run()
