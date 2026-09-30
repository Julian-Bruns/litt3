#!/usr/bin/env python3
"""Normalize p0*p1=1 on the open cyclic cubic chart.

Scaling the section makes this normalization exhaustive over the
algebraic closure. The leading square-root coefficient is constant,
so the upper seven coefficient equations solve its other coefficients.
"""
import argparse,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,prod

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('net',type=Path)
    ap.add_argument('--output',type=Path,required=True);ap.add_argument('--prepare-only',action='store_true')
    ap.add_argument('--retain-roots',action='store_true',help='Retain the small square circuit instead of expanding the root recurrence.')
    a=ap.parse_args();data=json.loads(a.net.read_text())
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'v')([2,4,1]));alpha=k.gen()
    decode=lambda n:k(n%5)+(n//5)*alpha
    names=['p'+str(i) for i in range(7)]
    if a.retain_roots:names+=['z'+str(i) for i in range(7)]
    R=PolynomialRing(k,names,order='degrevlex');ps=R.gens()[:7]
    def reduced(f):
        out={}
        for e,c in f.dict().items():
            e=list(e);m=min(e[0],e[1]);e[0]-=m;e[1]-=m;e=tuple(e)
            out[e]=out.get(e,k.zero())+c
        return R(out)
    coeff=[reduced(sum(decode(c)*prod(p**i for p,i in zip(ps,e))
                 for c,e in zip(row,data['parameter_monomials']) if c)) for row in data['x_coefficients']]
    assert coeff[14]==3
    if a.retain_roots:
        z=list(R.gens()[7:])+[R(k(3).sqrt())]
        eq=[ps[0]*ps[1]-1]+[coeff[n]-sum(z[i]*z[n-i] for i in range(8) if 0<=n-i<8) for n in range(14)]
        receipt={'status':'PREPARED','scope':'Exact square circuit on the geometrically exhaustive normalization p0*p1=1 of the nonzero-leading chart.',
                 'variables':names,'equations':[str(f) for f in eq],
                 'equation_term_counts':[len(f.monomials()) for f in eq]}
        a.output.write_text(json.dumps(receipt,indent=2)+'\n')
        print('PREPARED square circuit',len(names),'variables',len(eq),'equations',flush=True)
        return
    z=[R.zero() for _ in range(8)];z[7]=R(k(3).sqrt());counts=[]
    receipt={'status':'PREPARING','scope':'Only p0*p1 nonzero, with exhaustive projective scaling p0*p1=1.',
             'variables':[str(p) for p in ps],'root_term_counts':counts}
    for j in range(6,-1,-1):
        n=7+j
        known=sum(z[i]*z[n-i] for i in range(j+1,7) if 0<=n-i<8)
        z[j]=reduced((coeff[n]-known)/(2*z[7]))
        counts.append({'coefficient':j,'terms':len(z[j].monomials()),'degree':int(z[j].degree())})
        a.output.write_text(json.dumps(receipt,indent=2)+'\n')
        print('ROOT',j,'terms',counts[-1]['terms'],'degree',counts[-1]['degree'],flush=True)
    eq=[ps[0]*ps[1]-1]+[reduced(coeff[n]-sum(z[i]*z[n-i] for i in range(n+1))) for n in range(7)]
    # Exact reconstruction of the upper equations checks the recurrence.
    for n in range(7,15):
        assert reduced(coeff[n]-sum(z[i]*z[n-i] for i in range(8) if 0<=n-i<8))==0
    receipt.update(status='PREPARED',equations=[str(f) for f in eq],
                   root_coefficients=[str(f) for f in z],
                   equation_term_counts=[len(f.monomials()) for f in eq])
    a.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PREPARED',receipt['equation_term_counts'],flush=True)
    if a.prepare_only:return
    start=time.time();I=R.ideal(eq);gb=I.groebner_basis(algorithm='singular:slimgb')
    empty=list(gb)==[R.one()]
    receipt.update(status='COMPLETE',empty=empty,dimension=-1 if empty else int(I.dimension()),
                   groebner_basis=[str(f) for f in gb],seconds=time.time()-start)
    a.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('DONE empty',empty,'seconds',receipt['seconds'],flush=True)

if __name__=='__main__':main()
