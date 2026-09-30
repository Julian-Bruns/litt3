"""Exact control examples and nonzero minor certificates; neither is a window witness."""
from exact import *
from build import Builder
import pathlib,json
ROOT=pathlib.Path(__file__).resolve().parents[1]

def determinant(A):
 A=A.copy();n=A.shape[0];assert A.shape==(n,n);d=1
 for j in range(n):
  q=next((i for i in range(j,n) if A[i,j]),None)
  if q is None:return 0
  if q!=j:
   A[[q,j]]=A[[j,q]];d=int(NEG[d])
  v=int(A[j,j]);d=int(MUL[d,v])
  for k in range(j,n):A[j,k]=MUL[A[j,k],INV[v]]
  for i in range(j+1,n):
   c=int(NEG[A[i,j]])
   if c:A[i,j:]=ADD[A[i,j:],MUL[c,A[j,j:]]]
 return d

def full_column_minor(A):
 _,rows=rref(A.T);rows=rows[:A.shape[1]]
 assert len(rows)==A.shape[1]
 d=determinant(A[rows]);assert d
 return {'row_indices':rows.tolist(),'column_indices':list(range(A.shape[1])),'determinant':d,'indexing':'zero-based'}

def reconstruct(z,w):
 b=Builder();a=np.load(ROOT/'data/pencils.npz');meta=json.load(open(ROOT/'data/bases.json'))
 U=add(*[scale(b.U[i],int(z[i])) for i in range(19)])
 V=add(*[scale(b.V[i],int(z[i])) for i in range(19)])
 f=from_vector(w[:23],basis(31));alpha=from_vector(w[23:],basis(20))
 rhs=b.obstruction(f,alpha,U,V)
 recovery=NEG[mm(a['H'],rhs.reshape(-1,1)).ravel()]
 g0=from_vector(recovery[:123],basis(131));q0=from_vector(recovery[123:],basis(120))
 ob,H=b.obstruction(f,alpha,U,V,g0,q0,full=True);assert not ob.any()
 return H,g0,q0,U,V

def lattice_checks(H,U,V):
 E=frob25(e);a,q,r=H[0];f,g,h=H[1]
 p=add(a,neg(mul(e,f)))
 HV=[[p,add(q,neg(mul(e,g)),mul(U,p)),add(r,neg(mul(e,h)),mul(E,add(q,neg(mul(e,g)))),mul(add(V,mul(U,E)),p))],
     [f,add(g,mul(U,f)),add(h,mul(E,g),mul(add(V,mul(U,E)),f))]]
 bounds=[[20,120,-155],[31,131,-144]]
 weights=[]
 for row in H:
  assert all(i>=0 for pp in row for i,j in pp)
 for i in range(2):
  weights.append([])
  for j in range(3):
   maximum=max((3*a+10*b for a,b in HV[i][j]),default=None)
   assert maximum is None or maximum<=bounds[i][j]
   weights[i].append(maximum)
 minors=[]
 for i,j in [(0,1),(0,2),(1,2)]:minors.append(add(mul(H[0][i],H[1][j]),neg(mul(H[0][j],H[1][i]))))
 gr=2 if any(minors) else 1 if any(H[0]+H[1]) else 0
 return {'infinity_maximum_weights':weights,'infinity_weight_bounds':bounds,'generic_rank':gr,'all_two_by_two_minors_zero':not any(minors)}

if __name__=='__main__':
 a=np.load(ROOT/'data/pencils.npz');T=a['T'];Q=a['Q']
 f0=full_column_minor(a['C'][:152,:123])
 (ROOT/'certificates/f_zero_minor.json').write_text(json.dumps(f0,indent=2)+'\n')
 z=np.zeros(19,dtype=np.uint8);z[0]=1
 stable={'description':'Stable control, NOT a window witness: both Hom spaces vanish. Geometric stability is proved in REPORT.md.', 'xi':z.tolist(),'z':z.tolist(),'field':'F25','rank_T':35,'rank_Q':16,'T_minor':full_column_minor(T[0]),'Q_minor':full_column_minor(Q[0])}
 (ROOT/'certificates/stable_control.json').write_text(json.dumps(stable,indent=2)+'\n')
 z=np.array([0]*13+[14,5,13,12,0,1],dtype=np.uint8);w=np.zeros(35,dtype=np.uint8);w[23]=1
 assert not mm(pencil(T,z),w.reshape(-1,1)).any()
 H,g0,q0,U,V=reconstruct(z,w);checks=lattice_checks(H,U,V)
 excluded={'description':'Excluded boundary control, NOT a window witness: Hom dimensions (2,2). No stability claim is made.', 'xi':z.tolist(),'z':z.tolist(),'field':'F25','w':w.tolist(),'rank_T':int(rank(pencil(T,z))),'rank_Q':int(rank(pencil(Q,z))),'H':[[encode(p) for p in row] for row in H],'g0':encode(g0),'q0':encode(q0),'U':encode(U),'V':encode(V),'checks':checks}
 (ROOT/'certificates/excluded_boundary_map.json').write_text(json.dumps(excluded,indent=2)+'\n')
 print('f=0 minor determinant:',f0['determinant'])
 print('stable control ranks/minors:',stable['rank_T'],stable['rank_Q'],stable['T_minor']['determinant'],stable['Q_minor']['determinant'])
 print('excluded boundary ranks:',excluded['rank_T'],excluded['rank_Q'],'generic map rank:',checks['generic_rank'])
 print('boundary infinity checks:',checks)
