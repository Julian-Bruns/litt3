#!/usr/bin/env python3
"""Necessary cyclic-norm jets at the V-cube infinity fiber of F^*K(O).

In this chart p0=0,p1=1. Local cyclic action forces p3=2*p2^2
and the next U^3 coefficient to be3*p2^3. The discriminant then has
degree at most10. This excludes no other chart.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing, prod

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('net',type=Path);p.add_argument('sections',type=Path)
    p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    data=json.loads(args.net.read_text());sections=json.loads(args.sections.read_text())
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'v')([2,4,1]));alpha=k.gen()
    decode=lambda n:k(n%5)+(n//5)*alpha
    R=PolynomialRing(k,['p'+str(i) for i in range(2,7)]+['z'+str(i) for i in range(6)],order='degrevlex')
    gs=R.gens();pars=[R.zero(),R.one()]+list(gs[:5]);z=list(gs[5:])
    row=[]
    for section in sections['sections']:
        row.append(decode(next((c for r,m,c in section['other_chart'][0] if (r,m)==(0,-25)),0)))
    endpoint=[pars[3]-2*pars[2]**2,sum(c*p for c,p in zip(row,pars))-3*pars[2]**3]
    coeff=[sum(decode(a)*prod(v**i for v,i in zip(pars,e))
               for a,e in zip(row,data['parameter_monomials']) if a)
           for row in data['x_coefficients']]
    eq=endpoint+[coeff[n]-sum(z[i]*z[n-i] for i in range(6) if 0<=n-i<6) for n in range(15)]
    eq=[f for f in eq if f];used=set();steps=[]
    while True:
        choices=[]
        for j,f in enumerate(eq):
            for v in gs:
                if str(v) in used or f.degree(v)!=1:continue
                c=f.derivative(v)
                if c and c.is_constant():
                    rhs=v-f/c;choices.append((len(rhs.monomials()),str(v),j,v,rhs))
        if not choices:break
        _,name,j,v,rhs=min(choices,key=lambda a:(a[0],a[1]))
        steps.append({'variable':name,'replacement':str(rhs),'equation':str(eq[j])})
        used.add(name);eq=[f.subs({v:rhs}) for n,f in enumerate(eq) if n!=j];eq=[f for f in eq if f]
        coeff=[f.subs({v:rhs}) for f in coeff]
        print('ELIMINATED',name,'terms',len(rhs.monomials()),flush=True)
    assert all(f==0 for f in coeff[11:]),'Cyclic-jet convention mismatch'
    factorization=coeff[10].factor()
    assert all(e%2==0 for f,e in factorization)
    root=k(factorization.unit()).sqrt()*prod(f**(e//2) for f,e in factorization)
    assert root**2==coeff[10]
    top=z[5]
    assert str(top) not in used
    steps.append({'variable':str(top),'replacement':str(root),
                  'justification':'Every square root can be negated; the chosen leading coefficient covers all geometric squares.'})
    used.add(str(top));eq=[f.subs({top:root}) for f in eq];eq=[f for f in eq if f]
    print('FIXED leading square-root sign',flush=True)
    remaining=[str(v) for v in gs if str(v) not in used]
    S=PolynomialRing(k,remaining,order='degrevlex')
    hom=R.hom([S(str(v)) if str(v) in remaining else S.zero() for v in gs],S)
    eq=[hom(f) for f in eq]
    receipt={'status':'PREPARED','scope':'Only the p0=0,p1=1 chart; necessary cyclic local norm identities.',
             'net_sha256':hashlib.sha256(args.net.read_bytes()).hexdigest(),
             'endpoint_equations':[str(f) for f in endpoint],
             'substitutions':steps,'variables':remaining,'equations':[str(f) for f in eq],
             'degree10_leading_factorization':str(hom(coeff[10]).factor())}
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PREPARED variables',len(remaining),'equations',len(eq),flush=True)
    print('LEADING',receipt['degree10_leading_factorization'],flush=True)
    start=time.time();I=S.ideal(eq);gb=I.groebner_basis(algorithm='singular:slimgb')
    empty=list(gb)==[S.one()]
    receipt.update(status='COMPLETE',empty=empty,dimension=-1 if empty else int(I.dimension()),
                   groebner_basis=[str(f) for f in gb],seconds=time.time()-start)
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('DONE empty',empty,'dimension',receipt['dimension'],'seconds',receipt['seconds'],flush=True)

if __name__=='__main__':main()
