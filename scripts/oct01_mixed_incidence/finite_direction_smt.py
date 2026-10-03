#!/usr/bin/env python3
"""Finite GF5 circuit for the exact polynomial direction chart.

This is a necessary row/rank relaxation at one ACTUAL fixed source.
It neither replaces moments nor authenticates arbitrary target rows.
All bit-vector coordinates are canonical representatives 0,...,4.
"""
import argparse
import hashlib
import json
import os
import random
import sys
import time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from direction_system import build_direction
from source_system import Circuit, evaluate
from field import K, ba, bm, bn, bp, BINV
from incidence import endpoint
from finite import phi
from rank_reconstruction import flat, unflat, KBASIS


def compose_parametric(ep):
    original = build_direction(ep)
    A = endpoint(ep); U, V = A['U'], A['V']
    k = K.div(V[2], V[1]); d = K.div(K.sub(U[2], K.mul(k, U[1])), U[3])
    a0 = K.sub(K.one, K.scale(K.mul(k, d), 2))
    b0 = K.add(K.mul(d, d), K.scale(K.mul(k, k), 21))
    L = K.sub(K.mul(U[1], a0), K.mul(U[3], b0))
    Cstar = K.sub(K.scale(K.mul(U[3], a0), 21), K.mul(U[1], b0))
    if L == K.zero:
        raise ValueError('L=0 torus chart is retained but not encoded here')
    ell = K.mul(V[1], L); bs = K.neg(K.div(Cstar, L))
    alpha = K.neg(K.div(U[1], K.mul(K.mul(U[3], U[3]), V[1])))
    delta = K.neg(K.div(K.add(K.mul(k, U[1]), U[2]), U[3]))
    eta = K.sub(K.neg(K.scale(K.div(K.mul(U[1], d), U[3]), 2)), K.scale(k, 21))
    cc = Circuit(); a, c, h = [cc.input(n) for n in ('a', 'c', 'h')]
    scale = lambda z, q: cc.mul(z, cc.const(q))
    r1 = cc.add(cc.const(bs), cc.mul(a, c))
    r2 = cc.sum((scale(r1, k), cc.const(d), scale(a, K.inv(K.mul(U[3], V[1])))))
    r0 = cc.sum((scale(a, alpha), cc.const(K.add(K.mul(delta, bs), eta)),
                 cc.mul(cc.add(scale(a, delta), cc.const(ell)), c)))
    replacement = [r0, r1, r2, h]; gates = []
    for node in original['nodes']:
        op, args = node['op'], node['args']
        if op == 'constant': out = cc.const(K.decode(args[0]))
        elif op == 'input': out = replacement[args[0]]
        elif op == 'add': out = cc.add(gates[args[0]], gates[args[1]])
        elif op == 'multiply': out = cc.mul(gates[args[0]], gates[args[1]])
        elif op == 'Frobenius': out = cc.frob(gates[args[0]], args[1])
        else: raise ValueError(op)
        gates.append(out)
    # Third_2 follows from the quadric and third_1; retain the other originals.
    equations = {name: gates[g] for name, g in original['K_equations'].items()
                 if name != 'original_third_2'}
    return dict(inputs=cc.names, nodes=cc.nodes, K_equations=equations,
                scope='exact L!=0 source row/rank relaxation; no target authentication',
                source=ep)


def binverse_matrix(M):
    n = len(M); A = [list(row)+[int(i == j) for j in range(n)] for i, row in enumerate(M)]
    for j in range(n):
        p = next(i for i in range(j, n) if A[i][j]); A[p], A[j] = A[j], A[p]
        inv = BINV[A[j][j]]; A[j] = [bm(x, inv) for x in A[j]]
        for i in range(n):
            if i != j and A[i][j]:
                q = A[i][j]; A[i] = [ba(x, bn(bm(q, y))) for x, y in zip(A[i], A[j])]
    return [row[n:] for row in A]


def multiplication_maps():
    """Degree-six B-polynomial multiplication by 13-point interpolation."""
    points = range(13)
    ev = [[bp(p, j) for j in range(7)] for p in points]
    inv = binverse_matrix([[bp(p, j) for j in range(13)] for p in points])
    evaluation = []
    for row in ev:
        for side in (0, 1):
            evaluation.append([bm(coef, 1 if i % 2 == 0 else 5)//(5**side)%5
                               for i in range(14) for coef in [row[i//2]]])
    interpolation = []
    for point in points:
        coefficients = [inv[j][point] for j in range(13)]
        for i in range(12, 6, -1):
            for j, coef in enumerate(K.mod):
                coefficients[i-7+j] = ba(coefficients[i-7+j], bn(bm(coefficients[i], coef)))
        for side in (0, 1):
            interpolation.append(flat(tuple(bm(v, 1 if side == 0 else 5)
                                             for v in coefficients[:7])))
    return evaluation, list(map(list, zip(*interpolation)))


class Encoder:
    def __init__(self, solver):
        import z3
        self.z3, self.solver, self.count = z3, solver, 0
        self.ev, self.ip = multiplication_maps()
        self.frobs = {}

    def fresh(self, expr):
        z = self.z3.BitVec(f'n{self.count}', 3); self.count += 1
        self.solver.add(z == expr); return z

    def neg(self, a):
        if isinstance(a, int): return -a % 5
        return self.fresh(self.z3.If(a == 0, self.z3.BitVecVal(0, 3), 5-a))

    def add(self, a, b):
        if isinstance(a, int) and isinstance(b, int): return (a+b)%5
        if isinstance(a, int) and not a: return b
        if isinstance(b, int) and not b: return a
        wide = lambda x: self.z3.BitVecVal(x, 4) if isinstance(x, int) else self.z3.ZeroExt(1, x)
        s = wide(a)+wide(b)
        return self.fresh(self.z3.Extract(2, 0, self.z3.If(self.z3.UGE(s, 5), s-5, s)))

    def scale(self, a, coefficient):
        if coefficient == 0: return 0
        if coefficient == 1: return a
        if coefficient == 4: return self.neg(a)
        twice = self.add(a, a)
        return twice if coefficient == 2 else self.neg(twice)

    def mul(self, a, b):
        if isinstance(a, int): return self.scale(b, a)
        if isinstance(b, int): return self.scale(a, b)
        twice = self.add(b, b); negtwice = self.neg(twice); negb = self.neg(b)
        return self.fresh(self.z3.If(a == 0, self.z3.BitVecVal(0, 3), self.z3.If(a == 1, b,
            self.z3.If(a == 2, twice, self.z3.If(a == 3, negtwice, negb)))))

    def linear(self, coordinates, M):
        result = []
        for row in M:
            out = 0
            for x, coef in zip(coordinates, row):
                if coef: out = self.add(out, self.scale(x, coef))
            result.append(out)
        return result

    def kmul(self, a, b):
        if all(isinstance(x, int) for x in a):
            z = unflat(a); M = list(map(list, zip(*(flat(K.mul(z, t)) for t in KBASIS))))
            return self.linear(b, M)
        if all(isinstance(x, int) for x in b): return self.kmul(b, a)
        ea, eb = self.linear(a, self.ev), self.linear(b, self.ev)
        products = []
        for i in range(13):
            ar, ai, br, bi = ea[2*i], ea[2*i+1], eb[2*i], eb[2*i+1]
            ac, bd = self.mul(ar, br), self.mul(ai, bi)
            cross = self.mul(self.add(ar, ai), self.add(br, bi))
            products.extend((self.add(ac, self.scale(bd, 3)), self.add(cross, self.neg(ac))))
        return self.linear(products, self.ip)

    def build(self, spec):
        inputs = [[self.z3.BitVec(f'v{i}_{j}', 3) for j in range(14)] for i in range(len(spec['inputs']))]
        for vector in inputs:
            for z in vector: self.solver.add(self.z3.ULE(z, 4))
        values = []
        for node in spec['nodes']:
            op, args = node['op'], node['args']
            if op == 'constant': v = flat(K.decode(args[0]))
            elif op == 'input': v = inputs[args[0]]
            elif op == 'add': v = [self.add(x, y) for x, y in zip(values[args[0]], values[args[1]])]
            elif op == 'multiply': v = self.kmul(values[args[0]], values[args[1]])
            elif op == 'Frobenius':
                n = args[1]
                if n not in self.frobs:
                    self.frobs[n] = list(map(list, zip(*(flat(phi(t, n)) for t in KBASIS))))
                v = self.linear(values[args[0]], self.frobs[n])
            else: raise ValueError(op)
            values.append(v)
        return inputs, values


def main():
    import z3
    ap = argparse.ArgumentParser(); ap.add_argument('--source', required=True)
    ap.add_argument('--output-dir', required=True, type=Path); ap.add_argument('--timeout-ms', type=int, default=600000)
    args = ap.parse_args(); start = time.monotonic(); ep = json.loads(args.source)
    spec = compose_parametric(ep); out = args.output_dir; out.mkdir(parents=True, exist_ok=True)
    # Pure exact arithmetic independently checks the Toom maps before SMT construction.
    ev, ip = multiplication_maps(); rng = random.Random(101)
    lin = lambda v, M: [sum(a*b for a, b in zip(v, row))%5 for row in M]
    for _ in range(30):
        a, b = [K.decode(rng.randrange(5**14)) for i in range(2)]
        ea, eb = lin(flat(a), ev), lin(flat(b), ev)
        products = []
        for i in range(13):
            z = bm(ea[2*i]+5*ea[2*i+1], eb[2*i]+5*eb[2*i+1]); products.extend((z%5, z//5))
        assert lin(products, ip) == list(flat(K.mul(a, b)))
    solver = z3.SolverFor('QF_BV'); solver.set(timeout=args.timeout_ms)
    enc = Encoder(solver); inputs, values = enc.build(spec)
    # One bound original-circuit point checks every encoded field gate, not just outputs.
    solver.push(); point = [K.decode(rng.randrange(5**14)) for i in range(3)]
    for vector, actual in zip(inputs, point):
        for variable, coefficient in zip(vector, flat(actual)): solver.add(variable == coefficient)
    assert solver.check() == z3.sat
    model = solver.model(); original_values = evaluate(spec, point+[K.zero]*3)
    for vector, actual in zip(values, original_values):
        got = [x if isinstance(x, int) else model.eval(x).as_long() for x in vector]
        assert got == list(flat(actual))
    solver.pop()
    for name, gate in spec['K_equations'].items():
        for z in values[gate]: solver.add(z == 0 if not isinstance(z, int) else z == 0)
    smt = out/'relaxation.smt2'; smt.write_text(solver.to_smt2())
    metadata = dict(source=ep, scope=spec['scope'], field_inputs=3, prime_coordinates=42,
                    equations=list(spec['K_equations']), gates=len(spec['nodes']), auxiliary_prime_gates=enc.count,
                    exact_Toom_checks=30, bound_original_circuit_point_checks=1,
                    solver_version=z3.get_version_string(), timeout_ms=args.timeout_ms,
                    smt_sha256=hashlib.sha256(smt.read_bytes()).hexdigest(), build_seconds=time.monotonic()-start,
                    threads={n: os.environ.get(n) for n in ('OMP_NUM_THREADS','OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','VECLIB_MAXIMUM_THREADS')})
    (out/'result.json').write_text(json.dumps(metadata, indent=2)+'\n'); print(json.dumps(metadata), flush=True)
    begun = time.monotonic(); result = solver.check(); metadata.update(result=str(result), solve_seconds=time.monotonic()-begun)
    if result == z3.unknown: metadata['reason_unknown'] = solver.reason_unknown()
    elif result == z3.sat:
        model = solver.model(); recovered = [unflat([model.eval(x).as_long() for x in row]) for row in inputs]
        check = evaluate(spec, recovered+[K.zero]*3)
        assert all(check[gate] == K.zero for gate in spec['K_equations'].values())
        metadata['point'] = recovered
        metadata['positive_scope'] = 'only row/rank relaxation; genuine target authentication is still required'
    (out/'result.json').write_text(json.dumps(metadata, indent=2)+'\n'); print(json.dumps(metadata), flush=True)


if __name__ == '__main__': main()
