"""Lossless portable JSON versions of the two main tensor files."""
from pathlib import Path
import gzip,json,numpy as np
R=Path(__file__).resolve().parents[1]
for name in ['pure_v_return','equivariant']:
 d=np.load(R/'data'/f'{name}.npz')
 obj={'format':'named multidimensional arrays, row-major; integer codes are coefficients of F25 unless the key denotes indices or row selections',
      'field':'F5[beta]/(beta^2-beta-3)','code':'a+5*b for a+b*beta',
      'arrays':{k:{'shape':list(d[k].shape),'dtype':str(d[k].dtype),'values':d[k].tolist()} for k in d.files}}
 with gzip.GzipFile(filename=str(R/'data'/f'{name}.json.gz'),mode='wb',mtime=0) as f:f.write(json.dumps(obj,separators=(',',':')).encode())
 print('Exported',name)

