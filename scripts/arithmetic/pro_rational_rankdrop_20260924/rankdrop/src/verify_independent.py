#!/usr/bin/env python3
"""Independent exact verification using only Python's standard library.

This file does NOT import algebra.py, NumPy, Numba, or the tensor files.
A Laurent polynomial is a dictionary (x_exponent, y_exponent) -> GF25 code.
"""
from pathlib import Path
import json
import sys

ROOT = Path(__file__).resolve().parents[1]
P_ROW = [11,22,18,5,19,20,15,16,9,22,1]
C_ROW = [2,16,16,7,1,2,7,1,24,11]


def require(ok, message):
    if not ok:
        raise AssertionError(message)


def addc(x, y):
    x1, x0 = divmod(x, 5)
    y1, y0 = divmod(y, 5)
    return (x0+y0) % 5 + 5*((x1+y1) % 5)


def negc(x):
    x1, x0 = divmod(x, 5)
    return (-x0) % 5 + 5*((-x1) % 5)


def mulc(x, y):
    x1, x0 = divmod(x, 5)
    y1, y0 = divmod(y, 5)
    return (x0*y0+3*x1*y1) % 5 + 5*((x0*y1+x1*y0+x1*y1) % 5)


def powc(x, n):
    result = 1
    while n:
        if n % 2:
            result = mulc(result, x)
        x = mulc(x, x)
        n //= 2
    return result


def term(i=0, j=0, c=1):
    require(0 <= j <= 2 and 0 <= c < 25, 'invalid reduced monomial')
    return {(i, j): c} if c else {}


def from_row(row):
    return {(i,0): c for i,c in enumerate(row) if c}


def parse_terms(rows):
    answer = {}
    for i,j,c in rows:
        require(isinstance(i,int) and isinstance(j,int) and isinstance(c,int), 'noninteger term')
        require(0 <= j <= 2 and 0 < c < 25, 'invalid term code')
        require((i,j) not in answer, 'duplicate serialized term')
        answer[i,j] = c
    return answer


def plusadd(a, b):
    answer = a.copy()
    for key,c in b.items():
        answer[key] = addc(answer.get(key, 0), c)
        if not answer[key]:
            del answer[key]
    return answer


def negative(a):
    return {key: negc(c) for key,c in a.items()}


def subtract(a,b):
    return plusadd(a, negative(b))


def times(a,b):
    answer = {}
    for (i,j), c in a.items():
        for (s,t), d in b.items():
            coef = mulc(c,d)
            if j+t < 3:
                key = (i+s,j+t)
                answer[key] = addc(answer.get(key,0),coef)
            else:
                for k,p in enumerate(P_ROW):
                    key = (i+s+k,j+t-3)
                    answer[key] = addc(answer.get(key,0),mulc(coef,p))
    return {key:c for key,c in answer.items() if c}


def power(a,n):
    result = term()
    while n:
        if n % 2:
            result = times(result,a)
        a = times(a,a)
        n //= 2
    return result


def positive(a):
    return {key:c for key,c in a.items() if key[0] >= 0}


def minus(a):
    return {key:c for key,c in a.items() if key[0] < 0}


def pole_weight(a):
    return max((3*i+10*j for i,j in a), default=None)


def upper_bound(a,bound):
    return not a or pole_weight(a) <= bound


def matmul(A,B):
    result = [[{} for _ in B[0]] for _ in A]
    for i in range(len(A)):
        for j in range(len(B[0])):
            for k in range(len(B)):
                result[i][j] = plusadd(result[i][j],times(A[i][k],B[k][j]))
    return result


def b0(d):
    return [(i,j) for j in range(3) for i in range(max(0,(d-10*j)//3+1))]


def b1(d):
    return [(i,j) for j in range(3) for i in range((d-10*j)//3+1,0)]


def check_main():
    print('Independent verification; Python',sys.version.split()[0])
    print('Arithmetic: pure Python, exact GF(25), relation a^2=a+3')
    for c in range(25):
        require(addc(c,negc(c))==0, 'field negation')
        require(powc(c,25)==c, '25th Frobenius')
        if c:
            require(powc(c,24)==1, 'field units')
    require(mulc(5,5)==8, 'field generator relation')
    require(all((x*x-x-3)%5 for x in range(5)), 'irreducible coefficient polynomial')
    print('PASS coefficient field and coefficient Frobenius')

    small=json.loads((ROOT/'certificates'/'polynomial_identity.json').read_text())
    witness=json.loads((ROOT/'certificates'/'witness.json').read_text())
    inputs=json.loads((ROOT/'data'/'input.json').read_text())
    require(small['P']==inputs['P']==P_ROW,'P input mismatch')
    require(inputs['c']==C_ROW, 'extension cocycle input mismatch')
    require(small['C']==list(reversed(C_ROW)), 'numerator C mismatch')
    require(small['D']==[24,2,10,11,1], 'witness D mismatch')
    P,C,D,H,N,J = [from_row(small[key]) for key in ('P','C','D','H','K_low','J_high')]
    lhs=times(power(P,3),plusadd(times(power(C,5),H),times(term(20),power(D,5))))
    rhs=plusadd(N,times(term(50),J))
    require(lhs==rhs, 'polynomial identity fails')
    require(pole_weight(H)==24 and pole_weight(N)==108 and pole_weight(J)==99,'polynomial degrees')
    print('PASS exact identity P^3(C^5 H + x^20 D^5) = N + x^50 J')
    print('PASS degrees (H,N,J) = (8,36,33); all 84 coefficients checked')

    xi=[0]*19
    xi[13:19]=[24,2,10,11,1,0]
    b=[0]*35; b[23]=1
    require(witness['xi']==witness['z']==small['z']==xi, 'xi/z mismatch')
    require(witness['b']==small['b']==b,'b mismatch')
    require(xi[17]==1 and b[23]==1, 'projective nonzero coordinates')
    require([powc(c,25) for c in xi]==xi,'xi^25=z')
    print('PASS projective chart z_17 = b_23 = 1; xi^25 = z')

    e={(-m,2):c for m,c in enumerate(C_ROW,1) if c}
    v=times(term(-6,2),D); u={}
    require(parse_terms(witness['u'])==u and parse_terms(witness['v'])==v, 'extension witness')
    require(e==times(term(-10,2),C),'e numerator')
    E=power(e,25); U=power(u,25); V=power(v,25)
    for name,value in [('E',E),('U',U),('V',V)]:
        require(parse_terms(witness[name])==value,'stored '+name)

    # A smaller first-Frobenius quotient, whose Frobenius pullback gives the witness.
    first_U=[[term(),H,negative(times(term(0,1),J))]]
    first_V=[[term(),H,times(term(-50,1),N)]]
    source1=[[term(),{},negative(power(v,5))], [{},term(),negative(power(e,5))], [{},{},term()]]
    require(matmul(first_V,source1)==first_U,'first Frobenius chart identity')
    require(all(upper_bound(p,d) for p,d in zip(first_V[0],[4,24,-31])),'first Frobenius infinity bounds')
    require(all(not minus(p) for p in first_U[0]),'first Frobenius affine regularity')
    print('PASS auxiliary global quotient F^* R_xi -> O(-O): infinity weights (0,24,-32)')

    # Literal reconstruction (7)--(9), independent of the matrix implementation.
    f={}; alpha=term(); g0={}; q0=power(H,5)
    a=plusadd(positive(times(e,f)),alpha); p=subtract(a,times(e,f))
    w=minus(times(U,f)); g=subtract(g0,positive(times(U,f)))
    chi=subtract(plusadd(times(e,g0),times(e,w)),times(U,a))
    qp=plusadd(q0,positive(chi))
    bs=plusadd(times(E,plusadd(g0,w)),times(V,f)); h=negative(positive(bs))
    ast=plusadd(plusadd(negative(times(e,h)),times(E,subtract(q0,minus(chi)))),times(V,p))
    r=negative(positive(ast))
    fields=dict(a=a,f=f,g=g,q=qp,h=h,r=r,p=p,w=w,chi=chi,bstar=bs,astar=ast)
    for name,value in fields.items():
        require(parse_terms(witness['fields'][name])==value,'reconstruction '+name)
    for name,value in [('f',f),('alpha0',alpha),('g0',g0),('q0',q0)]:
        require(parse_terms(witness[name])==value,'input reconstruction '+name)
    require(all(upper_bound(value,bound) for value,bound in [(f,31),(alpha,20),(g0,131),(q0,120)]),'L_d input bounds')
    out1=b1(-144);out2=b1(-155)
    require((len(out1),len(out2))==(152,163),'residual dimensions')
    require(all(not bs.get(key,0) for key in out1),'b_* residual')
    require(all(not ast.get(key,0) for key in out2),'a_* residual')
    require(negative(power(times(term(0,1),J),5))==r,'compact r formula')
    sminus=power(times(term(-50,1),N),5)
    require(minus(ast)==sminus==parse_terms(witness['s_minus']),'compact negative-part formula')
    require(pole_weight(sminus)==-160,'negative-part infinity weight')
    require(q0==power(H,5) and pole_weight(q0)==120,'q0 bound')
    print('PASS literal formulas (7)--(9); 152+163=315 residual entries vanish')

    Mu=[[a,qp,r],[f,g,h]]
    Mv=[[term(),q0,sminus],[{},{},{}]]
    source2=[[term(),negative(U),negative(V)], [{},term(),negative(E)], [{},{},term()]]
    target=[[term(),negative(e)],[{},term()]]
    require(matmul(Mv,source2)==matmul(target,Mu),'actual K/source chart gluing')
    for row in Mu:
        require(all(not minus(value) for value in row),'U-chart regularity')
    source_degrees=[-25,-125,150];target_degrees=[-5,6]
    for i in range(2):
        for j in range(3):
            require(upper_bound(Mv[i][j],target_degrees[i]-source_degrees[j]),'infinity frame regularity')
    print('PASS M_V G_source = G_K M_U in the reduced Laurent function algebra')
    print('PASS all affine and infinity-frame checks; nonzero V-row weights (0,120,-160)')

    for i,j in [(0,1),(0,2),(1,2)]:
        require(not subtract(times(Mu[0][i],Mu[1][j]),times(Mu[0][j],Mu[1][i])),'generic rank >1')
    require(Mu[0][0]==term() and all(not v for v in Mu[1]),'rank-one form')
    require(pole_weight(Mv[0][1])==120,'surjectivity to O(-5O) at O')
    print('PASS generic rank exactly 1: first entry 1, second row zero')
    print('PASS image exactly the embedded O(-5O): unit entry on U and unit framed q0 entry at O')
    print('DECISION: incidence (12) is NONEMPTY over F25, hence over algebraic closure F5.')
    return True

if __name__=='__main__':
    check_main()
