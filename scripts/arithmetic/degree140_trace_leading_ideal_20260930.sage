"""Eliminate H from the degree-eleven leading-coefficient ideal.

This is a NEW exact small calculation on the leading coefficients of
the nine global trace equations. It does not decide their common locus.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'trace_top_reduction.sobj'))
R=d['ring'];H,q=R.gens();K=R.base_ring();Q=PolynomialRing(K,'zq');zq=Q.gen()
rows=d['rows'];base=rows[0]['coeff'][11][0]
assert base.degree(H)==1
aa=Q({e[1]:c for e,c in base.dict().items() if e[0]==1})
bb=Q({e[1]:c for e,c in base.dict().items() if e[0]==0})
gb=aa.gcd(bb);aa//=gb;bb//=gb
print('base equation degrees',aa.degree(),bb.degree(),'common factor degree',gb.degree(),flush=True)
polys=[];out=[]
for row in rows:
 if max(row['coeff'],default=0)!=11:continue
 N,D=row['coeff'][11];hd=int(N.degree(H));value=Q.zero()
 for (i,j),c in N.dict().items():value+=c*(-bb)^i*aa^(hd-i)*zq^j
 while value and value[0]==0:value//=zq
 polys.append(value)
 out.append({'label':row['label'],'degree':int(value.degree()) if value else int(-1)})
 print(out[-1],flush=True)
g=Q.zero()
for f in polys:g=g.gcd(f)
fac=[(str(p),int(e)) for p,e in g.factor()] if g else []
result={'scope':'leading-coefficient ideal only','base_a':str(aa),'base_b':str(bb),
 'rows':out,'gcd_degree':int(g.degree()) if g else -1,'gcd_factors':fac,
 'seconds':time.time()-start}
save({'ring':R,'base_a':aa,'base_b':bb,'gcd':g,'substitutions':polys},str(root/'trace_leading_ideal'))
(root/'trace_leading_ideal.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result),flush=True)
