#!/usr/bin/env python3
"""Reproduce the complete finite endpoint obstruction and historical checks.

Default: read-only verification, both exhaustive elimination implementations.
--record: regenerate deterministic certificates and execution logs.
--arithmetic-only: verify exact data and the exceptional case, but NOT the
                   exhaustive exclusion of all other endpoint pairs.
"""
from __future__ import annotations
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shlex
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime, timezone

if not __debug__:
    raise RuntimeError('Do not run with Python -O: verification uses assertions.')
sys.dont_write_bytecode = True
ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT/'src'))
from exact_data import generate, header_text


def json_text(value):
    return json.dumps(value, indent=2, sort_keys=True)+'\n'


def check_or_record(path, value, record):
    if record:
        path.write_text(json_text(value), encoding='utf-8')
    else:
        assert json.loads(path.read_text(encoding='utf-8')) == value, str(path)


def parse_scan(path):
    return [json.loads(line) for line in path.read_text().splitlines() if line.strip()]


def validate_scan(records, mode, data):
    orbit_rows = [row for row in records if row['record'] == 'orbit']
    linear_cases = [row for row in records if row['record'] == 'linear_case']
    summaries = [row for row in records if row['record'] == 'summary']
    assert len(orbit_rows) == 333 and len(summaries) == 1
    assert [row['orbit'] for row in orbit_rows] == list(range(333))
    for row, ids in zip(orbit_rows, data['representatives']):
        assert row['zero'] == ids
        assert row['pairs'] == 266916
        assert row['rank_deficient_consistent'] == row['quadratic_compatible'] == 0
    summary = summaries[0]
    assert summary['algorithm'] == mode
    assert summary['first_orbit'] == 0 and summary['end_exclusive'] == 333
    for key in ['pairs', 'linear_consistent', 'rank_deficient_consistent', 'quadratic_compatible']:
        assert summary[key] == sum(row[key] for row in orbit_rows)
    assert summary['pairs'] == 88883028
    assert summary['linear_consistent'] == 1
    assert summary['rank_deficient_consistent'] == summary['quadratic_compatible'] == 0
    if mode == 'primary':
        assert summary['minor_zero'] == sum(row['minor_zero'] for row in orbit_rows) == 11434
    else:
        assert summary['minor_zero'] is None and all(row['minor_zero'] is None for row in orbit_rows)
    assert linear_cases == [{
        'record': 'linear_case', 'orbit': 0, 'zero': [0,0,0],
        'infinity': [58,58,58], 'rank': 5, 'solution': [3,1,3,1,2],
        'norm_difference': 0, 'quadratic_residual': 2,
    }]
    return orbit_rows, linear_cases, summary


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--record', action='store_true')
    parser.add_argument('--arithmetic-only', action='store_true')
    parser.add_argument('--algorithm', choices=['both', 'primary', 'direct'], default='both')
    args = parser.parse_args()
    if args.record and args.arithmetic_only:
        parser.error('--record cannot be combined with --arithmetic-only')
    print('Python:', platform.python_version(), platform.python_implementation(), flush=True)
    print('Exact Python arithmetic: standard library only', flush=True)
    input_data = json.loads((ROOT/'inputs.json').read_text())
    data, exception = generate(input_data)
    check_or_record(ROOT/'certificates/generated_data.json', data, args.record)
    check_or_record(ROOT/'certificates/linear_exception.json', exception, args.record)
    header = header_text(data)
    if args.record:
        (ROOT/'src/constants.h').write_text(header)
    else:
        assert (ROOT/'src/constants.h').read_text() == header
    print('PASS: fields, input coprimality, forced jets, three local substitution checks, and every C++ input table', flush=True)
    print('PASS: complete normalization from 6786 triples containing endpoint 0 gives 333 representatives', flush=True)
    print('PASS: independent polynomial-basis verification of exceptional rank-5 matrix and nonzero residual [24]', flush=True)
    print('Running retained historical arithmetic (its old partial-status message is superseded).', flush=True)
    subprocess.run([sys.executable, '-B', str(ROOT/'prior_partial/verify.py')], check=True)
    subprocess.run([sys.executable, '-B', str(ROOT/'prior_partial/verify_manifest.py')], check=True)
    if args.arithmetic_only:
        print('ARITHMETIC-ONLY RUN PASSED. This invocation did NOT repeat the exhaustive endpoint scans.', flush=True)
        return
    compiler = shlex.split(os.environ.get('CXX', 'c++'))
    if not compiler or shutil.which(compiler[0]) is None:
        raise RuntimeError('A C++17 compiler is required; set CXX to its executable.')
    compiler_version = subprocess.run(compiler+['--version'], check=True, text=True,
                                      stdout=subprocess.PIPE).stdout
    print('Compiler:', compiler_version.splitlines()[0], flush=True)
    modes = ['primary', 'direct'] if args.algorithm == 'both' else [args.algorithm]
    checked = {}
    with tempfile.TemporaryDirectory(prefix='cubic_delta9_verify_') as temporary:
        temporary = Path(temporary)
        executable = temporary/('scan.exe' if os.name == 'nt' else 'scan')
        build = compiler+['-O3', '-std=c++17', '-Wall', '-Wextra', '-pedantic',
                          str(ROOT/'src/scan.cpp'), '-o', str(executable)]
        print('BUILD:', shlex.join(build), flush=True)
        subprocess.run(build, check=True)
        for mode in modes:
            output = temporary/f'scan_{mode}.jsonl'
            command = [str(executable), mode, '0', '333', str(output)]
            error_path = ROOT/f'logs/scan_{mode}.log' if args.record else temporary/f'{mode}.log'
            print(f'RUN {mode}: every one of 88,883,028 normalized endpoint pairs', flush=True)
            with error_path.open('w', encoding='utf-8') as errors:
                errors.write('EXECUTED COMMAND: '+shlex.join(command)+'\n')
                errors.flush()
                subprocess.run(command, check=True, stderr=errors)
            records = parse_scan(output)
            checked[mode] = validate_scan(records, mode, data)
            certificate = ROOT/f'certificates/scan_{mode}.jsonl'
            if args.record:
                shutil.copyfile(output, certificate)
            else:
                assert parse_scan(certificate) == records
            print(f'PASS {mode}: 88,883,028 pairs; 1 rank-5 linear case; 0 deficient cases; 0 quadratic-compatible cases', flush=True)
    if len(checked) == 2:
        left, right = checked['primary'], checked['direct']
        assert left[1] == right[1]
        for a, b in zip(left[0], right[0]):
            assert {k:v for k,v in a.items() if k != 'minor_zero'} == {k:v for k,v in b.items() if k != 'minor_zero'}
        print('PASS: both exhaustive elimination implementations agree on every orbit and the exceptional case', flush=True)
    if args.record:
        environment = {
            'utc_recorded': datetime.now(timezone.utc).isoformat(),
            'python_version': platform.python_version(),
            'python_implementation': platform.python_implementation(),
            'platform': platform.platform(),
            'compiler_command': compiler,
            'compiler_version': compiler_version.strip(),
            'compiler_flags': ['-O3', '-std=c++17', '-Wall', '-Wextra', '-pedantic'],
            'executed_algorithms': modes,
            'source_sha256': hashlib.sha256((ROOT/'src/scan.cpp').read_bytes()).hexdigest(),
            'constant_header_sha256': hashlib.sha256((ROOT/'src/constants.h').read_bytes()).hexdigest(),
            'python_requirements': 'Python 3.10+; standard library only',
            'cpp_requirements': 'C++17 compiler; no external libraries',
            'exact_record_command': 'python3 -B verify.py --record',
            'scope': 'All listed scans actually ran; mathematical globalization is proved in REPORT.md, not formally machine-checked',
        }
        (ROOT/'logs/environment.json').write_text(json_text(environment))
    print('OVERALL: complete endpoint obstruction reproduced. Together with REPORT.md, this excludes the entire delta=9 cubic branch.', flush=True)


if __name__ == '__main__':
    main()
