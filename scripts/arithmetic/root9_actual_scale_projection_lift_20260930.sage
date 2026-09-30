"""Lift the entire reduced q-support of the new actual root-nine traces.

No finite-field sampling is used: each irreducible q-factor is retained
as its whole residue field. First reduce every q-coefficient modulo the
factor, before coercion to the extension. Checkpoint after every factor.
Optional arguments FIRST LAST restrict work to a disjoint factor range.
"""
import sys, json, time, struct
from pathlib import Path

root = Path(sys.argv[1]); start = time.time()
first = int(sys.argv[2]) if len(sys.argv) > 2 else 0
last = int(sys.argv[3]) if len(sys.argv) > 3 else 10**9
d = load(str(root/'actual_scale_resultants_compressed.sobj'))
R = d['ring']; H0, q0 = R.gens(); K = R.base_ring(); a = K.gen()
Q = PolynomialRing(K, 'q'); q = Q.gen()
beta = -(a**4+2*a**3+a**2+2*a)/(a**3+a**2+1)
def dec(n):
    n = int(n); value = K.zero()
    for i in range(4):
        c = n % 25; n //= 25
        value += (K(c % 5)+(c//5)*beta)*a**i
    return value

cp = root/'actual_scale_projection_factorization.sobj'
if cp.exists():
    saved = load(str(cp)); g = saved['projected_gcd']; fac = saved['factors']
else:
    support_path = root/'actual_scale_projection_gcd_digits_allowed_gcd.bin'
    if not support_path.exists():
        support_path = root/'actual_scale_projection_gcd_allowed_gcd.bin'
    raw = support_path.read_bytes()
    count = struct.unpack_from('<i', raw)[0]
    assert count > 0 and len(raw) == 4*(count+1)
    g = Q([dec(n) for n in struct.unpack_from('<'+'i'*count, raw, 4)])
    assert g and g.gcd(g.derivative()).is_one()
    fac = g.factor()
    assert fac.unit()*prod(f**m for f, m in fac) == g
    save({'projected_gcd': g, 'factors': fac}, str(cp))
print('complete projected factors', [(f.degree(), m) for f,m in fac],
      'seconds', time.time()-start, flush=True)

def by_H(p):
    if not p:
        return []
    rows = [{} for _ in range(p.degree(H0)+1)]
    for (i,j),c in p.dict().items():
        rows[int(i)][int(j)] = c
    return [Q(row) for row in rows]

# Chart factors only: H=42135 is the separately proved whole marked
# content exclusion. The different value H=356769 is NOT removed.
resultant_coefficients = [by_H(p) for p in d['scale_resultants']]
units = [H0, d['Psi'], d['D'], q0, H0-dec(42135)]
unit_coefficients = [by_H(p) for p in units]
reports = []
for idx, (factor, multiplicity) in enumerate(fac):
    if not first <= idx < last:
        continue
    target = root/f'actual_scale_projection_fibre_{idx}.sobj'
    if target.exists():
        rec = load(str(target)); reports.append(rec['receipt'])
        print('retained', rec['receipt'], flush=True)
        continue
    L = Q.quotient(factor, names='qbar'); qb = L.gen()
    T = PolynomialRing(L, 'H'); H = T.gen()
    def specialize(rows):
        # Reduction in K[q] avoids constructing long extension elements.
        return T([L(c.quo_rem(factor)[1]) for c in rows])
    pp = [specialize(rows) for rows in resultant_coefficients]
    order = sorted(range(len(pp)), key=lambda i: pp[i].degree())
    gg = pp[order[0]]
    for i in order[1:]:
        gg = gg.gcd(pp[i])
        if gg.degree() == 0:
            break
    rawg = gg.monic() if gg else gg
    removed = []
    if not gg:
        # A whole H-fibre is a remaining boundary, not an exclusion.
        receipt = {'index': idx, 'q_degree': int(factor.degree()),
                   'raw_H_degree': -1, 'allowed_H_degree': -1,
                   'status': 'whole_H_fibre_requires_further_work'}
    else:
        for ki, rows in enumerate(unit_coefficients):
            u = specialize(rows)
            if not u:
                removed.append({'unit_index': ki, 'whole_fibre': True})
                gg = T.one(); break
            while gg.degree() > 0:
                z = gg.gcd(u)
                if z.degree() <= 0:
                    break
                quo, rem = gg.quo_rem(z); assert not rem
                removed.append({'unit_index': ki, 'factor': z})
                gg = quo
        receipt = {'index': idx, 'q_degree': int(factor.degree()),
                   'raw_H_degree': int(rawg.degree()),
                   'allowed_H_degree': int(gg.degree()),
                   'status': 'excluded' if gg.degree() == 0 else
                             'remaining_full_residue_field'}
    record = {'qfactor': factor, 'multiplicity': multiplicity,
              'field': L, 'Hring': T, 'resultant_polynomials': pp,
              'raw_gcd': rawg, 'allowed_gcd': gg, 'removed': removed,
              'receipt': receipt}
    pending = target.with_suffix('.pending.sobj')
    save(record, str(pending)); pending.replace(target); reports.append(receipt)
    print(receipt, 'seconds', time.time()-start, flush=True)
    (root/f'actual_scale_projection_lift_{first}_{last}.json').write_text(
        json.dumps({'scope': 'complete residue fields in the stated factor range',
                    'projected_degree': int(g.degree()),
                    'factor_degrees': [int(f.degree()) for f,m in fac],
                    'range': [first,last], 'fibres': reports,
                    'seconds': time.time()-start}, indent=2, default=int)+'\n')

all_reports = []
for idx in range(len(fac)):
    path = root/f'actual_scale_projection_fibre_{idx}.sobj'
    if path.exists():
        all_reports.append(load(str(path))['receipt'])
complete = len(all_reports) == len(fac)
excluded = complete and all(r['status'] == 'excluded' for r in all_reports)
(root/'actual_scale_projection_lift.json').write_text(json.dumps(
    {'scope': 'entire necessary projected geometric support',
     'projected_degree': int(g.degree()),
     'factor_degrees': [int(f.degree()) for f,m in fac],
     'fibres': all_reports, 'complete': complete,
     'complete_exclusion': excluded, 'seconds_this_run': time.time()-start},
    indent=2, default=int)+'\n')
print('complete', complete, 'complete exclusion', excluded, flush=True)
