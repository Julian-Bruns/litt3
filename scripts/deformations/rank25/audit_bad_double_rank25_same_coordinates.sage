"""Independent finite audit of retained six-column rank25 diagnostics.

No Laurent geometry is regenerated. The geometric basis justification is
in BAD_DOUBLE_INITIAL_CHANNEL_AUDIT_2026_09_13.md.
"""
import itertools
import json
import argparse
from pathlib import Path

root = Path(__file__).resolve().parents[3]
receipts = root / 'Research/computations'
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--backup',action='store_true',help='Audit only the changed cubic backup input.')
options = parser.parse_args()
names = (['backup_rank25_fitting_nodal_p320'] if options.backup else
         ['bad_double_rank25_fitting_nodal_p320',
          'bad_double_rank25_fitting_invariant_p320'])
results = []
fp = GF(5)
poly = PolynomialRing(fp,'a')

for name in names:
    data = json.loads((receipts/(name+'.json')).read_text())
    mod = poly(data['field_modulus'])
    assert mod.is_irreducible()
    d = mod.degree()
    k = GF(5**d,'a',modulus=mod,impl='pari_ffelt')
    a = k.gen()
    def decode(co): return sum(k(c)*a**i for i,c in enumerate(co))
    parameter = decode(data['parameter'])
    minimal_coefficients = [int(c) for c in data['parameter_polynomial'].split(',')]
    assert sum(k(c)*parameter**i for i,c in enumerate(minimal_coefficients)) == 0
    six = [vector(k,[decode(c) for c in col]) for col in data['regular_free_columns']]
    inds = list(itertools.product(range(5),repeat=2))
    pos = {v:i for i,v in enumerate(inds)}
    # Construct each full column by applying the regular deck differences
    # to the six recorded image vectors, not by copying the producer's
    # row/column indexing formula.
    E = []
    for axis in range(2):
        mat = matrix(k,150,150,0,implementation='generic')
        for ab in inds:
            dest = list(ab); dest[axis] += 1
            if dest[axis] == 5: continue
            for j in range(6): mat[6*pos[tuple(dest)]+j,6*pos[ab]+j] = 1
        E.append(mat)
    def shift_vector(v, axis):
        ans = vector(k,150)
        for ab in inds:
            dest = list(ab); dest[axis] += 1
            if dest[axis] == 5: continue
            for c in range(6): ans[6*pos[tuple(dest)]+c] = v[6*pos[ab]+c]
        return ans
    columns = []
    for i,j in inds:
        for original in six:
            image = original
            for _ in range(i): image = shift_vector(image,0)
            for _ in range(j): image = shift_vector(image,1)
            columns.append(image)
    M = matrix(k,150,150,[columns[j][i] for i in range(150) for j in range(150)],implementation='generic')
    def frob(B, n=1):
        return matrix(k,B.nrows(),B.ncols(),[c**(5**n) for c in B.list()],implementation='generic')
    assert all(e*M == M*frob(e) for e in E)
    K0 = M.right_kernel().basis_matrix()
    K = frob(K0,d-1)
    assert M*frob(K.transpose()) == 0
    r = M.rank()
    ordinary = M.augment(K.transpose()).rank()-r
    chain = M
    ranks = [r]
    for j in range(1,5):
        chain = chain*frob(M,j)
        ranks.append(chain.rank())
    assert ranks == data['ranks']
    assert ordinary == 150-2*ranks[0]+ranks[1]
    assert ordinary == data['ordinary_kernel_to_cokernel_rank']
    # A separate cokernel-row calculation retains the SAME source
    # coordinates and provides a third expression for the rank.
    Lambda = M.left_kernel().basis_matrix()
    assert Lambda*M == 0
    assert (Lambda*K.transpose()).rank() == ordinary
    item = {'receipt':name,'field_degree':int(d),'ranks':list(map(int,ranks)),
            'defect':int(150-r),'ordinary_rank':int(ordinary),
            'checks':'regular deck, inverse-Frobenius kernel, augmentation quotient, iterate formula, and dual-row formula all PASS'}
    results.append(item)
    print(item,flush=True)

p320 = json.loads((receipts/(names[0]+'.json')).read_text())
p400_name = ('backup_rank25_fitting_nodal_p400.json' if options.backup else
             'bad_double_rank25_fitting_nodal_p400.json')
p400 = json.loads((receipts/p400_name).read_text())
assert p320['field_modulus'] == p400['field_modulus']
assert p320['parameter'] == p400['parameter']
assert p320['regular_free_columns'] == p400['regular_free_columns']
out = {'status':'PASS independent same-coordinate finite audit; special fiber only',
       'auditor':'/root/audit_nodal25_descent','date':'2026-09-13',
       'precision_comparison':'all six complete columns equal at320/400',
       'results':results}
out_name = ('backup_rank25_same_coordinate_independent_audit.json' if options.backup else
            'bad_double_rank25_same_coordinate_independent_audit.json')
(receipts/out_name).write_text(json.dumps(out,indent=2)+'\n')
