"""Independent finite checks of newly computed regular-frame channels.

Run with sage -python. This checks fourth-level reductions and one known
fifth coefficient. It does not certify a full-family support assertion.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse,json,sys,zipfile
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,vector

ap=argparse.ArgumentParser();ap.add_argument('--first',type=Path,required=True)
ap.add_argument('--second',type=Path);ap.add_argument('--output',type=Path,required=True)
args=ap.parse_args();root=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(root/'scripts'))
from scripts.deformations.rank25.rank25_pro_data_model import unpack
P=PolynomialRing(GF(5),'T');T=P.gen()
k=GF(625,'t',modulus=T**4+4*T**3+T**2+4*T+3);t=k.gen()
def val(c):
    if isinstance(c,int):c=[c//5**i%5 for i in range(4)]
    return sum(k(a)*t**i for i,a in enumerate(c))
def fmt(c):return ''.join(str(int(c.polynomial()[i])) for i in range(4))
def vv(c):return vector(k,map(val,c))
with zipfile.ZipFile(root/'Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip') as z:
    data=unpack(json.loads(z.read('data.json')));fourth=unpack(json.loads(z.read('fourth.json')))
a=json.loads(args.first.read_text());N=matrix(k,[list(vv(v)) for v in data['kernel_basis']]).transpose()
offset=N.solve_right(vv(a['origin_vector'])-vv(data['primary_repair']))
assert N*offset==vv(a['origin_vector'])-vv(data['primary_repair'])
y=offset.apply_map(lambda c:c**5)
F=fourth['obstruction'];J=matrix(k,list(zip(*[list(vv(v)) for v in F['frobenius']])))
quad={}
for i,j,col in F['quadratic']:
    v=vv(col);quad[i,j]=v;J[:,i]+=matrix(k,9,1,v*y[j]);J[:,j]+=matrix(k,9,1,v*y[i])
lin=a['moving_fourth_normal']['linear'];qs=a['moving_fourth_normal']['quadratic']
assert all(vv(v['projection'])==J.column(i) for i,v in enumerate(lin))
assert all(vv(v['projection'])==quad.get((v['i'],v['j']),vector(k,9)) for v in qs)
same=None
if args.second:
    b=json.loads(args.second.read_text())
    assert a['origin_vector']==b['origin_vector']
    assert all(v['projection']==w['projection'] and v['direct_fourth_projection']==w['direct_fourth_projection'] for v,w in zip(lin,b['moving_fourth_normal']['linear']))
    assert all(v['projection']==w['projection'] and v['direct_fourth_projection']==w['direct_fourth_projection'] for v,w in zip(qs,b['moving_fourth_normal']['quadratic']))
    assert all(a['directions'][str(i)]['constant_projection']==b['directions'][str(i)]['constant_projection'] and
      all(v['projection']==w['projection'] for v,w in zip(a['directions'][str(i)]['mixed_first_directions'],b['directions'][str(i)]['mixed_first_directions'])) for i in range(7))
    same=True
# Curve x-origin=lambda^-10 nu0 +lambda^5*(3112 nu5+nu6).
# The lambda^5 coefficient combines ordinary channels and the linear
# projection of the unfrobenized fourth curve digit in this same gauge.
kap=val([3,1,1,2]);om=vector(k,[0,0,0,-2,1,0,0,-val([4,0,1,4]),-val([0,3,2,0])])
gamma=vector(k,9)
for i,c in [(5,kap),(6,k(1))]:
    gamma+=c*(vv(a['directions'][str(i)]['constant_projection'])+vv(lin[i]['direct_fourth_projection']))
assert om*gamma==val([1,1,0,1]),('known lambda^5 mismatch',fmt(om*gamma))
out={'status':'PASS finite checks; not a full fifth-family theorem',
 'origin_actual_coordinates':[fmt(c) for c in offset],
 'all_7_fourth_linear_projections_match_J':True,'all_28_fourth_quadratic_projections_match':True,
 'increased_precision_changed_Frobenius_projected_agreement':same,
 'known_curve_lambda5_coefficient':fmt(om*gamma),'lambda5_full_projection':[fmt(c) for c in gamma]}
args.output.write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))
