"""Verify the manifest, both boundary certificates, and every installed branch.
This verifies exact certificates; replay_branch.py additionally regenerates tails.
"""
from pathlib import Path
import hashlib,json,subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
def main():
    for line in (ROOT/'SHA256SUMS').read_text().splitlines():
        expected,name=line.split('  ',1);h=hashlib.sha256()
        with (ROOT/name).open('rb') as f:
            while b:=f.read(1<<20):h.update(b)
        assert h.hexdigest()==expected,('manifest mismatch',name)
    print('SHA256 manifest PASS',flush=True)
    for script in ['verify_boundary.py','verify_J.py']:
        subprocess.run([sys.executable,str(ROOT/'src'/script)],cwd=ROOT,check=True)
    names=sorted(p.name for p in (ROOT/'data/branches').iterdir() if (p/'descriptor.json').exists())
    for i,name in enumerate(names):
        cmd=[sys.executable,str(ROOT/'src/verify_branch.py'),name]
        if i:cmd.append('--no-compile')
        subprocess.run(cmd,cwd=ROOT,check=True)
    verified=[]
    for name in names:
        record=json.loads((ROOT/'evidence/branches'/name/'verification.json').read_text())
        assert record['status']=='PASS';verified.append((record['r'],record['branch']))
    required={(r,b) for r in [145049,211895,211959] for b in range(4)}
    complete=set(verified)==required
    assert len(verified)==len(set(verified))
    claimed=json.loads((ROOT/'claims.json').read_text())['overall_status']
    assert claimed!='complete' or complete,'Claimed complete without all twelve cases'
    out={'status':'PASS','verified_cases':names,'complete_positive_content_exclusion':complete,'scope':'independent certificate/coverage check; no regeneration of tail values in this command'}
    (ROOT/'build/all_certificates_verification.json').write_text(json.dumps(out,indent=2)+'\n')
    print('ALL_INSTALLED_CERTIFICATES=PASS; COMPLETE_POSITIVE_CONTENT_EXCLUSION='+str(complete),flush=True)
if __name__=='__main__':main()
