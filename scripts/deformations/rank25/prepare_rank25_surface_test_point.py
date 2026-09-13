"""One off-curve geometric diagnostic for the proposed surface trace identity."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import json
from pathlib import Path
import sys
from scripts.deformations.rank25 import rank25_pro_data_model as m

out=Path(sys.argv[1]);out.mkdir(exist_ok=False)
s=lam=(0,1,0,0);q=m.power(lam,5)
x=[m.add((2,1,3,0),m.power(s,5)),m.mul((4,3,3,1),q),m.mul((2,2,3,4),q),
   (3,0,0,3),(0,3,1,4),m.mul((3,1,1,2),q),q,m.ZERO,m.ZERO]
expected=m.mul((3,0,4,0),m.power(m.add(m.mul(m.power(lam,2),s),m.neg(m.ONE)),25))
(out/'parameters.json').write_text(json.dumps({'s':s,'lambda':lam,'x':x,
    'candidate_trace':expected,'status':'diagnostic; no universal identity inferred'},indent=2)+'\n')
print('Prepared s=t, lambda=t; candidate trace',expected)
