#!/usr/bin/env python3
"""Verify the retained algebraic certificates and their file integrity."""
from __future__ import annotations
import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
import hashlib,json,os,platform,shlex,subprocess,sys
from pathlib import Path

ROOT=Path(__file__).resolve().parent

def manifest_check() -> int:
    manifest=ROOT/'MANIFEST.sha256'
    if not manifest.exists():raise RuntimeError('MANIFEST.sha256 is missing')
    checked=0
    for line in manifest.read_text().splitlines():
        if not line.strip():continue
        digest,name=line.split('  ',1)
        p=Path(name)
        if p.is_absolute() or '..' in p.parts:raise RuntimeError('unsafe manifest path')
        path=ROOT/p
        if not path.is_file():raise RuntimeError(f'missing file: {name}')
        h=hashlib.sha256()
        with path.open('rb') as f:
            for chunk in iter(lambda:f.read(1024*1024),b''):h.update(chunk)
        if h.hexdigest()!=digest:raise RuntimeError(f'SHA-256 mismatch: {name}')
        checked+=1
    print(f'MANIFEST PASS: {checked} files',flush=True)
    return checked

def run_logged(cmd:list[str],stdout:Path,stderr:Path) -> str:
    with stdout.open('w') as out,stderr.open('w') as err:
        p=subprocess.run(cmd,stdout=out,stderr=err,text=True)
    if p.returncode:raise RuntimeError(f'command failed ({p.returncode}): {shlex.join(cmd)}; see {stderr}')
    return stdout.read_text()

def check_summary(result:dict,expected:dict,basis:str) -> None:
    keys=['n','d','layouts','phase_cases','covered_subsets','power_exclusions','open_exclusions','degree_exclusions','reason_counts']
    if result.get('status')!='PASS':raise RuntimeError('native checker did not report PASS')
    for key in keys:
        if result[key]!=expected[key]:raise RuntimeError(f'unexpected {key} for n={result.get("n")}')
    if result['fingerprint']!=expected[basis+'_fingerprint']:raise RuntimeError('aggregate fingerprint mismatch')

def main() -> None:
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--n',nargs='+',type=int,default=list(range(7,27)),help='degrees to verify (default: all 7..26)')
    p.add_argument('--jobs',type=int,default=min(4,os.cpu_count() or 1))
    p.add_argument('--basis',choices=['fractions','polynomial'],default='fractions')
    p.add_argument('--output',type=Path,default=ROOT/'verification-output')
    p.add_argument('--manifest-only',action='store_true',help='integrity only, not mathematical verification')
    p.add_argument('--skip-reference',action='store_true',help='omit only the bounded Python cross-check, not the exhaustive C++ check')
    args=p.parse_args();ns=sorted(set(args.n))
    if args.jobs<1 or any(n<7 or n>26 for n in ns):p.error('jobs must be positive and degrees must lie in 7..26')
    integrity=manifest_check()
    if args.manifest_only:
        print('Integrity check only; mathematical certificates were not re-executed.')
        return
    out=args.output.resolve();out.mkdir(parents=True,exist_ok=True)
    compiler=shlex.split(os.environ.get('CXX','g++'));exe=out/'certificate';vec=out/'field_vectors'
    compile_base=compiler+['-O3','-std=c++17']
    run_logged(compile_base+[str(ROOT/'src/certificate.cpp'),'-o',str(exe)],out/'compile.log',out/'compile.stderr.log')
    run_logged(compile_base+[str(ROOT/'src/field_vectors.cpp'),'-o',str(vec)],out/'compile_vectors.log',out/'compile_vectors.stderr.log')
    run_logged([str(vec)],out/'field_vectors.txt',out/'field_vectors.stderr.log')
    run_logged([sys.executable,str(ROOT/'src/field_audit.py'),'--vectors',str(out/'field_vectors.txt'),'--output',str(out/'field_audit.json')],out/'field_audit.log',out/'field_audit.stderr.log')
    expected=json.loads((ROOT/'inputs/expected_counts.json').read_text())['degrees']
    results=[]
    def one(n:int)->dict:
        cmd=[str(exe),'verify',str(n-3),str(ROOT/'certificates'/f'n{n:02}.rrc'),args.basis]
        result=json.loads(run_logged(cmd,out/f'n{n:02}.json',out/f'n{n:02}.stderr.log'))
        check_summary(result,expected[str(n)],args.basis)
        print(f'n={n}: PASS ({result["layouts"]} layouts, {result["phase_cases"]} phase cases)',flush=True)
        return result
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        for f in as_completed([pool.submit(one,n) for n in ns]):results.append(f.result())
    if not args.skip_reference:
        run_logged([sys.executable,str(ROOT/'src/reference_audit.py'),'--n',*map(str,ns),'--output',str(out/'reference_audit.json')],out/'reference_audit.log',out/'reference_audit.stderr.log')
    summary={'status':'PASS','degrees':ns,'basis':args.basis,'manifest_files':integrity,
             'layouts':sum(r['layouts'] for r in results),'phase_cases':sum(r['phase_cases'] for r in results),
             'bounded_python_crosscheck_executed':not args.skip_reference,
             'python':sys.version,'platform':platform.platform(),'compiler_command':compiler}
    (out/'summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,indent=2))

if __name__=='__main__':
    try:main()
    except Exception as exc:
        print(f'FAIL: {exc}',file=sys.stderr);sys.exit(1)
