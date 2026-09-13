#!/usr/bin/env python3
"""Check the fixed W4 witness, complete next torsor and W5 precision inputs.

This verifies inputs for a NEW question; it does not compute a W5 obstruction.
Run with --root pointing to the extracted fifth-request packet.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import hashlib
import json
from pathlib import Path
from scripts.deformations.rank25.analyze_rank25_w4_germ import ZERO, ONE, elt, add, mul, power, rank, vp_factorial

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--root',type=Path,default=Path('.'))
    ap.add_argument('--output',type=Path)
    args=ap.parse_args(); root=args.root.resolve()
    ref=root/'reference/rank25_w4'
    stage=json.loads((root/'inputs/fifth_stage.json').read_text())
    manifest=json.loads((ref/'MANIFEST_RESULT.json').read_text())['files_sha256']
    assert all(hashlib.sha256((ref/n).read_bytes()).hexdigest()==s for n,s in manifest.items())
    d=json.loads((ref/'inputs/rank25_fourth.json').read_text())
    w=json.loads((ref/'point_and_fourth_digit.json').read_text())
    M=[[elt(x) for x in row] for row in d['hodge_matrix']]
    K=[[elt(x) for x in row] for row in d['kernel_basis']]
    rows=[[elt(x) for x in row] for row in d['obstruction_dual_rows']]
    def dot(A,v):
        out=[]
        for row in A:
            val=ZERO
            for x,y in zip(row,v): val=add(val,mul(x,y))
            out.append(val)
        return out
    assert rank(M)==66 and rank(K)==rank(rows)==9
    assert all(dot(M,[power(v,5) for v in k])==[ZERO]*75 for k in K)
    assert dot(M,[power(elt(v),5) for v in w['fourth_digit']])==[elt(v) for v in w['reference_rho4']]
    x=[elt(v) for v in w['parameters']]
    assert x==[ZERO]*3+[(3,0,0,3),(0,3,1,4)]+[ZERO]*4
    combined=[elt(v) for v in d['primary_repair']]
    for i in range(9): combined=[add(v,mul(x[i],k)) for v,k in zip(combined,K[i])]
    assert combined==[elt(v) for v in w['third_curve_repair_actual_coordinates']]
    assert stage['fixed_third_parameters']==w['parameters']
    assert stage['particular_fourth_digit']==w['fourth_digit']
    assert stage['actual_fourth_direction_basis']==d['kernel_basis']
    # Independently check the unique unramified coefficient lift at the new level.
    modulus=3125; f=[3,4,1,4,1]
    def ma(a,b):return [(x+y)%modulus for x,y in zip(a,b)]
    def mm(a,b):
        z=[0]*7
        for i,x in enumerate(a):
            for j,y in enumerate(b):z[i+j]+=x*y
        for i in range(6,3,-1):
            for j,c in enumerate(f[:4]):z[i-4+j]-=c*z[i]
        return [v%modulus for v in z[:4]]
    def ev(coeffs,point):
        value=[0]*4
        for c in reversed(coeffs):value=ma(mm(value,point),[c,0,0,0])
        return value
    sig=stage['coefficient_frobenius_mod3125']
    assert sig==[122,1363,2775,2385] and ev(f,sig)==[0]*4
    assert [v%625 for v in sig]==[122,113,275,510]
    assert tuple(v%5 for v in sig)==power((0,1,0,0),5)
    image=[0,1,0,0]
    for _ in range(4):image=ev(image,sig)
    assert image==[0,1,0,0]
    assert sig != ev([0,0,0,0,0,1],[0,1,0,0])
    assert 4-vp_factorial(4)==5-vp_factorial(5)==4
    assert 5-1-vp_factorial(5)==3
    assert all(j-1-vp_factorial(j)>=4 for j in range(6,1001))
    # All new full-cohomology diagnostics independently project to the coefficients.
    u=json.loads((root/'inputs/fresh_universal2100.json').read_text())
    assert dot(rows,[elt(v) for v in u['normal_cohomology_constant']])==[elt(v) for v in u['constant']]
    for normal,coefficient in [('normal_cohomology_linear_x','linear_x'),('normal_cohomology_linear_fifth','linear_fifth')]:
        for n,c in zip(u[normal],u[coefficient]):assert dot(rows,[elt(v) for v in n])==[elt(v) for v in c]
    for q in u['quadratic_fifth']:
        assert dot(rows,[elt(v) for v in q['normal_cohomology']])==[elt(v) for v in q['coefficient']]
    result={'status':'PASS','original_manifest_files':len(manifest),'primary_rank':66,
            'complete_next_compatible_torsor_dimension':9,'all75_fourth_digit_equations':True,
            'new_coefficient_frobenius':sig,'coefficient_frobenius_order4':True,
            'fresh_full_normal_coefficient_projections':True,
            'fifth_Taylor_term_required':True,'fifth_obstruction_computed':False}
    if args.output: args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))

if __name__=='__main__': main()
