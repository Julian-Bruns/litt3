#!/usr/bin/env sage-python
"""Exact small-field inputs for one actual cyclic-five fourth-lift question.

This computes the cover, characteristic-five Hodge operator, complete first
repair plane, and the trace functional. It does not compute a W4 obstruction.
The two Laurent helper functions are taken from the audited six-cover source;
only their definitions are loaded, never that source's large-field census.
"""
import argparse
import ast
import hashlib
import json
import time
from pathlib import Path

from sage.all import *


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--precision', type=int, default=220)
    ap.add_argument('--output', type=Path)
    args = ap.parse_args()
    started = time.monotonic()
    helper = Path(__file__).with_name('cyclic5_witt_obstruction.sage')
    tree = ast.parse(helper.read_text())
    selected = [node for node in tree.body if isinstance(node, ast.FunctionDef)
                and node.name in ('setup', 'laurent_coefficient')]
    assert len(selected) == 2
    exec(compile(ast.Module(body=selected, type_ignores=[]), str(helper), 'exec'), globals())
    prime = GF(5)
    poly = PolynomialRing(prime, 'T'); T = poly.gen()
    modulus = T**4+4*T**3+T**2+4*T+3
    assert modulus.is_irreducible()
    k = GF(625, 't', modulus=modulus); t = k.gen()
    PR, u, F, LS, z, uf, vf, reduce0 = setup(k, t, args.precision)
    encode = lambda c: [int(k(c).polynomial()[i]) for i in range(4)]
    encvec = lambda v: [encode(c) for c in v]
    encmat = lambda M: [encvec(row) for row in M]
    orders = [-3, -1, 1]
    M = matrix(k, 2, 2, lambda i,j:
               laurent_coefficient(reduce0(z**(5*orders[j]))[0], orders[i]))
    F4 = identity_matrix(k, 2)
    for i in range(4):
        F4 *= M.apply_map(lambda c: c**(5**i))
    assert F4.charpoly() == F4.charpoly().parent()([1, 2, 1])
    assert (F4+1).rank() == 1
    H = 3*t**2+t+3
    assert M*vector(k, [1, t**5]) == H*vector(k, [1, t])
    assert H != 0 and H**156 == 4
    chi = z**(-3)+t*z**(-1)

    # Recover the exact affine polynomial v*Q(u), retaining the regular tail.
    rem = chi**5-H*chi
    Q = PR(0)
    for ex in range(int(rem.valuation()), 1):
        if ex in (-3, -1):
            continue
        c = laurent_coefficient(rem, ex)
        if c:
            assert -ex >= 5 and ex % 2 == 1
            power = (-ex-5)//2
            Q += c*u**power
            rem -= c*vf*uf**power
    assert rem.valuation() >= 1 and rem.precision_absolute() > 20
    assert Q.degree() == 5
    fu = vf*Q(uf)
    # Independent exact rational-function check of regularity at infinity.
    # chi=v*c(u), hence chi^5-H*chi-vQ=v*(F²*c^5-H*c-Q).
    rat = PR.fraction_field(); cu = rat(F/u**6+t/u**2)
    tail_rat = F**2*cu**5-H*cu-Q
    assert tail_rat.numerator().degree()-tail_rat.denominator().degree() <= -3
    assert (vf*tail_rat(uf)-rem).valuation() > 15
    mu, h0 = 4+4*t, 4*t+3
    A = (uf-t)*(uf-h0)**2/mu

    def vreduce(values):
        values = list(values)
        for j in range(4, -1, -1):
            rr, _ = reduce0(values[j])
            assert rr.precision_absolute() > 3*j+2
            canonical = sum(laurent_coefficient(rr, ex)*z**ex for ex in orders)
            tail = rr-canonical
            assert tail.valuation() >= 2
            # w_O=w_U-chi; tangent sections regular at infinity start at z².
            for i in range(j):
                values[i] -= binomial(j, i)*(-chi)**(j-i)*tail
            values[j] = canonical
        return vector(k, [laurent_coefficient(values[j], ex)
                          for j in range(5) for ex in orders])

    cols = []
    for j in range(5):
        for ex in orders:
            cols.append(vreduce([A*z**(5*ex)*binomial(j,i)*H**i*fu**(j-i)
                                if i <= j else LS(0) for i in range(5)]))
    psi = matrix(k, cols).transpose()
    base = psi[:3,:3]
    assert psi.rank() == 13 and base.rank() == 2
    rho = vector(k, [1+4*t+2*t**2, 1+t+t**3, t+2*t**2+2*t**3]+[0]*12)
    root = lambda c: c**125
    particular = psi.solve_right(rho).apply_map(root)
    assert psi*particular.apply_map(lambda c:c**5) == rho
    assert all(c == 0 for c in particular[9:])
    baseker = base.right_kernel().basis()[0].apply_map(root)
    kb = vector(k, list(baseker)+[0]*12)
    kernels = [row.apply_map(root) for row in psi.right_kernel().basis()]
    kd = next(row for row in kernels if any(row[3:]))
    kd /= next(c for c in kd[3:] if c)
    assert matrix(k,[kd,kb]).rank() == 2
    assert all(c == 0 for row in (kd,kb) for c in row[6:])
    assert all(psi*row.apply_map(lambda c:c**5) == 0 for row in (kd,kb))
    # Trace(w^4)=-H, and Trace(w^j)=0 for j<4. This is field trace,
    # not trace divided by five. It commutes with the actual Hodge map.
    tr = matrix(k, 3, 15, lambda i,j: -H if j == i+12 else 0)
    assert tr*psi == base*tr.apply_map(lambda c:c**5)
    dualC = vector(k, [3*t**2+t+1, 3*t+4, 3])
    assert dualC*base == 0 and dualC*rho[:3] == 1/mu
    dual0 = dualC*tr
    dual1 = next(row for row in psi.left_kernel().basis()
                 if matrix(k,[dual0,row]).rank() == 2)
    dual = matrix(k,[dual0,dual1]); assert dual*psi == 0
    assert dual.rank() == 2

    # Verify the actual geometric cyclic action in the small splitting field.
    ext = GF(5**8, 's'); emb = k.embeddings(ext)[0]
    px = PolynomialRing(ext,'x'); x = px.gen()
    lam = (x**4-emb(H)).roots(multiplicities=False)[0]
    assert lam**4 == emb(H) and lam**625 == -lam
    sig = matrix(ext,15,15,lambda row,col:
                 binomial(col//3,row//3)*lam**(col//3-row//3)
                 if row//3 <= col//3 and row%3 == col%3 else 0)
    pext = psi.apply_map(emb)
    assert sig**5 == 1 and sig*pext == pext*sig.apply_map(lambda c:c**5)
    e = sig-1
    assert [int((e**j).rank()) for j in range(1,5)] == [12,9,6,3]
    assert pext.augment(e).rank() == 14  # coinvariant obstruction dimension1
    assert pext.augment(e**2).rank() == 13  # e² kills the cokernel
    assert e.column_space().is_subspace(dual0.apply_map(emb).column().transpose().right_kernel())
    ranks = [15]; iterate = identity_matrix(k,15)
    for j in range(1,17):
        iterate *= psi.apply_map(lambda c:c**(5**(j-1)))
        ranks.append(int(iterate.rank()))
        if ranks[-1] == ranks[-2]: break

    # Exact unramified coefficient Frobenius, not the fifth power of T.
    Opoly = PolynomialRing(Integers(625),'T')
    O4 = Opoly.quotient(Opoly([3,4,1,4,1]),'T'); TT = O4.gen()
    phit = TT**5
    for _ in range(4):
        phit -= (phit**4+4*phit**3+phit**2+4*phit+3)/(4*phit**3+12*phit**2+2*phit+4)
    phi_digits = [int(phit.lift()[i]) for i in range(4)]
    assert phi_digits == [122,113,275,510] and phit != TT**5
    result = dict(status='PASS primary inputs only; fourth obstruction not computed',
                  precision=args.precision, coefficient_basis=['1','t','t^2','t^3'],
                  coefficient_modulus=[3,4,1,4,1], H=encode(H),
                  shift_z_exponents=[-3,-1], shift_coefficients=encvec([1,t]),
                  affine_Q_coefficients=encvec(Q), affine_Q=str(Q),
                  regular_tail_numerator=encvec(tail_rat.numerator()),
                  regular_tail_denominator=encvec(tail_rat.denominator()),
                  h1_basis='z^i w_U^j eta^{-1}; j=0,...,4; i=-3,-1,1 in that order',
                  h1_O_frobenius=encmat(M), h1_O_fourth_frobenius=encmat(F4),
                  hodge_matrix=encmat(psi), hodge_matrix_convention='Psi(v)=M*(v^[5])',
                  base_reference_rho=encvec(rho), primary_repair=encvec(particular),
                  kernel_d=encvec(kd), kernel_b=encvec(kb),
                  compatible_third_lifts='T3ref + primary_repair + d*kernel_d + b*kernel_b',
                  obstruction_dual_rows=encmat(dual), trace_matrix=encmat(tr),
                  trace_row_convention='row0 = Lambda_C * Tr; Tr(w^4)=-H',
                  semilinear_ranks=ranks, deck_splitting_field_degree=8,
                  witt_frobenius_mod625=phi_digits,
                  checks=['exact affine equation and regular infinity remainder',
                          'actual degree5 geometric cover; nonzero AS cohomology class',
                          'rank13 and complete two-dimensional first repair plane',
                          'trace naturality and exact obstruction duals',
                          'geometric deck action and actual R/e^2 obstruction module',
                          'primary repairs have AS degree<=2; kernel degree<=1',
                          'actual coefficient Witt Frobenius'],
                  source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  helper_sha256=hashlib.sha256(helper.read_bytes()).hexdigest(),
                  seconds=time.monotonic()-started)
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({key:result[key] for key in ['status','precision','affine_Q','H',
                     'semilinear_ranks','deck_splitting_field_degree','seconds']},indent=2))


if __name__ == '__main__':
    main()
