"""Export the accepted root-nine source to a compact native evaluator."""
import sys,json,time
from pathlib import Path
src=Path(sys.argv[1]);out=Path(sys.argv[2]);out.mkdir(parents=True,exist_ok=True)
d=load(str(src/'actual_delta.sobj'));gs=d['source_G'];FF=d['P'].base_ring();R=FF.ring();h,w=R.gens();K=R.base_ring();a=K.gen();F5=GF(5)
beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1)
def pv(c):return vector(F5,[K(c).polynomial()[i] for i in range(8)])
change=matrix(F5,[pv(beta^j*a^i) for i in range(4) for j in range(2)]).transpose().inverse()
def enc(c):
 z=change*pv(c);return int(sum(ZZ(z[2*i])*25^i+ZZ(z[2*i+1])*5*25^i for i in range(4)))
report=[]
with (out/'source_native.txt').open('w') as f:
 for g in gs:
  den=lcm([c.denominator() for j in range(3) for c in g[j] if c]);rows=[]
  for j in range(3):
   for i,c in enumerate(g[j]):
    p=R(c*den)
    rows.extend((i,j,int(he),int(we),enc(co)) for (he,we),co in p.dict().items())
  dd=[(int(he),int(we),enc(co)) for (he,we),co in den.dict().items()]
  f.write(f'{len(rows)} {len(dd)}\n')
  for row in rows:f.write(' '.join(map(str,row))+'\n')
  for row in dd:f.write(' '.join(map(str,row))+'\n')
  report.append({'numerator_terms':len(rows),'denominator_terms':len(dd),'denominator':str(den)})
(out/'source_native.json').write_text(json.dumps({'scope':'accepted source exported, not a new reconstruction','groups':report},indent=2)+'\n')
print(report,flush=True)
