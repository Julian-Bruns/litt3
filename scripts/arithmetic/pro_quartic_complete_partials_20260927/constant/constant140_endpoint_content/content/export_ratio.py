from pathlib import Path
import json
root=Path(__file__).resolve().parents[1]
s=json.loads((root/'inputs/ratio_source.json').read_text())['source']
with (root/'regenerated/ratio_source.dat').open('w') as f:
 f.write('RATIO_SOURCE_V1\n')
 for r in s:
  def put(a):
   while a and a[-1]==0:a.pop()
   f.write(str(len(a))+' '+ ' '.join(map(str,a))+'\n')
  put(r['U'][:]);put(r['V'][:])
  for h in range(2):
   for q in range(6):
    a=[0]*20
    for hh,qq,x,c in r['Z_terms_H_q_x_code']:
     if hh==h and qq==q:a[x]=c
    put(a)
print('ratio_source.dat regenerated')
