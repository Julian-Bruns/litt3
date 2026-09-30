"""Pack, compare, and independently verify cubic-extension exclusion evidence."""
from __future__ import annotations
import argparse,gzip,hashlib,json
from pathlib import Path
FILES=['input.json','tails.jsonl','tails.meta.json','resultants.json','gcd_certificate.json']
def load(p:Path):
    if not p.exists():p=Path(str(p)+'.gz')
    return json.loads(gzip.decompress(p.read_bytes()) if p.suffix=='.gz' else p.read_bytes())
def certificate(folder:Path,out:Path):
    r,c=load(folder/'resultants.json'),load(folder/'gcd_certificate.json')
    assert r['factor_index']==c['factor_index']
    data=[]
    for a,v in zip(r['polynomials'],c['H_valuations']):
        assert all(x==[0,0,0] for x in a[:v]) and a[v]!=[0,0,0]
        data.append(a[v:])
    data.extend(c['multipliers']);data.append(c['gcd'])
    assert data[-1]==[[1,0,0]],'not a unit certificate'
    with out.open('w') as f:
        f.write(str(c['factor_index'])+'\n')
        for a in data:f.write(str(len(a))+' '+' '.join(str(v) for c in a for v in c)+'\n')
def pack(src:Path,out:Path):
    out.mkdir(parents=True,exist_ok=True);records=[]
    for name in FILES:
        b=(src/name).read_bytes();z=gzip.compress(b,compresslevel=9,mtime=0);(out/(name+'.gz')).write_bytes(z)
        records.append({'name':name,'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest(),'compressed_sha256':hashlib.sha256(z).hexdigest()})
    (out/'hashes.json').write_text(json.dumps(records,indent=2)+'\n')
    p=src/'resultant_nodes.bin'
    if p.exists():(out/'restart_nodes_hash.json').write_text(json.dumps({'name':p.name,'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'input_tails_bin_bytes':(src/'tails.bin').stat().st_size,'input_tails_bin_sha256':hashlib.sha256((src/'tails.bin').read_bytes()).hexdigest(),'note':'Regenerable nodes are omitted. The optional from-verified-nodes mode requires this hash and the identical tails input.'},indent=2)+'\n')
    print('Packed exact cubic-extension data:',out)
def check_restart(src:Path,expected:Path):
    r=load(expected/'restart_nodes_hash.json');p=src/r['name'];t=src/'tails.bin'
    assert p.stat().st_size==r['bytes'] and hashlib.sha256(p.read_bytes()).hexdigest()==r['sha256']
    assert t.stat().st_size==r['input_tails_bin_bytes'] and hashlib.sha256(t.read_bytes()).hexdigest()==r['input_tails_bin_sha256']
    print('PASS: exact tail-input and retained resultant-node hashes for restart.')
def compare(src:Path,expected:Path):
    for r in load(expected/'hashes.json'):
        b=(src/r['name']).read_bytes()
        assert len(b)==r['bytes'] and hashlib.sha256(b).hexdigest()==r['sha256'],r['name']
        assert b==gzip.decompress((expected/(r['name']+'.gz')).read_bytes()),r['name']
    check_restart(src,expected)
    print('PASS: all five cubic-extension evidence files and the restart-node hash reproduced exactly.')
if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('mode',choices=['certificate','pack','compare','check-restart']);p.add_argument('source',type=Path);p.add_argument('target',type=Path);a=p.parse_args()
    {'certificate':certificate,'pack':pack,'compare':compare,'check-restart':check_restart}[a.mode](a.source,a.target)
