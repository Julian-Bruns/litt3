#!/usr/bin/env python3
"""Build an exact root-of-unity circuit for the complete residual problem.
This is a verified REFORMULATION, not an emptiness certificate or a solver.
All gates are over F25. A scalar gate takes its value in K at root-grid inputs.
"""
from pathlib import Path
from dataclasses import dataclass
import json,gzip,argparse
ROOT=Path(__file__).resolve().parents[2]
def fadd(x,y):return (x%5+y%5)%5+5*((x//5+y//5)%5)
def fmul(x,y):
 a,b=x%5,x//5;c,d=y%5,y//5
 return (a*c+3*b*d)%5+5*((a*d+b*c+b*d)%5)
def fpow(x,n):
 v=1
 while n:
  if n&1:v=fmul(v,x)
  x=fmul(x,x);n//=2
 return v
class Circuit:
 def __init__(self):self.gates=[];self.cache={};self.inputs=[]
 def node(self,op,a,b=-1):
  key=(op,a,b)
  if key not in self.cache:self.cache[key]=len(self.gates);self.gates.append([op,a,b])
  return Expr(self,self.cache[key])
 def code(self,n):return self.node('c',n)
 def input(self,name,order):
  x=self.node('i',len(self.inputs));self.inputs.append({'name':name,'order':order,'gate':x.id});return x
@dataclass(frozen=True)
class Expr:
 R:Circuit
 id:int
 def cc(self,x):return x if isinstance(x,Expr) else self.R.code(x%5)
 def const(self):
  g=self.R.gates[self.id];return g[1] if g[0]=='c' else None
 def __add__(self,o):
  o=self.cc(o);a,b=self.const(),o.const()
  if a==0:return o
  if b==0:return self
  if a is not None and b is not None:return self.R.code(fadd(a,b))
  return self.R.node('+',*sorted((self.id,o.id)))
 __radd__=__add__
 def __mul__(self,o):
  o=self.cc(o);a,b=self.const(),o.const()
  if a==0 or b==0:return self.R.code(0)
  if a==1:return o
  if b==1:return self
  if a is not None and b is not None:return self.R.code(fmul(a,b))
  return self.R.node('*',*sorted((self.id,o.id)))
 __rmul__=__mul__
 def __neg__(self):return self*4
 def __sub__(self,o):return self+-self.cc(o)
 def __rsub__(self,o):return self.cc(o)+-self
 def __pow__(self,n):
  assert n>=0;v=self.R.code(1);x=self
  while n:
   if n&1:v=v*x
   x=x*x;n//=2
  return v
@dataclass(frozen=True)
class Pair:
 v:Expr
 b:Expr
 def cc(self,x):
  if isinstance(x,Pair):return x
  x=self.v.cc(x);return Pair(x,x)
 def __add__(self,x):x=self.cc(x);return Pair(self.v+x.v,self.b+x.b)
 __radd__=__add__
 def __neg__(self):return Pair(-self.v,-self.b)
 def __sub__(self,x):return self+-self.cc(x)
 def __rsub__(self,x):return self.cc(x)+-self
 def __mul__(self,x):x=self.cc(x);return Pair(self.v*x.v,self.b*x.b)
 __rmul__=__mul__
 def bar(self):return Pair(self.b,self.v)
 def norm(self):
  v=self.v*self.b;return Pair(v,v)
 def __pow__(self,n):return Pair(self.v**n,self.b**n)

def build():
 R=Circuit();zero=R.code(0);one=R.code(1);Z=Pair(zero,zero);O=Pair(one,one)
 # User labels i correspond to type roots t=2^i. Q's first label is (0,0).
 qz=[one]+[R.input(f'qz{j}',29) for j in range(1,4)]
 qt=[one]+[R.input(f'qt{j}',4) for j in range(1,4)]
 hz=[R.input(f'hz{j}',29) for j in range(4)]
 ht=[R.input(f'ht{j}',4) for j in range(4)]
 ie=fpow(22,23)
 def const(c,n=0):return Pair(R.code(fpow(c,5**(n%2))),R.code(fpow(c,5**((n+7)%2))))
 def faddv(a,b):return [x+y for x,y in zip(a,b)]
 def fneg(a):return [-x for x in a]
 def fsub(a,b):return faddv(a,fneg(b))
 def fm(a,b,d):
  out=[Z]*4
  for i in range(4):
   for j in range(4):out[(i+j)%4]=out[(i+j)%4]+a[i]*b[j]*(d if i+j>=4 else O)
  return out
 def fs(a,s):return [x*s for x in a]
 def scalar(s):return [s,Z,Z,Z]
 def sig(a,j=1):return [x*pow(2,i*j,5) for i,x in enumerate(a)]
 rows={'C':([20,1,7,19],5),'E':([8,1,15,0],8),'U':([12,18,8,6],17),'V':([4,17,2,0],4)}
 def endpoint(zs,ts,name,n):
  cs,m=rows[name];out=[]
  for j,c in enumerate(cs):
   sm=Z
   for z,t in zip(zs,ts):
    pp=Pair(z**((m*pow(5,n,29))%29),z**((m*pow(5,n+7,29))%29))
    sm=sm+Pair(t**j,t**j)*pp
   out.append(const(fmul(c,ie),n)*sm)
  return out
 cache={}
 def bundle(n):
  if n in cache:return cache[n]
  aa=endpoint(qz,qt,'E',n);bb=endpoint(qz,qt,'C',n);cc=endpoint(hz,ht,'C',n);dd=endpoint(hz,ht,'E',n);ds=const(20,n)
  w=fsub(fm(aa,dd,ds),fm(bb,cc,ds));dc=cc[3].norm()-bb[3].norm();de=aa[1].norm()-dd[1].norm();den=dc*de
  yy=bb[3]*w[3].bar()-cc[3].bar()*w[3]
  rr=dc*w[1]+bb[1]*yy.bar()+cc[1]*yy
  xx=aa[1].bar()*rr-dd[1]*rr.bar()
  zz=den*w[2]-aa[2]*xx-dd[2]*xx.bar()+de*(bb[2]*yy.bar()+cc[2]*yy)
  ss=den*w[0]-aa[0]*xx-dd[0]*xx.bar()+de*(bb[0]*yy.bar()+cc[0]*yy)
  tt=den*ss+xx.norm()-de**2*yy.norm()
  out={'A':aa,'B':bb,'C':cc,'D':dd,'W':w,'dc':dc,'de':de,'d':den,'Y':yy,'X':xx,'Z':zz,'T':tt,'theta4':ds};cache[n]=out;return out
 b=bundle(0);bn=fsub(fs(b['B'],b['dc']),scalar(b['Y']));dn=fsub(fs(b['D'],b['d']),scalar(b['X']))
 adj=fm(fm(sig(bn),sig(bn,2),b['theta4']),sig(bn,3),b['theta4'])
 normb=fm(bn,adj,b['theta4'])[0];ee=b['de']*normb;gg=fm(dn,adj,b['theta4'])
 # epsilon=G/E; x=X/d; y=Y/dc. Four component equations, after unit clearing.
 b4,b8,b1,b11=[bundle(n) for n in [4,8,1,11]]
 UQ,VQ=endpoint(qz,qt,'U',0),endpoint(qz,qt,'V',0)
 UH,VH=endpoint(hz,ht,'U',0),endpoint(hz,ht,'V',0)
 e3=faddv(fs(fm(gg,fsub(fs(UQ,b4['d']),scalar(b4['X'])),b['theta4']),b8['dc']),fs(faddv(fs(VQ,b8['dc']),scalar(b8['Y'])),ee*b4['d']))
 e4=fsub(faddv(fs(UH,ee*b11['d']*b1['dc']),fs(fm(gg,faddv(fs(VH,b1['dc']),scalar(b1['Y'])),b['theta4']),b11['d'])),scalar(ee*b1['dc']*b11['X']))
 phase=(qz[1]-1)*(qz[2]-1)*(qz[1]-qz[2])*(hz[0]-hz[1])*(hz[0]-hz[2])*(hz[1]-hz[2])
 base=phase*b['dc'].v*b['de'].v*ee.v*gg[3].v
 outputs={'delta_C':b['dc'].v.id,'delta_E':b['de'].v.id,'d':b['d'].v.id,'Y':b['Y'].v.id,'X':b['X'].v.id,'Z':b['Z'].v.id,'T':b['T'].v.id,'E':ee.v.id,'G':[p.v.id for p in gg],
          'eq3_cleared':[p.v.id for p in e3],'eq4_cleared':[p.v.id for p in e4],
          'eq3_multiplier':(ee*b4['d']*b8['dc']).v.id,'eq4_multiplier':(ee*b11['d']*b1['dc']).v.id,
          'phase_unit':phase.id,'unit_patch_0':(base*gg[0].v).id,'unit_patch_2':(base*gg[2].v).id}
 zeros=[outputs['Z'],outputs['T']]+outputs['eq3_cleared']+outputs['eq4_cleared']
 return {'status':'EXACT_REFORMULATION_NOT_SOLVED','coefficient_field':{'name':'F25','beta_polynomial':[2,4,1],'code':'a+5b means a+b beta'},'inputs':R.inputs,'gates':R.gates,'outputs':outputs,'required_zero_outputs':zeros,'nonzero_patches':[outputs['unit_patch_0'],outputs['unit_patch_2']],
         'equations':'Each input has its listed root order. Each gate gives one assignment equation. Impose the ten zero outputs. In each of two patches add h*unit_patch-1=0.',
         'coverage':'Every oriented remaining solution admits a permutation with first three phases distinct on both endpoints and a symmetry normalizing the first Q label to (0,0). Repeated fourth labels are allowed.'}

def main():
 p=argparse.ArgumentParser();p.add_argument('--output',type=Path,default=ROOT/'build'/'residual_circuit');a=p.parse_args();a.output.parent.mkdir(parents=True,exist_ok=True);c=build()
 with gzip.GzipFile(filename=str(a.output.with_suffix('.json.gz')),mode='wb',mtime=0) as f:f.write((json.dumps(c,separators=(',',':'))+'\n').encode())
 with a.output.with_suffix('.txt').open('w') as f:
  f.write(f"{len(c['inputs'])} {len(c['gates'])}\n")
  for g in c['gates']:f.write(' '.join(map(str,g))+'\n')
  f.write(str(len(c['outputs']))+'\n')
  for k,v in c['outputs'].items():
   if isinstance(v,int):v=[v]
   f.write(k+' '+str(len(v))+' '+' '.join(map(str,v))+'\n')
 summary={'status':c['status'],'root_inputs':len(c['inputs']),'scalar_gates':len(c['gates']),'zero_outputs':len(c['required_zero_outputs']),'nonzero_patches':len(c['nonzero_patches']),'solving_run_executed':False}
 print(json.dumps(summary,indent=2))
if __name__=='__main__':main()
