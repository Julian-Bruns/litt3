"""Construct/verify a polynomial Bezout identity excluding square Delta globally.
This checker multiplies the stored rank-nine polynomials exactly. Its decisive
identities do not depend on interpolation degree bounds, irreducibility of a
sample algebra, generic inverses, or a bounded geometric parameter search.
"""
import ctypes as ct,gzip,json,struct,subprocess,sys,time
from exact import *
import rank9 as R
from critical_model import interpolate
from interpolate_global import library

def run(verify=False):
 start=time.time();dat=json.loads(gzip.open(ROOT/'evidence/critical_nonsplit.json.gz','rb').read())
 delta_raw=gzip.open(ROOT/'evidence/critical_delta.bin.gz','rb').read()
 delta=list(struct.unpack('<%dI'%(len(delta_raw)//4),delta_raw))
 dd=[[R.from_flat(delta,8,33,j*11+x) for x in range(11)] for j in range(3)]
 # Independent polynomial reconstruction of Delta_1^2-4 Delta_0 Delta_2.
 raw=[R.zero() for _ in range(21)]
 for i in range(11):
  for j in range(11):
   raw[i+j]=R.plus(raw[i+j],R.minus(R.times(dd[1][i],dd[1][j]),R.scalar(R.times(dd[0][i],dd[2][j]),4)))
 assert all(a==R.zero() for a in raw[15:])
 prim=[R.from_flat(dat['primitive_coefficients'],15,15,i) for i in range(15)]
 assert dat['stripped_original_open_factors']=={'q':4,'d_monic':0,'u':0}
 q4=R.zero();q4[4]=[1]
 for i in range(15):
  assert raw[i]==R.from_flat(dat['raw_coefficients'],15,15,i)
  assert R.times(q4,prim[i])==raw[i]
 n0,n1=dat['norms_by_x_coefficient'][:2]
 s,t=dat['bezout'][:2]
 assert pa(pm(s,n0),pm(t,n1))==[1]
 path=ROOT/'evidence/critical_bezout.json.gz'
 if verify:
  cert=json.loads(gzip.open(path,'rb').read());adjs=cert['adjugate_lifts']
 else:
  lp=ROOT/'src/libcriticalnorms.so'
  subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(ROOT/'src/critical_norms.cpp'),'-o',str(lp)],check=True)
  lib=ct.CDLL(str(lp));lib.ff_init();IP=ct.POINTER(ct.c_int)
  lib.adjugate9.argtypes=[IP,IP,IP]
  # This is construction only; the identities below are the certificate proof.
  vals=[];nn=97
  for u in range(nn):
   mod=(ct.c_int*10)(*[peval(a,u) for a in R.G])
   for p in prim[:2]:
    el=(ct.c_int*9)(*[peval(a,u) for a in p]);out=(ct.c_int*9)()
    lib.adjugate9(mod,el,out);vals.extend(out)
  flat=interpolate(vals,nn,18)
  adjs=[[trim([flat[i*18+j*9+k] for i in range(nn)]) for k in range(9)] for j in range(2)]
 for p,a,n in zip(prim[:2],adjs,[n0,n1]):
  assert R.times(p,a)==[n]+[[] for _ in range(8)]
 lifts=[R.times_poly(adjs[0],s),R.times_poly(adjs[1],t)]
 assert R.plus(R.times(prim[0],lifts[0]),R.times(prim[1],lifts[1]))==R.one()
 cert={'status':'exact_global_polynomial_bezout_verified','ring':'K[u,q]/(g), monic q degree 9',
  'identity':'B0*m0+B1*m1=1; [x^j](Delta_1^2-4Delta_0*Delta_2)=q^4*mj',
  'used_coefficient_indices':[0,1],
  'primitive_coefficients':prim[:2],'norms':[n0,n1],'univariate_bezout':[s,t],
  'adjugate_lifts':adjs,'global_bezout_lifts':lifts,
  'global_lift_u_degrees':[max(map(len,a))-1 for a in lifts],
  'conclusion':'Delta is nonsquare in k(X) at every geometric ratio with q nonzero.'}
 rawj=json.dumps(cert,separators=(',',':')).encode()
 if verify:assert gzip.open(path,'rb').read()==rawj
 else:path.write_bytes(gzip.compress(rawj,mtime=0,compresslevel=9))
 print('EXACT GLOBAL CRITICAL BEZOUT VERIFIED: m0*B0+m1*B1=1;',
  'lift u degrees',cert['global_lift_u_degrees'],'seconds',round(time.time()-start,3),flush=True)
 return cert
if __name__=='__main__':run('--verify' in sys.argv)
