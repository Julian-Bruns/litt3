"""Full nonzero-pivot parameter chart and cleared F6; no further pivot chosen."""
import json
from ff import *
from laurent import LP

def main():
 C=json.loads((ROOT/'data/charts.json').read_text())['cases'];B=json.loads((ROOT/'data/boundary_series.json').read_text())['cases'];out=[]
 for ch,bc in zip(C,B):
  det=LP.load(ch['determinant']);n0=LP.load(ch['s_numerator']);n1=LP.load(ch['u_numerator']);F6=LP.load(bc['F']['6'])
  psi=LP()
  for (h,w,s,u),c in F6.d.items():
   assert s>=0 and u>=0 and s+u<=2
   psi=psi+LP.mon([h,w,0,0],c)*(n0**s)*(n1**u)*(det**(2-s-u))
  assert all(e[2]==e[3]==0 for e in psi.d)
  for h,w in [(1,1),(2,3),(7,11)]:
   d=det.eval([h,w,0,0])
   if not d:continue
   ss=div(n0.eval([h,w,0,0]),d);uu=div(n1.eval([h,w,0,0]),d)
   assert psi.eval([h,w,0,0])==mul(powf(d,2),F6.eval([h,w,ss,uu]))
  out.append({'index':ch['index'],'root':ch['root'],'Psi6':psi.dump(),'terms':len(psi.d),'h_degree':psi.degree(0),'w_min':psi.valuation(1),'w_max':psi.degree(1),'degree140_open':'h*w*determinant*Psi6 != 0; kappa !=0; s=n0/determinant,u=n1/determinant'})
  print('case',ch['index'],'Psi6 terms',len(psi.d),'h degree',psi.degree(0),'w range',psi.valuation(1),psi.degree(1),flush=True)
 (ROOT/'data/generic_boundary.json').write_text(json.dumps({'variables':['h','w','s','u'],'identity':'Psi6=determinant^2*F6(h,w,n0/determinant,n1/determinant)','cases':out},indent=2)+'\n')
 # Independent numerical checks of the universal leading formula.
 from reconstruct import epsilon
 for sl in json.loads((ROOT/'data/slices.json').read_text())['cases']:
  R=json.loads((ROOT/sl['residual']).read_text())['lambda_coefficients'];expected=powf(mul(mul(3,powf(sl['h'],3)),mul(powf(epsilon,8),sl['F6'])),3)
  assert R[0][140]==expected and all(len(p)<=140 for p in R[1:])
 for sign in [0,1]:
  path=ROOT/'data'/f'exceptional_param_3_{sign}_metadata.json'
  rp=ROOT/'data'/f'exceptional_param_3_{sign}.json'
  if path.exists() and rp.exists():
   md=json.loads(path.read_text());R=json.loads(rp.read_text())['lambda_coefficients'];expected=powf(mul(mul(3,powf(md['h'],3)),powf(epsilon,8)),3)
   assert R[0][3*1024+140]==expected
 print('GENERIC CHARTS AND LEADING COEFFICIENT CHECKS PASSED',flush=True)
if __name__=='__main__':main()
