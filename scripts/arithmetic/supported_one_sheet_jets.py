#!/usr/bin/env python3
"""Geometric one-sheet supported-function test, with character-scaled jets.

All columns of character j are divided by the same y0^j, so matrices
are over F_(5^8), although the marked points lie in F_(5^24).
The zero coefficients remain unrestricted geometric coefficients.
"""
import argparse,itertools,json,time
from pathlib import Path
from math import comb
from sage.all import GF,PolynomialRing,matrix

def compositions(n,r):
    if r==1:yield (n,);return
    for i in range(n+1):
        for tail in compositions(n-i,r-1):yield (i,)+tail

def field_and_jets(pole, characters=(0,1,2)):
    K=GF(5**8,'z');R=PolynomialRing(K,'x');x=R.gen()
    beta=(x*x-x-3).roots(multiplicities=False)[0]
    dec=lambda c:K(c%5)+K(c//5)*beta
    alpha=(x**4+dec(7)*x**3+dec(6)*x*x+dec(2)*x+dec(5)).roots(multiplicities=False)[0]
    P=R([dec(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
    roots=[alpha**(25**i) for i in range(4)];p0=P(alpha);zeta=dec(11)
    columns=[(i,j) for j in characters for i in range(max(-1,(pole-10*j)//3)+1)]
    jets=[]
    for aindex,a in enumerate(roots):
        pn=[sum((P[i]*comb(i,n)*a**(i-n) for i in range(n,11)),K(0)) for n in range(pole+1)]
        Y=[p0**((25**aindex-1)//3)]+[K(0)]*pole
        assert p0*Y[0]**3==P(a)
        for n in range(1,pole+1):
            old=sum((Y[i]*Y[j]*Y[n-i-j] for i in range(n+1) for j in range(n+1-i)),K(0))
            Y[n]=(pn[n]/p0-old)/(3*Y[0]**2)
        YY=[sum((Y[i]*Y[n-i] for i in range(n+1)),K(0)) for n in range(pole+1)]
        chars=[[K(1)]+[K(0)]*pole,Y,YY]
        phases=[]
        for phase in range(3):
            rows=[]
            for n in range(pole+1):
                rows.append([zeta**(phase*j)*sum((K(comb(i,k))*a**(i-k)*chars[j][n-k]
                     for k in range(min(i,n)+1)),K(0)) for i,j in columns])
            phases.append(rows)
        jets.append(phases)
    code=lambda a:sum(int(c)*5**i for i,c in enumerate(K(a).polynomial().list()))
    return K,columns,jets,dict(modulus=[int(c) for c in K.modulus()],beta=code(beta),
        alpha=code(alpha),p0=code(p0),zeta=code(zeta)),code

def main():
    ap=argparse.ArgumentParser();ap.add_argument('pole',type=int);ap.add_argument('output',type=Path)
    ap.add_argument('--characters',choices=['012','01','02'],default='012')
    args=ap.parse_args();start=time.monotonic();n=args.pole
    characters=[int(j) for j in args.characters]
    K,columns,jets,field,code=field_and_jets(n,characters)
    reps=[w for w in compositions(n,4) if w==min(w[i:]+w[:i] for i in range(4))]
    records=[];survivors=[]
    for index,w in enumerate(reps):
        occupied=[i for i,m in enumerate(w) if m]
        for tail in itertools.product(range(3),repeat=len(occupied)-1):
            phases=[0]*4
            for i,s in zip(occupied[1:],tail):phases[i]=s
            rows=[]
            for i,m in enumerate(w):rows.extend(jets[i][phases[i]][:m])
            M=matrix(K,rows);pivots=list(M.transpose().pivots());det=K(0)
            if len(pivots)==len(columns):det=M.matrix_from_rows(pivots).determinant();assert det
            else:
                survivors.append(dict(weights=w,phases=phases,rank=len(pivots),
                    kernel=[[code(c) for c in v] for v in M.right_kernel().basis()]))
            records.append(dict(weights=w,phases=phases,rows=pivots,det=code(det)))
        if (index+1)%100==0:print(index+1,'orbits',len(records),'systems',len(survivors),'survivors',flush=True)
    data=dict(pole=n,field=field,columns=columns,characters=characters,orbits=len(reps),systems=len(records),
        records=records,survivors=survivors,elapsed_seconds=time.monotonic()-start,
        scope='all one-sheet-per-fibre zero divisors of degree pole; not all support patterns with two sheets')
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(data,separators=(',',':'))+'\n')
    print('COMPLETE',n,len(records),'systems;',len(survivors),'survivors;',round(data['elapsed_seconds'],3),'seconds',flush=True)

if __name__=='__main__':main()
