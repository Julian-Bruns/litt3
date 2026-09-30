"""Compact actual quadratic-scale cubic element with norm q^4*R_tilde.
Theta=q^2*Res_(10,2)(f_tilde,S_tilde')/(V*P^13*t^5*v).
Polynomiality, pole <=140 and all coefficients follow by degree-bounded
interpolation in the complete rank-nine ratio algebras, including u=0.
"""
import json,gzip,struct,hashlib,ctypes as ct,time,sys
from exact import ROOT,DATA,t as tc,power,rref,mul,code
from extension import E,Poly
from leading_preimage import src_at
from residual import Curve,resultant_coefficients,bp_add,bp_pow,bp_mul,bp_scale
from interpolate_global import library
N=45;NX=47;NT=3;D=9

def sample(u0):
 mod,q,G=src_at(u0);P=Poly(DATA['P']);Q=Poly(DATA['Q']);t=Poly(tc);v=Poly([-E(DATA['r']),1]);d=Poly(DATA['d']).eval(q)
 T=Curve([Poly(),(t**3)*(P**3)*q*q*d,Poly()])
 rc=resultant_coefficients(3*G[2],2*G[3],G[4],G[5],Curve(Q),T,v)
 den=P**13*t**5*v
 theta=[]
 for zz in rc:
  coeff=[zz.c[1]*q*q/den,zz.c[2]*q*q/den,zz.c[0]/(den*P)]
  assert all(p.degree()<=((140-10*j)//3) for j,p in enumerate(coeff))
  theta.append(Curve(coeff))
 F=Poly(DATA['a0']).eval(q)*E(u0)**3+Poly(DATA['b']).eval(q)*E(u0)**2+Poly(DATA['c']).eval(q)*E(u0)+Poly(DATA['e']).eval(q)
 leading=E(3)*E(code(DATA['epsilon']))**8*q**28*d**11*E(u0)**3*F
 assert theta[0].c[2][40]==leading
 assert theta[1].c[2][40]==0 and theta[2].c[2][40]==0
 flat=[a for z in theta for p in z.c for ix in range(NX) for a in p[ix].a]
 return flat,theta

def run(verify=False):
 start=time.time();values=[];records=[]
 for u0 in range(N):
  flat,_=sample(u0);raw=struct.pack('<%dI'%len(flat),*flat);values.extend(flat);records.append({'u_code':u0,'raw_sha256':hashlib.sha256(raw).hexdigest()})
  if u0%10==0:print('NORM ELEMENT exact divisions, pole and leading coefficient at u',u0,flush=True)
 m=NT*3*NX*D
 mat=[[power(u0,j) for j in range(N)]+[int(u0==j) for j in range(N)] for u0 in range(N)]
 rr,piv=rref(mat,N);assert piv==list(range(N));lib=library()
 a=(ct.c_int*(N*N))(*[x for row in rr for x in row[N:]]);b=(ct.c_int*len(values))(*values);out=(ct.c_int*len(values))()
 lib.ff_matmul_batch(a,b,out,N,N,m)
 check=(ct.c_int*len(values))();lib.ff_matmul_batch((ct.c_int*(N*N))(*[power(c,j) for c in range(N) for j in range(N)]),out,check,N,N,m);assert list(check)==values
 raw=struct.pack('<%dI'%len(out),*out);path=ROOT/'evidence/norm_element.bin.gz'
 if verify:assert gzip.open(path,'rb').read()==raw
 else:path.write_bytes(gzip.compress(raw,mtime=0,compresslevel=9))
 meta={'shape':[N,NT,3,NX,D],'order':['u','tau','V','x','q'],'coefficient_type':'little-endian uint32 K codes','definition':'Theta=q^2*Res/(V*P^13*t^5*v)','identity':'Norm(Theta)=q^4*R_tilde','parameter_weight_bound_times_three':268,'u_degree_bound':44,'observed_u_degree':max(i for i in range(N) if any(out[i*m:(i+1)*m])),'raw_sha256':hashlib.sha256(raw).hexdigest(),'samples':records,'seconds':round(time.time()-start,3)}
 for iu in range(N):
  for ti in range(3):
   for vv in range(3):
    for xx in range(NX):
     for qq in range(9):
      a=out[((((iu*3+ti)*3+vv)*NX+xx)*9+qq)]
      if a:assert 6*iu+3*qq+2*vv<=268
 if verify:
  old=json.loads((ROOT/'evidence/norm_element.json').read_text());assert {k:v for k,v in meta.items() if k!='seconds'}=={k:v for k,v in old.items() if k!='seconds'}
 else:(ROOT/'evidence/norm_element.json').write_text(json.dumps(meta,indent=2)+'\n')
 print('GLOBAL NORM ELEMENT RECONSTRUCTED',meta['observed_u_degree'],meta['raw_sha256'],flush=True)
 return meta
if __name__=='__main__':run('--verify' in sys.argv)
