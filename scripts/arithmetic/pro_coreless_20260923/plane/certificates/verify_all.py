#!/usr/bin/env python3
"""Run all exact certificates. Requires Python 3.9+ and no dependencies.

Usage:
  python3 certificates/verify_all.py
  python3 certificates/verify_all.py --json verification/results.json

A successful run verifies the arithmetic used by the report. It does not
claim to decide arbitrary non-descending divisors on all etale covers.
"""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys


def main():
    if not __debug__:
        raise RuntimeError("Run this verifier without Python optimization flags (-O/-OO).")
    sys.dont_write_bytecode = True
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--json', type=Path, help='write complete machine-readable results')
    args = parser.parse_args()
    here = Path(__file__).resolve().parent
    modules = ['verify_base_data', 'verify_contact_obstructions',
               'verify_cubic_obstruction', 'verify_divisor_arithmetic']
    results = {}
    for name in modules:
        module = __import__(name)
        results[name] = module.run()
        print(name + ': PASS')
    legacy = here / 'legacy' / 'cartier_twisted_base_certificate.py'
    proc = subprocess.run([sys.executable, str(legacy)], capture_output=True,
                          text=True, check=True)
    if 'certificate = PASS' not in proc.stdout:
        raise RuntimeError('legacy certificate did not report PASS')
    results['legacy'] = {
        'status':'PASS', 'sha256':hashlib.sha256(legacy.read_bytes()).hexdigest(),
        'stdout':proc.stdout,
    }
    print('legacy/cartier_twisted_base_certificate.py: PASS')
    results['overall_status'] = 'PASS'
    results['universal_incidence_decided'] = False
    results['explicit_admissible_cover_constructed'] = False
    print('All finite arithmetic certificates: PASS')
    print('Universal incidence decision: NOT ESTABLISHED')
    print('Explicit admissible cover: NOT CONSTRUCTED')
    if args.json:
        args.json.parent.mkdir(parents=True,exist_ok=True)
        args.json.write_text(json.dumps(results,indent=2)+'\n',encoding='utf-8')
        print('JSON results written to: ' + str(args.json))


if __name__ == '__main__':
    main()
