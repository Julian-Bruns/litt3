"""Pack essential exact evidence or prepare the independent verifier's input."""
from __future__ import annotations
import argparse, gzip, hashlib, json
from pathlib import Path

def read_json(path: Path):
    return json.loads(gzip.decompress(path.read_bytes()) if path.suffix == '.gz' else path.read_bytes())

def certificate_text(evidence: Path, output: Path) -> None:
    rp = evidence / 'resultants.json'
    cp = evidence / 'gcd_certificate.json'
    if not rp.exists(): rp = rp.with_suffix('.json.gz')
    if not cp.exists(): cp = cp.with_suffix('.json.gz')
    r, c = read_json(rp), read_json(cp)
    polynomials = []
    for a, v in zip(r['polynomials'], c['h_valuations']):
        assert all(x == 0 for x in a[:v]) and a[v] != 0
        polynomials.append(a[v:])
    polynomials.extend(c['multipliers'])
    polynomials.append(c['gcd'])
    assert c['gcd'] == [1], 'certificate does not exclude the fiber'
    with output.open('w') as f:
        for a in polynomials:
            f.write(str(len(a))+' '+' '.join(map(str, a))+'\n')

def pack(source: Path, resultants: Path, target: Path) -> None:
    target.mkdir(parents=True, exist_ok=True)
    records=[]
    for path in [source/'fiber_input.json', source/'tails_71_73.jsonl', source/'tails_71_73.meta.json', resultants/'resultants.json', resultants/'gcd_certificate.json']:
        data=path.read_bytes()
        dest=target/(path.name+'.gz')
        dest.write_bytes(gzip.compress(data, compresslevel=9, mtime=0))
        records.append({'name':path.name,'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest(),'compressed_sha256':hashlib.sha256(dest.read_bytes()).hexdigest()})
    (target/'hashes.json').write_text(json.dumps(records,indent=2)+'\n')
    print('Packed five essential exact coefficient/certificate files.')

def compare(source: Path, resultants: Path, target: Path) -> None:
    for r in read_json(target/'hashes.json'):
        p=(resultants if r['name'] in {'resultants.json','gcd_certificate.json'} else source)/r['name']
        data=p.read_bytes()
        assert len(data)==r['bytes'] and hashlib.sha256(data).hexdigest()==r['sha256'],p
        assert data==gzip.decompress((target/(r['name']+'.gz')).read_bytes()),p
    print('PASS: all five regenerated mathematical data files are byte-identical.')

if __name__=='__main__':
    p=argparse.ArgumentParser();sub=p.add_subparsers(dest='action',required=True)
    for action in ['pack','compare']:
        a=sub.add_parser(action);a.add_argument('source',type=Path);a.add_argument('resultants',type=Path);a.add_argument('target',type=Path)
    a=sub.add_parser('certificate');a.add_argument('evidence',type=Path);a.add_argument('output',type=Path)
    a=p.parse_args()
    if a.action=='certificate': certificate_text(a.evidence,a.output)
    elif a.action=='pack': pack(a.source,a.resultants,a.target)
    else: compare(a.source,a.resultants,a.target)
