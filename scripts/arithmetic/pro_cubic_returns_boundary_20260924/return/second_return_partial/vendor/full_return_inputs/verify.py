from pathlib import Path
import hashlib,json,sys
import numpy as np
root=Path(__file__).resolve().parent
for name,h in json.loads((root/'SHA256.json').read_text()).items():
 assert hashlib.sha256((root/name).read_bytes()).hexdigest()==h,name
sys.path.insert(0,str(root/'src'))
import compute as c
import geometry as g
import negative_quotient as n
c.ROOT.mkdir(exist_ok=True)
T=c.build()
assert T.shape==(19,80,35)
_,_,Q,_,_=n.build_negative(25,-1)
assert Q.shape==(19,43,16)
np.savez_compressed(root/'data/negative_second.npz',Q=Q)
g.stability_sections();g.regression()
print('PASS exact input reconstruction; no geometric return decision asserted.')
