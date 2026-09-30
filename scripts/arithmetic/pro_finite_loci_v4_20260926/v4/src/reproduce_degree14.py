#!/usr/bin/env python3
"""Reproduce the complete degree-14 endpoint-moment exclusion in restartable chunks.

Requires Python 3.10+, a C++17 compiler, and a little-endian platform. Only the
Python and C++ standard libraries are used. Completed raw streams are gzip
compressed by default; --keep-raw keeps them uncompressed. No network is used.
"""
from __future__ import annotations
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[1]
PROFILES=('one2','two1','two2')

def digest(path: Path) -> str:
    h=hashlib.sha256()
    with path.open('rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''):h.update(b)
    return h.hexdigest()

def run(command: list[str], log: Path | None=None) -> None:
    if log is None:
        subprocess.run(command,check=True)
    else:
        with log.open('w') as f:subprocess.run(command,stdout=f,stderr=subprocess.STDOUT,check=True)

def restore(path: Path) -> None:
    compressed=Path(str(path)+'.gz')
    if not path.exists() and compressed.exists():
        temporary=Path(str(path)+'.tmp')
        with gzip.open(compressed,'rb') as src,temporary.open('wb') as dst:
            shutil.copyfileobj(src,dst,1024*1024)
        temporary.replace(path)

def compress(path: Path) -> None:
    target=Path(str(path)+'.gz');temporary=Path(str(target)+'.tmp')
    with path.open('rb') as src,temporary.open('wb') as raw:
        with gzip.GzipFile(filename='',mode='wb',fileobj=raw,compresslevel=1,mtime=0) as dst:
            shutil.copyfileobj(src,dst,1024*1024)
    temporary.replace(target);path.unlink()

def check_chunk(directory: Path,row: dict) -> bool:
    summary=directory/f"{row['profile']}.{row['chunk_index']:02d}.json"
    if not summary.exists():return False
    try:
        actual=json.loads(summary.read_text());actual.pop('elapsed_seconds',None)
        expected={k:v for k,v in row.items() if k not in ('keys','chunk_index')}
        if actual!=expected:return False
        for item in row['keys'].values():
            path=directory/item['filename']
            if not path.exists() or path.stat().st_size!=item['bytes'] or digest(path)!=item['sha256']:return False
        return True
    except (ValueError,OSError):return False

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--workdir',type=Path,required=True)
    ap.add_argument('--profiles',nargs='+',choices=PROFILES,default=list(PROFILES))
    ap.add_argument('--compiler',default='g++')
    ap.add_argument('--force',action='store_true',help='Regenerate even hash-verified completed chunks')
    ap.add_argument('--keep-raw',action='store_true')
    args=ap.parse_args()
    if sys.byteorder!='little':raise RuntimeError('The retained binary stream format requires a little-endian machine')
    work=args.workdir.resolve();chunks=work/'chunks';binary=work/'bin'
    chunks.mkdir(parents=True,exist_ok=True);binary.mkdir(parents=True,exist_ok=True)
    run([args.compiler,'--version'])
    for name in ('search_moments','merge_moments','audit_moment_keys'):
        run([args.compiler,'-O3','-std=c++17','-Wall','-Wextra','-Wpedantic',str(ROOT/f'src/{name}.cpp'),'-o',str(binary/name)])
    certificate=json.loads((ROOT/'evidence/moments/chunks.json').read_text())
    for profile in args.profiles:
        rows=[r for r in certificate['chunks'] if r['profile']==profile]
        for row in rows:
            for item in row['keys'].values():restore(chunks/item['filename'])
            if args.force or not check_chunk(chunks,row):
                stem=f"{profile}.{row['chunk_index']:02d}.json"
                command=[str(binary/'search_moments'),'--profile',profile,'--start',str(row['range_start']),
                         '--limit',str(certificate['chunk_size']),'--write-keys','--output',str(chunks/stem)]
                run(command,chunks/(stem+'.generation.log'))
                if not check_chunk(chunks,row):raise AssertionError(f'Chunk evidence mismatch: {stem}')
                action='regenerated'
            else:action='restored/verified'
            print(f"PASS {profile} chunk {row['chunk_index']:02d}: {action}, both SHA-256 digests match",flush=True)
        prefix=str(chunks/profile)
        for name,suffix in [('merge_moments','merged'),('audit_moment_keys','audit')]:
            output=work/f'{profile}_{suffix}.json'
            run([str(binary/name),'--prefix',prefix,'--profile',profile,'--output',str(output)],work/f'{profile}_{suffix}.log')
            expected=json.loads((ROOT/f'evidence/moments/{profile}_{suffix}.json').read_text())
            if json.loads(output.read_text())!=expected:raise AssertionError(f'{profile}: {suffix} evidence mismatch')
            print(f'PASS {profile}: complete {suffix} replay matches retained evidence',flush=True)
        if not args.keep_raw:
            for row in rows:
                for item in row['keys'].values():compress(chunks/item['filename'])
            print(f'PASS {profile}: completed stream chunks gzip-compressed',flush=True)
    print('RESULT: selected complete profile replays passed. All three profiles together exclude n=14.')
    print('SCOPE: no search over the remaining degrees 15..87 or actual variable branch curves.')

if __name__=='__main__':main()
