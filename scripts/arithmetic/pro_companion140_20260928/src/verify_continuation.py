"""Verify the continuation certificates; keep full replays restartable.
The complete global certificate has a separate driver: verify_global.py.
"""
from pathlib import Path
import argparse, hashlib, subprocess, sys
ROOT=Path(__file__).resolve().parent.parent

def run(cmd):
    print('EXECUTE '+' '.join(map(str,cmd)),flush=True)
    subprocess.run(list(map(str,cmd)),cwd=ROOT,check=True)

def reproduce(path,cmd):
    p=ROOT/path;before=hashlib.sha256(p.read_bytes()).hexdigest()
    run(cmd)
    assert hashlib.sha256(p.read_bytes()).hexdigest()==before,('regeneration changed certificate',path)
    print('BYTE-FOR-BYTE PASS '+path,flush=True)

def fast():
    from verify import manifest,identities
    from verify_boundary import run as boundary,run_norm,run_opposites
    manifest();identities();boundary();run_norm();run_opposites()
    print('Boundary certificate checks: PASS. Use verify_global.py for the complete global certificate.',flush=True)

def replay(part=None):
    from verify import manifest
    manifest();run(['sh',ROOT/'src/native/build.sh']);exe=ROOT/'work/companion'
    todo=[part] if part else [1,2,3,4]
    for n in todo:
        if n==1:
            run([exe,ROOT,'sample'])
            for q in [1,24,47]:run([exe,ROOT,'grid',q,23])
        elif n==2:
            for idx in range(6):
                name=f'data/boundary_certificate_{idx}.json'
                reproduce(name,[exe,ROOT,'boundary',idx,ROOT/name])
        elif n==3:
            reproduce('data/norm_s_boundary.json',[sys.executable,ROOT/'src/norm_s_boundary.py'])
            reproduce('data/norm_s_certificate.json',[exe,ROOT,'norm-s',ROOT/'data/norm_s_certificate.json'])
        elif n==4:
            reproduce('data/opposite_boundary.json',[sys.executable,ROOT/'src/opposite_boundary.py'])
            for idx in range(6):
                name=f'data/opposite_certificate_{idx}.json'
                reproduce(name,[exe,ROOT,'opposite',idx,ROOT/name])
    manifest()
    print('Boundary replay: PASS. Global certificate verification is separate.',flush=True)

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    m=p.add_mutually_exclusive_group();m.add_argument('--fast',action='store_true');m.add_argument('--replay',action='store_true')
    p.add_argument('--part',type=int,choices=[1,2,3,4]);a=p.parse_args()
    if a.part and not a.replay:p.error('--part requires --replay')
    if a.replay:replay(a.part)
    else:fast()
