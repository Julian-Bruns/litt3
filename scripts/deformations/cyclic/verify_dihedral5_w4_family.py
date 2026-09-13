#!/usr/bin/env python3
"""Verify provenance and agreement of the two full fourteen-cover W4 runs.

This read-only comparison does not replace their actual cocycle construction
or the independent geometric model and parameter-independence audits.
"""
import argparse
import hashlib
import json
from pathlib import Path


def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('directory')
    ap.add_argument('--output',required=True)
    args=ap.parse_args();data=Path(args.directory).resolve()
    root=Path(__file__).resolve().parents[3]
    raw=json.loads((data/'models/summary.json').read_text())
    labels={r['label'] for r in raw['rows'] if r['neutral']}
    assert len(raw['rows'])==15 and len(labels)==14
    results={};hashes={}
    for name in ['census','changed_frobenius']:
        summary=json.loads((data/name/'summary.json').read_text())
        assert summary['status']=='PASS' and summary['expected']==14
        rows={r['label']:r for r in summary['completed']};assert set(rows)==labels
        results[name]=rows
        for label,row in rows.items():
            fp=row['fingerprint'];assert fp['model_sha256']==sha(data/'models'/f'{label}.json')
            assert fp['sources']=={n:sha(root/n) for n in fp['sources']}
            case=data/name/label
            assert row['status']=='PASS' and row['returncode']==0 and row['nonzero']
            assert len(row['output_hashes'])==5
            for n,h in row['output_hashes'].items():
                assert sha(case/n)==h;hashes[str((case/n).relative_to(data))]=h
            fourth=json.loads((case/'genus6_fourth_result.json').read_text())
            assert fourth['status'].startswith('PASS complete')
            assert fourth['first_lift_frobenius_rank']==15
            assert fourth['c4']==row['c4'] and any(row['c4'])
            assert fourth['rho4_precision']>=100
            decomp=json.loads((case/'genus6_decomposition.json').read_text())
            summands=['divided_linear_carry','quadratic_first_repairs','weighted_jet',
                      'cubic_Taylor_derivative','preceding_oper_potential']
            total=[sum(decomp['components'][n]['scalar'][i] for n in summands)%5 for i in range(4)]
            assert total==row['c4']==decomp['c4']
            log=(case/'run.log').read_text()
            for check in ['FIRST FL CONNECTION CHECK PASS','FULL W2 JET TRANSITION CHECK PASS',
                          'PASS actual next flat-connection gluing modulo125',
                          'PASS independent iterated p-connection Taylor formula',
                          'PASS: fourth scalar, exact cochain decomposition, and independent weighted-jet coefficient']:
                assert check in log,(label,check)
    table=[]
    for label in sorted(labels):
        a,b=results['census'][label],results['changed_frobenius'][label]
        assert a['fingerprint']['precision']==3500 and b['fingerprint']['precision']==3800
        assert a['fingerprint']['frobenius_variant']==0 and b['fingerprint']['frobenius_variant']==1
        assert a['c4']==b['c4'],label
        table.append(dict(label=label,c4=a['c4'],precisions=[a['rho4_precision'],b['rho4_precision']]))
    assert results['census']['pair_0_1']['c4']==[1,0,0,3]
    audits={}
    for n in ['dihedral5_family_model_independent_audit.json','dihedral5_family_frame_independent_audit.json']:
        p=root/'Research/computations'/n
        if p.exists():audits[str(p.relative_to(root))]=sha(p)
    output=dict(status='PASS 28 full comparisons; all fourteen scalars nonzero and unchanged',
                directory=str(data),table=table,output_files=len(hashes),output_hashes=hashes,
                independent_audit_receipts=audits,
                scope='Exact finite family of actual D10 quotients of one obstructed F625 pair; all-b and closure consequences require the separately audited geometric lemmas.')
    Path(args.output).write_text(json.dumps(output,indent=2)+'\n')
    print(json.dumps({k:v for k,v in output.items() if k!='output_hashes'},indent=2))


if __name__=='__main__':main()
