"""Compact exact leading coefficient inspection for new trace reduction."""
import sys,json
from pathlib import Path
root=Path(sys.argv[1]);out=[]
for name in sys.argv[2:]:
 d=load(str(root/(name+'_rational_coefficients.sobj')))
 R=d['ring'];H,q=R.gens();K=R.base_ring();a=K.gen()
 u=a^4+2*a^3+a^2+2*a;v=a^3+a^2+1;beta=-u/v
 def vec(c):
  x=c.polynomial().list();return vector(GF(5),x+[0]*(8-len(x)))
 invmat=matrix(GF(5),[vec(a^j*beta^k) for j in range(4) for k in range(2)]).transpose().inverse()
 def code(c):
  v=invmat*vec(c);return int(sum((ZZ(v[2*j])+5*ZZ(v[2*j+1]))*25^j for j in range(4)))
 for j in range(3):
  rows=[r for r in d['coefficients'] if r[0]==j];top=max(r[1] for r in rows)
  for _,n,N,D in rows:
   if n>=top-1:
    dd=N.dict();entry={'family':name,'j':int(j),'n':int(n),'terms':len(dd),'den':list(map(int,D))}
    if len(dd)<=50:entry['coefficients']=[[int(e[0]),int(e[1]),code(c)] for e,c in sorted(dd.items())]
    out.append(entry)
print(json.dumps(out,indent=2))
