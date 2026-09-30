"""Find and serialize an exact witness, including its reconstructed chart map."""
import numpy as np,json
from reconstruct import *
D=np.load(ROOT/'data'/'tensor.npz');A,L,B,T=[D[k] for k in ('A','L','B','T')]
b=np.zeros(35,np.uint8);b[23]=1
N=nullspace(T[:,:,23].T);z=N[0]
rhs=NEG[mm(z[None,:],B[:,:,23])[0]]
rr,pv=rref(np.column_stack((A,rhs)));assert len(pv)==235 and list(pv)==list(range(235))
x=rr[:235,-1];assert np.array_equal(mm(A,x[:,None])[:,0],rhs)
f=LP.zero();alpha=LP.mon(0);g0=linear_comb(x[:123],[LP.mon(i,j) for i,j in gb]);q0=linear_comb(x[123:],[LP.mon(i,j) for i,j in qb])
u=LP.zero();v=LP.zero()
for c,(wh,i,j) in zip(z,zmon):
 if wh=='u':u=u+LP.mon(i,j,int(c))
 else:v=v+LP.mon(i,j,int(c))
U=u**25;V=v**25
res,fields=reconstruct(f,alpha,g0,q0,U,V,True)
assert not res.any()
assert fields['a'].equal(LP.mon(0)) and all(fields[key].iszero() for key in ('f','g','h'))
w=dict(format='GF25-Laurent-witness-v1',field=dict(characteristic=5,degree=2,relation='a^2=a+3',encoding='c0+5*c1'),xi=z.tolist(),z=z.tolist(),b=b.tolist(),auxiliary_coefficients=x.tolist(),u=u.terms(),v=v.terms(),f=f.terms(),alpha0=alpha.terms(),g0=g0.terms(),q0=q0.terms(),E=E.terms(),U=U.terms(),V=V.terms(),fields={k:p.terms() for k,p in fields.items()},s_minus=fields['astar'].minus().terms(),generic_rank=1)
(ROOT/'certificates'/'witness.json').write_text(json.dumps(w,indent=2)+'\n')
print('xi=z=',z.tolist())
print('b=',b.tolist())
print('v=',v.terms()); print('q0=',q0.terms())
S=fields['astar'];Sm=S.minus()
print('Sminus=',Sm.terms())
print('Sminus max pole weight=',max((3*i+10*j for i,j,c in Sm.terms()),default=None))
print('rank(T(z))=',rank(mm(z[None,:],T.reshape(19,-1)).reshape(80,35)))
print('kernel T(z)=',nullspace(mm(z[None,:],T.reshape(19,-1)).reshape(80,35)).tolist())
print('rank A,L=',rank(A),rank(L))
print('315 residuals zero; generic rank 1, first entry 1')
