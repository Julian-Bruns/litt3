#!/usr/bin/env python3
"""Verification entry point.  No third-party Python packages are needed.

--quick checks arithmetic, retained outcomes and the example necessary filter.
--full reruns the exhaustive finite endpoint tests (all five cases by default).
--manifest checks the delivered SHA-256 manifest.
"""
from pathlib import Path
import argparse
import datetime
import hashlib
import json
import os
import platform
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parent


def digest(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda:f.read(1024*1024),b''):
            h.update(block)
    return h.hexdigest()


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def manifest_check():
    path = ROOT/'MANIFEST.sha256'
    if not path.is_file():
        raise RuntimeError('MANIFEST.sha256 is missing')
    count = 0
    for line in path.read_text().splitlines():
        expected, relative = line.split('  ',1)
        p = ROOT/relative
        if not p.is_file() or digest(p)!=expected:
            raise RuntimeError('manifest mismatch: '+relative)
        count += 1
    print(f'PASS: SHA-256 manifest, {count} files')


def run(cmd, log):
    log.parent.mkdir(parents=True,exist_ok=True)
    with log.open('w') as out:
        out.write('START '+now()+'\nCOMMAND '+json.dumps(list(map(str,cmd)))+'\n')
        out.flush()
        result = subprocess.run(list(map(str,cmd)),cwd=ROOT,stdout=out,stderr=subprocess.STDOUT)
        out.write('\nEND '+now()+'\nRETURN_CODE '+str(result.returncode)+'\n')
    if result.returncode:
        raise RuntimeError(f'command failed with status {result.returncode}; see {log}')


def check_outcome(path, case):
    d = json.loads(path.read_text())
    expected_n = 273819 if case==0 else 7940751
    expected_zero_m = 1 if case==1 else 0
    required = {'status':'executed','defect':case,'enumerated':expected_n,
                'multisets':7940751,'zero_c':0,'zero_m':expected_zero_m,
                'zero_both':0,'degenerate_hits':0,'reciprocal_hits':0,
                'representatives':expected_n-expected_zero_m,
                'ratio_classes':expected_n-expected_zero_m}
    for k,v in required.items():
        if d.get(k)!=v:
            raise RuntimeError(f'{path}: {k}={d.get(k)!r}, expected {v!r}')
    if d.get('witnesses')!=[]:
        raise RuntimeError('unexpected reciprocal witness')
    return d


def quick(build):
    p = build/'quick'
    run([sys.executable,ROOT/'src/make_constants.py','--check'],p/'constants.log')
    run([sys.executable,ROOT/'src/verify_small.py','--output',p/'small_checks.json'],p/'small_checks.log')
    run([sys.executable,ROOT/'src/trace_filter.py',ROOT/'data/example_trace_input.json',
         '--output',p/'example_trace_result.json'],p/'example_trace.log')
    small = json.loads((p/'small_checks.json').read_text())
    if small.get('status')!='passed' or small.get('C_determinant_F25_code')!=2:
        raise RuntimeError('small arithmetic checks failed')
    if json.loads((p/'example_trace_result.json').read_text()).get('passes_trace_filter') is not False:
        raise RuntimeError('negative example unexpectedly passed')
    for case in range(5):
        check_outcome(ROOT/f'results/endpoint_check_d{case}.json',case)
    print('PASS: constants, fields, local coefficient arithmetic, root independence, example and retained outcomes')
    print('NOTE: --quick does not rerun the exhaustive endpoint enumeration; use --full for that.')


def full(build,cases,keep):
    compiler = shutil.which(os.environ.get('CXX','g++'))
    if compiler is None:
        raise RuntimeError('g++/CXX is required, with C++17 and OpenMP support')
    build.mkdir(parents=True,exist_ok=True)
    executable = build/'check_endpoint_pairs'
    command = [compiler,'-O3','-fopenmp','-std=c++17','-Wall','-Wextra','-pedantic',
               ROOT/'src/check_endpoint_pairs.cpp','-o',executable]
    run(command,build/'compile.log')
    version = subprocess.check_output([compiler,'--version'],text=True).splitlines()[0]
    dependencies = sorted((ROOT/'src').glob('*.py'))+sorted((ROOT/'src').glob('*.cpp'))+sorted((ROOT/'src').glob('*.h'))+sorted((ROOT/'data').glob('*.json'))
    source_hashes = {str(p.relative_to(ROOT)):digest(p) for p in dependencies}
    for case in cases:
        directory = build/f'case_{case}'
        directory.mkdir(parents=True,exist_ok=True)
        output = directory/'endpoint_check.json'
        record = {'case':case,'started_utc':now(),'python':platform.python_version(),
                  'compiler':version,'source_and_input_sha256':source_hashes,
                  'method':'exact exhaustive finite endpoint test, not a curve-model search',
                  'stages':[],'temporary_cache_sha256':{}}
        stages = [0] if case==0 else [1,2,3]
        for stage in stages:
            log = directory/f'stage_{stage}.log'
            run([executable,output,str(case),str(stage)],log)
            record['stages'].append({'stage':stage,'status':'completed','log':log.name})
            if stage==1:
                record['temporary_cache_sha256']['ratios'] = digest(Path(str(output)+'.ratios'))
            if stage==2:
                if digest(Path(str(output)+'.ratios'))!=record['temporary_cache_sha256']['ratios']:
                    raise RuntimeError('ratio cache changed')
                record['temporary_cache_sha256']['inverses'] = digest(Path(str(output)+'.inverses'))
            if stage==3:
                for extension in ('ratios','inverses'):
                    if digest(Path(str(output)+'.'+extension))!=record['temporary_cache_sha256'][extension]:
                        raise RuntimeError('stage cache changed: '+extension)
        result = check_outcome(output,case)
        record['finished_utc'] = now()
        record['status'] = 'passed'
        record['outcome'] = result
        record['cache_note'] = 'Native temporary caches are reproducible from source; their deletion does not remove an input or an independent certificate.'
        (directory/'execution.json').write_text(json.dumps(record,indent=2)+'\n')
        if not keep:
            for extension in ('ratios','inverses'):
                p = Path(str(output)+'.'+extension)
                if p.exists():
                    p.unlink()
        print(f'PASS: case d={case}, enumerated {result["enumerated"]}, zero reciprocal hits',flush=True)


def main():
    if not __debug__:
        raise RuntimeError('Run Python without -O')
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--quick',action='store_true')
    mode.add_argument('--full',action='store_true')
    mode.add_argument('--manifest',action='store_true')
    parser.add_argument('--cases',default='0,1,2,3,4',help='with --full: comma-separated cases among 0..4')
    parser.add_argument('--build-dir',type=Path,default=ROOT/'_verification')
    parser.add_argument('--keep-intermediates',action='store_true')
    args = parser.parse_args()
    build = args.build_dir.resolve()
    if args.manifest:
        manifest_check()
    elif args.quick:
        quick(build)
    else:
        cases = [int(s) for s in args.cases.split(',')]
        if not cases or len(set(cases))!=len(cases) or any(x not in range(5) for x in cases):
            parser.error('--cases must be distinct integers in 0..4')
        full(build,cases,args.keep_intermediates)

if __name__=='__main__':
    main()
