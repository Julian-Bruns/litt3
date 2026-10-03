#!/usr/bin/env sage
"""Recover metadata from the already saved successful low-pole tuple.

Does not recompute normal forms, coefficients, determinants or a basis.
The original exit-one receipt and serialization traceback stay intact.
"""
import argparse
import json
from pathlib import Path
import signal
parser=argparse.ArgumentParser()
parser.add_argument('--input',required=True)
parser.add_argument('--output',required=True)
args=parser.parse_args()
signal.alarm(5)
R,Rx,G,F,c31,c26,high,low,delta,mapback=load(args.input)
summary={'scope':'metadata recovery from saved low-pole tuple, no arithmetic replay',
         'threads':1,'all_saved_poles_22_through_31_zero':all(all(c==0 for c in row) for row in high),
         'gauge_pair_degrees':[[int(z.degree()) for z in p] for p in F],
         'lower_independence_minor_nonzero_polynomial':bool(delta),
         'independence_minor_degree':int(delta.total_degree()) if delta else -1,
         'independence_minor_terms':len(delta.monomials()),'saved_mapback_zero':bool(mapback==0),
         'primary_exit1_cause':'Sage Integer JSON serialization after all assertions and data saves'}
Path(args.output).write_text(json.dumps(summary,indent=2,default=int)+'\n')
print(json.dumps(summary,default=int))
