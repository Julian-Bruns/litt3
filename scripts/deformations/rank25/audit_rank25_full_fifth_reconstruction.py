"""Independent Sage checks of the finite fifth reconstruction and separator.

Geometric support and actual point replays are audited separately.
"""
import argparse,hashlib,json
from pathlib import Path
import numpy as np
from sage.all import GF,PolynomialRing,matrix,vector
ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
root=Path(__file__).resolve().parents[3];base=root/'Research/computations'
pt=PolynomialRing(GF(5),'t');tt=pt.gen();k=GF(625,'t',modulus=tt**4+4*tt**3+tt**2+4*tt+3);t=k.gen()
vals=[sum(k(c//5**i%5)*t**i for i in range(4)) for c in range(625)]
def fmt(a):return ''.join(str(int(a.polynomial()[i])) for i in range(4))
def mat(a):return matrix(k,[[vals[int(c)] for c in row] for row in a])
z=np.load(base/'rank25_fifth_covariant_reconstruction_space.npz')
rep=mat(z['representation']);assert rep.rank()==293
diff=mat(z['difference']);null=mat(z['homogeneous_basis'])
assert diff.ncols()==293 and null.rank()==19 and diff*null.transpose()==0
minor=diff.matrix_from_rows_and_columns(list(map(int,z['pivot_rows'])),list(map(int,z['pivot_columns'])))
assert minor.nrows()==minor.ncols()==274
det=minor.det();assert det
aug=mat(z['covariance_augmented']);part=vector(k,[vals[int(c)] for c in z['particular']])
assert aug.nrows()==diff.nrows() and aug[:,:293]==diff and diff*part==aug.column(293)
print('independent ranks, complete kernel and inhomogeneous identity PASS',flush=True)
curve=json.loads((base/'rank25_fifth_curve_reconstruction.json').read_text())
assert curve['restriction_rank']==curve['augmented_rank']==17 and curve['remaining_dimension']==2
assert all(not row[0] and not row[1] for row in curve['remaining_cotangent_root_sections'])
P=PolynomialRing(k,'v');v=P.gen();co=lambda s:vals[sum(int(c)*5**i for i,c in enumerate(s))]
a=co('4442')+co('0220')*v+co('4003')*v**2
b=co('0141')+co('1313')*v+co('1014')*v**2
u=co('2013')+co('3340')*v;w=co('1413')+co('4410')*v
assert u*a+w*b==1
tr=json.loads((base/'rank25_transverse_covariants.json').read_text())
for polys,expected in zip(tr['transverse_components'],[a,b]):
    got=P(0)
    for e,c in polys:
        assert e[0]==e[1]==e[2]==e[4]==e[5]==0 and (e[3]-2)%4==0
        got+=vals[c]*v**((e[3]-2)//4)
    assert got==expected
files=['rank25_fifth_covariant_reconstruction_space.json','rank25_fifth_covariant_reconstruction_space.npz','rank25_fifth_curve_reconstruction.json','rank25_transverse_covariants.json','rank25_ordinary_channel_finite_audit.json','rank25_cotangent_pairing.json']
out={'status':'PASS independent Sage finite reconstruction checks; geometric theorem audited separately',
 'representation_rank':293,'covariance_rank':274,'covariance_minor_determinant':fmt(det),
 'invariant_dimension':19,'audited_curve_constraint_rank':17,'remaining_dimension':2,
 'remaining_sections_have_zero_two_transverse_components':True,
 'transverse_polynomials_in_v':[[fmt(c) for c in p.list()] for p in [a,b]],
 'bezout_polynomials':[[fmt(c) for c in p.list()] for p in [u,w]],
 'identity':'u(v)*a(v)+w(v)*b(v)=1; actual transverse components are q^2*a(q^4),q^2*b(q^4)',
 'sha256':{p:hashlib.sha256((base/p).read_bytes()).hexdigest() for p in files}}
args.output.write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))
