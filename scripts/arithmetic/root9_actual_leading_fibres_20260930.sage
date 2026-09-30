"""Lift all two-leading-coefficient fibres and test the actual scale equations."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'actual_leading_geometry.sobj'));cc=load(str(root/'actual_seven_rational_coefficients.sobj'))
R=d['ring'];H,q=R.gens();K=R.base_ring();a=K.gen();beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1)
def dec(n):
 v=K.zero()
 for i in range(4):c=n%25;n//=25;v+=(K(c%5)+(c//5)*beta)*a^i
 return v
units=[H,d['Psi'],H-dec(42135)]
report=json.loads((root/'actual_leading_fibres.json').read_text())['fibres'] if (root/'actual_leading_fibres.json').exists() else []
done={(v['k'],v['factor']) for v in report}
for proj in d['leading_projections']:
 for fi,(fac,mult) in enumerate(proj['factors']):
  if (int(proj['k']),fi) in done:continue
  E=fac.parent().quotient(fac,'r');r=E.gen();P=PolynomialRing(E,'Z');z=P.gen()
  def spec(N):
   cs=[{} for _ in range(N.degree(H)+1)]
   for (i,j),c in N.dict().items():cs[i][j]=c
   return P([E(fac.parent()(v).quo_rem(fac)[1]) for v in cs])
  p0=spec(proj['phi']);p1=spec(d['N4']);g=p0.gcd(p1).monic();raw=g
  for unit in units:
   uu=spec(unit)
   while g.degree()>0:
    gg=g.gcd(uu)
    if gg.degree()<=0:break
    g//=gg
  receipt={'k':int(proj['k']),'factor':fi,'q_degree':int(fac.degree()),'raw_H_degree':int(raw.degree()),'allowed_H_degree':int(g.degree())}
  data={'qfactor':fac,'projection':proj,'ring':E,'raw_H_gcd':raw,'allowed_H_gcd':g}
  if g.degree()>0:
   # Keep the whole remaining H fibre; a degree-one quotient is just E.
   if g.degree()==1:
    h=-g[0]/g[1];A=E
    def ev(N):return spec(N)(h)
   else:
    A=P.quotient(g,'h');h=A.gen()
    def ev(N):return A(spec(N))
   S=PolynomialRing(A,'mu');mu=S.gen();rows=[]
   for row in range(3):
    terms=[(n,N,D) for j,n,N,D in cc['coefficients'] if j==row]
    assert len(terms)==[5,6,6][row]
    poly=S.zero()
    for n,N,D in terms:
     den=h^D[0]*A(r)^D[1]*ev(d['Psi'])^D[2]*ev(d['D'])^D[3]
     poly+=ev(N)/den*mu^n
    rows.append(poly)
   gg=rows[0];bez=[S.one(),S.zero(),S.zero()]
   for row in range(1,3):
    gn,u,v=gg.xgcd(rows[row]);bez=[u*b for b in bez];bez[row]+=v;gg=gn
   assert sum(b*p for b,p in zip(bez,rows))==gg
   receipt['scale_gcd_degree']=int(gg.degree());data.update(H=h,algebra=A,rows=rows,bezout=bez,scale_gcd=gg)
  else:receipt['scale_gcd_degree']=None
  report.append(receipt);save(data,str(root/f"actual_leading_fibre_{proj['k']}_{fi}"));print(receipt,'seconds',time.time()-start,flush=True)
  (root/'actual_leading_fibres.json').write_text(json.dumps({'status':'in_progress','fibres':report},indent=2)+'\n')
assert all(r['allowed_H_degree']==0 or r['scale_gcd_degree']==0 for r in report)
(root/'actual_leading_fibres.json').write_text(json.dumps({'status':'complete_exclusion','fibres':report,'seconds':time.time()-start},indent=2)+'\n')
