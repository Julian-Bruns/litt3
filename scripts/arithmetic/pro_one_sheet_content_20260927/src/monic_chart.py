"""Exact global sextic normal form and marked-sheet scale reduction.
No further curve point is removed: only the already justified B1 open is used.
"""
from endpoints import *

def divide_monomial(f,m):
 assert len(m)==1
 e,c=next(iter(m.items()))
 return pscale(pshift(f,tuple(-j for j in e)),inv(c))

def main():
 ends=json.loads((ROOT/'data'/'endpoint_curves.json').read_text())['endpoints'];out=[]
 for e in ends:
  B0,B1=splitH(loads(e['B']));C0,C1=splitH(loads(e['C']));E0,E1=splitH(loads(e['E']));A0,A1=splitH(loads(e['A']))
  D=loads(e['D']);Delta=loads(e['Delta']);G=loads(e['G']);m=e['M_r'];zz={(0,1):1}
  T=psub(pmul(B1,zz),C1)
  gamma=divide_monomial(pmul(Delta,ppow(B1,3)),D)
  Ee=psub(pmul(E0,B1),pmul(E1,B0));Ef=psub(pmul(E1,C0),pmul(E0,C1))
  ca=pscale(gamma,neg(mul(2,m)))
  cb=psub(psub(ppow(C1,5),pscale(pmul(gamma,C1),mul(4,m))),divide_monomial(pmul(Ee,ppow(B1,4)),D))
  J=padd(pscale(ppow(C1,2),mul(2,m)),pmul(E1,B1))
  cc=pneg(pmul(gamma,J))
  monic=padd(padd(padd(ppow(zz,6),pmul(ca,ppow(zz,2))),pmul(cb,zz)),cc)
  left=padd(padd(padd(ppow(T,6),pmul(ca,ppow(T,2))),pmul(cb,T)),cc)
  right=pneg(divide_monomial(pmul(ppow(B1,5),G),D))
  assert left==right
  # Selected large-root scale: Atilde=a*z+b, Btilde=Delta.
  aa=psub(pmul(A0,B1),pmul(A1,B0));ab=psub(pmul(A1,C0),pmul(A0,C1))
  at=padd(pmul(aa,zz),ab)
  nr=padd(padd(pmul(ppow(Delta,3),ppow(at,3)),pmul(ppow(aa,5),padd(padd(pscale(pmul(Delta,ppow(zz,2)),mul(2,m)),pmul(Ee,zz)),Ef))),pmul(pmul(D,ppow(ab,5)),T))
  old=loads(e['branches'][1]['numerator']);den=loads(e['branches'][1]['denominator'])
  assert nr==padd(old,pmul(ppow(aa,5),G))
  assert den==pmul(T,ppow(Delta,5))
  assert max(j for i,j in nr)<=3
  row={'r':e['r'],'monic_variables':['v','T'],'monic_equation':dumps(monic),'gamma':dumps(gamma),'coefficient_T2':dumps(ca),'coefficient_T1':dumps(cb),'constant':dumps(cc),'T_norm_auxiliary_J':dumps(J),'marked_large_scale_variables':['v','z'],'marked_large_scale_numerator_cubic':dumps(nr),'marked_large_scale_denominator':dumps(den),'difference_multiplier_aa5':dumps(ppow(aa,5))}
  out.append(row)
  print('endpoint',e['r'],'monic_terms',len(monic),'scale_numerator_terms',len(nr),'scale_z_degree',max(j for i,j in nr),'IDENTITIES=PASS',flush=True)
 (ROOT/'data'/'monic_charts.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
 (ROOT/'evidence'/'monic_chart_checks.json').write_text(json.dumps({'verified_endpoints':[e['r'] for e in ends],'sextic_coordinate_identity':True,'scale_numerator_identity':True,'new_localizations':'none beyond already justified B1 nonzero','T_norm_auxiliary_J_zero_fibres':'NOT EXCLUDED; no inversion of J permitted by this result'},indent=2)+'\n')
if __name__=='__main__':main()
