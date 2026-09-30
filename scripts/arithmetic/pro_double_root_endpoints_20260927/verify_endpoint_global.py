"""Actual source jets and the global endpoint resultant factorisation.

The seven-by-seven Sylvester determinants use fixed degrees 3,4, with no
pivot inversions. A proved u-degree bound makes the complete-algebra
Vandermonde verification a global polynomial identity, not a ratio search.
"""
import ctypes as ct,json,gzip,hashlib,struct,time,sys
from exact import *
import rank9 as R
from branch_root import weight,ud
from endpoint_geometry import DEST,ENDPOINTS,qpoly,norm_linear,cnorm
from endpoint_incidence import coefficient_jets
from fast_arithmetic import library

def padd(a,b):
 n=max(len(a),len(b));return [R.plus(a[i] if i<len(a) else R.zero(),b[i] if i<len(b) else R.zero()) for i in range(n)]
def pscale(a,k):return [R.scalar(v,k) for v in a]
def pmul(a,b):
 out=[R.zero() for _ in range(len(a)+len(b)-1)]
 for i,x in enumerate(a):
  for j,y in enumerate(b):out[i+j]=R.plus(out[i+j],R.times(x,y))
 return out

def norm_derivative(A,B,Ap,Bp,Cp,p):
 rr=[[a,b] for a,b in zip(A,B)];ss=[[a,b,c] for a,b,c in zip(Ap,Bp,Cp)]
 out=[R.zero() for _ in range(5)];pp=[R.one(),p,R.power(p,2)]
 for i in range(3):
  z=pmul(pmul(rr[i],rr[i]),ss[i]);z=[R.times(v,pp[i]) for v in z];out=padd(out,pscale(z,3))
 for i in range(3):
  z=ss[i]
  for j in range(3):
   if j!=i:z=pmul(z,rr[j])
  out=padd(out,pscale([R.times(v,p) for v in z],2))
 return out

def run(x,verify=True):
 tic=time.time();geo=json.loads(gzip.open(DEST/f'geometry_{x}.json.gz','rb').read());raw=coefficient_jets(x)
 polys=[[trim([raw[(i*9+k)*9+j] for i in range(133)]) for j in range(9)] for k in range(9)]
 f,g=polys[:4],polys[4:];p=qpoly([0,0,geo['P_at_x']]);q4=qpoly([0,0,0,0,1])
 assert norm_linear(geo['A'],geo['B'],p)==[R.times(q4,z) for z in f]
 assert norm_derivative(geo['A'],geo['B'],geo['Aprime'],geo['Bprime'],geo['Cprime'],p)==[R.times(q4,z) for z in g]
 assert geo['common_jet_unit_powers']=={'q':16,'d_monic':0,'u':0}
 assert geo['W_unit_powers']=={'q':4,'d_monic':0,'u':0}
 assert geo['norm_W_unit_powers']=={'q':4,'d_monic':0,'u':0}
 assert geo['wedge_unit_powers']=={'q':2,'d_monic':0,'u':0}
 assert geo['K_unit_powers']=={'q':2,'d_monic':0,'u':0}
 nw,kk=geo['norm_W_primitive'],geo['K_primitive']
 w=max(weight(z) for z in polys);bound=max(7*w,8+weight(nw)+2*weight(kk));N=bound//2+1
 src=json.loads((ROOT/'evidence/global_source.json').read_text());gq=[0]*30
 for iq,iu,c in src['critical_monic']:
  assert 2*iu+iq<=9;gq[3*iq+iu]=c
 allp=polys+[nw,kk];rows=max(max(map(len,z)) for z in allp)
 ar=[p[j][i] if i<len(p[j]) else 0 for i in range(rows) for p in allp for j in range(9)]
 lib=library('endpoint_global');IP=ct.POINTER(ct.c_int)
 lib.endpoint_resultant_checks.argtypes=[IP,ct.c_int,IP,ct.c_int,ct.c_int,IP]
 checks=(ct.c_int*(N*9))();status=lib.endpoint_resultant_checks((ct.c_int*len(ar))(*ar),rows,(ct.c_int*30)(*gq),geo['P_at_x'],N,checks)
 assert status==0,status
 out={'x_code':x,'identity':'Res_nu;(3,4)(Rstar(a),dRstar/dx(a))=3*P(a)^2*q^8*K_a^2*N_a',
   'source_value_identity':'Norm(A+B*nu)=q^4*Rstar(a)',
   'source_derivative_identity':'DNorm=q^4*dRstar/dx(a)',
   'coefficient_weight_bound':w,'identity_weight_bound':bound,'identity_u_degree_bound':N-1,
   'distinct_complete_u_algebras_verified':N,'u_codes':'0,...,N-1',
   'polynomiality_and_globality':'q-monic reduction does not increase weight (q,u)=(1,2); Vandermonde over K is invertible',
   'fixed_degree_and_no_pivot_localization':True,
   'determinant_samples_sha256':hashlib.sha256(struct.pack('<%dI'%len(checks),*checks)).hexdigest()}
 dest=DEST/f'global_identity_{x}.json'
 if verify:assert json.loads(dest.read_text())==out
 else:dest.write_text(json.dumps(out,indent=2)+'\n')
 print('GLOBAL ACTUAL ENDPOINT IDENTITY',x,'proved u bound',N-1,'complete algebras',N,'seconds',round(time.time()-tic,3),flush=True)
 return out
if __name__=='__main__':
 args=[int(s) for s in sys.argv[1:] if not s.startswith('--')]
 for x in args or ENDPOINTS:run(x,'--build' not in sys.argv)
