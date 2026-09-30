#!/usr/bin/env python3
"""Bounded exhaustive NECESSARY INTEGER PROFILES, never a geometric search.

Adds the scalar consequence of companion cancellations to the prior exact
profile relaxation. Splittable/restartable by --n-min and --n-max. No branch
polynomials, endpoint coefficients, or actual covers are enumerated.
"""
import argparse
import json
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'prior/src'))
from profile_checks import balanced, grid_min, check_optimizer

def one_degree(n):
    before=after=0; min_g=max_g=None; tail=[]; equality=[]
    for j2 in range(30):
        for j1 in range(30-j2):
            j=j1+j2; a=n-12-3*j1-6*j2
            if a<0: continue
            for s in range((a+3)//4,min(a,29-j)+1):
                e=s+j; b=min(10,3+(e+1)//2)
                hi=min(n+1,85,3*b+2*j-3-2*int(e%2==1 and e<=13))
                special=26<=n<=54 and n%2==0 and e==14 and a==s and j2==0
                if not special: hi=min(hi,n)
                lo=max(0,j-3)
                for g in range(lo,hi+1):
                    m=j1+2*j2; N=7*n-3*g+15+3*m
                    lower=(n-12)*(n-13)//2+grid_min(n,N)+4*balanced(a,s)+j1+8*j2
                    if g+lower>(n-1)**2: continue
                    before+=1
                    if 2*g+j1 > 3*e+12+4*j: continue
                    after+=1
                    min_g=g if min_g is None else min(g,min_g)
                    max_g=g if max_g is None else max(g,max_g)
                    item={'g':g,'s':s,'a':a,'j1':j1,'j2':j2,'e':e}
                    if n>=89: tail.append(item)
                    if g==n+1: equality.append(item)
    grid_min.cache_clear()
    row={'n':n,'prior_survivors':before,'new_survivors':after,
         'min_surviving_g':min_g,'max_surviving_g':max_g}
    if n>=89: row['surviving_tuples']=sorted(tail,key=lambda z:tuple(z[k] for k in ('g','s','a','j1','j2')))
    if equality: row['genus_n_plus_one_survivors']=equality
    return row

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--n-min',type=int,default=14); ap.add_argument('--n-max',type=int,default=91)
    ap.add_argument('--output',type=Path); ap.add_argument('--check',type=Path)
    args=ap.parse_args()
    if not 14<=args.n_min<=args.n_max<=182: ap.error('Require 14 <= min <= max <= 182.')
    checks=check_optimizer()
    rows=[one_degree(n) for n in range(args.n_min,args.n_max+1)]
    out={'scope':'Bounded exhaustive necessary scalar integer-profile relaxation, NOT geometric solutions.',
         'n_min':args.n_min,'n_max':args.n_max,
         'new_condition':'2g+j1 <= 3e+12+4j, in addition to prior REPORT (30)',
         'omitted':'Individual inertia allocations; polynomial divisibilities; nonlinear endpoint identities; actual ramification and existence.',
         'optimizer_checks':checks,
         'prior_survivors':sum(r['prior_survivors'] for r in rows),
         'new_survivors':sum(r['new_survivors'] for r in rows),
         'degrees_with_survivors':[r['n'] for r in rows if r['new_survivors']],
         'equality_degrees':[r['n'] for r in rows if r.get('genus_n_plus_one_survivors')],
         'per_degree':rows}
    if args.n_min==14 and args.n_max==91:
        assert out['prior_survivors']==518726
        assert out['degrees_with_survivors']==list(range(14,92))
        assert out['equality_degrees']==[26]
        assert rows[-1]['new_survivors']==1
    if args.output: args.output.write_text(json.dumps(out,indent=2,sort_keys=True)+'\n')
    if args.check:
        assert out==json.loads(args.check.read_text()), 'Stored profile summary differs.'
        print('PASS: stored new profile summary exactly regenerated.')
    print('PASS: optimizer checks',checks)
    print('Scope:',args.n_min,'..',args.n_max)
    print('Prior necessary-profile survivors:',out['prior_survivors'])
    print('New necessary-profile survivors:',out['new_survivors'])
    print('Surviving degrees:',out['degrees_with_survivors'])
    print('Degrees retaining g=n+1:',out['equality_degrees'])
    print('No numerical survivor is certified as an actual object.')
if __name__=='__main__': main()
