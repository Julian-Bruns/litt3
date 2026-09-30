"""Independent polynomial/rank checks of the geometric partial certificates."""
from pathlib import Path
import json,itertools
from ffpoly import *
from compute import mono,mul,bas0,bas1,vec,e,P,power,kernel
from negative_quotient import build_negative
DATA=Path(__file__).resolve().parents[1]/'data'
NEG_PARTS=[([0,1,2,7,8,9,10,11],[0,6,7]),([12,13,14,15,16,17,18,19,20,21,22],[1,2,3,4,5,8,9,10,11,12]),([3,4,5,6],[13,14,15,16,17,18])]
ZERO_PARTS=[([0,5,6,7,8,9,10],[0,6,7]),([11,12,13,14,15,16,17,18,19,20],[1,2,3,4,5,8,9,10,11,12]),([1,2,3,4],[13,14,15,16,17,18])]

def check_minors(C,cert):
 total=[]
 for m,b in zip(cert['minors'],cert['bezout']):
  p=pencilminor(C,m['rows'],m['cols']);assert p==m['poly']
  total=pa(total,pm(b,p))
 assert total==cert['gcd']
 assert len(rref(C[1])[1])==cert['rank_infinity']

def compare_npz(expected,actual):
 assert set(expected.files)==set(actual), (set(expected.files),set(actual))
 for name in actual:assert np.array_equal(expected[name],actual[name]),name

def verify_first(rebuild=True):
 J=json.loads((DATA/'first_classification.json').read_text())
 if rebuild:
  for q,d,fn in [(5,-1,'negative_first.npz'),(5,0,'first_line_d0.npz'),(25,-1,'negative_second.npz')]:
   A,B,Q,S,L=build_negative(q,d)
   compare_npz(np.load(DATA/fn),dict(A=A,B=B,Q=Q,S=S,L=L))
   print('First/second line-morphism matrix rebuilt:',q,d,'PASS',flush=True)
 C=np.load(DATA/'negative_first.npz')['Q'].transpose(2,1,0)
 for j,(rr,cc) in enumerate(NEG_PARTS):
  b=C[:,rr][:,:,cc];check_minors(b,J['negative_block_'+str(j)])
  assert J['negative_block_'+str(j)]['gcd']==[1]
 # The graph really has only these three blocks.
 support=np.zeros(C.shape[1:],bool)
 for rr,cc in NEG_PARTS:support[np.ix_(rr,cc)]=True
 assert not C[:,~support].any()
 S=C[:,NEG_PARTS[2][0]][:,:,NEG_PARTS[2][1]]
 K=np.array(J['scroll_kernel'],np.uint8)
 for d in [0,1,2]:
  A=np.zeros((4*(d+2),6*(d+1)),np.uint8)
  for i in range(d+1):A[4*i:4*i+4,6*i:6*i+6]=S[0];A[4*(i+1):4*(i+1)+4,6*i:6*i+6]=S[1]
  Ker=kernel(A);assert Ker.shape[1]==([0,0,2][d])
  if d==2:assert np.array_equal(K,Ker)
 M=K.reshape(3,6,2).transpose(1,2,0).reshape(6,6)
 assert M.tolist()==J['scroll_coefficient_matrix'];assert len(rref(M)[1])==6
 assert len(rref(C.reshape(-1,19))[1])==19
 print('Negative-line locus: three all-geometric block certificates, quadratic syzygies, invertible scroll coordinates: PASS',flush=True)
 C0=np.load(DATA/'first_line_d0.npz')['Q'].transpose(2,1,0)
 for j,(rr,cc) in enumerate(ZERO_PARTS[:2]):check_minors(C0[:,rr][:,:,cc],J['zero_block_'+str(j)])
 assert np.array_equal(C0[:,ZERO_PARTS[2][0]][:,:,ZERO_PARTS[2][1]],S)
 support=np.zeros(C0.shape[1:],bool)
 for rr,cc in ZERO_PARTS:support[np.ix_(rr,cc)]=True
 assert not C0[:,~support].any()
 B0=C0[:,ZERO_PARTS[1][0]][:,:,ZERO_PARTS[1][1]]
 check_minors(B0,J['zero_block_1_rank9']);assert J['zero_block_1_rank9']['gcd']==[1]
 delta=J['zero_block_1']['gcd'];g3=[19,22,12,1];g4=[19,0,6,6,1]
 assert delta==pm([0,0,1],pm([int(NEG[24]),1],pm(g3,g4)))
 assert pg(g3,pa(pp([0,1],25,g3),[0,4]))==[1]
 assert pg(g4,pa(pp([0,1],625,g4),[0,4]))==[1]
 assert pg(g3,g4)==[1];assert pg(pm(g3,g4),deriv(pm(g3,g4)))==[1]
 assert all(pe(g,r)!=0 for g in [g3,g4] for r in [0,24])
 assert J['zero_block_0']['gcd']==[0,1]
 for r,d in [(0,4),(24,3)]:
  k=kernel(ADD[C0[0],MUL[r,C0[1]]]);assert k.shape==(19,d)
  assert k.tolist()==J['zero_special_kernels'][str(r)]
 assert len(rref(C0.reshape(-1,19))[1])==19
 print('Zero-line locus: quartic scroll, one P3, eight P2s (1 rational, 3 cubic-conjugate, 4 quartic-conjugate): PASS',flush=True)
 return J

def verify_scroll_stability():
 J=json.loads((DATA/'scroll_stability.json').read_text());D=json.loads((DATA/'stability_sections.json').read_text());C=json.loads((DATA/'first_classification.json').read_text())
 p5=np.array([pp([i],5)[0] if i else 0 for i in range(25)],np.uint8)
 M=np.array(J['coefficient_matrix_xi'],np.uint8);Mi=np.array(J['inverse_matrix_xi'],np.uint8)
 assert np.array_equal(M,p5[np.array(C['scroll_coefficient_matrix'],np.uint8)])
 from compute import matmul
 assert np.array_equal(matmul(M,Mi),np.eye(6,dtype=np.uint8))
 # Exact identification of the stability-boundary intersection with the six-coordinate plane.
 sec=D['dual_sections'];assert sec[5]['a_U']==[[0,0,1]] and not sec[5]['b_U']
 assert sec[12]['b_U']==[[0,1,1]]
 for a in sec[:13]:assert all(j>0 for i,j,c in a['b_U'])
 infinity=np.array(D['infinity_fiber'],np.uint8)
 assert len(rref(infinity[:,:13])[1])==2 and not infinity[:,13:].any()
 b=[]
 for s in sec[13:]:
  p=[]
  for i,j,c in s['b_U']:assert j==0;p=pa(p,[0]*i+[c])
  b.append(p)
 assert b==J['branch_b'];z=[]
 for row in Mi:
  p=[]
  for c,bb in zip(row,b):p=pa(p,ps(int(c),bb))
  z.append(p)
 assert z==J['transformed_branch_b']
 U=[0,1,3,4];V=[1,2,4,5]
 quads=[pa(pm(z[U[a]],z[V[c]]),pn(pm(z[U[c]],z[V[a]]))) for a,c in itertools.combinations(range(4),2)]
 assert quads==J['pulled_back_scroll_quadrics']
 pp0=[11,22,18,5,19,20,15,16,9,22,1]
 assert J['bezout_polynomials'][0]==pp0
 assert J['bezout_polynomials'][1:]==quads[:len(J['bezout_polynomials'])-1]
 total=[]
 for f,g in zip(J['bezout_polynomials'],J['bezout_coefficients']):total=pa(total,pm(f,g))
 assert total==[1] and J['gcd_with_P']==[1]
 q1=np.array([24,2,10,11,1,0],np.uint8);q2=np.array([14,5,13,12,0,1],np.uint8)
 assert len(rref(np.column_stack([M[:,0],M[:,3],q1,q2]))[1])==2
 # H0(K(5O)) has dimension two: four independent constraints on the five b-monomials.
 cb=np.column_stack([vec(mul(e,mono(*m)),bas1(0)) for m in bas0(11)])
 assert cb.shape[1]==5 and len(rref(cb)[1])==4
 print('Entire scroll is outside Sigma, including infinity; polynomial Bezout stability certificate: PASS',flush=True)
 print('H0(K(5O))=2; the four explicit sections give H0(R_xi(5O))=4 on the pure last-six-coordinate plane: PASS',flush=True)
