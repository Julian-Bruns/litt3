"""Identify repeated factors in exploratory H-slices of a scale resultant."""
import sys,time,json
from pathlib import Path
root=Path(sys.argv[1]);start=time.time();d=load(str(root/'actual_scale_resultant_compressed_0.sobj'));p=d['polynomial'];R=p.parent();H,q=R.gens();K=R.base_ring();a=K.gen();beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1)
def dec(n):
 ans=K.zero()
 for i in range(4):c=n%25;n//=25;ans+=(K(c%5)+(c//5)*beta)*a^i
 return ans
P=PolynomialRing(K,'h');h=P.gen();sigma=[112400,246025,215500,360225,164100,272625]
def frow(cs,v):return sum(dec(c)*v^i for i,c in enumerate(cs))
records=[]
for val in [K(2),a+2]:
 pp=P(p(h,val));fac=pp.factor()
 dd=frow([47171,357608],val);aa=frow([350365,93449],val)
 b=frow([90885,339126,362701,194731,371097,144818],val);c=frow([56518,278019,104390,351083,235630,246647,217983],val);e=frow([324104,260238,219737,136154,199269,240524,27757,108951,319279],val)
 vals=[]
 for s in sigma:
  ph=(aa-dec(s)*dd)*h^3*val^2+b*h^2*val+c*h+e;cur=pp;n=0
  while cur and cur.degree()>=ph.degree():
   quo,rem=cur.quo_rem(ph)
   if rem:break
   cur=quo;n+=1
  vals.append(n)
 rec={'q':val,'factorization':fac,'known_six_curve_valuations':vals};records.append(rec)
 print('q',val,'factors',[(f.degree(),n) for f,n in fac],'known6',vals,'seconds',time.time()-start,flush=True)
 save({'scope':'exploratory slices only','records':records},str(root/'actual_resultant_factor_probe'))
(root/'actual_resultant_factor_probe.json').write_text(json.dumps({'scope':'slices are not geometric factor identifications','slices':[{'q':str(v['q']),'factors':[(int(f.degree()),int(n)) for f,n in v['factorization']],'known_six_curve_valuations':v['known_six_curve_valuations']} for v in records]},indent=2)+'\n')
