#!/usr/bin/env sage
"""Finite exact singular chart for the source-only scalar direction.

This uses the original third shared-moment equation and epsilon_3 != 0.
It does not decide the complementary two-K-variable chart.
"""
import argparse
import json
import random
import sys
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, power_mod, pari

sys.path.insert(0, '/Users/julian/Documents/litt3-computation-data/october01_audited_replies/mixed_span_incidence/src')
from field import K
from incidence import endpoint
sys.path.insert(0, str(Path(__file__).parent))
from direction_system import build_direction
from source_system import evaluate


def marked_field():
    KK = GF(5**14, name='z')
    R = PolynomialRing(KK, 's'); s = R.gen()
    beta = (s*s-s-3).roots(multiplicities=False)[0]
    b = lambda code: KK(code % 5)+(code//5)*beta
    xi = (s**7+b(24)*s**6+b(7)*s**5+b(21)*s**4+b(20)*s**3+b(7)*s**2+b(22)*s+b(4)).roots(multiplicities=False)[0]
    k = lambda values: sum((b(code)*xi**i for i, code in enumerate(values)), KK.zero())
    basis = [xi**i for i in range(7)] + [beta*xi**i for i in range(7)]
    from sage.all import matrix, vector, GF as field
    vec = lambda value: vector(field(5), [value.polynomial()[i] for i in range(14)])
    inverse = matrix(field(5), [list(vec(x)) for x in basis]).transpose().inverse()
    def unembed(value):
        v = inverse*vec(value)
        return tuple(int(v[i])+5*int(v[i+7]) for i in range(7))
    return KK, b, k, unembed


def build_boundary(ep, data=None):
    if data is None:
        data = marked_field()
    KK, b, embed, unembed = data
    rows = {name: [embed(x) for x in row] for name, row in endpoint(ep).items()}
    C, U, V = [rows[name] for name in ('C', 'U', 'V')]
    assert all(C[i] and U[i] for i in (1, 2, 3)) and V[1] and V[2]
    m = b(21)
    assert not m.is_square()
    ratio = V[2]/V[1]
    intercept = (U[2]-ratio*U[1])/U[3]
    aa = 1-2*ratio*intercept
    bb = intercept**2+m*ratio**2
    linear = U[1]*aa-U[3]*bb
    constant = m*U[3]*aa-U[1]*bb
    assert linear or constant
    out = dict(field=KK, embedding=embed, unembed=unembed,
               rows=rows, source=ep, linear=linear, constant=constant,
               ratio=ratio, intercept=intercept)
    if not linear:
        out['empty_stage'] = 'nonzero-constant-on-singular-direction-line'
        return out
    r1 = -constant/linear
    r2 = ratio*r1+intercept
    R = PolynomialRing(KK, 'q'); q = R.gen()
    A = U[3]*(V[1]*r2-V[2]*r1)+V[2]*U[1]-V[1]*U[2]
    B1 = (m*U[3]-U[1]*r1)*r2+U[2]*(m-r1*r1)
    B2 = U[1]*r1-U[2]*r1*r2-U[1]*r2*r2+m*U[3]
    assert A == 0 and V[1]*B2-V[2]*B1 == 0
    F1 = (U[1]-U[3]*r1)*q+B1
    assert F1 != 0
    F0 = -U[3]*q*q-(U[2]*r1+U[1]*r2)*q+m*(U[3]*r1+U[2]*r2+U[1])
    Yconstant = C[0]+C[2]*r1+C[1]*r2
    P = (V[1]*F0-(V[0]+Yconstant**(5**8))*F1)/(C[3]**(5**8))
    assert P.degree() == 2 and P.gcd(F1).degree() == 0
    numerator, denominator = q, R.one()
    for j in range(7):
        pc = [P[i]**(5**(8*j % 14)) for i in range(3)]
        lc = [F1[i]**(5**(8*j % 14)) for i in range(2)]
        oldn, oldd = numerator, denominator
        numerator = pc[2]*oldn**2+pc[1]*oldn*oldd+pc[0]*oldd**2
        denominator = lc[1]*oldn*oldd+lc[0]*oldd**2
    assert max(numerator.degree(), denominator.degree()) == 128
    monodromy = numerator-q*denominator
    assert monodromy and monodromy.degree() <= 128
    out.update(r1=r1, r2=r2, F0=F0, F1=F1, P=P,
               monodromy=monodromy, numerator=numerator, denominator=denominator)
    return out


def solve_boundary(out):
    if 'empty_stage' in out:
        return [], dict(empty_stage=out['empty_stage'])
    # Exact finite-field roots; no traversal of K.
    all_roots = out['monodromy'].roots(multiplicities=False)
    roots = [x for x in all_roots if out['F1'](x) and
             x**(5**8)*out['F1'](x) == out['P'](x)]
    candidates = []
    circuit = build_direction(out['source'])
    failures = {}
    for r0 in roots:
        h = -out['rows']['V'][1]/out['F1'](r0)
        values = [out['unembed'](x) for x in (r0, out['r1'], out['r2'], h)]
        direct = evaluate(circuit, values+[K.zero, K.zero])
        assert all(direct[circuit['K_equations'][f'original_third_{l}']] == K.zero for l in range(3))
        bad = [name for name, gate in circuit['K_equations'].items() if direct[gate] != K.zero]
        if bad:
            failures[bad[0]] = failures.get(bad[0], 0)+1
        else:
            candidates.append(values)
    return candidates, dict(monodromy_degree=int(out['monodromy'].degree()),
                            roots_K_before_semilinear_filter=len(all_roots),
                            original_third_candidates=len(roots),
                            row_relaxation_candidates=len(candidates), first_failure_counts=failures)


def solve_boundary_quotient(out, finite_algorithm='pari'):
    """Exact gcd decision without factoring the degree-128 monodromy.

    The finite-field gcd is squarefree and contains every original-third
    candidate. Remaining row identities are evaluated in its finite algebra.
    """
    if 'empty_stage' in out:
        return [], dict(empty_stage=out['empty_stage'])
    mon = out['monodromy']; R = mon.parent(); q = R.gen()
    if finite_algorithm == 'pari':
        pm = pari(mon); pq = pari(str(q))
        finite = R(pm.gcd((pq.Mod(pm)**(5**14)).lift()-pq)).monic()
    elif finite_algorithm == 'sage':
        finite = mon.gcd(power_mod(q, 5**14, mon)-q).monic()
    else:
        raise ValueError(finite_algorithm)
    before = int(finite.degree())
    if before:
        finite = finite.gcd(power_mod(q, 5**8, finite)*out['F1']-out['P']).monic()
    count = int(finite.degree())
    metadata = dict(monodromy_degree=int(mon.degree()),
                    roots_K_before_semilinear_filter=before,
                    original_third_candidates=count,
                    finite_field_gcd_algorithm=finite_algorithm,
                    method='exact finite-field and residual gcds; no degree-128 factorization')
    if not count:
        metadata['row_relaxation_candidates'] = 0
        return [], metadata
    Q = R.quotient(finite, 'a')
    inputs = [Q.gen(), Q(out['r1']), Q(out['r2']),
              -Q(out['rows']['V'][1])*Q(out['F1']).inverse_of_unit()]
    circuit = build_direction(out['source'])
    cache = {}
    def gate(i):
        if i in cache:
            return cache[i]
        node = circuit['nodes'][i]; op, args = node['op'], node['args']
        if op == 'constant': value = Q(out['embedding'](K.decode(args[0])))
        elif op == 'input': value = inputs[args[0]]
        elif op == 'add': value = gate(args[0])+gate(args[1])
        elif op == 'multiply': value = gate(args[0])*gate(args[1])
        elif op == 'Frobenius': value = gate(args[0])**(5**args[1])
        else: raise ValueError(op)
        cache[i] = value
        return value
    assert all(gate(circuit['K_equations'][f'original_third_{l}']) == 0 for l in range(3))
    degrees = []
    for name in ['actual_rank_lift']+[f'actual_W_G_{l}' for l in range(3)]:
        residue = gate(circuit['K_equations'][name]).lift()
        finite = finite.gcd(residue).monic()
        degrees.append((name, int(finite.degree())))
        if finite.degree() == 0:
            break
    metadata.update(residual_gcd_degrees=degrees,
                    row_relaxation_candidates=int(finite.degree()))
    candidates = []
    if finite.degree():
        for r0 in finite.roots(multiplicities=False):
            h = -out['rows']['V'][1]/out['F1'](r0)
            candidates.append([out['unembed'](x) for x in (r0, out['r1'], out['r2'], h)])
    return candidates, metadata


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--source', required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--quotient', action='store_true')
    args = parser.parse_args()
    ep = json.loads(args.source)
    start = time.monotonic()
    out = build_boundary(ep)
    rng = random.Random(106)
    if 'empty_stage' not in out:
        C, U, V = [out['rows'][n] for n in ('C', 'U', 'V')]
        circuit = build_direction(ep)
        for _ in range(5):
            r0 = out['field'].random_element()
            if not out['F1'](r0):
                continue
            h = -V[1]/out['F1'](r0)
            vals = [out['unembed'](x) for x in (r0, out['r1'], out['r2'], h)]
            direct = evaluate(circuit, vals+[K.zero, K.zero])
            assert direct[circuit['K_equations']['original_third_1']] == K.zero
            assert direct[circuit['K_equations']['original_third_2']] == K.zero
            expected = C[3]**(5**8)*(r0**(5**8)-out['P'](r0)/out['F1'](r0))
            assert out['embedding'](direct[circuit['K_equations']['original_third_0']]) == expected
    candidates, metadata = (solve_boundary_quotient(out) if args.quotient else solve_boundary(out))
    metadata.update(source=ep, scalar_direction='A=0', checked_random_points=5,
                    candidate_original_K_tuples=candidates,
                    seconds=time.monotonic()-start,
                    scope='complete singular direction chart for this source; complementary open chart unresolved')
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(metadata, indent=2)+'\n')
    print(json.dumps(metadata))


if __name__ == '__main__':
    main()
