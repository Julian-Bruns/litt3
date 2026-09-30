"""Independent schoolbook multiplication for all new finite-algebra Bezout identities."""
from verify_certificates_python import run
from exact import ROOT
import time
start=time.time();total=0
for u0 in range(1,25):total+=run(ROOT/'evidence'/f'fibre_u_{u0}.json')
assert total==216
print('Independent verification: 24 identities = 1, covering 216 geometric ratios and every geometric scale; seconds',round(time.time()-start,3),flush=True)
