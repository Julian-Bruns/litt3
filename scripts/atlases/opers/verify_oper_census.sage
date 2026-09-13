"""Verify the complete oper census by cubic symmetry and global length.

Construct28,935 distinct non-invariant points and homogeneous length-eight
local quotients at55 invariant points. Their disjoint lengths exhaust the
independently proved global length29,375. No discovery basis, saved formal
elimination or exceptional-slice calculation is read.
"""
import argparse,hashlib,json,os,subprocess,time
from pathlib import Path

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--out',required=True,type=Path)
args=parser.parse_args()
out=args.out.resolve();out.mkdir(parents=True,exist_ok=False)
root=Path(__file__).resolve().parents[3];base=root/'Research/computations'
started=time.monotonic()
env=dict(os.environ,OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1')
def run(name,arguments):
    subprocess.run(['sage',str(root/'scripts'/name)]+arguments,check=True,env=env)

run('certify_oper_parametrization.sage',
    [str(base/'normalized_oper_a9_parametrization.json'),'--output',str(out/'normalized.json')])
normalized=json.loads((out/'normalized.json').read_text())
assert normalized['status']=='VERIFIED_reduced_normalized_solution_algebra'
frozen=json.loads((base/'normalized_oper_algebra_certificate.json').read_text())
assert all(normalized[key]==frozen[key] for key in ['P','coordinates','B','lambda'])
# The frozen file is original hash-linked evidence. Its former known-length
# metadata is historical; none of it is a premise of this new verifier.
R=PolynomialRing(GF(5),'z',implementation='FLINT');z=R.gen();P=R(normalized['P'])
assert P.degree()==19290 and P.gcd(P.derivative())==1
assert R(normalized['lambda']).gcd(P)==1
closed=json.loads((base/'normalized_oper_closed_points.json').read_text())['factors']
factors=[R(row['polynomial']) for row in closed]
assert len(factors)==12 and prod(factors)==P and all(h.is_irreducible() for h in factors)
assert all(h.degree()==2*row['degree_F25'] and row['multiplicity']==1 for h,row in zip(factors,closed))
print('PASS normalized solutions, all12 factors and invertible cubic scale',flush=True)

run('verify_oper_local_quadrics.sage',
    ['--input',str(base/'invariant_oper_centers.json'),'--out',str(out/'local_quadrics.json')])
local=json.loads((out/'local_quadrics.json').read_text())
assert local['status']=='PASS_explicit_homogeneous_local_quotients'
assert local['weighted_lower_length']==440 and local['invariant_geometric_points']==55
assert all(row['quotient_length']==8 and row['c4_slice_length']==6
           and row['hilbert_function']==[1,3,3,1] for row in local['points'])
assert 3*19290//2+8*55==29375
names=['normalized_oper_a9_parametrization.json','normalized_oper_algebra_certificate.json',
       'normalized_oper_closed_points.json','invariant_oper_centers.json']
report=dict(status='PASS_given_global_oper_length_theorem',global_length_input=29375,
    noninvariant_distinct_points=28935,invariant_distinct_points=55,
    invariant_local_length=8,invariant_local_algebra='homogeneous complete intersection of three quadrics',
    invariant_hilbert_function=[1,3,3,1],invariant_c4_slice_length=6,
    total_c4_slice_length=330,total_lower_length=29375,distinct_points=28990,
    full_cubic_quotient_distinct_points=9700,full_cubic_quotient_length=9755,
    consequence='Lengths exhausted: no additional points; simple non-invariant points; each invariant local quotient is the whole local algebra.',
    source_hashes={name:hashlib.sha256((base/name).read_bytes()).hexdigest() for name in names},
    local_receipt_sha256=hashlib.sha256((out/'local_quadrics.json').read_bytes()).hexdigest(),
    normalized_residue_degrees=[row['degree_F25'] for row in closed],
    elapsed_seconds=time.monotonic()-started,
    scope='Rank-two census and cubic quotient only; no atlas exclusion, common-cover solution or Lean verification.')
(out/'verification.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
print('COMPLETE census certificate PASS;',round(report['elapsed_seconds'],3),'seconds',flush=True)
