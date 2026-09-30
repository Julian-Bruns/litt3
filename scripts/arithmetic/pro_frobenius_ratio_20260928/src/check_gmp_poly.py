#!/usr/bin/env python3
"""Bounded exact arithmetic regressions; not a geometric point search."""
from pathlib import Path
import json,time
import numpy as np
from ff import Poly
from gmp_poly import fast_mul,fast_divmod,lib,install
from half_gcd import xgcd
from known_unit_factorization import factor_known,rebuild
ROOT=Path(__file__).resolve().parents[1]

def verify():
    start=time.time();rng=np.random.default_rng(391833);cases=[]
    # The reference multiplication is the original polynomial implementation.
    for na,nb in [(1,18),(300,280),(625,640),(2048,1614),(8010,7031)]:
        a,b=[Poly(rng.integers(0,390625,n,dtype=np.uint32))for n in (na,nb)]
        c=fast_mul(a,b);assert c==a*b
        q,r=fast_divmod(c,b);assert q==a and not r
        cases.append([na,nb])
    install()
    for n in (10000,50000):
        a,b=[Poly(rng.integers(0,390625,n,dtype=np.uint32))for _ in range(2)]
        c=a*b;q,r=divmod(c,b);assert q==a and not r
    for n in (1000,5000):
        g,a,b=[Poly(rng.integers(0,390625,k,dtype=np.uint32))for k in (50,n,n-3)]
        ag,bg=a*g,b*g;gg,U,V=xgcd(ag,bg)
        assert U*ag+V*bg==gg and gg==g.monic()
    fs=[Poly(f)for f in json.loads((ROOT/'data/zero_scale_compact.json').read_text())['unit_factors']]
    for case in (0,1,2):
        es=[(1234+77*i)%256 if case==0 else (5000 if i==4 else 0)if case==1 else i%7 for i in range(len(fs))]
        d={'scalar':41321,'exponents':es};p=rebuild(d,fs);got=factor_known(p,fs)
        assert got['scalar']==d['scalar'] and got['exponents']==d['exponents'] and rebuild(got,fs)==p
    result={'status':'bounded exact arithmetic regressions passed; not a square-locus test',
            'GMP':lib.gp_version().decode(),'reference_product_cases':cases,
            'exact_division_lengths':[10000,50000],'exact_bezout_lengths':[1000,5000],
            'unit_factorization_fixtures':3,'seconds':round(time.time()-start,3)}
    (ROOT/'checks/gmp_poly.json').write_text(json.dumps(result,indent=2)+'\n')
    print('GMP_POLYNOMIAL_ARITHMETIC_REGRESSIONS_PASSED='+json.dumps(result),flush=True)
    return result
if __name__=='__main__':verify()
