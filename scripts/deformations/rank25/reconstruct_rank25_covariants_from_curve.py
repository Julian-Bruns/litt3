"""Exact restrictions of bounded covariants to the audited 30-point curve.

This is reconstruction in a proved/proposed finite support space, not
interpolation of an unrestricted geometric family.
"""
import argparse,json
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,vector
ap=argparse.ArgumentParser();ap.add_argument('--space',type=Path,required=True);ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
root=Path(__file__).resolve().parents[3]
pt=PolynomialRing(GF(5),'t');tt=pt.gen();k=GF(625,'t',modulus=tt**4+4*tt**3+tt**2+4*tt+3);t=k.gen()
def val(c):return sum(k(c//5**i%5)*t**i for i in range(4))
def code(c):return sum(int(c.polynomial()[i])*5**i for i in range(4))
P=PolynomialRing(k,'l');l=P.gen()
curve=json.loads((root/'Research/computations/rank25_one_parameter_full_exclusion.json').read_text())
G=P(list(map(val,curve['G_monic'])));Q=P.quotient(G,'z');z=Q.gen();n=G.degree()
def cv(a):return vector(k,list(Q(a).lift())+[k(0)]*(n-len(list(Q(a).lift()))))
fm=matrix(k,[cv(z**(5*i)) for i in range(n)]).transpose();fi=fm.inverse()
def froot(a):
    b=fi*cv(a);r=Q(list(c**125 for c in b));assert r**5==a
    return r
def ev(pol):
    out=Q(0)
    for e,c in pol:
        assert e[0]==e[4]==e[5]==0
        if e[1]==e[2]==0:out+=val(c)*(z**5)**e[3]
    return out
d=json.loads(args.space.read_text());normal=list(map(ev,d['known_nonFrobenius_normal_part']))
target=[Q(0)]*9
target[5],target[6]=[Q(P(list(map(val,p)))) for p in curve['residual_polynomials_mod_G']]
rows=[[ev(p) for p in rr] for rr in d['root_cotangent_rows']]
pure=[froot(a-b) for a,b in zip(target,normal)]
wanted=[sum((a*b for a,b in zip(rr,pure)),Q(0)) for rr in rows]
part=list(map(ev,d['particular_cotangent_root_section']))
cols=[[ev(p) for p in col] for col in d['homogeneous_cotangent_root_sections']]
mat=matrix(k,[sum((list(cv(p)) for p in col),[]) for col in cols]).transpose()
rhs=vector(k,sum((list(cv(a-b)) for a,b in zip(wanted,part)),[]))
rank=mat.rank();aug=mat.augment(matrix(k,len(rhs),1,rhs)).rank()
print('curve restriction rank',rank,'augmented',aug,flush=True)
out={'status':'finite support reconstruction check; geometric support audit separate','curve_points':int(n),'restriction_rank':int(rank),'augmented_rank':int(aug)}
if rank==aug:
    sol=mat.solve_right(rhs);ker=mat.right_kernel().basis_matrix()
    out['particular_in_invariant_basis']=[code(c) for c in sol]
    out['remaining_in_invariant_basis']=[[code(c) for c in r] for r in ker]
    out['remaining_dimension']=int(ker.nrows())
    def combine_serial(parts,weights):
        ans={}
        for p,w in zip(parts,weights):
            for e,c in p:
                e=tuple(e);ans[e]=ans.get(e,k(0))+w*val(c)
        return [[list(e),code(c)] for e,c in sorted(ans.items()) if c]
    homogeneous=d['homogeneous_cotangent_root_sections']
    out['particular_cotangent_root_section']=[combine_serial([d['particular_cotangent_root_section'][i],*[p[i] for p in homogeneous]],[k(1),*sol]) for i in range(3)]
    out['remaining_cotangent_root_sections']=[[combine_serial([p[i] for p in homogeneous],row) for i in range(3)] for row in ker]
    out['known_nonFrobenius_normal_part']=d['known_nonFrobenius_normal_part']
    out['root_cotangent_rows']=d['root_cotangent_rows']
args.output.write_text(json.dumps(out,indent=2)+'\n')
assert rank==aug,'audited curve data contradict proposed support/channels/covariance'
