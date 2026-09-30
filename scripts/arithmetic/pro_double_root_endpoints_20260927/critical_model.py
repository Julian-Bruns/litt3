"""Actual critical double cover and the square factor of its scale discriminant.
Delta=(b^2+a*c)/P^2, with a=3Gtilde2,b=2Gtilde3,c=Gtilde4.
Discriminant_tau(Theta)=Delta*H^2, with H reconstructed from the actual source.
"""
import ctypes as ct,gzip,struct,json,hashlib,time,sys
from exact import ROOT,DATA,t as tc,power,rref
from extension import E,Poly
from residual import Curve,resultant_coefficients
from leading_preimage import src_at
from interpolate_global import library

def sample(u0,with_square_factor=True):
 mod,q,G=src_at(u0);P=Poly(DATA['P']);Q=Curve(Poly(DATA['Q']));t=Poly(tc)
 d=Poly(DATA['d']).eval(q)
 a,b,c,gg=3*G[2],2*G[3],G[4],G[5]
 D=b*b+a*c
 delta=Curve([p/(P**2) for p in D.c])
 assert all(p.degree()<=(32-10*j)//3 for j,p in enumerate(delta.c))
 if not with_square_factor:return mod,delta,None
 T=Curve([Poly(),t**3*P**3*q*q*d,Poly()])
 N=a**5*(Q*Q)-b**5*Q+c**5
 K=N*(D*gg+a**3*Q+2*b*c*c)+T*D*(2*a**5*Q-b**5)
 DK=D*K;den=P**12*t**5
 H=Curve([DK.c[1]*q*q/den,DK.c[2]*q*q/den,DK.c[0]/(den*P)])
 assert all(p.degree()<=(120-10*j)//3 for j,p in enumerate(H.c))
 rc=resultant_coefficients(a,b,c,gg,Q,T,Poly([-E(DATA['r']),1]))
 denn=P**13*t**5*Poly([-E(DATA['r']),1])
 th=[Curve([zz.c[1]*q*q/denn,zz.c[2]*q*q/denn,zz.c[0]/(denn*P)]) for zz in rc]
 assert th[1]*th[1]-4*th[0]*th[2]==delta*H*H
 return mod,delta,H

def interpolate(vals,n,m):
 rr,piv=rref([[power(u,j) for j in range(n)]+[int(u==j) for j in range(n)] for u in range(n)],n)
 assert piv==list(range(n));lib=library()
 out=(ct.c_int*(n*m))();inp=(ct.c_int*(n*m))(*vals)
 mat=(ct.c_int*(n*n))(*[x for row in rr for x in row[n:]])
 lib.ff_matmul_batch(mat,inp,out,n,n,m)
 check=(ct.c_int*(n*m))();lib.ff_matmul_batch((ct.c_int*(n*n))(*[power(u,j) for u in range(n) for j in range(n)]),out,check,n,n,m)
 assert list(check)==vals
 return list(out)

def run(verify=False):
 started=time.time();dvals=[];hvals=[];records=[]
 for u0 in range(38):
  mod,de,H=sample(u0,True)
  dd=[a for p in de.c for i in range(11) for a in p[i].a]
  hh=[a for p in H.c for i in range(41) for a in p[i].a]
  if u0<8:dvals.extend(dd)
  hvals.extend(hh)
  records.append({'u_code':u0,'delta_digest':hashlib.sha256(struct.pack('<%dI'%len(dd),*dd)).hexdigest(),'H_digest':hashlib.sha256(struct.pack('<%dI'%len(hh),*hh)).hexdigest()})
  if u0%10==0:print('CRITICAL MODEL',u0,'exact P,t divisions, pole bounds and discriminant identity',flush=True)
 dar=interpolate(dvals,8,3*11*9);har=interpolate(hvals,38,3*41*9)
 for ar,n,nx,w in [(dar,8,11,44),(har,38,41,224)]:
  for i in range(n):
   for j in range(3):
    for x in range(nx):
     for q in range(9):
      if ar[(((i*3+j)*nx+x)*9+q)]:assert 6*i+2*j+3*q<=w
 outputs={}
 for name,ar,shape in [('critical_delta',dar,[8,3,11,9]),('critical_square_factor',har,[38,3,41,9])]:
  raw=struct.pack('<%dI'%len(ar),*ar);p=ROOT/'evidence'/f'{name}.bin.gz'
  if verify:assert gzip.open(p,'rb').read()==raw
  else:p.write_bytes(gzip.compress(raw,compresslevel=9,mtime=0))
  outputs[name]={'shape':shape,'order':['u','V','x','q'],'raw_sha256':hashlib.sha256(raw).hexdigest(),'observed_u_degree':max(i for i in range(shape[0]) if any(ar[i*(len(ar)//shape[0]):(i+1)*(len(ar)//shape[0])]))}
 meta={'identity':'disc_tau(Theta)=Delta*H^2','critical_discriminant':'b^2+a*c=P^2*Delta','delta_pole_bound':32,'H_pole_bound':120,'delta_parameter_weight_bound':44,'H_parameter_weight_bound':224,'outputs':outputs,'samples':records}
 mp=ROOT/'evidence/critical_model.json'
 if verify:assert json.loads(mp.read_text())==meta
 else:mp.write_text(json.dumps(meta,indent=2)+'\n')
 print('GLOBAL CRITICAL MODEL VERIFIED',json.dumps(outputs),'seconds',round(time.time()-started,3),flush=True)
 return meta
if __name__=='__main__':run('--verify' in sys.argv)
