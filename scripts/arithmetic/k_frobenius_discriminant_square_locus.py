#!/usr/bin/env python3
"""Exact geometric square-locus calculation in all three parameter charts.

Sage Python. Save only the input equations, resulting bases and compact
outcomes; do not save elimination intermediates.
"""
import argparse
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('net',type=Path)
    p.add_argument('--output',type=Path,required=True);args=p.parse_args()
    data=json.loads(args.net.read_text())
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'v')([2,4,1]));alpha=k.gen()
    decode=lambda n:k(n%5)+(n//5)*alpha
    result={'status':'RUNNING','scope':'Full projective parameter locus where the degree<=10 discriminant is a polynomial square, including zero and lower-degree squares.','charts':[]}
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    for chart in (2,1,0):
        # Work from the smallest boundary to the two-dimensional chart.
        names=['p'+str(i) for i in range(chart+1,3)]+['z'+str(i) for i in range(6)]
        R=PolynomialRing(k,names,order='degrevlex');gens=R.gens();nparams=2-chart
        parameters=[R.zero()]*chart+[R.one()]+list(gens[:nparams]);z=gens[nparams:]
        coeff=[]
        for row in data['x_coefficients']:
            coeff.append(sum(decode(a)*parameters[0]**e[0]*parameters[1]**e[1]*parameters[2]**e[2]
                             for a,e in zip(row,data['parameter_monomials'])))
        equations=[coeff[n]-sum(z[i]*z[n-i] for i in range(6) if 0<=n-i<6) for n in range(11)]
        start=time.time();print('START chart',chart,'variables',len(gens),'equations',len(equations),flush=True)
        I=R.ideal(equations);basis=I.groebner_basis(algorithm='singular:slimgb')
        empty=len(basis)==1 and basis[0]==1
        row={'first_nonzero_parameter':chart,'variables':names,'equations':[str(v) for v in equations],
             'groebner_basis':[str(v) for v in basis],'empty':empty,'seconds':time.time()-start}
        result['charts'].append(row);args.output.write_text(json.dumps(result,indent=2)+'\n')
        print('DONE chart',chart,'basis length',len(basis),'empty',empty,'seconds',row['seconds'],flush=True)
    result['status']='EMPTY' if all(c['empty'] for c in result['charts']) else 'NONEMPTY'
    args.output.write_text(json.dumps(result,indent=2)+'\n');print('COMPLETE',result['status'],flush=True)

if __name__=='__main__':main()
