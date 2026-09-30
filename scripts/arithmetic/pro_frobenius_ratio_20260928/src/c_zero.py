"""Whole c(q)=0 fiber via a verified primitive element, no q-root selection."""
from residual import *
from ff import Poly,X,neg,rref
from factor import factor_squarefree,irreducible
import numpy as np
import json,time

def primitive_model(save=True):
 c=Poly(RATIO['c']).monic();b=Poly(RATIO['b']);e=Poly(RATIO['e']);d=c.degree()
 assert c.gcd(c.derivative())==Poly(1)
 gb,bi,_=b.xgcd(c);assert gb==Poly(1)
 v=(2*e*bi)%c # u^2=2e/b when c=0.
 assert v.gcd(c)==Poly(1)
 def plus(a,b):return tuple((a[i]+b[i])%c for i in range(2))
 def times(a,b):return ((a[0]*b[0]+a[1]*b[1]*v)%c,(a[0]*b[1]+a[1]*b[0])%c)
 def flat(a):return [a[j][i] for j in range(2) for i in range(d)]
 one=(Poly(1),Poly());qq=(X%c,Poly());uu=(Poly(),Poly(1));z=plus(qq,uu)
 powers=[one]
 for i in range(2*d):powers.append(times(powers[-1],z))
 mtx=np.array([flat(a) for a in powers[:2*d]],dtype=np.uint32).T
 rhs=np.array([flat(qq),flat(uu),flat(powers[-1])],dtype=np.uint32).T
 rr,pivs=rref(np.concatenate((mtx,rhs),axis=1));assert pivs==list(range(2*d))
 qrep=Poly(rr[:,2*d]);urep=Poly(rr[:,2*d+1]);mod=Poly([neg(int(a)) for a in rr[:,2*d+2]]+[1])
 assert mod.gcd(mod.derivative())==Poly(1)
 def ev(poly):
  o=(Poly(),Poly())
  for a in poly.tolist()[::-1]:o=plus(times(o,z),(Poly(a),Poly()))
  return o
 assert ev(qrep)==qq and ev(urep)==uu and ev(mod)==(Poly(),Poly())
 z0=ext.context(mod);q=E(qrep);u=E(urep)
 assert peval(RATIO['c'],q)==0
 check_open(q,u)
 out={'base_modulus_c':c.tolist(),'u_square':v.tolist(),'primitive_element':'z=q+u','primitive_modulus':mod.tolist(),'q_representation':qrep.tolist(),'u_representation':urep.tolist(),'Krylov_rank':2*d}
 if save:(ROOT/'data'/'c_zero_primitive.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
 return mod,qrep,urep,out

def main():
 start=time.time();mod,qrep,urep,model=primitive_model();fs=factor_squarefree(mod)
 assert all(irreducible(f) for f in fs)
 records=[]
 for i,m in enumerate(fs):
  ext.context(m);q=E(qrep);u=E(urep);check_open(q,u)
  assert peval(RATIO['c'],q)==0
  print('c_zero','factor',i,'degree',m.degree(),flush=True)
  _,A=residual(q,u);ts=Tails(A);t1,t2=ts.tail(71),ts.tail(72)
  g,a,b=t1.xgcd(t2);assert g==1 and a*t1+b*t2==1
  cert={'case':'c_zero','modulus':m.tolist(),'q_representation':(qrep%m).tolist(),'u_representation':(urep%m).tolist(),'tail_indices':[71,72],'tail_degrees':[t1.degree(),t2.degree()],'mu_power':0,'bezout_coefficients':[a.serialize(),b.serialize()]}
  file=ROOT/'data'/'boundary_certificates'/('c_zero_'+str(i)+'.json');file.write_text(json.dumps(cert,separators=(',',':'))+'\n')
  records.append({'degree':m.degree(),'modulus':m.tolist(),'certificate':str(file.relative_to(ROOT))})
 summary={'case':'c_zero','geometric_ratios':mod.degree(),'geometric_q_values':len(RATIO['c'])-1,'primitive_model':'data/c_zero_primitive.json','factors':records,'status':'excluded','elapsed_seconds':round(time.time()-start,3)}
 (ROOT/'checks'/'c_zero.json').write_text(json.dumps(summary,indent=2)+'\n');print(json.dumps(summary,indent=2))
if __name__=='__main__':main()
