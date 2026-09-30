#!/usr/bin/env python3
"""Exact square test in the remaining U-cube infinity boundary.

p0=1,p1=0 forces p2=0 from the odd degree13 coefficient. The
degree12 leading coefficient is a square; its root sign is fixed
without losing any geometric square.
"""
import argparse,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,prod

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('net',type=Path)
    ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();data=json.loads(a.net.read_text())
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'v')([2,4,1]));alpha=k.gen()
    decode=lambda n:k(n%5)+(n//5)*alpha
    R=PolynomialRing(k,['p'+str(i) for i in range(2,7)]+['z'+str(i) for i in range(6)],order='degrevlex')
    gs=R.gens();ps=[R.one(),R.zero()]+list(gs[:5]);z=list(gs[5:])
    def coefficients(parameters):
        return [sum(decode(c)*prod(p**i for p,i in zip(parameters,e))
               for c,e in zip(row,data['parameter_monomials']) if c) for row in data['x_coefficients']]
    original=coefficients(ps);assert original[14]==0 and original[13]==ps[2]**3
    ps[2]=R.zero();coeff=coefficients(ps);assert all(f==0 for f in coeff[13:])
    fac=coeff[12].factor();assert all(e%2==0 for f,e in fac)
    top=k(fac.unit()).sqrt()*prod(f**(e//2) for f,e in fac);assert top**2==coeff[12]
    z.append(top)
    eq=[coeff[n]-sum(z[i]*z[n-i] for i in range(7) if 0<=n-i<7) for n in range(12)]
    eq=[f for f in eq if f];used={'p2'};steps=[]
    while True:
        choices=[]
        for j,f in enumerate(eq):
            for v in gs:
                if str(v) in used or f.degree(v)!=1:continue
                c=f.derivative(v)
                if c and c.is_constant():
                    rhs=v-f/c;choices.append((len(rhs.monomials()),str(v),j,v,rhs))
        if not choices:break
        _,name,j,v,rhs=min(choices,key=lambda t:(t[0],t[1]));used.add(name)
        steps.append({'variable':name,'replacement':str(rhs),'equation':str(eq[j])})
        eq=[f.subs({v:rhs}) for n,f in enumerate(eq) if n!=j];eq=[f for f in eq if f]
    names=[str(v) for v in gs if str(v) not in used];S=PolynomialRing(k,names,order='degrevlex')
    hom=R.hom([S(str(v)) if str(v) in names else S.zero() for v in gs],S);eq=[hom(f) for f in eq]
    result={'status':'PREPARED','scope':'Entire p0=1,p1=0 square boundary; no actual-curve inference.',
            'forced_zero':'p2^3=0, hence p2=0 geometrically','leading_root':str(top),
            'variables':names,'substitutions':steps,'equations':[str(f) for f in eq]}
    a.output.write_text(json.dumps(result,indent=2)+'\n')
    print('PREPARED U-cube',len(names),'variables',len(eq),'equations',flush=True)
    start=time.time();I=S.ideal(eq);gb=I.groebner_basis(algorithm='singular:slimgb');empty=list(gb)==[S.one()]
    result.update(status='COMPLETE',empty=empty,dimension=-1 if empty else int(I.dimension()),
                  groebner_basis=[str(f) for f in gb],seconds=time.time()-start)
    a.output.write_text(json.dumps(result,indent=2)+'\n')
    print('DONE U-cube empty',empty,'seconds',result['seconds'],flush=True)

if __name__=='__main__':main()
