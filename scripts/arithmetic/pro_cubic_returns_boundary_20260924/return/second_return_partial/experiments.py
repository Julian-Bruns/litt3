#!/usr/bin/env python3
"""Portable replay of exploratory EXACT GRADED ranks, not a field-point search.

Only the final certificates checked by verify.py support the geometric claims.
A nonzero graded cokernel at one degree is an inconclusive result, not a
projective rank-drop witness. See logs/experiments/README.md.
"""
from __future__ import annotations
import argparse
import itertools
from pathlib import Path
import sys
import time
import numpy as np
ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'src'))
import graded_module as gm

def check(T,support,degree):
    start=time.monotonic()
    M=gm.macaulay(T[support],degree)
    rank=len(gm.arithmetic.rref(M)[1])
    print('support',support,'degree',degree,'shape',M.shape,'rank',rank,
          'graded defect',M.shape[1]-rank,'seconds',round(time.monotonic()-start,3),flush=True)
    return rank==M.shape[1]

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--suite',choices=('initial','expanded','pairs','P6'),default='initial')
    args=parser.parse_args()
    T=np.load(ROOT/'data/hom_tensor.npz')['T']
    if args.suite=='initial':
        for support in ([0,6,7],[0,6,7,13],[0,6,7,8],[0,6,7,1],list(range(6))):
            for degree in range(1,5):
                if len(support)==6 and degree>3:
                    break
                if check(T,support,degree):
                    break
    elif args.suite=='expanded':
        supports=[[0,6,7,1,2],[0,6,7,8,9],[0,6,7,13,14],[0,6,7,1,8],
                  list(range(6)),[0,6,7,1,2,3],[0,6,7,8,9,10],
                  [0,6,7,13,14,15],[0,6,7,1,8,13]]
        for support in supports:
            for degree in ([4,5] if len(support)==6 else [4]):
                if check(T,support,degree):
                    break
    elif args.suite=='pairs':
        outside=[i for i in range(19) if i not in (0,6,7)]
        for pair in itertools.combinations(outside,2):
            check(T,[0,6,7,*pair],4)
    else:
        support=[0,6,7,1,8,13,2]
        M=gm.macaulay(T[support],4)
        N,pivots,free=gm.normal_form(M)
        assert N.shape==(7350,630) and len(pivots)==6720
        total=gm.relation_count(7,4,35)
        indices=np.random.default_rng(0).choice(total,size=8820,replace=False)
        A=gm.commutator_relations(N,7,4,35,indices)
        rank=len(gm.arithmetic.rref(A)[1])
        assert rank==4410
        print('P6 exact quotient dimension 630; commutator matrix',A.shape,'rank',rank,flush=True)
    print('Exploration completed. No full nineteen-coordinate decision is asserted.',flush=True)

if __name__=='__main__':
    main()
