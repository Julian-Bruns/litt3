"""Exact error polynomials in inverse scale on a specified ratio fiber."""
import argparse,json
from pathlib import Path
import exact as E

def errors(R):
 F=E.F;deg=max(len(p)-1 for p in R);assert deg==140
 lc=int(R[0][140]);assert lc and all(len(p)<=140 for p in R[1:])
 b=[]
 for m in range(141):b.append(E.scale(E.poly([int(p[140-m]) if len(p)>140-m else 0 for p in R]),F.I(lc)))
 j=[E.poly([1])]
 for m in range(1,71):
  s=E.poly()
  for i in range(1,m):s=E.add(s,E.mul(j[i],j[m-i]))
  j.append(E.scale(E.sub(b[m],s),3))
 es=[]
 for m in range(71,141):
  s=E.poly()
  for i in range(max(0,m-70),min(70,m)+1):s=E.add(s,E.mul(j[i],j[m-i]))
  es.append(E.sub(b[m],s))
 return j,es

def xgcd(a,b):
 r0,r1=a,b;s0,s1=E.poly([1]),E.poly();t0,t1=E.poly(),E.poly([1])
 while len(r1):
  q,r=E.divmodp(r0,r1);r0,r1=r1,r;s0,s1=s1,E.sub(s0,E.mul(q,s1));t0,t1=t1,E.sub(t0,E.mul(q,t1))
 if len(r0):
  c=E.F.I(int(r0[-1]));r0,s0,t0=E.scale(r0,c),E.scale(s0,c),E.scale(t0,c)
 return r0,s0,t0

if __name__=='__main__':
 ap=argparse.ArgumentParser();ap.add_argument('--tables',required=True);ap.add_argument('--data',required=True);ap.add_argument('--certificates',required=True);args=ap.parse_args();E.init(args.tables);Path(args.certificates).mkdir(exist_ok=True,parents=True)
 for fn in sorted(Path(args.data).glob('residual_h2w1_*.json')):
  d=json.loads(fn.read_text());R=[E.poly(p) for p in d['R_lambda']];j,es=errors(R);g,a,b=xgcd(es[0],es[1]);assert len(g)==1 and g[0]==1
  assert E.add(E.mul(a,es[0]),E.mul(b,es[1])).tolist()==[1]
  cert={'scope':'h=2,w=1; all geometric lambda, including zero','root':d['root'],'error_indices':[71,72], 'errors':[e.tolist() for e in es[:2]],'bezout':[a.tolist(),b.tolist()],'rhs':[1], 'all_error_degrees':[len(e)-1 for e in es]}
  name=fn.name.replace('residual_','bezout_');Path(args.certificates,name).write_text(json.dumps(cert,separators=(',',':'))+'\n')
  print(name,'E71,E72 degrees',len(es[0])-1,len(es[1])-1,'Bezout degrees',len(a)-1,len(b)-1,'identity verified',flush=True)
