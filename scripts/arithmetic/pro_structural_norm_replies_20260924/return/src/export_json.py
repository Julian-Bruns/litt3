"""Export every stored integer array to a software-independent JSON description."""
from pathlib import Path
import numpy as np,json
ROOT=Path(__file__).resolve().parents[1]
out={}
for p in sorted((ROOT/'data').glob('*.npz')):
 with np.load(p) as z:
  out[p.name]={k:{'shape':list(z[k].shape),'dtype':str(z[k].dtype),'data':z[k].tolist()} for k in z.files}
(ROOT/'data'/'portable_arrays.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
print('Exported',len(out),'NPZ containers to portable_arrays.json')
