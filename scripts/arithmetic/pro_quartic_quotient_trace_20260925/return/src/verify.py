"""Reproducible exact checks. This is NOT an emptiness or existence certificate."""
from pathlib import Path
import argparse,json,time,sys,numpy as np
from exact import *
from lift import *
import atlas
from finite_field import F25,F25Extension
from geometric_stability import check_stability
ROOT=Path(__file__).resolve().parents[1]
parser=argparse.ArgumentParser();parser.add_argument('--lift-range',nargs=2,type=int);parser.add_argument('--rebuild-core',action='store_true');args=parser.parse_args()
t=time.monotonic()
def log(s):print(f'{time.monotonic()-t:.3f}s PASS {s}',flush=True)
D=np.load(ROOT/'data/matrices.npz');parts=[np.load(ROOT/f'data/lift_part_{j:02d}.npz') for j in range(19)];common=np.load(ROOT/'data/lift_common.npz')
if args.lift_range:
 start,end=args.lift_range
 for j in range(start,end):
  C=parts[j]['C'];top=parts[j]['top'];lo=parts[j]['lo'];z=np.zeros(19,dtype=np.uint8);z[j]=1
  for k in range(35):
   m=np.zeros(35,dtype=np.uint8);m[k]=1
   U,V,phi,res=recover_lower(D,z,m)
   assert np.array_equal(lo[:,k],np.array([evalp(p,*POINT) for p in (phi[1],phi[2],phi[4],phi[5])],dtype=np.uint8))
   for l,(u,v) in enumerate(COORDS):
    obs,row=top_column(D,U,V,phi,u,v)
    assert np.array_equal(C[l,:,k],obs)
    assert np.array_equal(top[l,:,k],np.array([evalp(p,*POINT) for p in row[1:]],dtype=np.uint8))
  log(f'all 665 target/free columns for source coordinate {j}, including determinant-evaluation recovery')
 print('COMPLETED coefficient range',start,end,'No geometric nonemptiness conclusion.');sys.exit(0)

# All field laws (associativity and distributivity), not random arithmetic.
for a in range(25):
 for b in range(25):
  assert np.array_equal(MUL[MUL[a,b],np.arange(25)],MUL[a,MUL[b,np.arange(25)]])
  assert np.array_equal(MUL[a,ADD[b,np.arange(25)]],ADD[MUL[a,b],MUL[a,np.arange(25)]])
for a in range(1,25):assert MUL[a,INV[a]]==1
assert MUL[5,5]==8
log('F25 field laws and specified beta relation')
rng=np.random.default_rng(913721)
for rep in range(100):
 p={(int(rng.integers(-20,20)),int(rng.integers(0,3))):int(rng.integers(1,25)) for _ in range(40)}
 q={(int(rng.integers(-20,20)),int(rng.integers(0,3))):int(rng.integers(1,25)) for _ in range(40)}
 import exact
 assert mul_dense(p,q)==exact._mul_sparse(p,q)
log('100 dense/sparse Laurent multiplication comparisons')
assert D['T'].shape==(19,80,35) and D['Q'].shape==(19,43,16) and D['S'].shape==(19,32,11)
assert not np.any(dot(D['CT'],D['Ac'])) and np.array_equal(dot(D['RT'],D['Ac']),np.eye(235,dtype=np.uint8))
assert not np.any(dot(D['CQ'],D['Aq'])) and np.array_equal(dot(D['RQ'],D['Aq']),np.eye(116,dtype=np.uint8))
for j in range(19):assert np.array_equal(dot(D['CT'],D['RawT'][j]),D['T'][j])
log('constant ranks 235 and 116; elimination and all 19 T coefficient compressions')
W=[]
for col in D['Wb'].T:
 b=poly(col,L(151));assert not np.any(vec(mul(E,b),forbidden(-124)));W.append((plus(mul(E,b)),b))
b=poly(D['sstar_b'],L(142));a=plus(mul(E,b));assert b[(44,1)]==1 and not np.any(vec(mul(E,b),forbidden(-133)))
js=[sub(mul(a,bb),mul(b,aa)) for aa,bb in W]
assert all(not any(i<0 or 3*i+10*j>18 for i,j in p) for p in js)
J=np.column_stack([vec(p,L(18)) for p in js]);assert np.array_equal(J,D['J']) and rank(J)==7
vr=[[1,0,0,0,17,2,1],[0,1,0,0,22,21,22],[0,0,1,0,13,18,23],[0,0,0,1,16,1,15]]
VD=np.column_stack([vec({(i,0):c for i,c in enumerate(row) if c},L(18)) for row in vr]+[vec({(i,1):1},L(18)) for i in range(3)])
assert rank(np.column_stack([J,VD]))==7
for j,(U,V) in enumerate(UV25):
 assert np.array_equal(D['S'][j],np.column_stack([vec(add(mul(U,a),mul(V,b)),forbidden(-24)) for a,b in W]))
log('W, normalized s_star, exact V18 image, and all S entries')
assert evalp(P,*POINT)==int(MUL[MUL[POINT[1],POINT[1]],POINT[1]])
log('regular finite determinant-evaluation point (F25 codes 5,14) lies on X')
for k,(f,a) in enumerate(FREE):
 assert np.array_equal(common['AF'][:,k],np.array([evalp(p,*POINT) for p in (a,f)],dtype=np.uint8))
 for l,(u,v) in enumerate(COORDS):assert common['N0'][l,k]==evalp(plus(add(mul(u,a),mul(v,f))),*POINT)
for j,(U,V) in enumerate(UV25):
 for k,mon in enumerate(NB):
  obs,row=top_column(D,U,V,({},{},{},{},{},{}),{},{},s0={mon:1})
  assert np.array_equal(obs,D['Q'][j,:,k])
  assert np.array_equal(common['TOPS'][j,:,k],np.array([evalp(p,*POINT) for p in row[1:]],dtype=np.uint8))
  assert common['NS'][k]==evalp({mon:1},*POINT)
log('ALL common top-row and determinant-evaluation tensor coefficients')
# Compare assembled universal tensors with direct Laurent formulas at eight arbitrary values.
F=F25()
for trial in range(8):
 z=rng.integers(0,25,19,dtype=np.uint8);m=rng.integers(0,25,35,dtype=np.uint8)
 eta=rng.integers(0,25,19,dtype=np.uint8);s=rng.integers(0,25,16,dtype=np.uint8)
 U,V,phi,res=recover_lower(D,z,m)
 u=linear_combination(eta,[u for u,v in COORDS]);v=linear_combination(eta,[v for u,v in COORDS])
 obs,top=top_column(D,U,V,phi,u,v,poly(s,NB))
 A,N,info=atlas.assemble(D,parts,common,[int(c) for c in z],[int(c) for c in m],F)
 coeff=np.concatenate([eta,s]);assert np.array_equal(dot(np.array(A,dtype=np.uint8),coeff),obs)
 cf=cofactor(phi);det_at_point=0
 for p,q in zip(top,cf):det_at_point=int(ADD[det_at_point,MUL[evalp(p,*POINT),evalp(q,*POINT)]])
 assert int(dot(np.array([N[-1]],dtype=np.uint8),coeff)[0])==det_at_point
log('8 full 19-coordinate tensor/expanded-Laurent identities (not asserted global maps)')
st=np.load(ROOT/'data/stability.npz');assert np.array_equal(dot(st['pairing'],st['pairing_inverse']),np.eye(19,dtype=np.uint8))
assert rank(st['infinity_fiber'])==2
for xi in st['infinity_fiber']:
 assert not check_stability([int(c) for c in xi],F)['stable']
log('specified 19-coordinate Serre duality and infinity-fiber stability checks')
F2=F25Extension([20,0,1]);assert F2.power(25,25)==100 and F2.power(25,25)!=25
for a in range(1,625):assert F2.mul(a,F2.inv(a))==1
example=json.load(open(ROOT/'data/example_F625.json'));got=atlas.check_parameter(example['xi'],F2,True)
assert got['source_stability']['stable'] and got['T_rank']==35 and not got['nonsplit_actual_quotient']
log('F625 field, all inverses, nontrivial coefficient Frobenius, and complete geometric stability of the supplied negative example')
if args.rebuild_core:
 Ac=np.column_stack([raw_quotient({},{},{},{},g0={m:1}) for m in GB]+[raw_quotient({},{},{},{},q0={m:1}) for m in QB])
 assert np.array_equal(Ac,D['Ac'])
 for j,(U,V) in enumerate(UV25):
  raw=np.column_stack([raw_quotient(U,V,f,a) for f,a in FREE]);assert np.array_equal(raw,D['RawT'][j])
  qraw=np.column_stack([neg_residual(U,V,{m:1}) for m in NB]);assert np.array_equal(dot(D['CQ'],qraw),D['Q'][j])
 log('ALL raw T columns and all Q entries rebuilt from the Laurent reconstruction')
print('COMPLETED verification. Geometric actual-quotient nonemptiness and stable fixed-point decision remain OPEN.',flush=True)
