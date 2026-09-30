#!/usr/bin/env python3
"""Fresh, deterministic verification of every certificate used in the proof.

This verifier checks polynomial identities; it does not search field-valued
parameter points. Derived source files are regenerated and hash-compared.
"""
from __future__ import annotations
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time

ROOT=Path(__file__).resolve().parents[1]
def sha(p:Path)->str:
    h=hashlib.sha256()
    with p.open('rb') as f:
        for chunk in iter(lambda:f.read(1<<20),b''):h.update(chunk)
    return h.hexdigest()

def check_manifest()->int:
    count=0
    for line in (ROOT/'SHA256SUMS').read_text().splitlines():
        digest,name=line.split('  ',1)
        path=ROOT/name
        if not path.is_file() or sha(path)!=digest:raise AssertionError('manifest mismatch: '+name)
        count+=1
    print(f'MANIFEST_OK files={count}',flush=True)
    return count

def main()->None:
    ap=argparse.ArgumentParser()
    ap.add_argument('--work-dir',type=Path,default=ROOT/'verification_work')
    ap.add_argument('--skip-manifest',action='store_true')
    ap.add_argument('--manifest-only',action='store_true')
    args=ap.parse_args()
    if not args.skip_manifest:check_manifest()
    if args.manifest_only:return
    work=args.work_dir.resolve()
    if work==ROOT or ROOT in work.parents and work.name not in ('verification_work','replay_work'):
        raise ValueError('choose a separate verification directory')
    if work.exists():
        if any(work.iterdir()):raise ValueError(f'work directory must be empty: {work}')
    work.mkdir(parents=True,exist_ok=True)
    shutil.copytree(ROOT/'src',work/'src',ignore=shutil.ignore_patterns('__pycache__'))
    shutil.copytree(ROOT/'data',work/'data',ignore=shutil.ignore_patterns('field.bin','*.proof','matrices*.txt','gb_output.txt','gb_q_input.txt','gb_q_output.txt','gb_qt_output.txt','gb_Hlex_output.txt','gb_replayed.txt','gb_input.txt'))
    (work/'bin').mkdir();(work/'logs').mkdir()
    env=os.environ.copy();env['OPENBLAS_NUM_THREADS']='1'
    start=time.monotonic();stages=[];comparisons=[]
    def run(name:str,cmd:list[str])->None:
        ts=time.monotonic()
        with (work/'logs'/f'{name}.log').open('w') as log:
            p=subprocess.run(cmd,cwd=work,env=env,stdout=log,stderr=subprocess.STDOUT,check=False)
        elapsed=round(time.monotonic()-ts,3)
        if p.returncode:
            print((work/'logs'/f'{name}.log').read_text(),flush=True)
            raise RuntimeError(f'{name} failed, exit {p.returncode}')
        stages.append({'stage':name,'command':cmd,'exit_code':p.returncode,'seconds':elapsed})
        print(f'PASS {name} seconds={elapsed}',flush=True)
    def compare(name:str,generated:str|None=None)->None:
        dst=generated or name
        assert sha(ROOT/name)==sha(work/dst),f'generated data mismatch: {name}'
        comparisons.append(name)
    for target in ['make_field','verify_trace','finite_algebra','factor','residual','verify_square','verify_residual_identity']:
        run('compile_'+target,['g++','-O3','-std=c++17','src/'+target+'.cpp','-o','bin/'+target])
    run('field',['bin/make_field','data/field.bin'])
    stagespec=[('reconstruct',['affine_source.json']),('normalize',['normalized_source.json','kernel_and_series.json']),('incidence',['incidence.json']),('build_input',['gb_qt_input.txt']),('resultant_identity',['resultant_universal.json'])]
    for script,files in stagespec:
        run(script,[sys.executable,'src/'+script+'.py'])
        for name in files:compare('data/'+name)
    with gzip.open(work/'data/groebner.proof.gz','rb') as fi,(work/'data/groebner.proof').open('wb') as fo:
        shutil.copyfileobj(fi,fo,length=1<<20)
    run('trace',['bin/verify_trace','data/field.bin','data/gb_qt_input.txt','data/groebner.proof','data/replayed_gb.txt'])
    compare('data/gb_certified.txt','data/replayed_gb.txt')
    run('groebner_and_algebra',['bin/finite_algebra','data/field.bin','data/gb_qt_input.txt','data/replayed_gb.txt','data/matrices.txt'])
    run('shape',[sys.executable,'src/shape.py'])
    compare('data/shape.json');compare('data/shape_poly.txt')
    run('branches_and_units',[sys.executable,'src/branch_and_units.py'])
    compare('data/branch_bezout.json');compare('data/open_unit_certificates.json')
    run('prepare_residual',[sys.executable,'src/prepare_residual.py'])
    for name in ['residual_functions.json','residual_functions.txt','shape_H.txt']:compare('data/'+name)
    run('degree_bound',[sys.executable,'src/degree_bound.py'])
    compare('data/residual_degree_bound.json')
    run('factor',['bin/factor','data/field.bin','data/shape_poly.txt','data/factors.txt'])
    compare('data/factors.txt')
    run('residual',['bin/residual','data/field.bin','data/factors.txt','data','data/residuals'])
    for i in range(5):compare(f'data/residuals/residual_{i}.txt')
    run('residual_identity',['bin/verify_residual_identity','data/field.bin','data/factors.txt','data','data/residuals'])
    run('square_certificates',['bin/verify_square','data/field.bin','data/factors.txt','data/residuals','data/square_certificates'])
    summary={'status':'ALL_CHECKS_PASSED','stages':stages,'matched_reference_files':comparisons,'total_seconds':round(time.monotonic()-start,3),'field_table_sha256':sha(work/'data/field.bin')}
    (work/'verification_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(f'ALL_CHECKS_PASSED stages={len(stages)} hash_comparisons={len(comparisons)}',flush=True)

if __name__=='__main__':main()
