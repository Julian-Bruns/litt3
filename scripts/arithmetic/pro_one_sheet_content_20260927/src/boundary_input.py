"""Exact degree-drop fibres for the z^6 coefficient B1(v)."""
from endpoints import *
from univar import *

def main():
 ends=json.loads((ROOT/'data'/'endpoint_curves.json').read_text())['endpoints'];result=[]
 for e in ends:
  B,C,E,D=[loads(e[k]) for k in ['B','C','E','D']]
  v3=neg(div(B[(-1,1)],B[(2,1)]));qq=div(e['P_r'],v3)
  incidence=padd(psub(pmul(ppow(B,5),E),pmul(D,ppow(C,5))),pscale(pmul(ppow(B,4),ppow(C,2)),mul(2,e['M_r'])))
  comps=[[0]*7 for _ in range(3)]
  for (v,h),c in incidence.items():comps[v%3][h]=add(comps[v%3][h],mul(c,power(v3,v//3)))
  comps=list(map(trim,comps))
  norm=us(ua(ua(up(comps[0],3),uc(up(comps[1],3),v3)),uc(up(comps[2],3),power(v3,2))),uc(um(um(comps[0],comps[1]),comps[2]),mul(3,v3)))
  norm=monic(norm);assert len(norm)==16
  # Only the original H and Psi nonzero opens can remove factors in this fixed-q fibre.
  a0c=[89654,311173,214299,163299,315361,33043,356725,245794]
  a0=0
  for c in reversed(a0c):a0=add(mul(a0,qq),c)
  a1=mul(qq,add(299833,mul(232505,qq)))
  assert qq not in [0,1,15383] and a0 and a1
  openH=um([0,1],[a0,a1]);remaining=norm;removed=[1]
  while len((g:=ug(remaining,openH)))>1:
   remaining=ud(remaining,g)[0];removed=um(removed,g)
  remaining=monic(remaining)
  assert ug(norm,derivative(norm))==[1]
  fs=factor_squarefree(remaining)
  res={'r':e['r'],'v_cube':v3,'q':qq,'norm_incidence':norm,'retained_H_polynomial':remaining,'removed_factor':removed,'H_open':openH,'factors':fs,'factor_degrees':[len(f)-1 for f in fs]}
  result.append(res)
  print('B1 boundary',e['r'],'q',qq,'H_degree',len(remaining)-1,'factors',res['factor_degrees'],flush=True)
 (ROOT/'data'/'B1_boundaries.json').write_text(json.dumps(result,separators=(',',':'))+'\n')
 with open(ROOT/'data'/'B1_factor_jobs.txt','w') as f:
  f.write(str(sum(len(b['factors']) for b in result))+'\n')
  for b in result:
   for i,g in enumerate(b['factors']):f.write(f"{b['r']}_{i} {b['q']} {len(g)-1} "+' '.join(map(str,g))+'\n')
if __name__=='__main__':main()
