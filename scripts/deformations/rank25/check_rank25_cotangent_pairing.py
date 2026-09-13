"""Check the exact deck pairing needed for cotangent reconstruction."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse,json,math,sys,zipfile
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,vector
ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
root=Path(__file__).resolve().parents[3];sys.path.insert(0,str(root/'scripts'))
from scripts.deformations.rank25.rank25_pro_data_model import unpack
pt=PolynomialRing(GF(5),'t');tt=pt.gen();k=GF(625,'t',modulus=tt**4+4*tt**3+tt**2+4*tt+3);t=k.gen()
def val(c):return sum(k(a)*t**i for i,a in enumerate(c))
def fmt(c):return ''.join(str(int(c.polynomial()[i])) for i in range(4))
with zipfile.ZipFile(root/'Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip') as z:d=unpack(json.loads(z.read('data.json')))
N=matrix(k,[list(map(val,r)) for r in d['kernel_basis']]).transpose()
lam=matrix(k,[list(map(val,r)) for r in d['obstruction_dual_rows']])
P=matrix(k,[list(map(val,r)) for r in json.loads((root/'Research/computations/rank25_generalization_leverage.json').read_text())['constant_gradient_test']['exact_pairing']])
H=matrix(k,[list(map(val,r)) for r in d['additive_matrix']])
pol=PolynomialRing(k,2,names=('s','v'));s,v=pol.gens();I=pol.ideal(s**5-H[0,0]*s-H[0,1]*v,v**5-H[1,0]*s-H[1,1]*v)
red=lambda x:I.reduce(x)
T=matrix(pol,75)
for i in range(5):
 for j in range(5):
  for r in range(i+1):
   for a in range(j+1):
    c=pol(math.comb(i,r)*math.comb(j,a))*s**(i-r)*v**(j-a)
    for u in range(3):T[3*(5*r+a)+u,3*(5*i+j)+u]=c
nr=N.transpose().pivots();lc=lam.pivots()
Sinv=N.matrix_from_rows(nr).inverse();Linv=lam.matrix_from_columns(lc).inverse()
SN=T*N;SS=Sinv*SN.matrix_from_rows(nr)
assert N*SS==SN
TT=lam*T;TO=TT.matrix_from_columns(lc)*Linv
assert TO*lam==TT
checks={}
for name,ss,pp,to in [
 ('Frobenius_source_P_target',SS.apply_map(lambda x:red(x**5)),P,TO),
 ('ordinary_source_P_target',SS,P,TO),
 ('ordinary_source_inversePhiP_target',SS,P.apply_map(lambda x:x**125),TO)]:
 test=(ss.transpose()*pp*to-pp).apply_map(red)
 checks[name]=not bool(test)
 print(name,checks[name],flush=True)
out={'status':'exact finite deck pairing audit','checks':checks,'source_action_max_degree':int(max(p.total_degree() for p in SS.list())),'target_action_max_degree':int(max(p.total_degree() for p in TO.list()))}
if checks['Frobenius_source_P_target']:
 out['consequence']='After coefficientwise fifth-root transport, the obstruction quotient pairs equivariantly with the tangent space; cotangent covariance is justified.'
else:out['consequence']='Do not use the proposed cotangent covariance without a different verified pairing.'
def serialmat(M):return [[[{'exponents':list(map(int,e)),'coefficient':fmt(c)} for e,c in p.dict().items()] for p in row] for row in M]
out['source_deck_action']=serialmat(SS);out['target_deck_action']=serialmat(TO)
args.output.write_text(json.dumps(out,indent=2)+'\n')
