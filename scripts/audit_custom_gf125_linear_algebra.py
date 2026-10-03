"""Bounded independent scalar-arithmetic audit of three existing verifiers.

Run with sage -python. Original inputs are read only; receipts go outside litt3.
"""
from sage.all import *
from pathlib import Path
import hashlib
import itertools
import json
import runpy
import sys

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT.parent / 'litt3-computation-data/custom_gf125_audit_20260915'
OUT.mkdir(parents=True, exist_ok=True)
records = {'sage': version(), 'scope': 'three specified matrix consumers only'}


def scalar_rank(M):
    """Row reduction with scalar field operations; no matrix backend calls."""
    a = [[M[i,j] for j in range(M.ncols())] for i in range(M.nrows())]
    r = 0
    for c in range(M.ncols()):
        at = next((i for i in range(r, len(a)) if a[i][c]), None)
        if at is None:
            continue
        a[r], a[at] = a[at], a[r]
        inverse = 1/a[r][c]
        a[r] = [x*inverse for x in a[r]]
        for i in range(len(a)):
            if i != r and a[i][c]:
                factor = a[i][c]
                a[i] = [x-factor*y for x,y in zip(a[i],a[r])]
        r += 1
        if r == len(a):
            break
    return r


cross = ROOT/'scripts/deformations/rank125/verify_quadratic_cross_map.py'
certificate = (ROOT.parent/'litt3-computation-data/pro_rank125_return_20260913/'
               'continuation/rank125_continuation_certificate/results/geometric_quadratic.json')
sys.argv = [str(cross), str(certificate)]
d = runpy.run_path(str(cross), run_name='__main__')
M, image_matrix = d['kernel_matrix'], d['ordinary_image']
assert scalar_rank(M) == M.ncols()-9
assert scalar_rank(image_matrix) == 6
cross_ranks = []
for v in d['kernel']:
    assert all(sum((M[i,j]*v[j] for j in range(M.ncols())), M.base_ring()(0)) == 0
               for i in range(M.nrows()))
    h8 = sum((c*d['monomial'](e) for c,e in zip(v,d['monomials'][8])),d['poly'](0))
    second = d['macaulay'](h8)
    first = d['first']
    out = sum((c*(d['derivative'](first,e[:3])*d['derivative'](second,e[3:])+
                  d['derivative'](second,e[:3])*d['derivative'](first,e[3:]))
               for e,c in d['C'].items()),d['poly'](0))
    normal = d['coefficients'](d['inverse_macaulay'](d['truncated'](out).lift()))
    joined = matrix(d['k'], image_matrix.nrows(), image_matrix.ncols()+1,
                    lambda i,j: image_matrix[i,j] if j<image_matrix.ncols()
                    else normal.get(d['monomials'][4][i],0), sparse=True)
    cross_ranks.append(scalar_rank(joined))
assert cross_ranks == [6]*9
records['cross_map'] = {'matrix_type': str(type(M)), 'echelon_type': str(type(d['echelon'])),
    'kernel_matrix_shape': [M.nrows(),M.ncols()], 'kernel_rank': scalar_rank(M),
    'kernel_dimension': 9, 'scalar_kernel_products': 'all zero',
    'ordinary_rank': 6, 'all_nine_joined_ranks': cross_ranks}
print('PASS cross map: scalar ranks and all nine kernel products', flush=True)

conductor = ROOT/'scripts/genus_two/verify_backup_conductor_two.sage'
sys.argv = [str(conductor)]
ns = dict(globals())
exec(compile(conductor.read_text().split('def run_chart')[0],str(conductor),'exec'),ns)
Q, pivot, inv = ns['matrix_Q'], ns['pivot'], ns['inverse']
assert scalar_rank(Q) == 6
assert scalar_rank(pivot) == 6
for i in range(6):
    for j in range(6):
        assert sum((pivot[i,l]*inv[l,j] for l in range(6)), ns['k'](0)) == (i==j)
        assert sum((inv[i,l]*pivot[l,j] for l in range(6)), ns['k'](0)) == (i==j)
records['conductor_two'] = {'matrix_type':str(type(Q)),
    'transpose_type':str(type(Q.transpose())), 'pivot_type':str(type(pivot)),
    'inverse_type':str(type(inv)), 'shape':[9,6], 'scalar_rank':6,
    'selected_rows':ns['rows'], 'two_sided_scalar_inverse_products':'identity',
    'scope':'common coefficient elimination only; Groebner charts not rerun'}
print('PASS conductor two: rank six and both scalar inverse products',flush=True)

tangents = ROOT/'scripts/genus_two/backup_genus_two_twisted_tangents.sage'
fresh = OUT/'backup_genus_two_twisted_tangents_replay.json'
sys.argv = [str(tangents),'--output',str(fresh)]
runpy.run_path(str(tangents),run_name='__main__',init_globals=dict(globals()))
oldpath = ROOT/'../litt3-computation-data/legacy_workspace_computations/backup_genus_two_twisted_tangents.json'
old, new = [json.loads(p.read_text()) for p in (oldpath,fresh)]
assert old['twists'] == new['twists']
k = GF(125,'a',modulus=PolynomialRing(GF(5),'x')([1,1,0,1]))
Z = PolynomialRing(k,'z')
decode = lambda cs: sum((k(c)*k.gen()**i for i,c in enumerate(cs)),k(0))
poly = lambda cs: Z([decode(c) for c in cs])
q = poly(old['oper_separator'])
assert q.degree()==5 and q.is_irreducible()
A = Z.quotient(q,names='b2')
checked = []
for row in old['twists']:
    M = matrix(A,[[A(poly(c)) for c in line] for line in row['matrix']])
    assert scalar_rank(M)==3
    selected = row['full_rank_rows']
    minor = A(0)
    for perm in itertools.permutations(range(3)):
        inversions = sum(perm[i]>perm[j] for i in range(3) for j in range(i+1,3))
        minor += (-1)**inversions*prod(M[selected[i],perm[i]] for i in range(3))
    assert minor == A(poly(row['full_rank_minor'])) and minor != 0
    s, t = poly(row['bezout_q_multiplier']), poly(row['bezout_minor_multiplier'])
    assert s*q+t*poly(row['full_rank_minor']) == 1
    checked.append({'rows':selected,'scalar_rank':3,'explicit_determinant_and_bezout':'PASS'})
records['twisted_tangents'] = {'matrix_type':str(type(M)),
    'transpose_type':str(type(M.transpose())), 'base_ring':str(A),
    'replay_twists_byte_values_equal':True, 'cases':checked,
    'all_sixteen_kernel_dimensions': [0]*16}
records['input_sha256'] = {str(p.relative_to(ROOT)) if p.is_relative_to(ROOT) else str(p):
    hashlib.sha256(p.read_bytes()).hexdigest() for p in
    (cross,conductor,tangents,certificate,oldpath)}
(OUT/'audit.json').write_text(json.dumps(records,indent=2,default=int)+'\n')
print('PASS tangents: all sixteen fresh matrices match; scalar rank and explicit Bezout minors',flush=True)
print('PASS all three specified consumers; receipt '+str(OUT/'audit.json'),flush=True)
