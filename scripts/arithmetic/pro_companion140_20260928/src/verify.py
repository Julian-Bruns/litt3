"""Verify the archive. --full regenerates all mathematical data.
--full --part 1, 2, 3 are equivalent restartable stages.
"""
from pathlib import Path
import argparse,hashlib,json,subprocess,sys
ROOT=Path(__file__).resolve().parent.parent


def manifest():
    expected={}
    for line in (ROOT/'SHA256SUMS').read_text().splitlines():
        digest,name=line.split('  ',1);expected[name]=digest
    actual={str(p.relative_to(ROOT)) for p in ROOT.rglob('*') if p.is_file() and '__pycache__' not in p.parts and 'work' not in p.relative_to(ROOT).parts and p.name!='SHA256SUMS' and not p.name.endswith('.pyc')}
    assert actual==set(expected),('manifest file set mismatch',actual-set(expected),set(expected)-actual)
    for name,digest in expected.items():
        assert hashlib.sha256((ROOT/name).read_bytes()).hexdigest()==digest,('SHA-256 mismatch',name)
    print(f'Manifest: PASS ({len(expected)} payload files)',flush=True)


def identities():
    from field import pa,pm,pgcd,deriv,pdm,ppow,scale,sub,peval
    from fibre_certificates import verify_ratio
    from global_checks import lc72
    from tails import tails
    rows=json.loads((ROOT/'data/fibre_certificates.json').read_text())
    assert len(rows)==4 and [r['q'] for r in rows]==[1,1,2,2]
    for row in rows:
        verify_ratio(row['q'],row['u'],row['xi'],row['s'])
        assert pa(pm(row['U'],row['C71']),pm(row['V'],row['C72']))==[1]
        assert row['C72'][-1]==lc72(row['q'],row['u'],row['s'])
    ss=json.loads((ROOT/'data/sample_residual.json').read_text())
    _,_,eq=tails(ss['Rbar_scale_ascending'],74)
    assert eq[71]==rows[0]['C71'] and eq[72]==rows[0]['C72']
    bb=json.loads((ROOT/'data/leading_tail_boundary.json').read_text())
    prod=[1]
    for f in bb['fibres']:
        prod=pm(prod,f['discriminant'])
        assert len(pgcd(f['discriminant'],deriv(f['discriminant'])))==1
    assert prod==bb['leading_boundary_product']
    assert pa(pm(bb['pole_bezout_U'],prod),pm(bb['pole_bezout_V'],bb['licensed_q_pole_product']))==[1]
    assert len(prod)==145 and len(pgcd(prod,deriv(prod)))==1
    print('Stored geometric fibre identities, leading-tail identities and sample tails: PASS',flush=True)
    print('Fast verification does not replace regeneration of the four actual residuals.',flush=True)


def full(part=None):
    groups={1:['field.py','source.py','cramer.py','global_source.py','global_checks.py','resultant_check.py','residual.py'],
            2:['tails.py','fibre_certificates.py'],
            3:['compare_samples.py']}
    stages=groups[part] if part else groups[1]+groups[2]+groups[3]
    before={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in (ROOT/'data').glob('*.json')}
    for stage in stages:
        print(f'EXECUTE {stage}',flush=True)
        subprocess.run([sys.executable,str(ROOT/'src'/stage)],cwd=ROOT,check=True)
    after={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest() for p in (ROOT/'data').glob('*.json')}
    assert before==after,('regenerated data differ', [n for n in set(before)|set(after) if before.get(n)!=after.get(n)])
    print(f'Full regeneration {"part "+str(part)+"/3" if part else "all stages"}: PASS; every mathematical data file reproduced byte-for-byte.',flush=True)
    manifest()


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    mode=parser.add_mutually_exclusive_group();mode.add_argument('--fast',action='store_true');mode.add_argument('--full',action='store_true')
    parser.add_argument('--part',type=int,choices=[1,2,3]);args=parser.parse_args()
    if args.part and not args.full:parser.error('--part requires --full')
    manifest()
    if args.full:full(args.part)
    else:identities()
    print('BASELINE CHECKS: PASS. The complete global certificate is checked by src/verify_global.py; this baseline driver does not replace it.',flush=True)

if __name__=='__main__':main()
