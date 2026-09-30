"""Exact cubic-branch specialization and unit stripping of the actual norm element.
The coefficients are global rank-nine polynomials. Only named original-open
units are divided, with an exact polynomial division at every step.
"""
import gzip,json,struct,ctypes as ct,subprocess,time
from exact import ROOT,DATA,add,mul,power,neg,div,trim
import rank9 as R

def divlib():
 p=ROOT/'src/libglobaldivision.so'
 if not p.exists():subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/global_division.cpp'),'-o',str(p)],check=True)
 l=ct.CDLL(str(p));l.ff_init();IP=ct.POINTER(ct.c_int)
 l.div_q_linear.argtypes=[IP,ct.c_int,ct.c_int,IP,ct.c_int,IP]
 src=json.loads((ROOT/'evidence/global_source.json').read_text());gs=[0]*30
 for iq,iu,a in src['critical_monic']:gs[3*iq+iu]=a
 return l,(ct.c_int*30)(*gs)

def flat(p,n=None):
 n=n or max(map(len,p));return [p[j][i] if i<len(p[j]) else 0 for i in range(n) for j in range(9)]
def ring(a):return [trim(list(a[j::9])) for j in range(9)]
def weight(p):return max((2*i+j for j,c in enumerate(p) for i,a in enumerate(c) if a),default=-1)
def ud(p):return max(map(len,p))-1

def strip(polys):
 l,g=divlib();n=max(2,max(ud(p) for p in polys)+3);count=len(polys)
 vals=[p[j][i] if i<len(p[j]) else 0 for i in range(n) for p in polys for j in range(9)]
 a=(ct.c_int*len(vals))(*vals);b=(ct.c_int*len(vals))();powers={}
 for key,r in [('q',0),('d_monic',neg(div(DATA['d'][0],DATA['d'][1])))]:
  ndiv=0
  while True:
   status=l.div_q_linear(a,n,count,g,r,b)
   if status:break
   a,b=b,a;ndiv+=1
   assert ndiv<300
  assert status>0,(key,status)
  powers[key]=ndiv
 out=[[trim([a[(i*count+k)*9+j] for i in range(n)]) for j in range(9)] for k in range(count)]
 lo=min((i for p in out for c in p for i,x in enumerate(c) if x),default=0)
 out=[[c[lo:] if len(c)>lo else [] for c in p] for p in out];powers['u']=lo
 return out,powers

def extract(x=9):
 raw=gzip.open(ROOT/'evidence/norm_element.bin.gz','rb').read();a=struct.unpack('<%dI'%(len(raw)//4),raw)
 res=[]
 for j in range(3):
  pp=[]
  for s in range(3):
   p=R.zero()
   for i in range(45):
    for k in range(9):
     z=0
     for xx in range(46,-1,-1):z=add(mul(z,x),a[((((i*3+s)*3+j)*47+xx)*9+k)])
     while len(p[k])<=i:p[k].append(0)
     p[k][i]=z
   p=[trim(c) for c in p]
   q=R.zero();q[2*s]=[1]
   pp.append(R.times(p,q)) # tau=q^2*nu
  res.append(pp)
 return res

if __name__=='__main__':
 import sys
 from branch_geometry import run
 run(int(sys.argv[1]) if len(sys.argv)>1 and not sys.argv[1].startswith('--') else 9,'--verify' in sys.argv)
