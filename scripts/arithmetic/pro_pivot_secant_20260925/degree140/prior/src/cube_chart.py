"""Cube-root-free rational charts, with no additional open conditions.
Constant v: H=h*w. Linear v: H=h/w. In both cases q=w^3, mu=lambda/w.
The saved G_i satisfy H_i(x,wY)/w=G_i(H,q;x,Y)/d(q).
"""
import argparse,json
from pathlib import Path
from collections import defaultdict
import exact as E
from sparse import Poly
from atlas import fixed_data

def build(atlas,chart):
 F=E.F;h,w=Poly.var(0),Poly.var(1);alpha=25
 eps=chart['epsilon'];eta=chart['eta'];z=w*F.M(2,F.I(eps))
 Cd=F.A(F.A(F.A(3,F.M(10,alpha)),F.P(alpha,2)),F.M(14,F.P(alpha,3)))
 Ca=F.A(F.A(F.A(18,F.M(14,alpha)),F.M(10,F.P(alpha,2))),F.M(19,F.P(alpha,3)))
 c=w*Cd+(Poly() if atlas['root'] is None else h*Ca)
 e=-c*z-z**(-1)*F.M(eta,F.I(24));f=-w*w*F.I(eps)-z**5*F.M(8,F.I(24))
 det=Poly.read(chart['det']);ns=Poly.read(chart['s_num']);nu=Poly.read(chart['u_num'])
 pars=[det,h*det,w*det,e*det,f*det,ns,nu]
 sign=-1 if atlas['root'] is None else 1
 def convert(poly,shift):
  out={}
  for (a,b,s,u),v in poly.d.items():
   assert s==u==0
   b+=sign*a+shift;assert b%3==0,(atlas['root'],a,b)
   key=(a,b//3,0,0);out[key]=F.A(out.get(key,0),v)
  return Poly(out)
 G=[]
 for k in range(4):
  terms=[]
  for j in range(3):
   maxdegree=max(len(col[k][j]) for col in atlas['data'])
   for i in range(maxdegree):
    p=Poly()
    for par,col in zip(pars,atlas['data']):
     if i<len(col[k][j]):p=p+par*col[k][j][i]
    cp=convert(p,j-3)
    for (a,b,_,_),cf in cp.d.items():terms.append([[a,b,i,j],cf])
  G.append(sorted(terms))
 d=convert(det,-2);psi=convert(Poly.read(chart['Psi6']),-1)
 return {'root':atlas['root'],'variables':['H','q','x','Y'],
  'ratio_change':'H=h*w' if atlas['root'] is None else 'H=h/w',
  'common_denominator_d':d.serial(),'Psi':psi.serial(),'G':G,
  'open':'H*q*d(q)*Psi(H,q)!=0, mu!=0',
  'curve_relation':'Y^3=P(x)/q', 't_new':'q*t(x)',
  'residual_relation':'R_new(x,mu)=q^13*R_old(x,w*mu), w^3=q',
  'F6_relation':'F6_old=Psi(H,q)/(q*d(q)^2)'}

def evaluate(data,H,q):
 F=E.F;den=Poly.read(data['common_denominator_d']).evaluate([H,q,0,0]);out=[]
 if not den:raise ValueError('zero pivot')
 for terms in data['G']:
  g=list(E.czero())
  for (a,b,i,j),c in terms:
   v=F.M(c,F.M(F.P(H,a),F.P(q,b)));g[j]=E.add(g[j],E.monomial(i,0,v)[0])
  out.append(E.cscale(tuple(g),F.I(den)))
 return out

if __name__=='__main__':
 ap=argparse.ArgumentParser();ap.add_argument('--tables',required=True);ap.add_argument('--data',required=True);args=ap.parse_args();E.init(args.tables)
 for fn in sorted(Path(args.data).glob('atlas_*.json')):
  a=json.loads(fn.read_text());c=json.loads(fn.with_name(fn.name.replace('atlas_','chart_')).read_text());out=build(a,c)
  fn.with_name(fn.name.replace('atlas_','cube_')).write_text(json.dumps(out,separators=(',',':'))+'\n')
  print(fn.name,'cube-free terms',[len(p) for p in out['G']], 'denominator',out['common_denominator_d'],'Psi terms',len(out['Psi']),flush=True)
