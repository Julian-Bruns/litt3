#!/usr/bin/env sage-python
"""Derive the actual five theta points over the rational parameter field.

Uses the four Bol sections and their Wronskians; no parameter sampling
or arbitrary quadric realization. Output belongs outside litt3.
"""
from sage.all import GF, FunctionField, PolynomialRing, matrix
import argparse
import json
from pathlib import Path
import time


def derive():
    started = time.monotonic()
    F = FunctionField(GF(5), 'a')
    a = F.gen()
    RT = PolynomialRing(F, 'tt')
    tt = RT.gen()
    coeff = [F(0), a, -a-1, a+1, -a-1, F(1)]
    w = tt**2 + 3*coeff[4]*tt + 3*coeff[3]
    d = -coeff[2] + (coeff[4]+2*tt)*w
    psi = 2*coeff[0] - 2*coeff[1]*tt + coeff[2]*w-d*w
    K = F.extension(psi.monic(), 'T')
    T = K.gen()
    R = PolynomialRing(K, 'u')
    u = R.gen()
    f = u*(u-1)*(u-2)*(u-3)*(u-K(a))
    W = T*T+3*coeff[4]*T+3*coeff[3]
    V = -coeff[2]+(coeff[4]+2*T)*W
    H = 2*u**3+T*u*u+W*u+V

    def Lop(p):
        return f*p.derivative(2)-2*f.derivative()*p.derivative()-H*p

    def Mop(q):
        return f*q.derivative(2)-f.derivative()*q.derivative()+(3*f.derivative(2)-H)*q

    def even_section(top, imposed):
        images = [Lop(u**j) for j in range(top+1)]
        degree = max(p.degree() for p in images)
        rows = [[p[h] for p in images] for h in range(degree+1)]
        rhs = [K.zero()] * len(rows)
        for column, value in imposed.items():
            rows.append([K(j == column) for j in range(top+1)])
            rhs.append(K(value))
        solution = matrix(K,rows).solve_right(matrix(K,len(rhs),1,rhs)).column(0)
        p = sum(solution[j]*u**j for j in range(top+1))
        assert Lop(p) == 0
        return p

    p0 = even_section(4,{4:1})
    print('even degree4 reconstructed',flush=True)
    p1 = even_section(7,{7:1,4:0})
    q0 = u*u+2*T*u+W
    q1 = u**4+(2*coeff[4]-T)*u**3+(3*(2*coeff[4]-T)*W-2*coeff[2])*u-coeff[1]
    assert Mop(q0) == Mop(q1) == 0
    assert p0*p1.derivative()-p0.derivative()*p1 == 3*f*f
    assert q0*q1.derivative()-q0.derivative()*q1 == 2*f
    print('four actual sections and Wronskians verified',flush=True)
    RX = PolynomialRing(K,'x'); x = RX.gen()
    Ns=[]
    for p in [p0,p1]:
        line=[]
        for q in [q0,q1]:
            n=2*f*(p*q.derivative()-p.derivative()*q)+f.derivative()*p*q
            assert all(j%5==0 for j,c in enumerate(n.list()) if c)
            line.append(sum(n[5*j]*x**j for j in range(n.degree()//5+1)))
        Ns.append(line)
    fc=[K(c**5) for c in coeff]
    assert Ns[0][0]*Ns[1][1]-Ns[0][1]*Ns[1][0] == -sum(fc[j]*x**j for j in range(6))
    RXY=PolynomialRing(K,names=('x','y')); x,y=RXY.gens()
    B=-Ns[0][0](x)*Ns[1][1](y)+Ns[0][1](x)*Ns[1][0](y)+Ns[1][0](x)*Ns[0][1](y)-Ns[1][1](x)*Ns[0][0](y)
    polar=2*fc[0]+fc[1]*(x+y)+2*fc[2]*x*y+fc[3]*x*y*(x+y)+2*fc[4]*x*x*y*y+fc[5]*x*x*y*y*(x+y)
    A0=B.monomial_coefficient(x*x)
    A1=B.monomial_coefficient(x**3)
    A2=B.monomial_coefficient(x**3*y)
    assert B == polar+(x-y)**2*(A0+A1*(x+y)+A2*x*y)
    print('actual normalized theta identity verified over F5(a)[T]/Psi',flush=True)

    def serialize(c):
        return [str(F(c.element()[i])) for i in range(5)]

    data={'base':'F5(a)','extension_polynomial':[str(c) for c in psi.monic().list()],
          'p0':[serialize(c) for c in p0.list()], 'p1':[serialize(c) for c in p1.list()],
          'q0':[serialize(c) for c in q0.list()], 'q1':[serialize(c) for c in q1.list()],
          'theta_coordinates':[serialize(c) for c in [A0,A1,A2,K.one()]],
          'checks':['actual even/odd Bol equations','Wronskians','mixed polynomial support','N determinant','normalized theta identity'],
          'seconds':time.monotonic()-started}
    for j,c in enumerate([A0,A1,A2]):
        print('A'+str(j), serialize(c),flush=True)
    return data


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    target=args.output.resolve(); root=Path(__file__).resolve().parents[2]
    if target.is_relative_to(root):raise ValueError('output must be outside litt3')
    result=derive();target.parent.mkdir(parents=True,exist_ok=True)
    target.write_text(json.dumps(result,indent=2)+'\n')
