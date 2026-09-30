from pathlib import Path
import json,gzip,numpy as np
ROOT=Path(__file__).resolve().parents[1]
out={'format':'Exact F25-coded arrays; beta^2=beta+3; code a+5b means a+b*beta. Nested row-major lists.','arrays':{}}
for fn in sorted((ROOT/'data').glob('*.npz')):
 d=np.load(fn)
 for key in d.files:
  a=d[key];out['arrays'][fn.stem+'/'+key]={'shape':list(a.shape),'dtype':str(a.dtype),'values':a.tolist()}
raw=json.dumps(out,separators=(',',':')).encode()
with open(ROOT/'data/portable_arrays.json.gz','wb') as f:
 with gzip.GzipFile(fileobj=f,mode='wb',mtime=0) as g:g.write(raw)
print('Exported',len(out['arrays']),'arrays;',len(raw),'uncompressed JSON bytes')
