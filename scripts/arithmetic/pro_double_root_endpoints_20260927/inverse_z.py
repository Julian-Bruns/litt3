"""Exact inverse of Z=a0*u^2+4*b*u+2*c in K(u)[q]/g.
Only its polynomial multiplication identity is an eventual certificate;
no inverse denominator is silently added to the square-locus open set.
"""
import json,sys,time
from exact import ROOT,DATA,pa,ps,pm,pc,pgcd,pexact,inv
class Frac:
 def __init__(self,n=0,d=None):
  if isinstance(n,Frac):self.n,self.d=n.n,n.d;return
  if isinstance(n,int):n=[] if n==0 else [n]
  d=[1] if d is None else d
  assert d
  if not n:self.n=[];self.d=[1];return
  h=pgcd(n,d);n=pexact(n,h);d=pexact(d,h);v=inv(d[-1]);self.n=pc(n,v);self.d=pc(d,v)
 def __bool__(self):return bool(self.n)
 def __add__(self,o):
  o=Frac(o);return Frac(pa(pm(self.n,o.d),pm(o.n,self.d)),pm(self.d,o.d))
 __radd__=__add__
 def __neg__(self):return Frac(pc(self.n,4),self.d)
 def __sub__(self,o):return self+-Frac(o)
 def __rsub__(self,o):return Frac(o)+-self
 def __mul__(self,o):
  o=Frac(o);return Frac(pm(self.n,o.n),pm(self.d,o.d))
 __rmul__=__mul__
 def __truediv__(self,o):
  o=Frac(o);assert o;return Frac(pm(self.n,o.d),pm(self.d,o.n))
 def __repr__(self):return repr((self.n,self.d))
def trim(a):
 while a and not a[-1]:a.pop()
 return a
def add(a,b):return trim([(a[i] if i<len(a) else Frac())+(b[i] if i<len(b) else Frac()) for i in range(max(len(a),len(b)))])
def mul(a,b):
 out=[Frac() for i in range(len(a)+len(b)-1)] if a and b else []
 for i,x in enumerate(a):
  for j,y in enumerate(b):out[i+j]=out[i+j]+x*y
 return trim(out)
def div(a,b):
 a=a[:];q=[Frac() for i in range(max(0,len(a)-len(b)+1))]
 while a and len(a)>=len(b):
  i=len(a)-len(b);v=a[-1]/b[-1];q[i]=v
  for j,z in enumerate(b):a[i+j]=a[i+j]-v*z
  trim(a)
 return trim(q),a

def run():
 start=time.time();src=json.loads((ROOT/'evidence/global_source.json').read_text());gs=[[0]*3 for _ in range(10)]
 for iq,iu,a in src['critical_monic']:gs[iq][iu]=a
 g=[Frac(p) for p in gs];z=[]
 for iq in range(7):z.append(Frac([pc(DATA['c'],2)[iq] if iq<len(DATA['c']) else 0,pc(DATA['b'],4)[iq] if iq<len(DATA['b']) else 0,DATA['a0'][iq] if iq<len(DATA['a0']) else 0]))
 a,b=g,z;s0,s1=[],[Frac(1)]
 while b:
  q,r=div(a,b);a,b=b,r;s0,s1=s1,add(s0,[-v for v in mul(q,s1)])
  print('RATIONAL EUCLID',len(a)-1,len(b)-1,'max u',max((max(len(v.n),len(v.d)) for v in s0),default=0),flush=True)
 assert len(a)==1
 s0=[v/a[0] for v in s0]
 _,r=div(mul(s0,z),g);assert len(r)==1 and r[0].n==r[0].d
 D=[1]
 for v in s0:D=pm(D,pexact(v.d,pgcd(D,v.d)))
 nums=[pm(v.n,pexact(D,v.d)) for v in s0]
 result={'Z_q_coefficients':[v.n for v in z],'inverse_numerators_by_q_degree':nums,'denominator_u_coefficients':D,'identity':'Z*sum(nums[j](u)*q^j)=D(u) modulo monic g','q_degree':len(nums)-1,'denominator_degree':len(D)-1,'seconds':round(time.time()-start,3)}
 (ROOT/'evidence/inverse_z.json').write_text(json.dumps(result,indent=2)+'\n');print('INVERSE Z',result['denominator_degree'],flush=True)
if __name__=='__main__':run()
