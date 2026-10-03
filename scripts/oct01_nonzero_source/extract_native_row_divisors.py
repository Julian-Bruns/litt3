#!/usr/bin/env python3
"""Read the initial row divisors without replaying a completed target check."""
import argparse,json
from pathlib import Path
import numpy as np
p=argparse.ArgumentParser();p.add_argument('directory',type=Path);a=p.parse_args();d=a.directory
report=json.loads((d/'small_certificate.json').read_text())
assert report['stream_operations'].get('5',0)==0,'later saturation divisors require full extractor'
v=np.memmap(d/'native_module_operations.bin',dtype='<u4',mode='r');assert int(v[0])==0x4c495433
k=2+int(v[1]);divisors={};count=0
while int(v[k])==1:
    k+=2;n=int(v[k]);k+=1;f=tuple(map(int,v[k:k+n]));k+=n;divisors[f]=divisors.get(f,0)+1;count+=1
assert count==report['stream_operations']['1']
(d/'row_divisors.json').write_text(json.dumps({'scope':'literal original-row divisors; full parsed stream certifies no later saturation division','divisors':[{'coefficients':list(f),'uses':n} for f,n in divisors.items()]},separators=(',',':'))+'\n')
meta=json.loads((d/'metadata.json').read_text());assert meta['auxiliaries']==15
report['meaning']='whole eta/lambda exclusion conditional on H exactm6leading selectedcriticalleading; endpoint type '+str(meta['root'])+'; auxiliary determinant zero included'
(d/'small_certificate.json').write_text(json.dumps(report,separators=(',',':'))+'\n')
print(json.dumps({'row_divisions':count,'distinct_divisors':len(divisors),'root':meta['root']}))
