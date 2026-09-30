"""Determinantal chart equations; no pivot-zero chart is discarded."""
import json
from ff import *
from laurent import LP

def reduce_w3(F,q):
 out=LP()
 for e,c in F.d.items():
  ee=list(e);m,r=divmod(ee[1],3);ee[1]=r
  out=out+LP.mon(ee,mul(c,powf(q,m)))
 return out

def data_cases():return json.loads((ROOT/'data'/'boundary_series.json').read_text())['cases']

def chart(case):
 F={i:LP.load(case['F'][str(i)]) for i in range(4,9)}
 p4,p5=F[4].without([2,3]),F[5].without([2,3])
 a,b=F[4].coeff(2,1),F[4].coeff(3,1)
 c,d=F[5].coeff(2,1),F[5].coeff(3,1)
 det=a*d-b*c
 n0=b*p5-d*p4;n1=c*p4-a*p5
 assert det==LP.load(case['kernel_determinant'])
 out={'index':case['index'],'root':case['root'],'determinant':det.dump(),'s_numerator':n0.dump(),'u_numerator':n1.dump()}
 if case['root'] is None:
  s,u=n0/det,n1/det
  assert not F[4].subs({2:s,3:u}) and not F[5].subs({2:s,3:u})
  out['s']=s.dump();out['u']=u.dump()
  out['F_sub']={str(i):F[i].subs({2:s,3:u}).dump() for i in range(6,9)}
  print('constant kernel s=',s.show(),flush=True)
  print('constant kernel u=',u.show(),flush=True)
  for i in range(6,9):print('constant F'+str(i)+'=',LP.load(out['F_sub'][str(i)]).show(),flush=True)
 else:
  q=neg(div(det.d[(0,2,0,0)],det.d[(0,5,0,0)]))
  compat=reduce_w3(a*p5-c*p4,q)
  # a is a nonzero constant times w^2, so use F4 to solve s globally.
  s=-(b*LP.var(3)+p4)/a
  F5s=reduce_w3(F[5].subs({2:s}),q)
  assert reduce_w3(a*F5s-compat,q)==LP()
  # Translate compatibility to h=w*H: w*(c0+c1*H+c2*q*H^2).
  cc0=compat.d.get((0,1,0,0),0);cc1=compat.d.get((1,0,0,0),0);cc2=mul(q,compat.d.get((2,2,0,0),0))
  assert len(compat.d)==3 and cc0 and cc1 and cc2
  discriminant=sub(mul(cc1,cc1),mul(4,mul(cc0,cc2)))
  out['exceptional']={'w3':q,'compatibility':compat.dump(),'H_polynomial':[cc0,cc1,cc2],'H_discriminant':discriminant,'s':s.dump(),'F_sub_w3':{str(i):reduce_w3(F[i].subs({2:s}),q).dump() for i in range(6,9)}}
  print('linear',case['root'],'w^3=',q,'cube?',LOG[q]%3==0,'H polynomial',[cc0,cc1,cc2],'disc square?',not discriminant or LOG[discriminant]%2==0,flush=True)
 return out

def main():
 data={'variables':['h','w','s','u'],'convention':'On det != 0, s=s_numerator/determinant and u=u_numerator/determinant. At det=0 use exceptional equations. H=h/w.','cases':[chart(c) for c in data_cases()]}
 (ROOT/'data'/'charts.json').write_text(json.dumps(data,indent=2)+'\n')
 print('ALL CHART IDENTITIES PASSED',flush=True)
if __name__=='__main__':main()
