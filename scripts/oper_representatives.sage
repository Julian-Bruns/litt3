"""Lazy exact representatives for the complete untwisted fixed-X oper census.

Plain Python syntax: exec(compile(Path(...).read_text(), ..., 'exec'), ns)
works under Sage, as does load(). Importing does not construct any fields.
"""
import json
from pathlib import Path


def _oper_folder(folder=None):
    if folder is not None:
        return Path(folder)
    # load()/exec() may inherit the calling script's __file__.
    for root in [Path.cwd()] + list(Path.cwd().parents):
        candidate = root / 'Research/computations'
        if (candidate / 'normalized_oper_closed_points.json').exists():
            return candidate
    raise FileNotFoundError('Run inside litt3 or pass folder=.../Research/computations')


def oper_manifest(folder=None):
    """Read only compact census inputs; never construct finite fields."""
    folder = _oper_folder(folder)
    normalized = json.loads((folder / 'normalized_oper_closed_points.json').read_text())
    invariant = json.loads((folder / 'invariant_oper_solutions.json').read_text())
    reps = []
    for row in normalized['factors']:
        assert row['multiplicity'] == 1
        d = row['degree_F25']
        assert row['degree_F5'] == 2*d
        reps.append(dict(id=row['id'], kind='normalized', degree_F25=d,
                         geometric_coverage=3*d, multiplicity_each=1,
                         scheme_length=3*d, cubic_branches=3,
                         source='normalized_oper_closed_points.json',
                         coefficient_field_degree_F5_bounds=[2*d, 6*d]))
    for orbit in invariant['orbits']:
        rows = [(j, r) for j, r in enumerate(invariant['solutions'])
                if r['orbit_id'] == orbit['orbit_id']]
        assert len(rows) == orbit['degree']
        assert sorted(r['frobenius_exponent'] for _, r in rows) == list(range(orbit['degree']))
        assert all(r['multiplicity'] == 8 for _, r in rows)
        index = next(j for j, r in rows if r['frobenius_exponent'] == 0)
        d = orbit['degree']
        reps.append(dict(id='invariant_%d' % orbit['orbit_id'], kind='invariant',
                         invariant_orbit_id=orbit['orbit_id'], invariant_row=index,
                         degree_F25=d, geometric_coverage=d, multiplicity_each=8,
                         scheme_length=8*d, cubic_branches=1,
                         source='invariant_oper_solutions.json',
                         coefficient_field_degree_F5_bounds=[2*d, 2*d]))
    assert len(reps) == 18
    assert sum(r['geometric_coverage'] for r in reps) == 28990
    assert sum(r['scheme_length'] for r in reps) == 29375
    return dict(schema_version=1, representatives=reps, representative_count=18,
                geometric_coverage=28990, scheme_length=29375,
                equivalence='F25 Frobenius and actual cubic deck automorphism; untwisted atlas existence only',
                scope='No atlas exclusion, nontrivial twist computation, or common-cover conclusion.')


def load_oper(rep_id, folder=None, verify=True):
    """Return dict k,a,R,x,F,Fcurve,A,B,C,C0,P,c4,alpha and exact metadata.

    P is its three k[x] coefficients in 1,y,y^2. Finite fields are
    constructed only for this selected representative. field_description
    and encode_element provide a recursive exact serialization convention.
    """
    from sage.all import GF, PolynomialRing, sage_eval, inverse_mod
    folder = _oper_folder(folder)
    metadata = next((r for r in oper_manifest(folder)['representatives']
                     if r['id'] == rep_id), None)
    if metadata is None:
        raise ValueError('Unknown oper representative: %s' % rep_id)
    prime = GF(5)
    Z = PolynomialRing(prime, 'z')
    base = GF(25, name='a', modulus=Z([2, 4, 1]))
    base_description = dict(kind='finite_field', characteristic=5, degree=2,
                            generator='a', modulus=[2,4,1], coefficients='ascending powers')
    def finite_encode(v):
        return [int(c) for c in v.polynomial().list()]
    alpha = None
    lam = None
    if metadata['kind'] == 'invariant':
        data = json.loads((folder / 'invariant_oper_solutions.json').read_text())
        orbit = next(r for r in data['orbits'] if r['orbit_id'] == metadata['invariant_orbit_id'])
        T = PolynomialRing(base, 'b7')
        h = T(sage_eval(orbit['factor'], locals={'a':base.gen(), 'b7':T.gen()}))
        if h.degree() == 1:
            k = base
            a = k.gen()
            u = -h[0]
            description = base_description
            encode = finite_encode
        else:
            k = T.quotient(h, names='u')
            a, u = k(base.gen()), k.gen()
            description = dict(kind='polynomial_quotient_field', generator='u',
                               base=base_description, modulus=[finite_encode(c) for c in h.list()],
                               coefficients='ascending powers', degree=int(h.degree()))
            encode = lambda v: [finite_encode(c) for c in k(v).lift().list()]
        row = data['solutions'][metadata['invariant_row']]
        coords = [k(sage_eval(c, locals={'a':a, 'u':u})) for c in row['coordinates']]
        bv, cv, av = coords[:8], coords[8:13], coords[13:]
        t = k(0)
    else:
        factors = json.loads((folder / 'normalized_oper_closed_points.json').read_text())['factors']
        factor = next(f for f in factors if f['id'] == rep_id)
        cert = json.loads((folder / 'normalized_oper_algebra_certificate.json').read_text())
        f = Z(factor['polynomial'])
        if rep_id == 'orbit_0000':
            k = base
            alpha = 4*k.gen()+2
            description = base_description
        else:
            # Irreducibility is already certified by the completed census.
            k = GF(5**int(f.degree()), name='alpha', modulus=f, check_irreducible=False)
            alpha = k.gen()
            description = dict(kind='finite_field', characteristic=5,
                               degree=int(f.degree()), generator='alpha',
                               modulus=factor['polynomial'], coefficients='ascending powers')
        encode = finite_encode
        # Reduce in F5[z] first. Evaluating 19,290 coefficients directly in
        # the huge field would perform avoidable expensive multiplications.
        reduced = {name: Z(poly) % f for name, poly in cert['coordinates'].items()}
        residue = k
        evaluate = (lambda poly: residue(poly(alpha))) if rep_id == 'orbit_0000' else (lambda poly: residue(poly.list()))
        a = evaluate(reduced['zeta'])
        lam = evaluate(Z(cert['lambda']) % f)
        assert lam != 0 and a*a+4*a+2 == 0
        if rep_id == 'orbit_0000':
            assert f(alpha) == 0
        else:
            assert residue.modulus().list() == f.list()
        residue_b = [evaluate(Z(poly) % f) for poly in cert['B']]
        residue_c = [evaluate(reduced['c%d' % i]) for i in range(4)]
        residue_a = [evaluate(reduced['a%d' % i]) for i in range(10)]
        if rep_id == 'orbit_0000':
            t = k(3)
        else:
            T = PolynomialRing(k, 't')
            cubic = T.gen()**3-lam
            # Every residue degree in this completed census is prime to3.
            # Thus q-1=3*m with gcd(3,m)=1. Avoid generic polynomial
            # factorization, whose large-degree PARI scratch stack is huge.
            m = (k.cardinality()-1)//3
            assert m % 3 != 0
            if lam**m == 1:
                beta = lam**inverse_mod(3, m)
                rho = 2*a+1
                assert beta**3 == lam and rho**3 == 1 and rho != 1
                t = min([beta, beta*rho, beta*rho**2], key=finite_encode)
            else:
                k = T.quotient(cubic, names='t')
                description = dict(kind='polynomial_quotient_field', generator='t',
                                   base=description, modulus=[finite_encode(c) for c in cubic.list()],
                                   coefficients='ascending powers', degree=3)
                encode = lambda v: [finite_encode(c) for c in k(v).lift().list()]
                a, alpha, lam = k(a), k(alpha), k(lam)
                t = k.gen()
        # Evaluation in the original residue field, then the explicit tower inclusion.
        bv = [k(v) for v in residue_b]
        cv = [t*k(v) for v in residue_c] + [t]
        av = [t*t*k(v) for v in residue_a] + [t*t]
        coords = bv+cv+av
        assert t**3 == lam
    R = PolynomialRing(k, 'x')
    x = R.gen()
    F = (x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6
         +4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2+(4*a+2)*x+2*a+1)
    A, B, C = R(av), R(bv), R(cv)
    description = dict(description, base_F25_generator=encode(a))
    result = dict(k=k, a=a, R=R, x=x, F=F, Fcurve=F, A=A, B=B, C=C, C0=C,
                  P=[A, B+2*x**8, C], c4=t, alpha=alpha, lambda_scale=lam,
                  coordinates=coords, metadata=metadata, field_description=description,
                  encode_element=encode)
    if verify:
        _verify_loaded_oper(result)
        if rep_id == 'orbit_0000':
            cached = json.loads((folder / 'canonical_atlas_system.json').read_text())
            assert alpha == sage_eval(cached['oper_alpha'], locals={'a':a})
            assert t == k(cached['c4'])
            result['cached_first_oper_verified'] = True
    return result


def _verify_loaded_oper(op):
    """Verify all three original differential numerator identities exactly."""
    F, A, B, C, x = (op[n] for n in ['F','A','B','C','x'])
    Fp, Fpp = F.derivative(), F.derivative(2)
    n0 = 2*Fpp*F+2*Fp**2+(B+2*x**8)*F
    def L(n, j):
        return F**2*n.derivative(2)+(4*j-4)*F*Fp*n.derivative()+(2*j-2)*F*Fpp*n+(2*j-2)*(2*j-3)*Fp**2*n
    assert L(n0,0)-3*n0**2-F**2*C*A == 0
    assert F*(C*F).derivative(2)-n0*C-3*A**2 == 0
    assert L(A,2)-n0*A-3*F**2*C**2 == 0
    assert A[10] == C[4]**2
    op['original_equations_verified'] = True
    return True
