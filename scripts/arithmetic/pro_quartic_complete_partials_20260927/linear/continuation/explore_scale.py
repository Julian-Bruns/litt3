import sys,json,time
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'src'))
import field as F,poly as U,evaluate as E

def interpolate(xs,ys):
 o=[]
 for i,x in enumerate(xs):
  t=[1];d=1
  for j,y in enumerate(xs):
   if i!=j:t=U.mul(t,[F.neg(y),1]);d=F.mul(d,F.sub(x,y))
  o=U.add(o,U.scale(t,F.div(ys[i],d)))
 return o

def getR(h,w):
 dic,pars,fs,det=E.cramer(h,w)
 samples=[E.residual(dic,i) for i in range(7)]
 return [interpolate(list(range(7)),[U.coeff(R,i) for R in samples]) for i in range(141)]

def bmul(a,b,N):
 o=[[] for _ in range(min(N,len(a)+len(b)-1))]
 for i,u in enumerate(a):
  for j,v in enumerate(b[:N-i]):
   if i+j<len(o):o[i+j]=U.add(o[i+j],U.mul(u,v))
 return o

def bpow(a,p,N):
 o=[[1]]
 while p:
  if p&1:o=bmul(o,a,N)
  p//=2
  if p:a=bmul(a,a,N)
 return o

def bplus(a,b,N):return [U.add(a[i] if i<len(a) else [],b[i] if i<len(b) else []) for i in range(N)]

def main():
 start=time.time();r=getR(1,1);ar=r[::-1]
 print('scale-degrees',[(i,len(a)-1) for i,a in enumerate(ar)],flush=True)
 # Compute R^13 = R^3 (R^2)^5 through reciprocal degree 100.
 a2=bmul(ar[:100],ar[:100],100); a3=bmul(a2,ar[:100],100)
 f5=[[] for _ in range(100)]
 for i,a in enumerate(a2[:20]):f5[i*5]=U.frob(a)
 c=bmul(a3,f5,100)
 minors=[]
 for i in range(21,25):
  for j in range(i+1,25):
   pp=U.sub(U.mul(c[i],c[j+25]),U.mul(c[j],c[i+25]));
   minors.append((i,j,pp))
 print('pivot degrees',[(i,j,len(pp)-1) for i,j,pp in minors],flush=True)
 gg=[]
 for i,j,pp in minors:gg=U.gcd(gg,pp)
 print('pivot gcd degree',len(gg)-1,flush=True)
 # first two standard tails + pivot check univariate at diagnostic ratio.
 c63=bmul(a3, f5,125) # redo proper product
 c63=bmul(c63, [U.frob(a2[i//25],2) if i%25==0 and i//25<len(a2) else [] for i in range(125)],125)
 print('tail degrees',[(i,len(c63[i])-1) for i in (71,72,73,74,75)],flush=True)
 out={'scope':'Diagnostic at h=w=1 only; not a global exclusion', 'scale_degrees':[len(a)-1 for a in ar], 'pivot_degrees':[(i,j,len(pp)-1) for i,j,pp in minors], 'pivot_gcd':gg, 'tail_degrees':[(i,len(c63[i])-1) for i in range(71,76)],'seconds':time.time()-start}
 Path(__file__).with_name('explore_scale.json').write_text(json.dumps(out,indent=2))
 print(json.dumps(out,indent=2),flush=True)
if __name__=='__main__':main()
