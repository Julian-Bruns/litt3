"""Exact description of the pivot-zero degree-140 coefficient locus."""
import json
from ff import *
from laurent import LP
from charts import reduce_w3

def reduce_H(F,poly):
 H=LP.var(0);c0,c1,c2=poly;rel=-LP(div(c0,c2))-H*div(c1,c2)
 hp=[LP(1),H]
 for i in range(2,max(1,F.degree(0))+1):
  rr=hp[-1]*H;hp.append(rr.coeff(0,0)+rr.coeff(0,1)*H+rr.coeff(0,2)*rel)
 out=LP()
 for exp,c in F.d.items():
  ee=list(exp);power=ee[0];ee[0]=0
  assert power>=0
  out=out+LP.mon(ee,c)*hp[power]
 return out

def main():
 cases=json.loads((ROOT/'data/charts.json').read_text())['cases'];out=[]
 for case in cases[1:]:
  ex=case['exceptional'];q=ex['w3'];poly=ex['H_polynomial'];H,w=LP.var(0),LP.var(1)
  fs={}
  for i in [6,7,8]:
   F=LP.load(ex['F_sub_w3'][str(i)]).subs({0:H*w})
   fs[i]=reduce_H(reduce_w3(F,q),poly)
  F=fs[6]
  assert all(e[2]==0 and e[3]<=1 for e in F.d)
  c0=F.d.get((0,0,0,0),0);c1=F.d.get((1,0,0,0),0)
  d0=F.d.get((0,1,0,1),0);d1=F.d.get((1,1,0,1),0)
  assert F==LP(c0)+LP(c1)*H+(LP(d0)+LP(d1)*H)*w*LP.var(3)
  disc=sub(mul(poly[1],poly[1]),mul(4,mul(poly[0],poly[2])))
  assert disc and poly[0] and poly[2] and q
  slope_root=neg(div(d0,d1));nonvan=peval(poly,slope_root)
  assert nonvan
  # An explicit inverse for d0+d1*H modulo the quadratic, via Euclidean solve.
  aa=div(poly[0],poly[2]);bb=div(poly[1],poly[2])
  mat=[[d0,neg(mul(d1,aa))],[d1,sub(d0,mul(d1,bb))]]
  inverse=solve(mat,[1,0])[:,0].tolist()
  assert pmod(pmul([d0,d1],inverse),poly)==[1]
  out.append({'index':case['index'],'root':case['root'],'w3':q,'H_polynomial':poly,'H_discriminant':disc,'F6':fs[6].dump(),'F7':fs[7].dump(),'F8':fs[8].dump(),'F6_constant':[c0,c1],'F6_slope_div_w':[d0,d1],'slope_inverse_mod_H':inverse,'slope_root_not_on_quadratic':nonvan})
  print('v=x-root',case['root'],'six distinct (w,H); F6=',fs[6].show(('H','w','s','u')),'; slope invertible',flush=True)
 (ROOT/'data'/'exceptional.json').write_text(json.dumps({'variables':['H','w','s','u'],'H_convention':'H=h/w','cases':out},indent=2)+'\n')
 print('ALL 60 GEOMETRIC EXCEPTIONAL FIBERS RETAINED; EACH HAS F6 AFFINE LINEAR WITH NONZERO SLOPE.',flush=True)
if __name__=='__main__':main()
