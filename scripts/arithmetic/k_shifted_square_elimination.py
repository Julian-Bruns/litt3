#!/usr/bin/env python3
"""Geometric square-chart reduction with exact constant-coefficient elimination.

Drop square-root coefficients forced to vanish by degree. Each following
elimination solves one variable with a nonzero constant coefficient;
the retained equations and substitutions determine the whole chart.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing, TermOrder, prod

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('net',type=Path);p.add_argument('--output',type=Path,required=True)
    p.add_argument('--chart',type=int,required=True);p.add_argument('--prepare-only',action='store_true')
    p.add_argument('--weighted',action='store_true')
    args=p.parse_args();data=json.loads(args.net.read_text())
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'v')([2,4,1]));alpha=k.gen()
    decode=lambda n:k(n%5)+(n//5)*alpha
    names=['p'+str(i) for i in range(args.chart+1,7)]+['z'+str(i) for i in range(7)]
    order=TermOrder('wdegrevlex',tuple(2 if n.startswith('z') else 1 for n in names)) if args.weighted else 'degrevlex'
    R=PolynomialRing(k,names,order=order);gs=R.gens();np=6-args.chart
    pars=[R.zero()]*args.chart+[R.one()]+list(gs[:np])
    coeff=[sum(decode(a)*prod(v**i for v,i in zip(pars,e))
               for a,e in zip(row,data['parameter_monomials']) if a)
           for row in data['x_coefficients']]
    degree=max(i for i,f in enumerate(coeff) if f)
    z=list(gs[np:])+[k(3).sqrt()*pars[0]*pars[1]]
    forced=[]
    for i in range(degree//2+1,8):
        if z[i]:
            assert z[i] in gs
            forced.append(str(z[i]));z[i]=R.zero()
    eq=[coeff[n]-sum(z[i]*z[n-i] for i in range(8) if 0<=n-i<8) for n in range(15)]
    eq=[f for f in eq if f]
    used=set(forced);steps=[]
    while True:
        choices=[]
        for j,f in enumerate(eq):
            for v in gs:
                if str(v) in used:continue
                if f.degree(v)!=1:continue
                c=f.derivative(v)
                if c and c.is_constant():
                    rhs=v-f/c
                    choices.append((len(rhs.monomials()),str(v),j,v,rhs))
        if not choices:break
        _,name,j,v,rhs=min(choices,key=lambda a:(a[0],a[1]))
        steps.append({'variable':name,'replacement':str(rhs),'equation':str(eq[j])})
        used.add(name);eq=[f.subs({v:rhs}) for n,f in enumerate(eq) if n!=j]
        eq=[f for f in eq if f]
        print('ELIMINATED',name,'replacement terms',len(rhs.monomials()),flush=True)
    remaining=[str(v) for v in gs if str(v) not in used]
    order=TermOrder('wdegrevlex',tuple(2 if n.startswith('z') else 1 for n in remaining)) if args.weighted else 'degrevlex'
    S=PolynomialRing(k,remaining,order=order)
    hom=R.hom([S(str(v)) if str(v) in remaining else S.zero() for v in gs],S)
    eq=[hom(f) for f in eq]
    receipt={'status':'PREPARED','scope':'Exact chart equivalence; high square-root vanishing used only geometrically.',
             'net_sha256':hashlib.sha256(args.net.read_bytes()).hexdigest(),'chart':args.chart,
             'discriminant_degree':degree,'weighted_order':args.weighted,
             'forced_zero_root_coefficients':forced,'substitutions':steps,
             'variables':remaining,'equations':[str(f) for f in eq]}
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PREPARED',args.chart,'variables',len(remaining),'equations',len(eq),flush=True)
    if args.prepare_only:return
    start=time.time();I=S.ideal(eq);gb=I.groebner_basis(algorithm='singular:slimgb')
    empty=list(gb)==[S.one()]
    receipt.update(status='COMPLETE',empty=empty,dimension=-1 if empty else int(I.dimension()),
                   groebner_basis=[str(f) for f in gb],seconds=time.time()-start)
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('DONE',args.chart,'empty',empty,'dimension',receipt['dimension'],'seconds',receipt['seconds'],flush=True)

if __name__=='__main__':main()
