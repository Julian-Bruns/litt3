#!/usr/bin/env python3
"""Exact geometric trace-zero norm systems; bounded exploration, not a point search.

Run with sage -python. Outputs, including any unfinished calculation, belong
outside the source workspace. A unit Groebner basis is recorded as a CAS
result until an independently checkable membership certificate is exported.
"""
import argparse
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing
from cysignals.alarm import alarm, cancel_alarm, AlarmInterrupt

parser = argparse.ArgumentParser()
parser.add_argument('output', type=Path)
parser.add_argument('--seconds', type=int, default=45)
parser.add_argument('--kind', choices=['square', 'square_cube', 'both'], default='both')
parser.add_argument('--lift', action='store_true')
args = parser.parse_args()
args.output.mkdir(parents=True, exist_ok=True)
F5 = GF(5)
R0 = PolynomialRing(F5, 'beta0')
beta0 = R0.gen()
F = GF(25, 'beta', modulus=beta0**2-beta0-3)
beta = F.gen()
codes = [11,22,18,5,19,20,15,16,9,22,1]
dec = lambda c: F(c % 5) + F(c // 5)*beta

for kind in (('square', 'square_cube') if args.kind == 'both' else (args.kind,)):
    names = ['g0','g1','g2','g3'] + ([] if kind == 'square' else ['j0','j1'])
    R = PolynomialRing(F, names=names, order='degrevlex')
    RX = PolynomialRing(R, 'x'); x = RX.gen()
    P = RX([dec(c) for c in codes])
    g = sum(R.gen(i)*x**i for i in range(4))
    norm = P + g**3
    if kind == 'square':
        H = x**5
        for j in range(4, -1, -1):
            H += (norm-H**2)[5+j]/F(2)*x**j
        residual = norm-H**2
        assert residual.degree() <= 4
        reconstructed = {'H': str(H), 'g': str(g)}
    else:
        J = x**2+R.gen(5)*x+R.gen(4)
        H = x**2
        H += (norm-H**2*J**3)[9]/F(2)*x
        H += (norm-H**2*J**3)[8]/F(2)
        residual = norm-H**2*J**3
        assert residual.degree() <= 7
        reconstructed = {'H': str(H), 'J': str(J), 'g': str(g)}
    eq = [R(c) for c in residual.list() if c]
    record = dict(kind=kind, field='F5[beta]/(beta^2-beta-3)', variables=names,
                  equations=list(map(str, eq)), reconstruction=reconstructed,
                  scope='All geometric g of degree at most three; monic square/cube factors, arbitrary multiplicities.')
    (args.output/(kind+'_system.json')).write_text(json.dumps(record,indent=2)+'\n')
    print(kind, 'variables', R.ngens(), 'equations', len(eq), 'degrees', [f.total_degree() for f in eq], flush=True)
    start=time.monotonic(); alarm(args.seconds)
    try:
        gb = list(R.ideal(eq).groebner_basis(algorithm='libsingular:slimgb'))
        result = dict(status='completed', unit=gb==[R.one()], basis=list(map(str,gb)))
    except AlarmInterrupt:
        result = dict(status='bounded_computation_incomplete',unit=None)
    finally:
        cancel_alarm()
    result['elapsed_seconds'] = time.monotonic()-start
    (args.output/(kind+'_result.json')).write_text(json.dumps(result,indent=2)+'\n')
    print(kind, json.dumps({k:v for k,v in result.items() if k!='basis'}), flush=True)
    if args.lift and result.get('unit'):
        start=time.monotonic(); alarm(args.seconds)
        try:
            weights=list(R.one().lift(R.ideal(eq)))
            assert sum(w*f for w,f in zip(weights,eq)) == 1
            def portable(poly):
                rows=[]
                for exponents,c in sorted(poly.dict().items()):
                    cs=list(F(c).polynomial())+[F5(0),F5(0)]
                    rows.append([list(map(int,exponents)),int(cs[0])+5*int(cs[1])])
                return rows
            certificate=dict(field='beta^2=beta+3',variables=names,P_codes=codes,
                equations=[portable(f) for f in eq],multipliers=[portable(w) for w in weights],
                identity='sum multipliers[i]*equations[i]=1',verified=True,
                seconds=time.monotonic()-start)
            (args.output/(kind+'_unit_certificate.json')).write_text(json.dumps(certificate,separators=(',',':'))+'\n')
            print(kind,'explicit unit identity verified; multiplier terms',sum(len(w.dict()) for w in weights),flush=True)
        except AlarmInterrupt:
            print(kind,'unit-identity extraction timed out; CAS result retained separately',flush=True)
        finally:
            cancel_alarm()
