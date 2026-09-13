"""Exact old/new AS-product comparison, including nontrivial Witt carries."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import ast
import json
from pathlib import Path
import sys
import time

dest=Path(sys.argv[1]);engine=dest/'reconstruction';sys.path.insert(0,str(engine))
sys.argv=['audit','--precision','4200','--modulus','3125','--third-parameters',str(dest/'octic_0/parameters.json')]
import witt as w
import numpy as np
from scripts.deformations.rank25.rank25_adaptive_as_convolution import adaptive_dense_product

ns=dict(vars(w));ns['HH']=[[w.ca(c) for c in row] for row in
    json.loads((dest/'supplied/inputs/rank25_fourth.json').read_text())['additive_matrix']]
ns['indices']=[(i,j) for i in range(5) for j in range(5)]
ns['pos']={ab:i for i,ab in enumerate(ns['indices'])}
nodes=ast.parse((engine/'as25.py').read_text()).body
selected=[]
for name in ['cmat','reduce_monomial','dense_product']:
    selected.append(next(n for n in nodes if isinstance(n,ast.FunctionDef) and n.name==name))
exec(compile(ast.Module(body=selected,type_ignores=[]),'original_dense','exec'),ns)
ns['RED']={ab:[(k,ns['cmat'](c)) for k,c in ns['reduce_monomial'](*ab).items() if np.any(c)]
           for ab in [(i,j) for i in range(9) for j in range(9)]}
old=ns['dense_product'];rng=np.random.default_rng(192)
def sample(step,n):
    out=[]
    for _ in range(25):
        ar=np.zeros((w.DEG,n),dtype=np.int64)
        ar[::step]=rng.integers(0,3125,(w.DEG//step,n))
        out.append(w.Ser(ar,l=-3))
    return out
checks=[]
for step in [2,4,8]:
    for n in [2,9,40]:
        a,b=sample(step,n),sample(step,n+1)
        x=old(a,b,4000);y=adaptive_dense_product(ns,old,a,b,4000)
        assert all(v.prec==q.prec and v.l==q.l and np.array_equal(v.a,q.a) for v,q in zip(x,y))
        checks.append([step,n])
a,b=sample(8,400),sample(8,400)
start=time.monotonic();x=old(a,b,4000);oldtime=time.monotonic()-start
start=time.monotonic();y=adaptive_dense_product(ns,old,a,b,4000);newtime=time.monotonic()-start
assert all(v.prec==q.prec and v.l==q.l and np.array_equal(v.a,q.a) for v,q in zip(x,y))
result={'status':'PASS','exact_full_coefficient_checks':checks,
        'basefield_400_terms_old_seconds':oldtime,'adaptive_seconds':newtime,
        'speedup':oldtime/newtime,'precision_and_all_coefficients_identical':True}
(dest/'adaptive_product_audit.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
