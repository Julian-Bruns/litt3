#!/usr/bin/env sage-python
"""Explore the residue fields of the finite simultaneous scheme.

This imports the previously computed degree-reverse-lexicographic basis.
Its output is exploratory until membership and zero-dimensionality have
separate certificates. No claim of a common cover is made.
"""
import argparse
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing
from sage.interfaces.singular import singular


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--probe',type=Path,required=True)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    if args.output.resolve().is_relative_to(Path(__file__).resolve().parents[3]):
        raise ValueError('Output must be outside litt3')
    start=time.monotonic()
    data=json.loads(args.probe.read_text())
    k=GF(125,'alpha',modulus=[1,1,0,1])
    R=PolynomialRing(k,names=['b0','b1','b2','c0','c1','c2'],order='degrevlex')
    gb=[R(f) for f in data['groebner_basis']]
    sg=singular(R.ideal(gb))
    oldring=singular.current_ring_name()
    singular.eval('attrib(%s,"isSB",1);'%sg.name())
    print('FGLM starting',flush=True)
    L=PolynomialRing(k,names=R.variable_names(),order='lex')
    singular(L)
    answer=singular('fglm(%s,%s)'%(oldring,sg.name()))
    lex=[L(f) for f in answer.sage()]
    out={'status':'exploratory','lex_basis':[str(f) for f in lex],
         'seconds':time.monotonic()-start}
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    print('lex basis size',len(lex),'seconds',out['seconds'],flush=True)
    for f in lex:
        if len(f.variables())==1:
            factors=f.univariate_polynomial().factor()
            print('univariate variable',str(f.variables()[0]),
                  'degree',f.degree(),
                  'factor degrees/multiplicities',[(g.degree(),int(e)) for g,e in factors],
                  flush=True)


if __name__=='__main__':
    main()
