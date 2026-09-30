"""Reconstruct the scale-independent coefficient a_1 at infinity.
This file is a standalone process: Sparse has four variables (h,w,k0,k1).
"""
import json,time
from pathlib import Path
from ff import *
import cramer
from sparse import Sparse as S,series_mul as sm,series_add as sa,series_pow as sp
ROOT=Path(__file__).resolve().parents[1]

def load_sparse(a):return S({tuple(m):v for m,v in a})
def compute(save=True):
 st=time.time();cramer.N=10;cramer.YP=cramer.ya_series()
 _,G=cramer.graph_source();F=cramer.series_F(G)
 print('F6..9 pre-Cramer term counts',[len(a.d) for a in F[6:10]],flush=True)
 N=4;h=cramer.h
 aa=cramer.expand(G[0],33)[:N];bb=cramer.expand(G[1],46)[:N];cc=cramer.expand(G[2],57)[:N];dd=cramer.expand(G[3],70)[:N]
 assert aa[0]==h and bb[0]==cramer.epsilon
 sig=[S(cramer.epsilon)*h**-1]+[S() for _ in range(N-1)]
 for j in range(1,N):
  res=sa([S(3)*a for a in sm(aa,sp(sig,2,N),N)],[S(2)*a for a in sm(bb,sig,N)],N)
  res=sa(res,[S(),S()]+cc[:2],N)
  sig[j]=S(neg(inv(mul(3,cramer.epsilon))))*res[j]
 chk=sa(sa([S(3)*a for a in sm(aa,sp(sig,2,N),N)],[S(2)*a for a in sm(bb,sig,N)],N),[S(),S()]+cc[:2],N)
 assert all(not x for x in chk)
 LL=sa(sa([S(3)*a for a in sm(aa,sp(sig,3,N),N)],[S(4)*a for a in sm(bb,sp(sig,2,N),N)],N),[S(),S()]+dd[:2],N)
 pref=(S(3)*h)**10*sig[0]**5
 MM=sm(F[6:10],[pref*a for a in LL],N)
 MM[3]=MM[3]+S(9)*MM[0]
 assert MM[0]==S(mul(3,power(cramer.epsilon,8)))*h**3*F[6]
 NN=S(3)*MM[0]**2*MM[3]+MM[1]**3-S(3)*MM[0]*MM[1]*MM[2]
 print('M counts',[len(a.d) for a in MM],'N count',len(NN.d),flush=True)
 src=json.loads((ROOT/'data/source_cramer.json').read_text())
 n0,n1=[load_sparse(a) for a in src['kernel_numerators']];D=load_sparse(src['denominator_d'])
 num,den=cramer.substitute_kernel(NN,n0,n1,D)
 print('Cramer numerator',len(num.d),'D power',den,flush=True)
 # u=h*w^2, q=w^3. Every exponent is a multiple of three after substitution.
 pairs={}
 for (ha,wa,ka,kb),co in num.d.items():
  assert ka==kb==0 and (wa-2*ha)%3==0
  i,j=ha,(wa-2*ha)//3
  pairs[(i,j)]=add(pairs.get((i,j),0),co)
 pairs={k:v for k,v in pairs.items() if v}
 min_u=min(i for i,j in pairs);min_q=min(j for i,j in pairs)
 pairs={(i-min_u,j-min_q):v for (i,j),v in pairs.items()}
 # Remove q-only content. All removed factors must be recorded, not presumed units.
 maxu=max(i for i,j in pairs);maxq=max(j for i,j in pairs)
 rows=[Poly([pairs.get((i,j),0) for j in range(maxq+1)]) for i in range(maxu+1)]
 common=Poly()
 for p in rows:common=common.gcd(p)
 rows=[p//common for p in rows]
 summary={'M0_formula':'3*epsilon^8*h^3*F6','a1_formula':'(3*M0^2*M3+M1^3-3*M0*M1*M2)/M0^3',
 'a1_numerator_q_rows_ascending_u':[a.tolist() for a in rows], 'cleared_Cramer_d_power':den,
 'removed_monomial_exponents_u_q':[min_u,min_q], 'q_content':common.tolist(),
 'status':'symbolic reconstruction; complete exclusion separately verified by verify_a1.py','elapsed_seconds':round(time.time()-st,3)}
 if save:(ROOT/'data/a1_model.json').write_text(json.dumps(summary,indent=2)+'\n')
 print('primitive degrees u,q',len(rows)-1,max(a.degree() for a in rows),'q content degree',common.degree(),flush=True)
 print('q_content',common.tolist(),flush=True)
 return rows,common,summary
if __name__=='__main__':compute()
