#!/usr/bin/env python3
"""Independent F5 re-encoding and explicit Bezout identities for square emptiness.

Sage Python. Uses std over the prime field, independently of the
extension-field slimgb calculation. Retains only final exact identities.
"""
import argparse
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing

def encode(poly):
    return [[list(e),int(c)] for e,c in sorted(poly.dict().items())]

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('net',type=Path)
    p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    data=json.loads(args.net.read_text());results=[]
    for chart in (2,1,0):
        names=['a']+['p'+str(i) for i in range(chart+1,3)]+['z'+str(i) for i in range(6)]
        R=PolynomialRing(GF(5),names,order='degrevlex');a=R.gen(0);rest=R.gens()[1:]
        nparams=2-chart;parameters=[R.zero()]*chart+[R.one()]+list(rest[:nparams]);z=rest[nparams:]
        coeff=[]
        for row in data['x_coefficients']:
            coeff.append(sum((code%5+(code//5)*a)*parameters[0]**e[0]*parameters[1]**e[1]*parameters[2]**e[2]
                             for code,e in zip(row,data['parameter_monomials'])))
        equations=[a*a-a-3]+[coeff[n]-sum(z[i]*z[n-i] for i in range(6) if 0<=n-i<6) for n in range(11)]
        start=time.time();print('START prime-field chart',chart,flush=True)
        I=R.ideal(equations);basis=I.groebner_basis(algorithm='singular:std')
        assert list(basis)==[R.one()]
        multipliers=R.one().lift(I)
        assert len(multipliers)==len(equations)
        assert sum(v*f for v,f in zip(multipliers,equations))==1
        terms=sum(len(v.dict()) for v in multipliers)
        results.append({'chart':chart,'variables':names,'equations':[encode(v) for v in equations],
                        'multipliers':[encode(v) for v in multipliers],'identity':1,'terms':terms,
                        'seconds':time.time()-start})
        args.output.write_text(json.dumps({'status':'RUNNING','charts':results},separators=(',',':'))+'\n')
        print('PASS chart',chart,'Bezout terms',terms,'seconds',results[-1]['seconds'],flush=True)
    args.output.write_text(json.dumps({'status':'PASS','scope':'Every geometric point of all three projective charts is excluded by an explicit prime-field polynomial identity1.',
                                      'charts':results},separators=(',',':'))+'\n')

if __name__=='__main__':main()
