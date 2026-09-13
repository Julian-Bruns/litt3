"""Finite audit and filtered preimages of the actual quadratic channel.

This reads computed characteristic-five normal vectors; it does not
construct a divided integral carry or prove uniform parameter vanishing.
"""
import argparse, hashlib, itertools, json
from pathlib import Path

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--receipt',type=Path,required=True)
p.add_argument('--compare',type=Path)
p.add_argument('--output',type=Path,required=True)
a=p.parse_args()
d=json.loads(a.receipt.read_text())
module=Path(d['module']); m=json.loads(module.read_text())
F=GF(5); P=PolynomialRing(F,'z'); z=P.gen()
k=GF(5**(len(d['field_modulus'])-1),name='t',modulus=P(d['field_modulus']),impl='pari_ffelt')
dec=lambda c:sum(k(v)*k.gen()**i for i,v in enumerate(c))
enc=lambda c:[int(v) for v in c.polynomial().list()]+[int(0)]*(k.degree()-len(c.polynomial().list()))
ix=list(itertools.product(range(5),repeat=2)); pos={v:i for i,v in enumerate(ix)}
M=matrix(k,150,150,0,implementation='generic')
for ab in ix:
 for cd in ix:
  ef=tuple(ab[h]+cd[h] for h in range(2))
  if max(ef)>=5:continue
  for i in range(6):
   for j in range(6):M[6*pos[ef]+i,6*pos[ab]+j]=dec(m['regular_free_columns'][j][6*pos[cd]+i])
K=matrix(k,[[dec(c) for c in row] for row in d['kernel_frobenius_inputs']])
Lam=matrix(k,[[dec(c) for c in row] for row in d['dual_rows']])
assert M.rank()==141 and K.rank()==Lam.rank()==9
assert not M*K.transpose() and not Lam*M
iterate=identity_matrix(k,150)
for _ in range(5):
 iterate=M*iterate.apply_map(lambda c:c**5)
stable=iterate.column_space()
assert len(d['coefficients'])==45 and d['status']=='complete'
assert [r['pair'] for r in d['coefficients']]==[list(v) for v in itertools.combinations_with_replacement(range(9),2)]
degree=lambda row:int(max([8-sum(ix[j//6]) for j,c in enumerate(row) if c]+[-1]))
kd=[degree(row) for row in K]
filts=[]
for dd in range(9):
 cols=[j for j in range(150) if sum(ix[j//6])>=8-dd]
 mm=M.matrix_from_columns(cols)
 filts.append((cols,mm,mm.column_space()))
records=[]
for item in d['coefficients']:
 coho=vector(k,[dec(c) for c in item['normal']]); projected=Lam*coho
 assert [enc(c) for c in projected]==item['projection'] and not projected
 bound=next(dd for dd,(_,_,space) in enumerate(filts) if coho in space)
 cols,mm,_=filts[bound]; root=mm.solve_right(coho)
 assert mm*root==coho
 records.append({'pair':item['pair'],'normal_AS_bound':degree(coho),
                 'minimal_preimage_AS_bound':bound,
                 'in_bijective_Fitting_image':coho in stable,
                 'preimage_nonzero':[[int(j),enc(c)] for j,c in zip(cols,root) if c]})
comparison=None
if a.compare:
 other=json.loads(a.compare.read_text())
 for key in ['field_modulus','parameter','kernel_frobenius_inputs','dual_rows','coefficients']:
  assert d[key]==other[key],key
 comparison={'file':str(a.compare),'sha256':hashlib.sha256(a.compare.read_bytes()).hexdigest(),
             'all_45_normal_vectors_identical':True}
out={'verdict':'PASS finite coefficient audit; no integral or uniform theorem',
 'receipt':str(a.receipt),'sha256':hashlib.sha256(a.receipt.read_bytes()).hexdigest(),
 'module':str(module),'module_sha256':hashlib.sha256(module.read_bytes()).hexdigest(),
 'kernel_AS_degrees':kd,'comparison':comparison,'coefficients':records}
a.output.write_text(json.dumps(out,separators=(',',':'))+'\n')
print(json.dumps({key:out[key] for key in ['verdict','kernel_AS_degrees','comparison']}))
print('PREIMAGE_BOUNDS',[(r['pair'],r['normal_AS_bound'],r['minimal_preimage_AS_bound']) for r in records])
print('NONBIJECTIVE_PAIRS',[r['pair'] for r in records if not r['in_bijective_Fitting_image']])
