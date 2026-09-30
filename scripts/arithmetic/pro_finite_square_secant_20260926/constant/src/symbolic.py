"""Sparse Laurent-polynomial reconstruction over K[h,w,w^-1]."""
from reconstruct import *
class LP:
 def __init__(self,data=None):
  self.d={m:c for m,c in (data or {}).items() if c}
 @classmethod
 def c(cls,c):return cls({(0,0):c})
 def __add__(self,o):
  if not isinstance(o,LP):o=LP.c(o%5)
  r=self.d.copy()
  for m,c in o.d.items():
   r[m]=add(r.get(m,0),c)
   if not r[m]:del r[m]
  return LP(r)
 __radd__=__add__
 def __neg__(self):return LP({m:neg(c) for m,c in self.d.items()})
 def __sub__(self,o):return self+-o
 def __mul__(self,o):
  if not isinstance(o,LP):o=LP.c(o%5)
  r={}
  for a,c in self.d.items():
   for b,d in o.d.items():
    m=(a[0]+b[0],a[1]+b[1]);r[m]=add(r.get(m,0),mul(c,d))
    if not r[m]:del r[m]
  return LP(r)
 __rmul__=__mul__
 def __pow__(self,e):
  if e<0:
   if len(self.d)!=1:raise ArithmeticError('nonmonomial denominator')
   m,c=next(iter(self.d.items()));return LP({(m[0]*e,m[1]*e):power(c,e)})
  if e==5:return LP({(m[0]*5,m[1]*5):power(c,5) for m,c in self.d.items()})
  r=LP.c(1);a=self
  while e:
   if e&1:r=r*a
   e//=2
   if e:a=a*a
  return r
 def __truediv__(self,o):return self*(o**-1)
 def __bool__(self):return bool(self.d)
 def __eq__(self,o):return isinstance(o,LP) and self.d==o.d
 def ev(self,h,w):
  r=0
  for (i,j),c in self.d.items():r=add(r,mul(c,mul(power(h,i),power(w,j))))
  return r
 def json(self):return [[*m,c] for m,c in sorted(self.d.items())]
 def __repr__(self):return str(self.json())
zero=LP();one=LP.c(1);h=LP({(1,0):1});w=LP({(0,1):1})

def add_series(a,b,n):return [(a[i] if i<len(a) else zero)+(b[i] if i<len(b) else zero) for i in range(n)]
def mul_series(a,b,n):
 r=[zero]*n
 for i,c in enumerate(a[:n]):
  if c:
   for j,d in enumerate(b[:n-i]):
    if d:r[i+j]=r[i+j]+c*d
 return r

def pow_series(a,e,n):
 if e==5:
  return [a[i//5]**5 if i%5==0 and i//5<len(a) else zero for i in range(n)]
 r=[one]+[zero]*(n-1)
 while e:
  if e&1:r=mul_series(r,a,n)
  a=mul_series(a,a,n);e//=2
 return r

def lin_vec(vecs,pars,offset):
 return [LP.c(offset[i])+sum((LP.c(v[i])*p for v,p in zip(vecs,pars)),zero) for i in range(155)]

def vec_to_g(vec):
 gs={k:[[zero for _ in range(len0)] for len0 in [24,21,17]] for k in [2,3,4,5]}
 for u,(i,j,k) in zip(vec,SLOTS):
  if not u:continue
  if k==2:
   if j==1:
    for n,c in enumerate(P):gs[2][0][i+n]=gs[2][0][i+n]+u*LP.c(c)
   else:gs[2][2][i]=gs[2][2][i]+u
  else:gs[k][j][i]=gs[k][j][i]+u
 return gs

def infsym(a,shift,n):
 ys=Yseries(n);yp=[spow(ys,j,n) for j in range(3)];r=[zero]*n
 for j,pol in enumerate(a):
  for i,c in enumerate(pol):
   if not c:continue
   k=shift-3*i-10*j
   if k<0:raise ArithmeticError('negative power')
   for m in range(n-k):r[k+m]=r[k+m]+c*LP.c(yp[j][m])
 return r

def fsym(vec,n=7):
 gs=vec_to_g(vec);aa=[c*3 for c in infsym(gs[2],35,n)];bb=[c*2 for c in infsym(gs[3],46,n)];cc=infsym(gs[4],57,n)
 rr=[LP.c(div(2,EPS))*w]+[zero]*(n-1)
 for k in range(1,n):
  v=add_series(add_series(mul_series(aa,pow_series(rr,2,k+1),k+1),mul_series(bb,rr,k+1),k+1),cc,k+1)[k]
  rr[k]=-v/LP.c(mul(2,EPS))
 assert not any(add_series(add_series(mul_series(aa,pow_series(rr,2,n),n),mul_series(bb,rr,n),n),cc,n))
 f0=[LP.c(c) for c in infinity(frompoly(Q),57,n)]
 first=add_series(f0,[zero,zero]+pow_series(rr,5,n),n)
 inn=add_series(mul_series(aa,pow_series(rr,3,n),n),[r*2 for r in mul_series(bb,pow_series(rr,2,n),n)],n)
 second=add_series(infsym(gs[5],70,n),[zero,zero]+inn,n)
 last=[LP.c(c) for c in infinity(cmulpoly(y10,t3),127,n)]
 return add_series(mul_series(first,second,n),last,n)

SYMBOLIC_FILE=ROOT/'evidence/chart_laurent.json'
def symbolic_chart():
 o=load_linear();z=LP.c(div(2,EPS))*w;c=LP.c(CD)*w
 e=-c*z-LP.c(div(ETA,24))/z
 f=-w*w/LP.c(EPS)-LP.c(div(8,24))*z**5
 base=lin_vec(o['sections'],[h,w,e,f],o['origin']);ff=fsym(base)
 assert not any(ff[:4])
 shifts=[]
 for v in o['kernel']:
  fs=fsym([a+LP.c(b) for a,b in zip(base,v)])
  shifts.append([fs[i]-ff[i] for i in range(7)])
 det=shifts[0][4]*shifts[1][5]-shifts[1][4]*shifts[0][5]
 assert det==LP.c(PSISCALE)*w**2
 u=(-ff[4]*shifts[1][5]+ff[5]*shifts[1][4])/det
 v=(-shifts[0][4]*ff[5]+shifts[0][5]*ff[4])/det
 vec=[a+LP.c(s)*u+LP.c(t0)*v for a,s,t0 in zip(base,*o['kernel'])]
 final=fsym(vec);assert not any(final[:6])
 q=w**3;HH=h*w
 a0=sum((LP.c(c)*q**i for i,c in enumerate(A0)),zero)
 a1=sum((LP.c(c)*q**i for i,c in enumerate(A1)),zero)
 psi=a0+a1*HH
 assert final[6]==psi/(q*LP.c(power(PSISCALE,2)))
 # Direct checks of all defining linear equations, by individual Laurent monomials.
 mons=set().union(*(a.d.keys() for a in vec))
 for m in mons:
  vals=[a.d.get(m,0) for a in vec]
  assert linear_values(as_G(vals),m==(0,0))==[0]*149
 for hv,wv in [(1,2),(25,6),(12345,67890)]:
  d=make_chart(hv,wv)
  got=as_G([a.ev(hv,wv) for a in vec])
  assert all(got[k]==d['G'][k] for k in got)
 obj={'variables':['h','w'],'coefficient_encoding':'K integer codes','format':'each coordinate is [[h_exponent,w_exponent,K_code],...]','slots':SLOTS,'coordinates':[a.json() for a in vec],'kernel_coordinates':[u.json(),v.json()],'F6':final[6].json(),'determinant':det.json(),'e':e.json(),'f':f.json()}
 SYMBOLIC_FILE.write_text(json.dumps(obj,separators=(',',':'))+'\n')
 return obj

if __name__=='__main__':
 st=time.time();o=symbolic_chart()
 print('kernel coordinates',o['kernel_coordinates'])
 print('F6',o['F6'])
 cs=o['coordinates'];print('support terms',sum(map(len,cs)),'max per coordinate',max(map(len,cs)))
 print('h degrees',min(m[0] for a in cs for m in a),max(m[0] for a in cs for m in a))
 print('w degrees',min(m[1] for a in cs for m in a),max(m[1] for a in cs for m in a))
 print('seconds',time.time()-st)
