#!/usr/bin/env python3
"""Bounded exact diagnostics for the all-power *algebraic* absorption lemma.

No curve or Hodge comparison is simulated.  Standard library only; no files
are written.  Tests actual cyclic functions, including wrapped differences,
over the unramified quadratic coefficient ring (Z/5^(a+1))[w]/(w^2-2).
"""

from math import comb
import random
import time


def check_power(a):
    q, mod = 5**a, 5**(a+1)
    maxdeg = 3*a+1
    bins = [[comb(s, j) % mod for j in range(min(s,maxdeg)+1)]
            for s in range(q)]
    zero = (0,0)

    def padd(x,y): return ((x[0]+y[0])%mod,(x[1]+y[1])%mod)
    def pmul(x,y):
        return ((x[0]*y[0]+2*x[1]*y[1])%mod,
                (x[0]*y[1]+x[1]*y[0])%mod)
    def scale(x,c): return [(c*u%mod,c*v%mod) for u,v in x]
    def plus(x,y): return [padd(u,v) for u,v in zip(x,y)]
    def times(x,y): return [pmul(u,v) for u,v in zip(x,y)]
    def phi(x): return [(u,-v%mod) for u,v in x]
    def alpha(x): return [(2*v%mod,u) for u,v in x]
    def shift(x,t=1):
        t%=q
        return x[t:]+x[:t]
    def e(x): return plus(shift(x),scale(x,-1))
    def correction(x):
        return plus(plus(alpha(x),phi(x)),
                    plus(e(alpha(phi(x))),scale(e(e(phi(x))),2)))
    def A(x): return plus(e(e(x)),scale(correction(x),5))
    def evaluate(c):
        return [(sum(row[j]*c[j][0] for j in range(min(len(c),len(row))))%mod,
                 sum(row[j]*c[j][1] for j in range(min(len(c),len(row))))%mod)
                for row in bins]
    def coefficients(x):
        row=x[:maxdeg+1]
        c=[]
        while row:
            c.append(row[0])
            row=[((v[0]-u[0])%mod,(v[1]-u[1])%mod)
                 for u,v in zip(row,row[1:])]
        assert evaluate(c)==x, 'Function escaped the bounded polynomial space'
        return c
    def contains(x,segments):
        cs=coefficients(x)
        for j,(u,v) in enumerate(cs):
            levels=[t for t,d in segments if j<=d]
            divisor=5**min(levels) if levels else mod
            if u%divisor or v%divisor: return False
        return True
    def integrate(x):
        c=coefficients(x)
        assert c[-1]==zero and c[-2]==zero
        return evaluate([zero,zero]+c[:-2])
    def absorb(f,EE):
        z=[zero]*q
        for _ in range(a):
            err=plus(f,scale(A(z),-1))
            if all(v==zero for v in err): break
            z=plus(z,integrate(err))
        assert A(z)==f
        assert contains(z,EE)

    rng=random.Random(5900+a)
    def randompoly(deg):
        return evaluate([(rng.randrange(mod),rng.randrange(mod))
                         for _ in range(deg+1)])
    def Q(x,d):
        result=[(1,0)]*q
        for i in range(d):
            factor=shift(phi(x) if i%2 else x,2*i+1)
            if i==0: factor=alpha(factor)
            result=times(result,factor)
        return plus(result,correction(result))

    gen_count=nonlin_count=0
    for m in range(1,a+1):
        if m==1:
            FF=[(j,3*j-1) for j in range(1,a+1)]
            EE=[(j,3*j+1) for j in range(1,a+1)]
            digits=[(j,3*j+1) for j in range(a)]
        else:
            FF=[(j,2*j+4-2*m) for j in range(m,a+1)]
            EE=[(j,d+2) for j,d in FF]
            digits=[(j,2*j+2) for j in range(a+1-m)]
        for val,deg in FF:
            for j in range(deg+1):
                for basis in (0,1):
                    c=[zero]*(j+1)
                    c[j]=(5**val,0) if basis==0 else (0,5**val)
                    f=evaluate(c)
                    assert contains(f,FF)
                    absorb(f,EE)
                    gen_count+=1
        for _ in range(8):
            y=[zero]*q
            for val,deg in digits:
                y=plus(y,scale(randompoly(deg),5**val))
            f=[zero]*q
            for d in range(2,1+a//m+1):
                f=plus(f,scale(Q(y,d),5**(m*(d-1))))
            assert contains(f,FF)
            absorb(f,EE)
            nonlin_count+=1
    return gen_count,nonlin_count


def main():
    start=time.monotonic()
    # The uniform inequalities are checked far beyond the function tests.
    budget=0
    for a in range(1,101):
        for j in range(1,a+1):
            assert 3*j+1<5**j
            for m in range(2,j+1):
                assert 2*j+6-2*m<5**j
                budget+=1
    gens=nonlinear=0
    for a in range(1,5):
        g,n=check_power(a)
        gens+=g; nonlinear+=n
        print(f'q={5**a}: {g} coefficient-basis generators, {n} nonlinear examples PASS')
    # A divided Frobenius expression is integral but not a homogeneous
    # additive polynomial until its *weighted* input is retained.
    mod=5**10
    def mult(x,y):
        return ((x[0]*y[0]+2*x[1]*y[1])%mod,
                (x[0]*y[1]+x[1]*y[0])%mod)
    def power5(x): return mult(mult(mult(x,x),mult(x,x)),x)
    divided=0
    for m in range(1,6):
        for a0 in range(5):
            for a1 in range(5):
                x=(a0+10,a1+5)
                fx=(x[0],-x[1]%mod)
                x5=power5(x)
                scaled=tuple(5**(m+1)*v%mod for v in x)
                fs=(scaled[0],-scaled[1]%mod)
                s5=power5(scaled)
                num=tuple((v-w)%mod for v,w in zip(fs,s5))
                assert all(v%5==0 for v in num)
                delta=tuple(v//5 for v in num)
                expected=tuple((5**m*v-5**(5*m+4)*w)%(mod//5)
                               for v,w in zip(fx,x5))
                assert delta==expected
                divided+=1
    print(f'Total: {gens} generators, {nonlinear} nonlinear examples, {budget} budgets PASS')
    print(f'Divided Frobenius scaling: {divided} nonprime-field checks PASS.')
    print('Degree-five nonlinear terms included at q625; no polarization division used.')
    print(f'Elapsed: {time.monotonic()-start:.3f}s. Algebra only; not a geometric certificate.')


if __name__=='__main__':
    main()
