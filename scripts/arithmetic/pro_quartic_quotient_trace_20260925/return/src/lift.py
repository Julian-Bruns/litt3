"""General target-extension lift, Yoneda kernel, and actual determinant test."""
from exact import *

def evalp(p,x,y):
 def pw(a,n):
  if n<0:a=int(INV[a]);n=-n
  z=1
  while n:
   if n&1:z=int(MUL[z,a])
   a=int(MUL[a,a]);n//=2
  return z
 s=0
 for (i,j),c in p.items():s=int(ADD[s,MUL[c,MUL[pw(x,i),pw(y,j)]]])
 return s

def find_point():
 for x in range(1,25):
  v=evalp(P,x,0)
  for y in range(1,25):
   if int(MUL[MUL[y,y],y])==v:return x,y
 raise RuntimeError('no finite nonbranch point found')
POINT=find_point()

def recover_lower(D,z,m):
 U=linear_combination(z,[u for u,v in UV25]);V=linear_combination(z,[v for u,v in UV25])
 f=linear_combination(m,[f for f,a in FREE]);a=linear_combination(m,[a for f,a in FREE])
 raw=raw_quotient(U,V,f,a)
 rec=NEG[dot(D['RT'],raw)]
 residual,phi=raw_quotient(U,V,f,a,poly(rec[:len(GB)],GB),poly(rec[len(GB):],QB),True)
 return U,V,phi,residual

def top_raw(U,V,phi,u,v,s0=None,t0=None):
 a,q,r,f,g,h=phi;s0=s0 or {};t0=t0 or {}
 n=add(plus(add(mul(u,a),mul(v,f))),s0)
 nv=add(n,neg(mul(u,a)),neg(mul(v,f)))
 na=add(plus(add(mul(u,q),mul(v,g),neg(mul(U,nv)))),t0)
 dt=add(neg(mul(u,r)),neg(mul(v,h)),mul(E,add(na,neg(mul(u,q)),neg(mul(v,g)),mul(U,nv))),mul(V,nv))
 nb=neg(plus(dt))
 return vec(dt,RAWQ),(n,na,nb)

def top_column(D,U,V,phi,u,v,s0=None):
 raw,top=top_raw(U,V,phi,u,v,s0)
 obstruction=dot(D['CQ'],raw)
 t0=poly(NEG[dot(D['RQ'],raw)],A0B)
 n,na,nb=top
 na=add(na,t0);nb=sub(nb,plus(mul(E,t0)))
 return obstruction,(n,na,nb)

def cofactor(phi):
 a,q,r,f,g,h=phi
 return (sub(mul(q,h),mul(r,g)),sub(mul(r,f),mul(a,h)),sub(mul(a,g),mul(q,f)))

def yoneda_matrix(D,z,m):
 U,V,phi,res=recover_lower(D,z,m)
 if np.any(res):raise ValueError('lower rows are not an actual global morphism')
 top=[];cols=[]
 for u,v in COORDS:
  obs,row=top_column(D,U,V,phi,u,v);cols.append(obs);top.append(row)
 for mon in NB:
  obs,row=top_column(D,U,V,phi,{},{},s0={mon:1});cols.append(obs);top.append(row)
 A=np.column_stack(cols)
 cf=cofactor(phi); ce=[evalp(p,*POINT) for p in cf]
 ell=[]
 for row in top:
  ev=[evalp(p,*POINT) for p in row]
  ell.append(int(dot(np.array([ce],dtype=np.uint8),np.array(ev,dtype=np.uint8))[0]))
 N=np.vstack([A,np.array(ell,dtype=np.uint8)])
 return A,N,phi,top
