#!/usr/bin/env python3
"""Validate exact inputs for the new whole-T2 W5 question, without assuming its verdict."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import hashlib
import json
from pathlib import Path
from scripts.deformations.rank25.check_rank25_fifth_return_and_family import run
from scripts.deformations.rank25.analyze_rank25_w4_germ import elt, mul, power, ZERO, ONE, vp_factorial

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--root',type=Path,default=Path('.'))
    p.add_argument('--output',type=Path);a=p.parse_args();root=a.root.resolve()
    ident=json.loads((root/'PACKET_IDENTITY.json').read_text())
    assert ident['packet_identity'] in {'RANK25-ALL-W5-v1','RANK25-ALL-W5-v2'}
    for name,h in ident['required_files'].items():
        assert hashlib.sha256((root/name).read_bytes()).hexdigest()==h,(name,'wrong packet')
    m=json.loads((root/'MANIFEST.json').read_text())
    assert all(hashlib.sha256((root/n).read_bytes()).hexdigest()==r['sha256'] for n,r in m['files'].items())
    result=run(root/'reference/rank25_w4',root/'reference/rank25_w5',root/'inputs/earlier_fourth_germ_checks.json')
    result=json.loads(json.dumps(result))
    expected=json.loads((root/'inputs/global_fourth_locus_checks.json').read_text())
    assert {k:v for k,v in result.items() if k!='input_sha256'}=={k:v for k,v in expected.items() if k!='input_sha256'}
    stage=json.loads((root/'inputs/all_fifth_stage.json').read_text())
    # Frobenius uses the root lift, not the ordinary fifth power.
    f=[3,4,1,4,1];mod=3125
    def mm(x,y):
        z=[0]*7
        for i,u in enumerate(x):
            for j,v in enumerate(y):z[i+j]+=u*v
        for i in range(6,3,-1):
            for j,u in enumerate(f[:4]):z[i-4+j]-=z[i]*u
        return [v%mod for v in z[:4]]
    def ev(a,b):
        v=[0]*4
        for c in reversed(a):v=mm(v,b);v[0]=(v[0]+c)%mod
        return v
    sig=stage['coefficient_frobenius_mod3125']
    assert ev(f,sig)==[0]*4 and elt(sig)==power((0,1,0,0),5)
    v=[0,1,0,0]
    for _ in range(4):v=ev(v,sig)
    assert v==[0,1,0,0] and sig!=ev([0,0,0,0,0,1],[0,1,0,0])
    assert all(j-1-vp_factorial(j)>=4 for j in range(6,1001))
    assert 4-vp_factorial(4)==5-vp_factorial(5)==4
    d=json.loads((root/'reference/rank25_w4/inputs/rank25_fourth.json').read_text())
    # Actual kernel support certifies the degree bound entering the new mechanism.
    degrees=[]
    for row in d['kernel_basis']:
        degrees.append(max(sum(divmod(i//3,5)) for i,c in enumerate(row) if elt(c)!=ZERO))
    assert degrees==[0,1,1,2,2,3,3,4,4]
    assert max(degrees[:7])==3
    out={'status':'PASS','packet_identity':ident['packet_identity'],'manifest_files':len(m['files']),
       'original_star_origin':True,'global_W4_locus_and_all_boundary_strata':True,
       'Jacobian_rank_everywhere':5,'B_equals_Jacobian_at_star_only':True,
       'coefficient_frobenius_3125':sig,'kernel_AS_degrees':degrees,
       'new_whole_T2_fifth_verdict':'OPEN; this verifies inputs, not the requested family calculation.'}
    if a.output:a.output.write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps(out,indent=2))

if __name__=='__main__':main()
