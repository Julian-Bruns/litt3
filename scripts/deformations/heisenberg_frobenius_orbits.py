#!/usr/bin/env sage-python
"""Exact coefficient-125-Frobenius orbits of actual UT3(F5) covers.

Transports both the abelian plane and its central character.  The
comparison uses the explicit polynomial UT3 automorphism and the
Artin--Schreier identification H1_et(D,F5)=ker(F-1 on H1(O_D)).
This script does not compute Hodge ranks or assume their constancy
under any relation other than actual coefficient conjugacy.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse
import hashlib
import json
from pathlib import Path
import time

from sage.all import GF, PolynomialRing, matrix, vector
from scripts.deformations.backup_heisenberg_defect import CurveAlgebra


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--case', type=int, default=0)
    ap.add_argument('--output', required=True)
    args = ap.parse_args()
    started = time.monotonic()
    root = Path(__file__).resolve().parents[2]
    data = root/'Research/computations'
    source_path = data/'backup_bad_double_cyclic_directions.json'
    source = json.loads(source_path.read_text())
    case = source['cases'][args.case]
    raw = json.loads((data/f'backup_bad_double_jet_{args.case}.json').read_text())
    prime = GF(5)
    pol = PolynomialRing(prime, 'z')
    small = GF(5**12, name='b', modulus=pol(source['coefficient_field_modulus']))
    b = small.gen()
    field, embed = small.extension(5, 'c', map=True)
    c = field.gen()
    degree = int(field.degree())
    assert degree == 60
    decode = lambda co: embed(sum((small(v)*b**i for i,v in enumerate(co)), small(0)))
    encode = lambda value: [int(field(value).polynomial()[i]) for i in range(degree)]
    alpha = decode(source['alpha_embedding'])
    base = CurveAlgebra(field, alpha, raw['R'], raw['A'])
    fixed = [vector(field, [decode(co) for co in row]) for row in case['as_basis']]
    fixed_matrix = matrix(field, fixed, implementation='generic').transpose()
    as_class = lambda v: sum((field(a)*w for a,w in zip(v,fixed)), vector(field,[0,0,0]))
    frob = matrix(field,3,3,lambda i,j:
        base.split(base.frob(base.mono(*base.obasis[j])),tangent=False)[0][i],
        implementation='generic')
    flatten = lambda v: vector(prime,[a for x in v for a in encode(x)])
    unflatten = lambda v: vector(field,[sum((field(v[degree*j+i])*c**i
                            for i in range(degree)),field(0)) for j in range(3)])
    lang_columns = []
    for j in range(3):
        for i in range(degree):
            v = vector(field,[0,0,0]); v[j] = c**i
            lang_columns.append(flatten(frob*vector(field,[a**5 for a in v])-v))
    lang = matrix(prime,lang_columns).transpose()
    assert lang.right_kernel().dimension() == 3

    def coeff_frob(value):
        return tuple(base.L({int(j):a**125 for j,a in lp.dict().items()}) for lp in value)

    def fixed_coordinates(v):
        assert frob*vector(field,[a**5 for a in v]) == v
        coefficients = fixed_matrix.solve_right(v)
        assert all(a**5 == a for a in coefficients)
        return vector(prime,[prime(a) for a in coefficients])

    # The BASE and oper are defined over F125.  Only cover coefficients move.
    for lp in [base.R,base.S,base.A]:
        assert all(a**125 == a for a in lp.coefficients())
    sigma_as = matrix(prime,[fixed_coordinates(vector(field,[a**125 for a in v]))
                            for v in fixed]).transpose()
    assert sigma_as.is_invertible() and sigma_as**4 == 1
    records = []
    for number, plane in enumerate(case['planes']):
        coefficient_basis = [vector(prime,v) for v in plane['coefficient_basis']]
        complement = next(vector(prime,[int(i==j) for i in range(3)]) for j in range(3)
                          if matrix(prime,coefficient_basis+[
                              vector(prime,[int(i==j) for i in range(3)])]).rank()==3)
        chi1,chi2 = [base.from_h1o(as_class(v)) for v in coefficient_basis]
        chi3 = base.from_h1o(as_class(complement))
        local = [base.split(base.add(base.frob(chi),base.neg(chi)),tangent=False)
                 for chi in [chi1,chi2]]
        assert all(not any(row[0]) for row in local)
        f1,f2 = [row[1] for row in local]
        g1,g2 = [base.neg(row[2]) for row in local]
        cross = base.add(base.neg(base.mul(base.frob(chi1),f2)),base.mul(g1,chi2))
        rhs = vector(field,[-a for a in base.split(cross,tangent=False)[0]])
        primitive = unflatten(lang.solve_right(flatten(rhs)))
        assert frob*vector(field,[a**5 for a in primitive])-primitive == rhs
        kappa = base.from_h1o(primitive)
        error = base.add(cross,base.add(base.frob(kappa),base.neg(kappa)))
        co,uu,oo = base.split(error,tangent=False)
        assert not any(co)
        records.append(dict(number=number,plane=plane,basis=coefficient_basis,
                            complement=complement,chi=(chi1,chi2),chi3=chi3,
                            kappa=kappa,f=(f1,f2,base.neg(uu)),g=(g1,g2,oo)))

    permutation = {}
    witnesses = []
    for old in records:
        old_image_basis = [sigma_as*v for v in old['basis']]
        targets = [r for r in records if all(vector(prime,r['plane']['normal'])*v == 0
                                             for v in old_image_basis)]
        assert len(targets) == 1
        target = targets[0]
        target_basis = matrix(prime,target['basis']).transpose()
        M = matrix(prime,[target_basis.solve_right(v) for v in old_image_basis])
        a,b,c0,d = [field(v) for v in M.list()]
        det = a*d-b*c0
        assert det
        chi1,chi2 = target['chi']
        assert coeff_frob(old['chi'][0]) == base.add(base.scale(chi1,a),base.scale(chi2,b))
        assert coeff_frob(old['chi'][1]) == base.add(base.scale(chi1,c0),base.scale(chi2,d))
        quadratic = base.add(base.add(base.scale(base.mul(chi1,chi1),a*c0/2),
                                       base.scale(base.mul(chi2,chi2),b*d/2)),
                                       base.scale(base.mul(chi1,chi2),b*c0))
        normal = vector(prime,target['plane']['normal'])
        denominator = prime(det)*(normal*target['complement'])
        assert denominator
        for central in range(5):
            old_kappa = base.add(old['kappa'],base.scale(old['chi3'],field(central)))
            transformed = base.add(base.scale(target['kappa'],det),quadratic)
            delta = base.add(coeff_frob(old_kappa),base.neg(transformed))
            co = vector(field,base.split(delta,tangent=False)[0])
            central_class = fixed_coordinates(co)
            new_central = int((normal*central_class)/denominator)
            residual = central_class-prime(det)*prime(new_central)*target['complement']
            # Residual characters in the plane are exactly central UT3
            # automorphisms.  Affine/infinity coboundaries do not change
            # H1_et: constants are AS-surjective over the geometric field.
            repair = target_basis.solve_right(residual)
            assert target_basis*repair == residual
            old_label = old['number']*5+central
            new_label = target['number']*5+new_central
            permutation[old_label] = new_label
            witnesses.append(dict(source=[old['number'],central],
                target=[target['number'],new_central],
                abelian_change=[list(map(int,row)) for row in M.rows()],
                central_difference=list(map(int,central_class)),
                plane_repair=list(map(int,repair))))
    assert sorted(permutation.values()) == list(range(155))
    orbits = []
    remaining = set(range(155))
    while remaining:
        start = min(remaining)
        orbit = [start]
        nxt = permutation[start]
        while nxt != start:
            assert nxt not in orbit
            orbit.append(nxt); nxt = permutation[nxt]
        remaining.difference_update(orbit)
        assert 20 % len(orbit) == 0
        orbits.append([[v//5,v%5] for v in orbit])
    result = dict(status='PASS',case=args.case,kind=case['kind'],
        coefficient_frobenius_power=125,cover_count=155,orbit_count=len(orbits),
        orbit_lengths=[len(orbit) for orbit in orbits],orbits=orbits,
        sigma_as=[list(map(int,row)) for row in sigma_as.rows()],witnesses=witnesses,
        field_modulus=[int(v) for v in field.modulus()],
        planes=[dict(plane=r['number'],complement=list(map(int,r['complement'])),
                     kappa=base.encode(r['kappa'],encode)) for r in records],
        source_sha256=hashlib.sha256(source_path.read_bytes()).hexdigest(),
        seconds=time.monotonic()-started,
        scope='Actual coefficient conjugacy, including central characters; no Hodge ranks computed.')
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({key:result[key] for key in ['status','case','kind','cover_count',
                      'orbit_count','orbit_lengths','sigma_as','seconds']}),flush=True)


if __name__ == '__main__':
    main()
