#!/usr/bin/env sage
"""Necessary global rank-three equations in the constant-first-jet stratum.

All computations are exact over F125, serial, and bounded by an alarm.
No equation system is presumed solved. This does not construct any map X.
"""
import argparse
import itertools
import json
import os
from pathlib import Path
import signal
import time
from sage.env import SAGE_VERSION

parser = argparse.ArgumentParser()
parser.add_argument('--output', required=True)
parser.add_argument('--seconds', type=int, default=60)
args = parser.parse_args()
signal.alarm(args.seconds)
start = time.monotonic()

P0 = PolynomialRing(GF(5), 'u')
u = P0.gen()
k = GF(125, name='alpha', modulus=u^3+u+1)
alpha = k.gen()
c = 2+4*alpha
A, B, C = c-1, c, k(-1)
R = PolynomialRing(k, names=('a0','a1','a2','a3','b0','b1','b2','b3','b4','b5'), order='degrevlex')
a0,a1,a2,a3,b0,b1,b2,b3,b4,b5 = R.gens()
Rx = PolynomialRing(R, 'x')
x = Rx.gen()
H = A*x^5+B*x^4+C
Hp_half = 2*B*x^3
h = 2*B*(A*x^5+C)
zero = (Rx.zero(), Rx.zero())
one = (Rx.one(), Rx.zero())


def add(p, q):
    return (p[0]+q[0], p[1]+q[1])


def scale(p, z):
    return (z*p[0], z*p[1])


def mul(p, q):
    return (p[0]*q[0]+H*p[1]*q[1], p[0]*q[1]+p[1]*q[0])


def D(p):
    # D=w*d/dx, D(w)=H'/2.
    return (H*p[1].derivative()+Hp_half*p[1], p[0].derivative())


def connection(v):
    dv = tuple(D(z) for z in v)
    return (add(dv[0], scale(v[1], -2)),
            add(dv[1], scale(v[2], -3)),
            add(dv[2], scale(v[3], -4)),
            add(dv[3], mul((h, Rx.zero()), v[0])))


def parity(permutation):
    return (-1)^sum(permutation[i]>permutation[j]
                    for i in range(4) for j in range(i+1,4))


def determinant(columns):
    out = zero
    for permutation in itertools.permutations(range(4)):
        term = one
        for j in range(4):
            term = mul(term, columns[j][permutation[j]])
        out = add(out, scale(term, parity(permutation)))
    return out


def D_iterate(p, n):
    for _ in range(n):
        p = D(p)
    return p


for coordinate in ((x,Rx.zero()), (Rx.zero(),Rx.one())):
    assert D_iterate(coordinate,5) == mul((h,Rx.zero()), D(coordinate))
assert D((h,Rx.zero())) == zero
for j in range(4):
    vj = tuple(one if i==j else zero for i in range(4))
    v4 = vj
    for _ in range(4):
        v4 = connection(v4)
    assert v4 == tuple(mul((h,Rx.zero()),z) for z in vj)

a = (a0+a1*x+a2*x^2, Rx(a3))
b = (b0+b1*x+b2*x^2+b3*x^3+4*A*a3*x^4, b4+b5*x)
v = (zero, one, a, b)
columns = [v]
for _ in range(3):
    columns.append(connection(columns[-1]))
det = determinant(columns)
equations = []
for character, polynomial in zip(('even','odd'),det):
    for j in range(polynomial.degree()+1):
        coefficient = polynomial[j]
        if coefficient:
            equations.append((character,j,coefficient))

out = Path(args.output)
out.mkdir(parents=True,exist_ok=True)
lines = ['# Necessary constant-jet rank-three equations; not solved',
         '# Field: F5[alpha]/(alpha^3+alpha+1)',
         '# H=(c-1)x^5+c*x^4-1, c=2+4alpha',
         '# Parameter order: '+','.join(R.variable_names())]
for character,j,equation in equations:
    lines.append(f'{character}[x^{j}] = {equation}')
(out/'equations.txt').write_text('\n'.join(lines)+'\n')
save((R,Rx,k,H,h,det,equations), str(out/'system.sobj'))
summary = {
    'status':'necessary_equations_generated_not_solved',
    'sage_version':SAGE_VERSION,
    'elapsed_seconds':time.monotonic()-start,
    'threads':1,
    'field':'F5[alpha]/(alpha^3+alpha+1)',
    'connection_checks':'D^5=hD and connection^4=hI PASS',
    'parameter_count':10,
    'equation_count':len(equations),
    'even_x_degree':int(det[0].degree()),
    'odd_x_degree':int(det[1].degree()),
    'equation_stats':[{'character':ch,'x_degree':j,
                       'parameter_degree':int(eq.degree()),
                       'monomials':len(eq.monomials())}
                      for ch,j,eq in equations],
    'open_claim':'No global actual horizontal source or endpoint maps constructed.'
}
(out/'summary.json').write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
