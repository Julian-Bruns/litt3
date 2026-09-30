"""Build both complete Hom pencils directly from the problem's Laurent formulas."""
from exact import *
import time,json,pathlib
ROOT=pathlib.Path(__file__).resolve().parents[1]

class Builder:
 def __init__(self):
  self.E=frob25(e)
  self.U=[frob25(mon(*m)) for m in u_basis]+[{}]*13
  self.V=[{}]*6+[frob25(mon(*m)) for m in v_basis]
  self.w_basis=[('f',*m) for m in basis(31)]+[('alpha',*m) for m in basis(20)]
  self.c_basis=[('g0',*m) for m in basis(131)]+[('q0',*m) for m in basis(120)]
  self.bB=obstruction_basis(-144);self.bD=obstruction_basis(-155)
  self.bQ=obstruction_basis(-151)
 def obstruction(self,f,alpha,U,V,g0={},q0={},full=False):
  a=add(positive(mul(e,f)),alpha)
  p=add(a,neg(mul(e,f)))
  g=add(neg(positive(mul(U,f))),g0)
  eg_Up=add(mul(e,g),neg(mul(U,p)))
  q=add(positive(eg_Up),q0)
  B=add(mul(self.E,add(g,mul(U,f))),mul(V,f))
  h=neg(positive(B))
  D=add(neg(mul(e,h)),mul(self.E,add(q0,neg(negative(eg_Up)))),mul(V,p))
  r=neg(positive(D))
  out=np.concatenate([vector(B,self.bB),vector(D,self.bD)])
  return (out,[[a,q,r],[f,g,h]]) if full else out
 def run(self):
  t=time.time();m=len(self.bB)+len(self.bD);c=len(self.c_basis)
  print('dimensions',m,c,len(self.w_basis),len(self.bQ),len(basis(124)),len(basis(24)),flush=True)
  C=np.zeros((m,c),dtype=np.uint8)
  for j,(typ,i,k) in enumerate(self.c_basis):
   C[:,j]=self.obstruction({},{},{},{},**{typ:mon(i,k)})
  aug,piv=rref(np.concatenate([C,np.eye(m,dtype=np.uint8)],axis=1),c)
  assert len(piv)==c
  H=aug[:c,c:];N=aug[c:,c:]
  assert not mm(N,C).any()
  assert np.array_equal(mm(H,C),np.eye(c,dtype=np.uint8))
  T=np.zeros((19,m-c,len(self.w_basis)),dtype=np.uint8)
  raw=np.zeros((19,m,len(self.w_basis)),dtype=np.uint8)
  for l in range(19):
   for j,(typ,i,k) in enumerate(self.w_basis):
    f=mon(i,k) if typ=='f' else {};alpha=mon(i,k) if typ=='alpha' else {}
    raw[l,:,j]=self.obstruction(f,alpha,self.U[l],self.V[l])
   T[l]=mm(N,raw[l])
   print('T slice',l,'elapsed',round(time.time()-t,2),flush=True)
  A=np.stack([vector(mul(self.E,mon(*m)),self.bQ) for m in basis(124)],axis=1)
  ma,na=A.shape
  aug,piv=rref(np.concatenate([A,np.eye(ma,dtype=np.uint8)],axis=1),na)
  assert len(piv)==na
  HQ=aug[:na,na:];NQ=aug[na:,na:]
  Qraw=np.zeros((19,ma,len(basis(24))),dtype=np.uint8)
  for l in range(19):
   for j,mn in enumerate(basis(24)):
    n=mon(*mn)
    pol=add(mul(self.E,negative(mul(self.U[l],n))),mul(self.V[l],n))
    Qraw[l,:,j]=vector(pol,self.bQ)
  Q=np.stack([mm(NQ,sl) for sl in Qraw])
  assert not mm(NQ,A).any()
  assert np.array_equal(mm(HQ,A),np.eye(na,dtype=np.uint8))
  np.savez_compressed(ROOT/'data/pencils.npz',T=T,Q=Q,C=C,H=H,N=N,raw=raw,A=A,HQ=HQ,NQ=NQ,Qraw=Qraw)
  meta={'field':{'prime':5,'degree':2,'relation':'beta^2=beta+3','encoding':'a+5b means a+b*beta, 0<=a,b<5'},'P':P_ROW,'e':encode(e),'u_basis':u_basis,'v_basis':v_basis,'w_basis':self.w_basis,'c_basis':self.c_basis,'B_obstructions':self.bB,'D_obstructions':self.bD,'Q_obstructions':self.bQ,'n_basis':basis(24),'a0_basis':basis(124)}
  (ROOT/'data/bases.json').write_text(json.dumps(meta,indent=2)+'\n')
  print('build done',round(time.time()-t,2),'seconds',flush=True)

if __name__=='__main__':Builder().run()
