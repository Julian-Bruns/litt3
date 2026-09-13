"""Check all45 saved quadratic vectors and their filtered preimages.

This is an independent finite certificate audit, not a Laurent replay.
"""
import argparse, hashlib, itertools, json
from pathlib import Path

root = Path(__file__).resolve().parents[2]
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--audit',type=Path,default=root/'Research/computations/bad_double_initial_quadratic_audit.json')
parser.add_argument('--output',type=Path,default=root/'Research/computations/bad_double_quadratic_independent_finite_audit.json')
args=parser.parse_args()
audit = json.loads(args.audit.read_text())
receipt = Path(audit['receipt'])
compare = Path(audit['comparison']['file'])
assert hashlib.sha256(receipt.read_bytes()).hexdigest() == audit['sha256']
assert hashlib.sha256(compare.read_bytes()).hexdigest() == audit['comparison']['sha256']
data,other = [json.loads(p.read_text()) for p in (receipt,compare)]
module = Path(audit['module'])
if not module.is_absolute(): module = root/module
assert hashlib.sha256(module.read_bytes()).hexdigest() == audit['module_sha256']
model = json.loads(module.read_text())
for key in ['field_modulus','parameter','kernel_frobenius_inputs','dual_rows','coefficients']:
    assert data[key] == other[key]
assert data['status'] == other['status'] == 'complete'
assert [c['pair'] for c in data['coefficients']] == [list(p) for p in itertools.combinations_with_replacement(range(9),2)]
assert len(data['coefficients']) == len(audit['coefficients']) == 45
fp = GF(5); P = PolynomialRing(fp,'a')
k = GF(5**(len(data['field_modulus'])-1),'a',modulus=P(data['field_modulus']),impl='pari_ffelt')
a = k.gen()
decode = lambda co: sum(k(c)*a**i for i,c in enumerate(co))
ix = list(itertools.product(range(5),repeat=2)); pos = {p:i for i,p in enumerate(ix)}
images = [vector(k,[decode(c) for c in v]) for v in model['regular_free_columns']]

def shift(v, axis):
    w = vector(k,150)
    for ab in ix:
        dest = list(ab); dest[axis] += 1
        if dest[axis] == 5: continue
        for j in range(6): w[6*pos[tuple(dest)]+j] = v[6*pos[ab]+j]
    return w

columns = []
for i,j in ix:
    for col in images:
        v = col
        for _ in range(i): v = shift(v,0)
        for _ in range(j): v = shift(v,1)
        columns.append(v)
M = matrix(k,150,150,[columns[j][i] for i in range(150) for j in range(150)],implementation='generic')
Lambda = matrix(k,[[decode(c) for c in row] for row in data['dual_rows']])
assert M.rank() == 141 and Lambda.rank() == 9 and Lambda*M == 0
degree = lambda v: max([8-sum(ix[j//6]) for j,c in enumerate(v) if c]+[-1])
records = []
for source,cert in zip(data['coefficients'],audit['coefficients']):
    assert source['pair'] == cert['pair']
    normal = vector(k,[decode(c) for c in source['normal']])
    assert normal != 0
    assert Lambda*normal == 0
    assert all(not any(c) for c in source['projection'])
    pre = vector(k,150)
    for j,c in cert['preimage_nonzero']: pre[j] = decode(c)
    assert M*pre == normal
    actual = vector(k,[c**(5**(k.degree()-1)) for c in pre])
    assert M*vector(k,[c**5 for c in actual]) == normal
    assert degree(normal) == cert['normal_AS_bound']
    assert degree(actual) <= cert['minimal_preimage_AS_bound'] <= degree(normal)
    records.append({'pair':source['pair'],'normal_degree':int(degree(normal)),
                    'certified_source_preimage_degree':int(degree(actual))})
out = {'status':'PASS all45 finite normal/projection/preimage identities; no integral or uniform theorem',
       'auditor':'/root/audit_nodal25_descent','date':'2026-09-13',
       'all45_nonzero_normal_vectors':True,'all45_cokernel_projections_zero':True,
       'all45_normal_vectors_equal_at500_and700':True,
       'all45_source_preimages_without_AS_degree_increase':True,
       'receipt_sha256':audit['sha256'],'comparison_sha256':audit['comparison']['sha256'],
       'records':records}
args.output.write_text(json.dumps(out,indent=2)+'\n')
print('PASS all45 normal vectors, zero projections, precision agreement, and filtered actual source preimages')
