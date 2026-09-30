"""Exact endpoint value/derivative incidence, with every pivot support retained.

Projection nilpotents are accounted for by explicit multiplicity blocks and
nilpotent lifting. Small scale Euclidean algorithms use only checked units,
and split a whole coefficient algebra whenever a leading pivot is a nonunit.
"""
import ctypes as ct,gzip,json,struct,subprocess,time,sys,hashlib
from exact import *
from endpoint_geometry import ENDPOINTS,DEST
from ratio_eliminant_data import load

def library():
 p=ROOT/'src/libendpointalgebra.so';s=ROOT/'src/endpoint_algebra.cpp'
 if not p.exists() or p.stat().st_mtime<max(s.stat().st_mtime,(ROOT/'src/field.cpp').stat().st_mtime):
  subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(s),'-o',str(p)],check=True)
 l=ct.CDLL(str(p));l.ff_init();IP=ct.POINTER(ct.c_int)
 l.endpoint_eval.argtypes=[IP,ct.c_int,ct.c_int,IP,ct.c_int,IP,IP]
 return l

def coefficient_jets(x):
 meta,raw=load();a=[]
 for i in range(133):
  vals=[];ders=[]
  for s in range(7):
   vs=[];ds=[]
   for j in range(9):
    pp=[raw[((i*7+s)*141+xx)*9+j] for xx in range(141)]
    vs.append(peval(pp,x));ds.append(peval(pder(pp),x))
   vals+=vs;ders+=ds
  assert not any(vals[4*9:]) and not any(ders[5*9:])
  a+=vals[:4*9]+ders[:5*9]
 return a

def evaluate(raw,M,u,count=9,rows=133):
 d=len(M)-1;u=prem(u,M);uu=u+[0]*(d-len(u));out=(ct.c_int*(count*d))()
 status=library().endpoint_eval((ct.c_int*len(raw))(*raw),rows,count,(ct.c_int*len(M))(*M),d,(ct.c_int*d)(*uu),out)
 assert status==0,status
 return [trim(list(out[i*d:(i+1)*d])) for i in range(count)]

def red(P,M):
 a=[prem(p,M) for p in P]
 while a and not a[-1]:a.pop()
 return a

def divrem(A,B,M):
 if not B:raise ZeroDivisionError('zero scale divisor')
 g,iv,_=pxgcd(B[-1],M)
 if g!=[1]:raise ArithmeticError(('nonunit pivot',g))
 R=A[:];Q=[[] for _ in range(max(0,len(A)-len(B)+1))]
 while R and len(R)>=len(B):
  k=len(R)-len(B);v=prem(pm(R[-1],iv),M);Q[k]=v
  for i,p in enumerate(B):R[k+i]=prem(ps(R[k+i],pm(v,p)),M)
  while R and not R[-1]:R.pop()
 return Q,R

def complete_gcd(F,G,M,path=''):
 """Yield disjoint whole squarefree coefficient factors and monic gcds.
 Any nonunit pivot splits the modulus; no pivot-zero locus is omitted.
 """
 F=red(F,M);G=red(G,M);A,B=F,G
 while B:
  g=pgcd(B[-1],M)
  if g!=[1]:
   assert len(g)<len(M), 'A nonzero reduced coefficient cannot be nilpotent here'
   other=pexact(M,g);assert pgcd(g,other)==[1]
   yield from complete_gcd(F,G,g,path+'0')
   yield from complete_gcd(F,G,other,path+'1')
   return
  _,rr=divrem(A,B,M);A,B=B,rr
 if not A:
  yield {'modulus':M,'gcd':[],'pivot_path':path,'zero_value_and_derivative':True};return
 g=pgcd(A[-1],M)
 if g!=[1]:
  assert len(g)<len(M)
  other=pexact(M,g);assert pgcd(g,other)==[1]
  yield from complete_gcd(F,G,g,path+'0')
  yield from complete_gcd(F,G,other,path+'1')
  return
 _,iv,_=pxgcd(A[-1],M);H=[prem(pm(p,iv),M) for p in A]
 assert H[-1]==[1]
 assert not divrem(F,H,M)[1] and not divrem(G,H,M)[1]
 yield {'modulus':M,'gcd':H,'pivot_path':path,'zero_value_and_derivative':False}

def run(x,verify=False):
 tic=time.time();prep=json.loads(gzip.open(DEST/f'prepared_{x}.json.gz','rb').read());raw=coefficient_jets(x)
 rec=[]
 for name,data in prep['projections'].items():
  for ms,z in data['multiplicity_blocks'].items():
   m=int(ms);u=prem(data['u'],z)
   val=evaluate(raw,z,u);F,G=val[:4],val[4:]
   parts=list(complete_gcd(F,G,z))
   product=[1]
   for part in parts:
    M=part['modulus'];product=pm(product,M);part['u']=prem(u,M)
    part['projection_kind']=name;part['projection_multiplicity']=m
    H=part['gcd'];deg=len(H)-1
    print('ENDPOINT INCIDENCE',x,name,'mult',m,'ratio length',len(M)-1,'scale gcd degree',deg,'path',part['pivot_path'],flush=True)
    if deg>=1:
     # In degrees one through three, a repeated unique geometric root has
     # root -H_(degree-1)/degree; all its nilpotents are retained by H.
     root=prem(pc(H[-2],neg(inv(deg))),M)
     expected=[[1]]
     for _ in range(deg):
      pp=[[] for __ in range(len(expected)+1)]
      for i,v in enumerate(expected):
       pp[i]=prem(ps(pp[i],pm(v,root)),M);pp[i+1]=prem(pa(pp[i+1],v),M)
      expected=pp
     if expected==H:
      part['unique_scale_root']=root;part['scale_root_multiplicity']=deg
      # Partition out the forbidden nu=0 support without losing its lift.
      zero=pgcd(root,M);good=pexact(M,zero)
      part['zero_scale_modulus']=zero;part['nonzero_scale_modulus']=good
      part['nu']=prem(root,good) if len(good)>1 else []
      print('  unique root; nonzero graph',len(good)-1,'zero removed',len(zero)-1,flush=True)
     else:part['unique_scale_root']=None
    rec.append(part)
   assert product==z
 out={'x_code':x,'actual_residual_jets_sha256':hashlib.sha256(struct.pack('<%dI'%len(raw),*raw)).hexdigest(),
   'value_scale_degree_bound':3,'derivative_scale_degree_bound':4,
   'incidence_polynomials':'Rstar(nu,x=a), dRstar/dx(nu,x=a)',
   'parts':rec,'status':'exact incidence decomposition; no square exclusion asserted by this file'}
 payload=json.dumps(out,separators=(',',':')).encode();dest=DEST/f'incidence_{x}.json.gz'
 if verify:assert gzip.open(dest,'rb').read()==payload
 else:dest.write_bytes(gzip.compress(payload,mtime=0,compresslevel=9))
 print('ENDPOINT INCIDENCE DONE',x,'seconds',round(time.time()-tic,3),flush=True)
 return out
if __name__=='__main__':
 args=[int(s) for s in sys.argv[1:] if not s.startswith('--')]
 for x in args or ENDPOINTS:run(x,'--verify' in sys.argv)
