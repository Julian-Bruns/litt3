#!/usr/bin/env sage
"""One-core exact positive/negative control; no atlas search or production edits."""
import argparse, hashlib, json, time
from pathlib import Path

ap=argparse.ArgumentParser(); ap.add_argument('--output',required=True,type=Path)
args=ap.parse_args(); started=time.monotonic()
source=Path('Research/computations/genus_two_intrinsic_tensor.json')
saved_source=Path('Research/computations/genus_two_intrinsic_solutions.json')
d=json.loads(source.read_text()); saved=json.loads(saved_source.read_text())
k=GF(5**6,name='q'); zring=PolynomialRing(k,'z'); z=zring.gen()
a=zring([2,4,1]).roots(multiplicities=False)[0]
get=lambda s:k(sage_eval(s,locals={'a':a}))
I=matrix(k,[[get(c) for c in row] for row in d['I']])
ell=matrix(k,[[get(c) for c in row] for row in d['ell']])
tensor=[matrix(k,[[get(d['tensor_plus_Jinverse_alpha5_p'][i][j][h])
                   for j in range(4)] for h in range(12)]) for i in range(4)]
f=zring(sage_eval(saved['projective_degree11_polynomial'],locals={'a':a,'z':z}))
hh=zring(sage_eval(saved['normalization_lambda_cubed'],locals={'a':a,'z':z}))
P=PolynomialRing(k,'t'); t=P.gen()
cs=[k(j%5)+k.gen()*k(j//5) for j in range(12)]; assert len(set(cs))==12
C=matrix(P,4,12,lambda i,j:cs[j]**i*t**j)
count=0; rejected=0; degrees=[]; leading_checks=[]
for zz in f.roots(multiplicities=False):
    c=1/((a+1)*zz**10+(-a+2)*zz**5+2*a)
    for lam in (z**3-hh(zz)).roots(multiplicities=False):
        ps=lam**(-4)*c*((-2*a+2)*zz**5-a-1)
        pt=-lam**(-4)*c*(zz**5+a+2); bx,by=lam*zz,lam
        p=vector(k,[-(2*a+1)*pt,a*ps-pt,ps,pt])
        b=vector(k,[-(2*a+1)*bx+(2*a+2)*by,
                    -(2*a+1)*bx+(2*a+1)*by,bx,by])
        H=-matrix(k,[M*vector(k,[x**5 for x in b]) for M in tensor]).transpose()
        assert H*p==I*b and p*ell*b==1 and H.rank()==4
        A=C*H; det=A.det(); assert det
        v=A.adjugate()*(C*(I*b)); assert v==det*p
        assert H*v==det*(I*b) and v*ell*b==det
        indices=list(H.transpose().pivots()); exponent=sum(indices)
        vand=matrix(k,4,4,lambda i,j:cs[indices[j]]**i)
        assert det.valuation()==exponent
        assert det[exponent]==vand.det()*H.matrix_from_rows(indices).det()
        # The unnormalized extension equations preserve b->2b,p->2^-4 p.
        # All original equations hold, but the exact normalization must fail.
        bad=2*b; badH=2**5*H; badA=C*badH; badD=badA.det()
        badV=badA.adjugate()*(C*(I*bad))
        assert badD and badH*badV==badD*(I*bad)
        assert badV*ell*bad!=badD
        count+=1; rejected+=1; degrees.append(int(det.degree()))
        leading_checks.append(int(exponent))
assert count==rejected==33
# A fixed constant compression really can fail, even at full column rank.
fixed=matrix(k,[[e(1) for e in row] for row in C.rows()])
hidden=fixed.right_kernel().basis_matrix().transpose().matrix_from_columns(range(4))
assert hidden.rank()==4 and fixed*hidden==0
assert (C*hidden).det()!=0
out=dict(scope='Exact generic-compression test, no genus-nine atlas exclusion',
    tensor_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
    solution_sha256=hashlib.sha256(saved_source.read_bytes()).hexdigest(),
    all_original_positive_points_verified=count, all_normalization_controls_rejected=rejected,
    all_adjugate_reconstructions_verified=True, all_greedy_leading_coefficients_verified=True,
    arbitrary_constant_compressor_counterexample_verified=True,
    determinant_degrees=degrees, determinant_valuations=leading_checks,
    seconds=time.monotonic()-started)
args.output.parent.mkdir(parents=True,exist_ok=True)
args.output.write_text(json.dumps(out,indent=2,default=int)+'\n')
print(json.dumps(out,indent=2,default=int),flush=True)
