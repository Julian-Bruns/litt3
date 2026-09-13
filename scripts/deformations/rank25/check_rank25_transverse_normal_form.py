"""A compact normal form for the separating part of the rank25 covariants.

Uses the previously audited complete nineteen-vector basis. It does not
infer geometric support from point evaluations or replace that basis's
completeness certificate. Run with python3.
"""
import argparse,hashlib,json,sys
from pathlib import Path
import numpy as np
root=Path(__file__).resolve().parents[3]
ap=argparse.ArgumentParser(description='Check the eleven-dimensional transverse normal form of the accepted rank25 covariant space.')
ap.add_argument('--output',type=Path,default=root/'Research/computations/rank25_transverse_normal_form.json')
args=ap.parse_args()
source=root.parent/'litt3-computation-data/rank25-universal-trace-return-20260913-9D6dTa/replay/lib'
sys.path.insert(0,str(source))
import finite_field as F
from locus import P,A,B,q,qi,Ap,Bp,reduce_s
space_path=root/'Research/computations/rank25_fifth_covariant_reconstruction_space.json'
s=json.loads(space_path.read_text())
assert s['invariant_section_dimension']==19 and s['finite_deck_difference_rank']==274
assert len(s['homogeneous_cotangent_root_sections'])==19
def poly(a):return P({tuple(e):c for e,c in a})
def cmatrix(cols):
 keys=sorted(set().union(*(set((i,*e) for i,p in enumerate(c) for e in p.d) for c in cols)))
 ind={k:i for i,k in enumerate(keys)};m=np.zeros((len(keys),len(cols)),dtype=np.uint16)
 for j,c in enumerate(cols):
  for i,p in enumerate(c):
   for e,v in p.d.items():m[ind[i,*e],j]=v
 return m
basis=[[poly(p) for p in c[:2]] for c in s['homogeneous_cotangent_root_sections']]
mat=cmatrix(basis);rank=len(F.rref(mat,False)[1]);print('transverse image dimension',rank,flush=True)
restr=[[P({e:c for e,c in p.d.items() if not e[1] and not e[2]}) for p in col] for col in basis]
restriction_rank=len(F.rref(cmatrix(restr),False)[1])
assert restriction_rank==11
print('whole-curve transverse restriction rank',restriction_rank,flush=True)
allowed=[-2,-1,0,1,2,3]
assert all(not any(e[j] for j in [0,1,2,4,5]) and e[3] in allowed for col in restr for p in col for e in p.d)
C=np.array([[basis[j][i].d.get((0,0,0,-2,0,0),0) for j in [17,18]] for i in range(2)],dtype=np.uint16)
print('q^-2 coefficient matrix',C.tolist())
assert len(F.rref(C,False)[1])==1 and C[0,0]
assert rank==11
new=[]
for j in [17]:
 col=[p*F.inv(int(C[0,0])) for p in basis[j]]
 for a in range(2):
  col[a]=P({e:c for e,c in col[a].d.items() if e[1] or e[2] or e[3]==-2})
 new.append(col)
plain=[]
for degree in [-1,0,1,2,3]:
 for a in range(2):
  col=[P(),P()];col[a]=q**degree if degree>=0 else qi**(-degree);plain.append(col)
assert len(F.rref(cmatrix([*basis,*plain]),False)[1])==rank
assert len(F.rref(cmatrix([*plain,*new]),False)[1])==11
assert len(F.rref(cmatrix([*basis,*plain,*new]),False)[1])==11

def ser(p):return [[list(e),int(c)] for e,c in sorted(p.d.items())]

# Translation quotient in u=(A/q,B/q): Z=u^[5]-M*u.
from locus import H,inv2
L=[[F.ff('0033'),F.ff('3112')],[F.ff('2100'),F.ff('1000')]]
Li=inv2(L)
def mm(M,N):return [[sumfield([F.mul(M[i][r],N[r][j]) for r in range(2)]) for j in range(2)] for i in range(2)]
def sumfield(xs):
 v=0
 for x in xs:v=F.add(v,x)
 return v
M=mm(mm([[int(F.FROB[x]) for x in row] for row in L],H),Li)
u=[A*qi,B*qi]
Z=[u[i]**5-sum((u[j]*int(M[i][j]) for j in range(2)),P()) for i in range(2)]
R=[]
for j,col in enumerate(new):
 rows=[]
 for a,p in enumerate(col):
  leading=int(p.d.get((0,0,0,-2,0,0),0))
  correction=p-qi**2*leading
  co=[p.d.get((0,5,0,-2,0,0),0),p.d.get((0,0,5,-2,0,0),0)]
  assert correction.d==(q**3*sum((Z[i]*int(co[i]) for i in range(2)),P())).d
  rows.append(co)
 R.append(rows)
print('translation M',[[F.fmt(x) for x in row] for row in M])
print('R coefficient columns',[[[F.fmt(x) for x in row] for row in c] for c in R])
out={'status':'exact consequence of existing complete covariant basis; no new geometric support claim','transverse_dimension':rank,'restriction_dimension':restriction_rank,'plain_q_degrees':[-1,0,1,2,3],'exceptional_form':'q^-2*v+q^3*R(Z), Z=(A/q,B/q)^[5]-M*(A/q,B/q)','leading_vector':['1000',F.fmt(new[0][1].d[(0,0,0,-2,0,0)])],'translation_M':[[F.fmt(x) for x in row] for row in M],'exceptional_R_columns':[[[F.fmt(x) for x in row] for row in c] for c in R],'exceptional_columns':[[ser(p) for p in col] for col in new], 'source_sha256':hashlib.sha256(space_path.read_bytes()).hexdigest(), 'source':str(space_path.relative_to(root)), 'finite_detection':'After A=B=0, q^2 times each component has degree at most5; any six distinct nonzero geometric q-values detect the transverse section.', 'normal_form_dimension_check':'The 19 accepted basis projections and the 11 displayed generators span the same dimension11 space. Its restriction also has rank11.'}
args.output.write_text(json.dumps(out,indent=2)+'\n')
