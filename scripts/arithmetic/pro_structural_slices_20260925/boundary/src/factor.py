"""Deterministic-seeded exact finite-field factorization, with product checks."""
from exact import *
import random,math
_rng=random.Random(20260925)

def powmod_big(a,n,f):
    r=FP(1)
    while n:
        if n&1:r=(r*a)%f
        n>>=1
        if n:a=(a*a)%f
    return r

def equal_degree(f,d):
    if f.deg==d:return [f.monic()]
    for trial in range(10000):
        a=FP([_rng.randrange(ORDER) for _ in range(f.deg)])
        g=f.gcd(a)
        if 0<g.deg<f.deg:return equal_degree(g,d)+equal_degree(f//g,d)
        b=powmod_big(a,(ORDER**d-1)//2,f)-1;g=f.gcd(b)
        if 0<g.deg<f.deg:return equal_degree(g,d)+equal_degree(f//g,d)
    raise RuntimeError('split search exhausted; no mathematical conclusion')

def squarefree_factors(f):
    f=f.monic()
    assert f.gcd(f.derivative())==1
    out=[];h=x%f;d=1
    while f.deg>=2*d:
        h=h.powmod(ORDER,f)
        g=f.gcd(h-x)
        if g.deg>0:
            out += equal_degree(g,d);f=f//g;h=h%f
        d+=1
    if f.deg>0:out.append(f)
    out.sort(key=lambda p:(p.deg,p.c))
    return out

def is_irreducible(f):
    n=f.deg
    if n<=0:return False
    primes=[];m=n;p=2
    while p*p<=m:
        if m%p==0:
            primes.append(p)
            while m%p==0:m//=p
        p+=1
    if m>1:primes.append(m)
    hs=[x%f]
    for _ in range(n):hs.append(hs[-1].powmod(ORDER,f))
    return hs[n]==x%f and all(f.gcd(hs[n//p]-x)==1 for p in primes)

if __name__=='__main__':
    import json
    from pathlib import Path
    ROOT=Path(__file__).resolve().parents[1]
    j=json.loads((ROOT/'data'/'constant_deep_boundary.json').read_text())
    g=FP(j['eliminants'][0])//(x**4)
    print('Degree 138 parameter polynomial degree',g.deg,'squarefree gcd',g.gcd(g.derivative()))
    fac=squarefree_factors(g)
    print('Factor degrees',[p.deg for p in fac])
    prod=FP(1)
    for f in fac:assert is_irreducible(f);prod*=f
    assert prod==g.monic()
    (ROOT/'data'/'constant_138_factors.json').write_text(json.dumps({'parameter_polynomial':list(g.monic().c),'factors':[list(p.c) for p in fac]},indent=2)+'\n')
