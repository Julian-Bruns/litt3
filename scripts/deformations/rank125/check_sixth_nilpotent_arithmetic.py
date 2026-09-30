#!/usr/bin/env python3
"""Focused checks of the extra nilpotent digit and exact binomial series."""
import argparse
from fractions import Fraction
import hashlib
import json
import os
from pathlib import Path
import sys


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--engine-dir',type=Path,required=True)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[3])
    os.environ['LITT3_REFERENCE_MODULUS']='15625'
    os.environ['LITT3_REFERENCE_PRECISION']='256'
    sys.path.insert(0,str(args.engine_dir.resolve()))
    import witt_cubic as w
    import batch_witt as b
    from fourth_engine import Engine
    checks=[]
    for module in (w,b):
        z=module.Z
        x=1+5*z**-1
        expected=sum(((-5)**j*z**(-j) for j in range(6)),module.Ser(0))
        actual=x.inv()
        assert (actual-expected).mod(15625).iszero()
        assert (x*actual-1).mod(15625).iszero()
        eng=Engine.__new__(Engine);eng.Ser=module.Ser
        for modulus in (125,625,3125,15625):
            e=(5*z**-1+25*z**-3).mod(modulus)
            root=eng.nil_binomial(e,Fraction(1,2),modulus)
            inverse_root=eng.nil_binomial(e,Fraction(-1,2),modulus)
            inverse=eng.nil_binomial(e,Fraction(-1),modulus)
            assert (root*root-1-e).mod(modulus).iszero()
            assert (root*inverse_root-1).mod(modulus).iszero()
            assert ((1+e)*inverse-1).mod(modulus).iszero()
        checks.append({'module':module.__name__,'fifth_geometric_term_retained':True,
                       'binomial_identity_moduli':[125,625,3125,15625]})
    sources={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in
             [Path(__file__)]+[args.engine_dir/n for n in ('witt_cubic.py','batch_witt.py','fourth_engine.py')]}
    args.output.write_text(json.dumps({'status':'PASS','checks':checks,
                                      'source_sha256':sources},indent=2)+'\n')
    print('PASS: sixth nilpotent digit and exact binomial identities')


if __name__=='__main__':main()
