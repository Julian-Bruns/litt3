"""Compare actual regular fifth replays with the covariant reconstruction."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse,json,sys,zipfile
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,vector
ap=argparse.ArgumentParser();ap.add_argument('--family',type=Path,required=True);ap.add_argument('--receipts',type=Path,nargs='+',required=True);ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
root=Path(__file__).resolve().parents[3];sys.path.insert(0,str(root/'scripts'))
from scripts.deformations.rank25.rank25_pro_data_model import unpack
pt=PolynomialRing(GF(5),'t');z=pt.gen();k=GF(625,'t',modulus=z**4+4*z**3+z**2+4*z+3);t=k.gen()
def val(c):
 if isinstance(c,int):c=[c//5**i%5 for i in range(4)]
 return sum(k(a)*t**i for i,a in enumerate(c))
def code(c):return int(sum(int(c.polynomial()[i])*5**i for i in range(4)))
def fmt(c):return ''.join(str(int(c.polynomial()[i])) for i in range(4))
with zipfile.ZipFile(root/'Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip') as zz:d=unpack(json.loads(zz.read('data.json')))
N=matrix(k,[list(map(val,r)) for r in d['kernel_basis']]).transpose();lam=matrix(k,[list(map(val,r)) for r in d['obstruction_dual_rows']])
family=json.loads(args.family.read_text());reports=[];mats=[];rhs=[]
for path in args.receipts:
 rec=json.loads(path.read_text());C=vector(k,map(val,rec['E5']))
 assert C==vector(k,map(val,rec['riccati_E5'])) and C==lam*vector(k,map(val,rec['rho5_coordinates']))
 x=N.solve_right(vector(k,map(val,rec['third_digit']))-vector(k,map(val,d['primary_repair'])))
 a,b,q=x[3]-val([3,0,0,3]),x[4]-val([0,3,1,4]),x[6]
 assert q and not C[0]
 def ev(pol):
  out=k(0)
  for e,c in pol:
   assert e[0]==e[4]==e[5]==0
   out+=val(c)*a**e[1]*b**e[2]*q**e[3]
  return out
 rows=matrix(k,[[ev(p) for p in rr] for rr in family['root_cotangent_rows']])
 omega=rows.apply_map(lambda c:c**5)*C
 want=vector(k,[q**2*(val([4,4,4,2])+val([0,2,2,0])*q**4+val([4,0,0,3])*q**8),q**2*(val([0,1,4,1])+val([1,3,1,3])*q**4+val([1,0,1,4])*q**8)])
 assert omega[:2]==want,('transverse prediction failed',str(path),list(map(fmt,omega[:2])),list(map(fmt,want)))
 normal=vector(k,map(ev,family['known_nonFrobenius_normal_part']))
 target=rows*(C-normal).apply_map(lambda c:c**125)
 part=vector(k,map(ev,family['particular_cotangent_root_section']))
 mat=matrix(k,[[ev(p) for p in col] for col in family['remaining_cotangent_root_sections']]).transpose()
 mats+=list(mat);rhs+=list(target-part)
 reports.append({'path':str(path),'chart':[fmt(c) for c in [a,b,q]],'actual_transverse':[fmt(c) for c in omega[:2]],'predicted_transverse':[fmt(c) for c in want],'rho_precision':rec['rho5_certified_laurent_precision']})
M=matrix(k,mats);r=vector(k,rhs);rank=M.rank();aug=M.augment(r).rank()
assert rank==aug,('third-component constant fit failed',rank,aug)
out={'status':'PASS actual off-curve regular/Riccati replays match transverse predictions','points':reports,'remaining_fit_rank':int(rank),'remaining_fit_augmented_rank':int(aug)}
if rank==M.ncols():
 sol=M.solve_right(r);out['remaining_constants']=[code(c) for c in sol]
 out['remaining_constants_readable']=[fmt(c) for c in sol]
args.output.write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))
