from reduce_return import *
from geometry import determinant3
import json
D=np.load(WROOT/'reduced_return.npz')

def lin(arr,coef):
 out=np.zeros_like(arr[0])
 for a,c in zip(arr,coef):
  if c:out=ADD[out,MUL[c,a]]
 return out

def matrices(xi,eta):
 TL=lin(D['T'],eta); QL=lin(D['Q'],eta)
 CL=lin(np.array([lin(a,eta) for a in D['C']]),xi)
 M=np.block([[TL,np.zeros((80,16),np.uint8)],[CL,QL]])
 Hforms=np.zeros((3,3,51),np.uint8)
 Hforms[0,0,:35]=lin(D['top_first_c'],xi);Hforms[0,0,35:]=D['top_first_s']
 mix=lin(np.array([lin(a,eta) for a in D['top_other_c']]),xi)
 Hforms[0,1:,:35]=mix;Hforms[0,1:,35:]=lin(D['top_other_s'],eta)
 Hforms[1,0,:35]=D['first_at_point'][0];Hforms[2,0,:35]=D['first_at_point'][1]
 low=lin(D['lower_at_point'],eta)
 Hforms[1,1,:35]=low[1];Hforms[1,2,:35]=low[3]
 Hforms[2,1,:35]=low[0];Hforms[2,2,:35]=low[2]
 return M,Hforms

def reconstruct(xi,eta,cs):
 c,s=cs[:35],cs[35:]
 aa=combine([a for a,f in sections],c);ff=combine([f for a,f in sections],c)
 u=combine([mono(*m) for m in u_keys],xi[:6]);v=combine([mono(*m) for m in v_keys],xi[6:])
 U=combine([power(mono(*m),25) for m in u_keys],eta[:6]);V=combine([power(mono(*m),25) for m in v_keys],eta[6:])
 y=matmul(lin(D['lower_recovery'],eta),c[:,None])[:,0]
 g0=combine([mono(*m) for m in b131],y[:123]);q0=combine([mono(*m) for m in b120],y[123:])
 s0=combine([mono(*m) for m in bas0(24)],s)
 tc=lin(np.array([lin(a,eta) for a in D['t_recovery_c']]),xi)
 t=ADD[matmul(tc,c[:,None]),matmul(lin(D['t_recovery_s'],eta),s[:,None])][:,0]
 t0=combine([mono(*m) for m in bas0(124)],t)
 pp=add(aa,neg(mul(e,ff)));uf=mul(U,ff);wt=tail(uf)
 chi=add(mul(e,g0),mul(e,wt),neg(mul(U,aa)))
 gg=add(g0,neg(pos(uf)));qq=add(q0,pos(chi))
 rb=add(mul(E,add(g0,wt)),mul(V,ff));hh=neg(pos(rb))
 ra=add(neg(mul(e,hh)),mul(E,add(q0,neg(tail(chi)))),mul(V,pp));rr=neg(pos(ra))
 w0=add(mul(u,aa),mul(v,ff));nn=add(s0,pos(w0));nv=add(s0,neg(tail(w0)))
 w1=add(mul(u,qq),mul(v,gg),neg(mul(U,nv)));na=add(t0,pos(w1))
 rn=add(neg(mul(u,rr)),neg(mul(v,hh)),mul(E,add(t0,neg(tail(w1)))),mul(V,nv));nb=neg(pos(rn))
 H=[[nn,na,nb],[aa,qq,rr],[ff,gg,hh]]
 residual=np.concatenate([vec(rb,bm144),vec(ra,bm155),vec(rn,bas1(-151))])
 HV=[[nv,add(t0,neg(tail(w1))),tail(rn)],[pp,add(q0,neg(tail(chi))),tail(ra)],[ff,add(g0,wt),tail(rb)]]
 return H,HV,residual,(u,v,U,V)

def pmatmul(A,B):
 return [[add(*(mul(A[i][k],B[k][j]) for k in range(3))) for j in range(3)] for i in range(3)]

def verify_transition(H,HV,uv):
 u,v,U,V=uv
 Z={};one=mono()
 G=[[one,neg(u),neg(v)],[Z,one,neg(e)],[Z,Z,one]]
 Gqinv=[[one,U,add(V,mul(U,E))],[Z,one,E],[Z,Z,one]]
 HH=pmatmul(pmatmul(G,H),Gqinv)
 assert HH==HV

def bounds(H,HV):
 assert all(all(i>=0 for i,j in p) for row in H for p in row)
 dd=[-1,-5,6]
 for i in range(3):
  for j in range(3):
   assert all(3*a+10*b<=dd[i]-25*dd[j] for a,b in HV[i][j]),(i,j)

def encode_poly(p):return [[i,j,int(c)] for (i,j),c in sorted(p.items())]

def verify(output_path=None):
 rng=np.random.default_rng(260924)
 # These are polynomial identity sanity checks, not a bounded existence scan.
 for t in range(8):
  xi=rng.integers(0,25,19,dtype=np.uint8);eta=rng.integers(0,25,19,dtype=np.uint8);cs=rng.integers(0,25,51,dtype=np.uint8)
  M,Hf=matrices(xi,eta);H,HV,res,uv=reconstruct(xi,eta,cs)
  r=matmul(M,cs[:,None])[:,0]
  assert not matmul(D['SA'],res[:315,None]).any()
  assert np.array_equal(matmul(D['LA'],res[:315,None])[:,0],r[:80])
  assert not matmul(D['SN'],res[315:,None]).any()
  assert np.array_equal(matmul(D['LN'],res[315:,None])[:,0],r[80:])
  actual=np.array([[evaluate(p,5,14) for p in row] for row in H],np.uint8)
  assert np.array_equal(actual,matmul(Hf.reshape(9,51),cs[:,None]).reshape(3,3))
  if t<2:verify_transition(H,HV,uv)
  print('independent source/target coefficient check',t,'PASS',flush=True)
 outcomes=[]
 for tail6 in [(24,2,10,11,1,0),(14,5,13,12,0,1)]:
  xi=np.array([0]*13+list(tail6),np.uint8);M,Hf=matrices(xi,xi);K=kernel(M)
  print('input pencil point',tail6,'full Hom dim',K.shape[1],'lower coefficient rank',len(rref(K[:35])[1]),flush=True)
  entry={'xi':xi.tolist(),'kernel':K.tolist(),'Hom_dimension':K.shape[1],'matrices':[]}
  for col in K.T:
   H,HV,res,uv=reconstruct(xi,xi,col);assert not res.any();verify_transition(H,HV,uv);bounds(H,HV);assert not determinant3(H)
   entry['matrices'].append({'H_U':[[encode_poly(p) for p in row] for row in H],'H_V':[[encode_poly(p) for p in row] for row in HV]})
  outcomes.append(entry)
 if output_path is not None:
  Path(output_path).write_text(json.dumps(outcomes,indent=2)+'\n')
 print('full Laurent transition, infinity bounds, determinant zero: PASS',flush=True)
 print('No determinant-one solution constructed. No global emptiness assertion.',flush=True)
 return outcomes
if __name__=='__main__':verify()
