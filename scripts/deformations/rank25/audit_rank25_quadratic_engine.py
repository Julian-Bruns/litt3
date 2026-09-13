"""Independent embedding checks before an unramified quadratic replay."""
import importlib.util
import json
from pathlib import Path
import random
import sys

base=Path(sys.argv[1]);sys.path.insert(0,str(base/'reconstruction'))
pointdir='quadratic_0' if (base/'quadratic_0').is_dir() else 'octic_0'
sys.argv=['audit','--third-parameters',str(base/pointdir/'parameters.json'),
          '--precision','4200','--modulus','3125']
import witt as w
import numpy as np

def oldmul(a,b):
    c=[0]*7
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]+=int(x)*int(y)
    for i in range(6,3,-1):
        for j,q in enumerate((3,4,1,4)):c[i-4+j]-=q*c[i]
    return [x%3125 for x in c[:4]]

rng=random.Random(319)
for _ in range(100):
    a=[rng.randrange(3125) for _ in range(4)];b=[rng.randrange(3125) for _ in range(4)]
    assert np.array_equal(w.cm(a,b),w.ca(oldmul(a,b)))
    assert np.array_equal(w.cm(w.ca(a),w.ca(b)),w.ca(oldmul(a,b)))
assert np.array_equal(w.cp(w.GEN,w.DEG//4),w.T)
assert np.array_equal(w.SIGT,w.ca([122,1363,2775,2385]))
assert np.array_equal(np.linalg.matrix_power(w.SIGMAT.astype(object),w.DEG)%3125,np.eye(w.DEG,dtype=np.int64))
for _ in range(25):
    a=np.array([rng.randrange(3125) for _ in range(w.DEG)])
    if not np.any(a%5):continue
    assert np.array_equal(w.cm(a,w.ci(a)),w.ONE)
    assert np.array_equal(w.SIGMAT@a%5,w.cp(a,5)%5)
    assert np.array_equal(w.cp(w.cp(a,5**(w.DEG-1)),5)%5,a%5)
point=json.loads((base/pointdir/'parameters.json').read_text())
lam=w.ca(point['lambda'])
assert np.any(lam[1::2])
assert not np.array_equal(w.cp(lam,625)%5,lam)
f=point.get('factor',point.get('factor_codes'));coeff=[[(c//5**i)%5 for i in range(4)] for c in f]
assert not np.any(sum((w.cm(w.cp(lam,j),c) for j,c in enumerate(coeff)),start=w.ca(0))%5)
receipt={'status':'PASS','multiplication_embeddings':100,'inverse_and_Frobenius_checks':25,
         'Witt_Frobenius_order':w.DEG,'original_T_Frobenius_unchanged':True,
         'root_not_in_base_field':True,'coefficient_ring':f'W5(F5^{w.DEG}), h^{w.DEG//4}=t'}
(base/'arithmetic_audit.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt,indent=2))
