"""Evaluate the exact actual-quotient atlas over F25 or a finite extension.
No bounded search is an emptiness proof. Parameter coefficients are raised to 25.
"""
from pathlib import Path
import numpy as np,json,argparse
from finite_field import F25,F25Extension,rank,kernel,normalize
from geometric_stability import check_stability
ROOT=Path(__file__).resolve().parents[1]

def tensor_eval(tensor,coeff,F):
 n,m=tensor.shape[1:];out=[[0]*m for _ in range(n)]
 for j,a in enumerate(coeff):
  if a:
   for i,k in zip(*np.nonzero(tensor[j])):
    i=int(i);k=int(k);out[i][k]=F.add(out[i][k],F.mul(a,int(tensor[j,i,k])))
 return out

def bilinear(C,z,m,F):
 # C[source,target,row,free]
 out=[[0]*C.shape[1] for _ in range(C.shape[2])]
 for j,a in enumerate(z):
  if not a:continue
  for l,b in enumerate(m):
   if not b:continue
   c=F.mul(a,b)
   for target,row in zip(*np.nonzero(C[j,:,:,l])):
    target=int(target);row=int(row)
    out[row][target]=F.add(out[row][target],F.mul(c,int(C[j,target,row,l])))
 return out

def dot(a,b,F):
 s=0
 for x,y in zip(a,b):
  if x and y:s=F.add(s,F.mul(x,y))
 return s

def assemble(D,parts,common,z,m,F):
 C=np.stack([p['C'] for p in parts]);Y=bilinear(C,z,m,F)
 Q=tensor_eval(D['Q'],z,F)
 A=[a+b for a,b in zip(Y,Q)]
 low=np.stack([p['lo'] for p in parts]);lo=tensor_eval(low,z,F)
 q,r,g,h=[dot(row,m,F) for row in lo]
 a,f=[dot([int(c) for c in row],m,F) for row in common['AF']]
 cf=[F.sub(F.mul(q,h),F.mul(r,g)),F.sub(F.mul(r,f),F.mul(a,h)),F.sub(F.mul(a,g),F.mul(q,f))]
 top=np.stack([p['top'] for p in parts]);tn=bilinear(top,z,m,F) # 2 rows x19
 nell=[dot([int(c) for c in row],m,F) for row in common['N0']]
 sell=tensor_eval(common['TOPS'],z,F)
 ell=[]
 for i in range(19):ell.append(dot(cf,[nell[i],tn[0][i],tn[1][i]],F))
 for i in range(16):ell.append(dot(cf,[int(common['NS'][i]),sell[0][i],sell[1][i]],F))
 return A,A+[ell],{'cofactor_at_evaluation_point':cf,'point':[int(c) for c in common['point']]}

def check_parameter(xi,F=None,stability=False):
 F=F or F25()
 if len(xi)!=19 or not any(xi):raise ValueError('Need a nonzero 19-vector')
 if any(not 0<=int(c)<F.order for c in xi):raise ValueError('A parameter field code is out of range')
 xi=normalize(xi,F);z=[F.power(a,25) for a in xi]
 D=np.load(ROOT/'data/matrices.npz');out={'xi':xi,'xi_to_25':z,'field_order':F.order,'outside_P_C':any(xi[:13])}
 if stability:
  out['source_stability']=check_stability(xi,F)
  out['stable_fixed_return']=False
 T=tensor_eval(D['T'],z,F);Q=tensor_eval(D['Q'],z,F);S=tensor_eval(D['S'],z,F)
 out.update(T_rank=rank(T,F),Q_rank=rank(Q,F),S_rank=rank(S,F))
 if out['T_rank']!=34 or out['Q_rank']!=16:
  out['nonsplit_actual_quotient']=False
  out['reason']='Fails a necessary rank supplied in the problem.'
  return out
 m=kernel(T,F)[0]
 parts=[np.load(ROOT/f'data/lift_part_{j:02d}.npz') for j in range(19)];common=np.load(ROOT/'data/lift_common.npz')
 A,N,info=assemble(D,parts,common,z,m,F);ra,rn=rank(A,F),rank(N,F)
 out.update(A_phi_rank=ra,N_phi_rank=rn,free_lower_map=m,**info)
 out['nonsplit_actual_quotient']=(ra==34 and rn==35)
 if out['nonsplit_actual_quotient']:
  v=kernel(A,F)[0];eta=normalize(v[:19],F)
  out['eta']=eta;out['fixed_in_projective_coordinates']=(eta==xi)
  out['determinant_of_recovered_lift']=dot(N[-1],v,F)
  if stability:
   out['target_stability']=check_stability(eta,F)
   out['stable_fixed_return']=bool(out['fixed_in_projective_coordinates'] and out['source_stability']['stable'])
 else:out['reason']='Fails the torsion-sensitive actual-quotient criterion proved in REPORT.md.'
 return out

if __name__=='__main__':
 parser=argparse.ArgumentParser();parser.add_argument('input');parser.add_argument('--stability',action='store_true');args=parser.parse_args()
 inp=json.load(open(args.input));F=F25Extension(inp['modulus']) if inp.get('modulus') else F25()
 print(json.dumps(check_parameter(inp['xi'],F,args.stability),indent=2))
