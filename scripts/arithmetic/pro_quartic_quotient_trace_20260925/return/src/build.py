from exact import *
from pathlib import Path
import time,json
ROOT=Path(__file__).resolve().parents[1]
t=time.monotonic()
def log(*a):print(f'{time.monotonic()-t:.2f}s',*a,flush=True)
assert len(FB)+len(AB)==35
assert (len(GB),len(QB),len(RAWB),len(RAWD))==(123,112,152,163)
log('construct quotient constant matrix')
Ac=np.column_stack([raw_quotient({},{},{},{},g0={m:1}) for m in GB]+[raw_quotient({},{},{},{},q0={m:1}) for m in QB])
log('eliminate',Ac.shape)
CT,RT=eliminate(Ac)
log('constant rank',Ac.shape[1])
T=[];RawT=[]
for j,(U,V) in enumerate(UV25):
 raw=np.column_stack([raw_quotient(U,V,f,a) for f,a in FREE])
 RawT.append(raw);T.append(dot(CT,raw));log('T coordinate',j)
Aq=np.column_stack([vec(mul(E,{m:1}),RAWQ) for m in A0B])
CQ,RQ=eliminate(Aq);log('Q constant rank',Aq.shape[1])
Q=[]
for j,(U,V) in enumerate(UV25):
 raw=np.column_stack([neg_residual(U,V,{m:1}) for m in NB]);Q.append(dot(CQ,raw))
log('construct W, s_star')
wm=L(151);cw=np.column_stack([vec(mul(E,{m:1}),forbidden(-124)) for m in wm]);kw=kernel(cw)
W=[]
for j in range(kw.shape[1]):
 b=poly(kw[:,j],wm);a=plus(mul(E,b));W.append((a,b))
assert len(W)==11
# The established positive presentation replaces the section-kernel census.
sm=L(142)
BPOS=[13,12,9,11,19,18,1,17,23,12,8,10,9,13,8,
      0,9,10,4,23,24,24,2,2,12,0,19,14,1,24,
      8,5,6,7,17,18,18,21,8,11,13,5,20,14,1]
b={(i,1):c for i,c in enumerate(BPOS) if c}
a=plus(mul(E,b));sstar=(a,b)
J=np.column_stack([vec(sub(mul(a,bb),mul(b,aa)),L(18)) for aa,bb in W]);assert rank(J)==7
S=[]
for U,V in UV25:S.append(np.column_stack([vec(add(mul(U,a),mul(V,b)),forbidden(-24)) for a,b in W]))
np.savez_compressed(ROOT/'data/matrices.npz',Ac=Ac,CT=CT,RT=RT,RawT=np.array(RawT),T=np.array(T),Aq=Aq,CQ=CQ,RQ=RQ,Q=np.array(Q),Wb=kw,J=J,S=np.array(S),sstar_b=vec(sstar[1],sm))
log('saved matrices',np.array(T).shape,np.array(Q).shape,np.array(S).shape)
json.dump({'shapes':{'T':list(np.array(T).shape),'Q':list(np.array(Q).shape),'S':list(np.array(S).shape)},'W_dimension':len(W),'J_rank':rank(J),'elapsed_seconds':time.monotonic()-t},open(ROOT/'data/build_summary.json','w'),indent=2)
