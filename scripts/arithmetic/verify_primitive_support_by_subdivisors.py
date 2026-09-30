#!/usr/bin/env python3
"""Independent geometric support exhaustion through short subdivisors.

For l=dim L(nO), every supported divisor contains a subdivisor of
degree l-1. Enumerate these short divisors (one or two sheets per
fibre). A rank-one kernel fixes the function. For a larger kernel,
its common marked base divisor has degree<n; a supported function
must lie in one of the twelve next-jet hyperplanes. Recursion in
dimension therefore covers all such functions, including deficient
initial ranks. This does not use the other search's prefix tree,
scaled-character field, or jet recurrence.
"""
import argparse,itertools,json,hashlib,time
from pathlib import Path
from sage.all import GF,PolynomialRing,PowerSeriesRing,matrix,vector

def compositions(n,r):
    if r==1:yield(n,);return
    for a in range(n+1):
        for b in compositions(n-a,r-1):yield(a,)+b

def patterns(m,first):
    if m==0:return [(0,0,0)]
    result=[]
    for i in ((0,) if first else range(3)):
        a=[0]*3;a[i]=m;result.append(tuple(a))
    for i,j in (((0,1),) if first else ((0,1),(1,2),(2,0))):
        for a in range(1,m):
            w=[0]*3;w[i]=a;w[j]=m-a;result.append(tuple(w))
    return result

def main():
    ap=argparse.ArgumentParser();ap.add_argument('pole',type=int);ap.add_argument('output',type=Path)
    args=ap.parse_args();n=args.pole;start=time.monotonic();last=start
    K=GF(5**24,'z');R=PolynomialRing(K,'x');x=R.gen()
    beta=(x*x-x-3).roots(multiplicities=False)[0]
    dec=lambda c:K(c%5)+K(c//5)*beta
    alpha=(x**4+dec(7)*x**3+dec(6)*x*x+dec(2)*x+dec(5)).roots(multiplicities=False)[0]
    P=R([dec(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
    A=R([dec(c) for c in [1,21,14,22,13]])
    y0=(x**3-P(alpha)).roots(multiplicities=False)[0];zeta=dec(11)
    cols=sorted([(i,j) for j in range(3) for i in range((n-10*j)//3+1)],
                key=lambda v:3*v[0]+10*v[1],reverse=True)
    dim=len(cols);assert 3*cols[0][0]+10*cols[0][1]==n
    degree=dim-1;nonpoly=[i for i,c in enumerate(cols) if c[1]]
    PS=PowerSeriesRing(K,'t',default_prec=n+1);t=PS.gen();power=5
    while power<=n:power*=5
    inverse=pow(3,-1,power);jets=[]
    for i in range(4):
        a=alpha**(25**i);y=y0**(25**i)
        assert A(a)==0 and P(a)!=0 and y**3==P(a)
        Y=y*PS(P(a+t)/P(a)).add_bigoh(n+1)**inverse
        assert (Y**3-PS(P(a+t))).valuation()>=n+1
        for phase in range(3):
            values=[PS((a+t)**u*(zeta**phase*Y)**v) for u,v in cols]
            jets.append([vector(K,[p[j] for p in values]) for j in range(n+1)])
    encode=lambda a:sum(int(c)*5**i for i,c in enumerate(K(a).polynomial().list()))
    stats=dict(short_divisors=0,kernel_dimensions={},recursive_spaces=0,
               line_checks=0,polynomial_spaces=0,top_zero_spaces=0,max_marked_zeros=0)
    digest=hashlib.sha256();survivors=[]

    def inspect(basis):
        stats['recursive_spaces']+=1
        if not basis:return
        if all(not v[0] for v in basis):stats['top_zero_spaces']+=1;return
        if all(not v[j] for v in basis for j in nonpoly):
            stats['polynomial_spaces']+=1;return
        common=[];functionals=[]
        for point in range(12):
            for order,row in enumerate(jets[point]):
                value=vector(K,[v.dot_product(row) for v in basis])
                if value:
                    common.append(order);functionals.append(value);break
            else:raise AssertionError('Nonzero exact-pole section cannot vanish to order>n')
        if len(basis)==1:
            stats['line_checks']+=1;total=sum(common)
            assert total<=n;stats['max_marked_zeros']=max(stats['max_marked_zeros'],total)
            v=basis[0]/basis[0][0]
            codes=[encode(c) for c in v]
            digest.update(json.dumps([codes,common],separators=(',',':')).encode()+b'\n')
            if total==n:
                witness=dict(coefficients=codes,orders=common)
                survivors.append(witness);print('EXACT WITNESS',witness,flush=True)
            return
        assert sum(common)<n, 'A degree-zero line cannot have two independent sections'
        # Every remaining supported function must gain at least one zero
        # beyond this common divisor, at one of these twelve points.
        for values in functionals:
            W=matrix(K,[values]).right_kernel_matrix()
            B=matrix(K,basis)
            inspect(list((W*B).rows()))

    reps=[w for w in compositions(degree,4) if w==min(w[i:]+w[:i] for i in range(4))]
    for w in reps:
        first=next(i for i,m in enumerate(w) if m)
        choices=[patterns(m,i==first) for i,m in enumerate(w)]
        for assignment in itertools.product(*choices):
            orders=[j for block in assignment for j in block];assert sum(orders)==degree
            rows=[]
            for point,m in enumerate(orders):rows.extend(jets[point][:m])
            basis=list(matrix(K,rows).right_kernel_matrix().rows())
            stats['short_divisors']+=1
            r=str(len(basis));stats['kernel_dimensions'][r]=stats['kernel_dimensions'].get(r,0)+1
            inspect(basis)
        now=time.monotonic()
        if now-last>15:
            print('pole',n,'subdivisor-degree',degree,'stats',stats,'seconds',round(now-start,2),flush=True);last=now
    result=dict(result='PASS_NO_NONPOLYNOMIAL_PRIMITIVE_FUNCTION' if not survivors else 'EXACT_WITNESS',
        pole=n,short_divisor_degree=degree,columns=cols,stats=stats,survivors=survivors,
        transcript_sha256=digest.hexdigest(),elapsed_seconds=time.monotonic()-start,
        field=dict(modulus=[int(c) for c in K.modulus()],beta=encode(beta),alpha=encode(alpha),y0=encode(y0)),
        scope='all geometric exact-pole functions with at most two occupied sheets in every marked fibre',
        independent_methods=['unscaled F5^24 jets','power-series cubic root','short subdivisor cover','library kernel bases','dimension-decreasing base-divisor hyperplane recursion'])
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(result,indent=2)+'\n')
    print('COMPLETE',json.dumps(result),flush=True)

if __name__=='__main__':main()
