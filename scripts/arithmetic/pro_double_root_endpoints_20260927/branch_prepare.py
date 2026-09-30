"""Retain the complete allowed quotient for the branch-root incidence."""
from exact import *
from curve_eliminate import remove_support
import rank9 as R
import json,time

def eval_ring(p,u,mod):
 v=[]
 for j in range(8,-1,-1):
  x=[]
  for c in p[j][::-1]:x=prem(pa(pm(x,u),[c]),mod)
  v=pa([0]+v,x);v=prem(v,mod)
 return v

def run():
 tic=time.time();d=json.loads((ROOT/'work/branch_root/data.json').read_text());pr=json.loads((ROOT/'work/branch_root/projection.json').read_text());mod=pr['allowed_projection'];mod=pc(mod,inv(mod[-1]))
 a,b=pr['primitive_linear_remainder'];g,iv,j=pxgcd(b,mod);assert g==[1]
 u=prem(pc(pm(a,iv),4),mod)
 assert not prem(pa(pa(pm(DATA['b'],pp(u,2)),pm(pc(DATA['c'],2),u)),pc(DATA['e'],3)),mod)
 factors={'q':[0,1],'d':DATA['d'],'b':DATA['b'],'e':DATA['e'],
  'leading_companion':pa(pp(DATA['c'],2),pm(DATA['b'],DATA['e'])),
  'q10149':[neg(10149),1],'q64426':[neg(64426),1],
  'ordinary_double':prem(pa(pm(DATA['b'],u),DATA['c']),mod),
  'u':u,'u24_minus1':ps(pmodpow(u,24,mod),[1])}
 F=prem(pa(pa(pm(DATA['a0'],pmodpow(u,3,mod)),pm(DATA['b'],pmodpow(u,2,mod))),pa(pm(DATA['c'],u),DATA['e'])),mod)
 factors['F']=F
 # The inherited complete F=0 projection, including its allowed companion.
 factors['Delta0']=json.loads((ROOT/'evidence/ratio_factorizations.json').read_text())['zero_F_projection']['polynomial']
 removed={};m=mod
 for key,v in factors.items():
  m,rr=remove_support(m,v);removed[key]=rr
  if len(rr)>1:print('removed',key,'degree',len(rr)-1,flush=True)
 m=pc(m,inv(m[-1]));u=prem(u,m)
 for key,p in [('p0',d['components'][0]['nu_coefficients'][0]),('p1',d['components'][0]['nu_coefficients'][1])]:
  val=eval_ring(p,u,m);print(key,'gcd m degree',len(pgcd(val,m))-1,flush=True)
 print('remaining degree',len(m)-1,'gcd derivative',len(pgcd(m,pder(m)))-1,flush=True)
 out={'modulus':m,'u':u,'initial_projection':mod,'removed_support':removed,
      'original_open_elements':factors}
 (ROOT/'work/branch_root/finite.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
 print('seconds',time.time()-tic,flush=True)
 return out
if __name__=='__main__':run()
