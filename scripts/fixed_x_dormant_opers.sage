#!/usr/bin/env sage
"""Exact dormant rank-two equations on the fixed trigonal genus-nine X.

Equation and certificate generator, not a common-cover exclusion. Use
--invariant for the completed invariant slice; --build-only gives all24
parameters. Enumerate the remaining points with normalized_oper_quotient.sage.
The global regularity proof is Solutions/Sol_fixed_x_dormant_equations.md.
"""
import sys
import time
from pathlib import Path

started = time.monotonic()
k = GF(25, name='a', modulus=PolynomialRing(GF(5), 'z')([2,4,1]))
a = k.gen()
invariant = '--invariant' in sys.argv
names = [f'b{i}' for i in range(8)]
if not invariant:
    names += [f'c{i}' for i in range(5)] + [f'a{i}' for i in range(11)]
P = PolynomialRing(k, names=names, order='degrevlex')
R = PolynomialRing(P, 'x')
x = R.gen()
F = (x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6
     +4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2+(4*a+2)*x+2*a+1)
Fp, Fpp = F.derivative(), F.derivative(2)
v = P.gens()
n0 = 2*Fpp*F + 2*Fp**2 + 2*x**8*F + F*sum(v[i]*x**i for i in range(8))
n1 = R.zero() if invariant else F*sum(v[8+i]*x**i for i in range(5))
n2 = R.zero() if invariant else sum(v[13+i]*x**i for i in range(11))

def second_numerator(n, j):
    return (F**2*n.derivative(2)+(4*j-4)*F*Fp*n.derivative()
            +(2*j-2)*F*Fpp*n+(2*j-2)*(2*j-3)*Fp**2*n)

eqs = [second_numerator(n0,0)-3*(n0**2+2*F*n1*n2),
       second_numerator(n1,1)-3*(2*n0*n1+F*n2**2),
       second_numerator(n2,2)-3*(2*n0*n2+n1**2)]
coefficients = list(dict.fromkeys(c for e in eqs for c in e.list() if c))
if '--c4-zero' in sys.argv:
    assert not invariant
    coefficients.append(v[12])
I = P.ideal(coefficients)
print(f'mode={"deck-invariant" if invariant else "full"}; variables={P.ngens()}; '
      f'equations={len(coefficients)}; max_degree={max(f.total_degree() for f in coefficients)}', flush=True)

# Verify the recurrence producing the fifth horizontal iterate independently.
J = PolynomialRing(GF(5), names=['r','r1','r2','r3','r4'])
rj = J.gens()
def deriv(f):
    return sum(f.derivative(rj[i])*rj[i+1] for i in range(4))
companion = matrix(J, [[0,1],[rj[0],0]])
iterate = identity_matrix(J, 2)
for _ in range(5):
    iterate = iterate.apply_map(deriv) + iterate*companion
rel = {rj[2]:3*rj[0]**2, rj[3]:rj[0]*rj[1],
       rj[4]:rj[1]**2+3*rj[0]**3}
assert all(f.subs(rel)==0 for f in iterate.list())
assert iterate[0,1] == 3*rj[2]+rj[0]**2
print('PASS: p-curvature recurrence and scalar criterion', flush=True)

if '--msolve-input' in sys.argv:
    if not invariant and '--c4-zero' not in sys.argv:
        raise SystemExit('Use normalized_oper_quotient.sage --msolve-input for the remaining roots; --dump-only still lists the full equations.')
    # Adjoin the coefficient-field generator as one variable over F5.
    # The resulting F5 scheme has two conjugate components, total length
    # 58750 in full mode. It is NOT a Weil restriction in 48 variables.
    Q = PolynomialRing(GF(5), names=names+['zeta'], order='degrevlex')
    transformed = []
    solver_coefficients = coefficients
    if '--reduced' in sys.argv:
        reduced = []
        for eq, factor in zip(eqs, [F**2, F, F]):
            quotient, remainder = eq.quo_rem(factor)
            assert not remainder
            reduced.extend(quotient.list())
        solver_coefficients = list(dict.fromkeys(c for c in reduced if c))
        if '--c4-zero' in sys.argv:
            solver_coefficients.append(v[12])
        print(f'Equivalent reduced system: {len(solver_coefficients)} quadrics', flush=True)
    for eq in solver_coefficients:
        data = {}
        for exponent, coeff in eq.dict().items():
            for j, c in enumerate(coeff.polynomial().list()):
                if c:
                    data[tuple(exponent)+(j,)] = c
        transformed.append(Q(data))
    transformed.append(Q.gens()[-1]**2+4*Q.gens()[-1]+2)
    filename = 'invariant_oper_msolve.in' if invariant else 'c4_zero_oper_msolve.in'
    if '--reduced' in sys.argv:
        filename=filename.replace('_msolve.in','_reduced_msolve.in')
    destination = Path('Research/computations')/filename
    destination.write_text(','.join(Q.variable_names())+'\n5\n'+
                           ',\n'.join(str(f).replace('**','^') for f in transformed)+'\n')
    print(f'msolve input saved: {destination}; {len(transformed)} equations', flush=True)
elif '--dump-only' in sys.argv:
    print('Field: F_5[a]/(a^2+4a+2). Each expression below equals zero.')
    for index, equation in enumerate(coefficients, 1):
        print(f'E{index}: {equation}')
elif '--build-only' not in sys.argv:
    if not invariant and '--c4-zero' not in sys.argv:
        raise SystemExit('Full unnormalized solver retired; use normalized_oper_quotient.sage --msolve-input.')
    G = I.groebner_basis(algorithm='singular:slimgb')
    # Persist the expensive result before any further algebra or printing.
    destination = ('Research/computations/invariant_oper_groebner.sobj' if invariant
                   else 'Research/computations/c4_zero_oper_groebner.sobj')
    save((P,list(G)), destination)
    print(f'Groebner basis size={len(G)}; elapsed={time.monotonic()-started:.1f}s', flush=True)
    print(f'dimension={I.dimension()}', flush=True)
    if I.dimension()==0:
        print(f'length={I.vector_space_dimension()}', flush=True)
    if invariant:
        if '--lex' in sys.argv:
            Lex = PolynomialRing(k, names=names, order='lex')
            GL = Lex.ideal([Lex(f) for f in G]).groebner_basis()
            univariates = [f for f in GL if len(f.variables())==1]
            print(f'lex_basis_size={len(GL)}', flush=True)
            for f in univariates:
                fac = f.univariate_polynomial().factor()
                print(f'univariate_variable={f.variables()[0]}; '
                      f'factor_degrees_multiplicities={[(h.degree(),e) for h,e in fac]}', flush=True)
                if '--tangents' in sys.argv:
                    assert f.variables()==(Lex.gen(7),)
                    triangular = {f.leading_monomial(): f for f in GL if len(f.variables())>1}
                    for factor, multiplicity in fac:
                        Qfield = factor.parent().quotient(factor, names='u')
                        root = Qfield.gen()
                        special = Lex.hom([Qfield.zero()]*7+[root], Qfield)
                        values = []
                        for index in range(7):
                            eq = triangular[Lex.gen(index)]
                            values.append(-special(eq)/Qfield(eq.monomial_coefficient(Lex.gen(index))))
                        values.append(root)
                        evaluate = P.hom(values, Qfield)
                        RX = PolynomialRing(Qfield, 'X')
                        X = RX.gen()
                        Fx = RX([Qfield(k(c)) for c in F.list()])
                        Fx1, Fx2 = Fx.derivative(), Fx.derivative(2)
                        nx = RX([evaluate(c) for c in n0.list()])
                        nullities = []
                        for j, size in [(1,5),(2,11)]:
                            polys = []
                            for index in range(size):
                                n = X**index*(Fx if j==1 else 1)
                                polys.append(Fx**2*n.derivative(2)+(4*j-4)*Fx*Fx1*n.derivative()
                                             +(2*j-2)*Fx*Fx2*n+(2*j-2)*(2*j-3)*Fx1**2*n-nx*n)
                            degree = max(f.degree() for f in polys)
                            linear = matrix(Qfield, [[f[i] for f in polys] for i in range(degree+1)])
                            nullities.append(size-linear.rank())
                        print(f'factor_degree={factor.degree()}; transverse_tangent_dimensions={nullities}', flush=True)
        else:
            print('basis=', G, flush=True)
