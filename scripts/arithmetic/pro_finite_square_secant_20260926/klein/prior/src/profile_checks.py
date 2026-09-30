#!/usr/bin/env python3
"""Exact necessary integer-profile relaxation, NOT a geometric solution search.

Supports independent bounded chunks by --n-min and --n-max. Only concise
per-degree summaries are emitted; all candidate tuples are regenerated.
No claim about existence follows from survival of a tuple.
"""
from __future__ import annotations

import argparse
from functools import lru_cache
import json
from pathlib import Path


def balanced(total: int, cells: int) -> int:
    if total < 0 or cells < 0:
        raise ValueError('Counts must be nonnegative.')
    if cells == 0:
        if total:
            raise ValueError('Nonzero count in zero cells.')
        return 0
    q, r = divmod(total, cells)
    return cells*q*(q-1)//2 + r*q


@lru_cache(maxsize=None)
def grid_min(n: int, N: int) -> int:
    """Exact min (28), using discrete convexity, not floating point.

For a fixed diagonal A count x, the smallest unconstrained minimizing
P-diagonal count is 10q+max(0,r-90), where N=100q+r. If the remaining
cap is smaller, use that cap. The resulting function of x is convex;
a binary search for its first nonnegative difference is exact.
    """
    M, cap = 4*n-4, n+12
    q,r = divmod(N,100)
    p_low = 10*q + max(0,r-90)
    def cost(x: int) -> int:
        y = min(cap-x,p_low)
        return (balanced(x,4)+balanced(M-x,12)
                +balanced(y,10)+balanced(N-y,90))
    low, high = 0, min(M,cap)
    while low < high:
        mid = (low+high)//2
        if cost(mid+1) >= cost(mid):
            high = mid
        else:
            low = mid+1
    return cost(low)


def grid_min_linear(n: int, N: int) -> int:
    """Independent linear sweep for the same one-dimensional minimum."""
    M,cap = 4*n-4,n+12
    q,r = divmod(N,100)
    p_low = 10*q+max(0,r-90)
    return min(balanced(x,4)+balanced(M-x,12)
               +balanced(min(cap-x,p_low),10)
               +balanced(N-min(cap-x,p_low),90)
               for x in range(min(M,cap)+1))


def check_optimizer() -> int:
    # Redundant bounded arithmetic check; discrete convexity is the proof.
    tested = 0
    for n in range(14,183):
        for N in (0,1,99,100,101,130,493,500,8*n+3):
            assert grid_min(n,N) == grid_min_linear(n,N)
            tested += 1
    assert grid_min(92,500) == 5028
    return tested


def one_degree(n: int) -> dict:
    before = after = 0
    min_g = max_g = None
    tail = []
    for j2 in range(30):
        for j1 in range(30-j2):
            j = j1+j2
            a = n-12-3*j1-6*j2
            if a < 0:
                continue
            s_low = (a+3)//4
            s_high = min(a,29-j)
            for s in range(s_low,s_high+1):
                e = s+j
                b = min(10,3+(e+1)//2)
                hi = min(n+1,85,3*b+2*j-3-2*int(e%2 == 1 and e<=13))
                exceptional_equality = 26<=n<=54 and n%2==0 and e==14 and a==s and j2==0
                if not exceptional_equality:
                    hi = min(hi,n)
                lo = max(0,j-3)
                for g in range(lo,hi+1):
                    before += 1
                    m = j1+2*j2
                    N = 7*n-3*g+15+3*m
                    lower = ((n-12)*(n-13)//2 + grid_min(n,N)
                             +4*balanced(a,s)+j1+8*j2)
                    if g+lower <= (n-1)**2:
                        after += 1
                        min_g = g if min_g is None else min(min_g,g)
                        max_g = g if max_g is None else max(max_g,g)
                        if n >= 89:
                            tail.append({'g':g,'s':s,'a':a,'j1':j1,'j2':j2,
                                         'e':e,'N':N,'slack':(n-1)**2-g-lower})
    result = {'n':n,'profiles_before_new_inequality':before,
              'profiles_surviving':after,'min_surviving_g':min_g,
              'max_surviving_g':max_g}
    if n>=89:
        result['surviving_tuples'] = sorted(tail,key=lambda x:(x['g'],x['s'],x['a'],x['j1'],x['j2']))
    grid_min.cache_clear()
    return result


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--n-min', type=int, default=14)
    parser.add_argument('--n-max', type=int, default=182)
    parser.add_argument('--output', type=Path)
    parser.add_argument('--check', type=Path, help='compare exact regeneration to a stored summary')
    args = parser.parse_args()
    if not 14<=args.n_min<=args.n_max<=182:
        parser.error('Require 14 <= n-min <= n-max <= 182.')
    opt_checks = check_optimizer()
    rows = [one_degree(n) for n in range(args.n_min,args.n_max+1)]
    result = {
        'scope':'Finite exhaustive necessary integer-profile relaxation, not geometric solutions.',
        'n_min':args.n_min,'n_max':args.n_max,
        'inequality':'REPORT (30), with input (3)-(9) scalar profile bounds',
        'omitted':'Individual h_i feasibility, branch coefficients, nonlinear identities, and actual realizability.',
        'optimizer_redundant_checks':opt_checks,
        'total_profiles_before':sum(r['profiles_before_new_inequality'] for r in rows),
        'total_profiles_surviving':sum(r['profiles_surviving'] for r in rows),
        'degrees_with_survivors':[r['n'] for r in rows if r['profiles_surviving']],
        'degrees_excluded':[r['n'] for r in rows if not r['profiles_surviving']],
        'per_degree':rows,
    }
    if args.n_min==14 and args.n_max==182:
        assert result['total_profiles_before']==4732360
        assert result['total_profiles_surviving']==518726
        assert result['degrees_with_survivors']==list(range(14,92))
        assert result['degrees_excluded']==list(range(92,183))
        row91 = rows[91-14]
        assert row91['profiles_surviving']==1
        assert row91['surviving_tuples'][0] == {
            'g':79,'s':1,'a':1,'j1':26,'j2':0,'e':27,'N':493,'slack':10}
    if args.check:
        stored = json.loads(args.check.read_text())
        assert result==stored, 'Stored profile summary differs from regeneration.'
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(json.dumps(result,indent=2,sort_keys=True)+'\n')
    print('PASS: optimizer agrees with linear sweep on',opt_checks,'bounded arithmetic cases.')
    print('Integer profiles before:',result['total_profiles_before'])
    print('Integer profiles surviving:',result['total_profiles_surviving'])
    print('Degrees with survivors:',result['degrees_with_survivors'])
    print('Excluded degrees:',result['degrees_excluded'])
    for r in rows:
        if r['n']==91:
            print('n=91:',r['surviving_tuples'])
    if args.check:
        print('PASS: stored profile summary matches exact regeneration.')
    print('Survivors are numerical necessary profiles, NOT actual covers or coefficient solutions.')

if __name__=='__main__':
    main()
