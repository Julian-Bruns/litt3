#!/usr/bin/env python3
"""Compute one new antecedent fiber over the SAME field F_(5^15).

The returned certificate is a read-only source of arithmetic and elimination
code. Generated inputs, binaries, coefficients and logs stay outside litt3.
This does not assert compatibility with a second endpoint.
"""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import shutil
import subprocess


def decode(n):
    row=[]
    for _ in range(5):
        row.append(n % 125)
        n //=125
    if n:
        raise ValueError('coefficient overflow')
    return row


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--certificate',type=Path,required=True)
    ap.add_argument('--target',type=Path,required=True)
    ap.add_argument('--point-index',type=int,default=None)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    root=Path(__file__).resolve().parents[2]
    out=args.output.resolve()
    if out.is_relative_to(root):
        raise ValueError('output must be outside litt3')
    if out.exists():
        raise ValueError('output exists; preserve completed stages')
    shutil.copytree(args.certificate,out,ignore=shutil.ignore_patterns('build','__pycache__'))
    target=json.loads(args.target.read_text())
    z=target.get('unique_point',target.get('z'))
    if args.point_index is not None:
        z=target['rational_points'][args.point_index]
    if not z or len(z)<3:
        raise ValueError('target lacks point')
    if len(z)==4 and z[3]!=1:
        raise ValueError('normalize target last coordinate first')
    data=json.loads((out/'input.json').read_text())
    data['A']=[decode(c) for c in z[:3]]
    (out/'input.json').write_text(json.dumps(data,separators=(',',':'))+'\n')
    # Supplied certificate files pertain to the old target. Preserve their
    # provenance in the source directory; recreate this stage's directory.
    shutil.rmtree(out/'certificates')
    (out/'certificates').mkdir()
    (out/'build').mkdir()
    shutil.copy2(Path(__file__).with_name('rational_frobenius_fiber.cpp'),
                 out/'src'/'rational_frobenius_fiber.cpp')
    spec=importlib.util.spec_from_file_location('returned_runner',out/'run.py')
    runner=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(runner)
    runner.input_header()
    with (out/'continuation.log').open('w') as log:
        for name,arguments in [('solve',['3','13']),('boundary',[])]:
            exe=runner.compile_program(name)
            subprocess.run([str(exe),*arguments],cwd=out/'certificates',
                           stdout=log,stderr=log,check=True)
        runner.rur_header()
        exe=runner.compile_program('rational_frobenius_fiber')
        subprocess.run([str(exe)],cwd=out/'certificates',
                       stdout=log,stderr=log,check=True)
    receipt={'source_certificate':str(args.certificate.resolve()),
             'target':str(args.target.resolve()),
             'target_sha256':hashlib.sha256(args.target.read_bytes()).hexdigest(),
             'point_index':args.point_index,
             'driver_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
             'compiler':os.environ.get('CXX','g++'),
             'scope':'one new fiber over the fixed coefficient field; no common-span realization'}
    (out/'continuation_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print((out/'continuation.log').read_text())


if __name__=='__main__':
    main()
