#!/usr/bin/env sage-python
"""All actual cyclic-five directions of the twelve backup bad doubles.

Builds Frobenius-fixed Artin--Schreier classes, retaining coefficient
Frobenius on the twisted Picard coordinates, and evaluates the audited
four-jets. This is not an arbitrary-direction or bounded-field map search.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix, vector


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True)
    parser.add_argument('--matrix-replay', action='store_true',
                        help='Independently rank every full 30-by-30 twisted presentation')
    args = parser.parse_args()
    start = time.monotonic()
    root = Path(__file__).resolve().parents[1]
    data = root/'Research/computations'
    prime = GF(5)
    p = PolynomialRing(prime, 'z')
    k = GF(125, name='a', modulus=p([1,1,0,1]))
    alpha = k.gen()
    ext, embed = k.extension(4, 'b', map=True)
    zeta = ext.gen()
    assert ext.degree() == 12
    decode = lambda co: embed(sum((k(c)*alpha**i for i,c in enumerate(co)), k.zero()))
    encode = lambda x: [int(ext(x).polynomial()[i]) for i in range(12)]
    to_vector = lambda v: vector(prime, [c for x in v for c in encode(x)])
    from_vector = lambda v: vector(ext, [sum((ext(v[12*j+i])*zeta**i for i in range(12)),ext.zero())
                                         for j in range(3)])
    records = []
    for index in range(12):
        tic = time.monotonic()
        path = data/('backup_bad_double_jet_%d.json' % index)
        raw = json.loads(path.read_text())
        frob = matrix(ext, [[decode(c) for c in row] for row in raw['H1O_frobenius']],
                      implementation='generic')
        # H1(O) absolute Frobenius is v -> frob*v^[5]. Solve over F5,
        # then verify every basis vector in the actual coefficient field.
        columns = []
        for j in range(3):
            for i in range(12):
                v = vector(ext, [ext.zero()]*3)
                v[j] = zeta**i
                columns.append(to_vector(frob*vector(ext,[c**5 for c in v])-v))
        fixed_matrix = matrix(prime, columns).transpose()
        fixed = [from_vector(v) for v in fixed_matrix.right_kernel().basis()]
        assert len(fixed) == 3, (index, len(fixed))
        assert all(frob*vector(ext,[c**5 for c in v]) == v for v in fixed)
        assert matrix(ext, fixed, implementation='generic').rank() == 3
        scalar = {tuple(map(int,key.split(','))): decode(value)
                  for key,value in raw['scalar_jet'].items()}
        matrix_jet = {tuple(map(int,key.split(','))):
                      matrix(ext,[[decode(c) for c in row] for row in mat],implementation='generic')
                      for key,mat in raw['matrix_jet'].items()}
        count = {}
        fixed_count = {}
        directions = []
        # First nonzero coefficient is one: exactly P2(F5), 31 classes.
        for coeffs in itertools.product(range(5), repeat=3):
            if not any(coeffs) or next(c for c in coeffs if c) != 1:
                continue
            ash = sum((ext(c)*v for c,v in zip(coeffs,fixed)), vector(ext,[0,0,0]))
            picard = vector(ext,[c**5 for c in ash])
            values = [sum((co*ext.prod(picard[i]**powers[i] for i in range(3))
                           for powers,co in scalar.items() if sum(powers)==degree),ext.zero())
                      for degree in range(5)]
            assert values[0] == values[1] == values[3] == 0
            length = 2 if values[2] else 4 if values[4] else 5
            if args.matrix_replay:
                mats = [matrix(ext,6,6,implementation='generic') for _ in range(5)]
                for powers,mat in matrix_jet.items():
                    mats[sum(powers)] += ext.prod(picard[i]**powers[i] for i in range(3))*mat
                # Multiplication on k[s]/s^5; replacing s by log(1+e)
                # is an invertible algebra substitution and preserves rank.
                full = matrix(ext,30,30,lambda i,j:
                              mats[i//6-j//6][i%6,j%6] if i//6>=j//6 else ext.zero(),
                              implementation='generic')
                assert 30-full.rank() == length
            # The ORIGINAL free involution negates both kappa and ell:
            # it fixes v/u,v/u^2 and negates ell/u in H1(O).
            tau = vector(ext,[ash[0],ash[1],-ash[2]])
            tau_eigen = 1 if tau == ash else -1 if tau == -ash else 0
            count[length] = count.get(length,0)+1
            if tau_eigen:
                fixed_count[length] = fixed_count.get(length,0)+1
            directions.append(dict(coefficients=list(coeffs), ash=[encode(c) for c in ash],
                                   picard=[encode(c) for c in picard],
                                   quadratic=encode(values[2]), quartic=encode(values[4]),
                                   defect=length, original_deck_eigenvalue=tau_eigen))
        assert len(directions) == 31
        assert sum(bool(d['original_deck_eigenvalue']) for d in directions) == 7
        hessian = matrix(ext, [[decode(c) for c in row] for row in raw['hessian']],
                         implementation='generic')
        plane_histogram = {}
        planes = []
        for normal in itertools.product(range(5), repeat=3):
            if not any(normal) or next(c for c in normal if c) != 1:
                continue
            coeff_basis = matrix(prime,[normal]).right_kernel().basis()
            as_plane = [sum((ext(c)*v for c,v in zip(co,fixed)),vector(ext,[0,0,0]))
                        for co in coeff_basis]
            pic_plane = matrix(ext,[[c**5 for c in row] for row in as_plane],
                               implementation='generic')
            restricted = pic_plane*hessian*pic_plane.transpose()
            rank = int(restricted.rank())
            assert rank in (1,2)
            is_base_plane = all(not row[2] for row in as_plane)
            assert (rank == 1) == (raw['kind'] == 'branch' and is_base_plane)
            plane_histogram[rank] = plane_histogram.get(rank,0)+1
            planes.append(dict(normal=list(normal), rank=rank,
                               coefficient_basis=[list(map(int,v)) for v in coeff_basis],
                               pulled_back_from_B=is_base_plane))
        rec = dict(case=index, kind=raw['kind'], source=raw['source_index'],
                   target=raw['twist_index'], as_basis=[list(map(encode,v)) for v in fixed],
                   histogram=count, original_deck_stable_histogram=fixed_count,
                   directions=directions, plane_histogram=plane_histogram, planes=planes,
                   input_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                   full_matrix_ranks_checked=31 if args.matrix_replay else 0,
                   seconds=time.monotonic()-tic)
        records.append(rec)
        print(json.dumps({key:rec[key] for key in ('case','kind','histogram',
              'original_deck_stable_histogram','plane_histogram','seconds')}),flush=True)
    result = dict(status='PASS', coefficient_field_modulus=[int(c) for c in ext.modulus()],
                  alpha_embedding=encode(embed(alpha)), cases=records,
                  seconds=time.monotonic()-start,
                  scope='All 31 actual cyclic-five quotient characters per bad double; no higher-Witt or common-cover exclusion.')
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')


if __name__ == '__main__':
    main()
