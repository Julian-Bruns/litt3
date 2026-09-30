"""Explore a smaller necessary system; specialization is not a decision."""
import sys,time,json
from pathlib import Path
root=Path(sys.argv[1]);start=time.time();d=load(str(root/'actual_seven_rational_coefficients.sobj'))
R=d['ring'];H,q=R.gens();K=R.base_ring();P=PolynomialRing(K,'z');z=P.gen();L=P.fraction_field()
records=[]
for val in [K(2),K.gen()+2]:
 psi=P(d['Psi'](z,val));den0=K(d['D'](0,val));assert psi and den0 and val
 rows=[{} for _ in range(7)]
 for j,n,N,D in d['coefficients']:
  pp=P(N(z,val));rows[j][n]=L(pp)/(z^D[0]*val^D[1]*psi^D[2]*den0^D[3])
 leading=[(j,max(r),r[max(r)].numerator().degree(),r[max(r)].denominator().degree()) for j,r in enumerate(rows)]
 original=[dict(r) for r in rows];ops=[]
 for pivot,deg in [(5,7),(3,6),(1,5),(0,4)]:
  assert max(rows[pivot])==deg and rows[pivot][deg]
  for i in [2,4,6]:
   if deg not in rows[i]:continue
   fac=rows[i][deg]/rows[pivot][deg];ops.append((i,pivot,fac))
   for n,c in rows[pivot].items():
    v=rows[i].get(n,L.zero())-fac*c
    if v:rows[i][n]=v
    else:rows[i].pop(n,None)
   assert deg not in rows[i]
 cubics=[];info=[]
 for i in [2,4,6]:
  assert max(rows[i])<=3
  ds=lcm([v.denominator() for v in rows[i].values()]);cc=[P(rows[i].get(n,0)*ds) for n in range(4)];gg=gcd(cc);cc=[c//gg for c in cc]
  cubics.append(cc);info.append([c.degree() for c in cc])
 rec={'value':val,'leading':leading,'cubic_H_degrees':info,'original':original,'rows':rows,'operations':ops,'cubics':cubics};records.append(rec)
 print('slice',str(val),'leading',leading,'cubics',info,'seconds',time.time()-start,flush=True)
 save({'scope':'two exploratory ratio slices only','records':records},str(root/'actual_cubic_slice_probe'))
(root/'actual_cubic_slice_probe.json').write_text(json.dumps({'scope':'degree probe, not a global decision','slices':[{'q':str(r['value']),'leading':r['leading'],'cubic_H_degrees':r['cubic_H_degrees']} for r in records],'seconds':time.time()-start},indent=2,default=int)+'\n')
