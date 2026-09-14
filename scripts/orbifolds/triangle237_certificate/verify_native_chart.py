"""Bounded independent check of the three-pole cofactor normalization.

Checks the entire original native polynomial system against the saved
alpha/beta, and all affine-substitution exports. No unit-ideal assertion.
"""
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, prod

base = Path('/Users/julian/Documents/litt3-computation-data')
load = lambda name: json.loads((base / name / 'source.json').read_text())
rec = load('degree84-recursive-linear-20260911')
aff = load('degree84-all63-quadratic-subideal-20260911')
chart = load('degree84-three-pole-cofactor-v2-20260911')
K = GF(5**15, 'a', modulus=PolynomialRing(GF(5), 'z')(rec['field_modulus']))
decode = lambda R, f: R({tuple(e): K(c) for e, c in f})
R = PolynomialRing(K, rec['original_variables'], order='degrevlex')
v = R.gens_dict()
U = PolynomialRing(R, 'u'); u = U.gen()
alpha, beta = K(chart['chosen_alpha']), K(chart['chosen_beta'])
assert alpha**3 + alpha + 1 == 0
assert beta**5+(alpha+1)*beta**4+(2*alpha**2-2)*beta**3-2*alpha**2*beta**2+(-2*alpha**2+alpha+1)*beta+2*alpha**2+2*alpha-2 == 0
F = prod(u-t for t in [K(0), K(1), K(2), K(3), alpha])
A = u**18 + sum(v['a%d'%j]*u**j for j in range(18))
B = -u**14 + sum(v['b%d'%j]*u**j for j in range(14))
C = u**6 + sum(v['c%d'%j]*u**j for j in range(6))
p1 = beta**2+3*F[4]*beta+3*F[3]
p0 = -F[2]+(F[4]+2*beta)*p1
P = 2*u**3+beta*u**2+p1*u+p0
H = A*C
s = 3*v['b13']+2*v['c5']
parts = [F*H.derivative(2)+4*F.derivative()*H.derivative()+(3*F.derivative(2)-P)*H,
         (F.derivative()*A+2*F*A.derivative())*C-2*F*A*C.derivative()+B**2,
         3*(B*C).derivative()+s*A,
         s*F*A**2-B**3-C**7]
native = [f for p in parts for f in p if f]+[v['loc']*s-1]
original = [decode(R, f) for f in rec['original_equations']]
assert original[:len(native)] == native, 'Full native polynomial normalization mismatch'
assert original[len(native):] == [v['a%d'%j] for j in (4,9,14)]
print('PASS all native equations, in order:', len(native), 'additional rows:', len(original)-len(native), flush=True)

for data in [rec, aff]:
    W = PolynomialRing(K, data['original_variables'], order='degrevlex')
    subs = {W(name): decode(W, f) for name, f in data['substitutions'].items()}
    assert all(not set(f.variables()).intersection(subs) for f in subs.values())
    current = [decode(W, f) for f in data['original_equations']]
    for stage in data['linear_substitution_stages']:
        fresh = {W(name): decode(W, f) for name, f in stage.items()}
        linear = [f for f in current if f and f.total_degree()==1]
        # Constant row spaces suffice, avoiding any nonlinear ideal computation.
        from sage.all import matrix
        columns = [W.one()]+list(W.gens())
        rows = [[f.monomial_coefficient(c) for c in columns] for f in linear]
        span = matrix(K, rows).row_space()
        assert all(span([ (x-f).monomial_coefficient(c) for c in columns ]) in span
                   for x, f in fresh.items())
        current = [f.subs(fresh) for f in current]
    reduced = list(dict.fromkeys(f.subs(subs) for f in [decode(W, q) for q in data['original_equations']] if f.subs(subs)))
    Q = PolynomialRing(K, data['variables'], order='degrevlex')
    assert reduced == [W(decode(Q, f)) for f in data['equations']]
    print('PASS affine row spaces and whole exported substitution:', len(subs), 'pivots', flush=True)

S = PolynomialRing(K, chart['variables'], order='degrevlex')
cv = {j:S('c%d'%j) for j in (2,3,5)}
Wa = PolynomialRing(K, aff['original_variables'], order='degrevlex')
for j in (0,1): cv[j] = S(decode(Wa, aff['substitutions']['c%d'%j]))
cv[4] = S(decode(R, rec['substitutions']['c4']))
V = PolynomialRing(S, 'u'); t = V.gen()
raw = sum(decode(S,f)*t**j for j,f in enumerate(chart['cofactor_numerators']))
L = decode(S, chart['cofactor_lead'])
assert raw[18] == L and raw.degree()==18
CC = t**6+sum(cv[j]*t**j for j in range(6))
FF = V([S(f) for f in F.list()]); PP = V([S(f) for f in P.list()])
HH = raw*CC
assert FF*HH.derivative(2)+4*FF.derivative()*HH.derivative()+(3*FF.derivative(2)-PP)*HH == 0
for j in (4,9,14): assert raw[j] == 0
suba17 = S(decode(R, rec['substitutions']['a17']))
assert raw[17] == L*suba17
assert {str(x) for f in cv.values() for x in f.variables()} <= {'c2','c3','c5'}
print('PASS saved cofactor full ODE, leading normalization, a17, zero coefficients, and joint three-pole affine chart', flush=True)

# Reconstruct the signed minors using determinants, independently of the
# producer's explicit permutation expansion.
UK = PolynomialRing(K, 'u'); x = UK.gen()
FK = UK([K(f) for f in F.list()]); PK = UK([K(f) for f in P.list()])
columns = [FK*(x**j).derivative(2)+4*FK.derivative()*(x**j).derivative()
           +(3*FK.derivative(2)-PK)*x**j for j in range(5)]
ker = matrix(K,8,5,lambda i,j: columns[j][i],implementation='generic').right_kernel().basis()
assert len(ker)==2
hs = [UK(list(v)) for v in ker]
assert hs[0].gcd(hs[1]) == 1
wr = hs[0]*hs[1].derivative()-hs[0].derivative()*hs[1]
assert wr and wr % FK == 0 and (wr//FK).degree()==0
ST = PolynomialRing(S, 'T'); T=ST.gen()
M = matrix(ST,5,6)
for j in range(4):
    for degree, coef in enumerate(CC.list()):
        M[(degree+j)%5,j] += coef*T**((degree+j)//5)
for j,h in enumerate(hs):
    for i in range(5): M[i,4+j] = -h[i]
cof = [(-1)**j*M.matrix_from_columns([i for i in range(6) if i!=j]).det() for j in range(6)]
rebuilt = sum(t**j*sum(c*t**(5*i) for i,c in enumerate(cof[j].list())) for j in range(4))
assert rebuilt == raw
print('PASS all signed cofactor determinants equal saved numerator exactly', flush=True)
