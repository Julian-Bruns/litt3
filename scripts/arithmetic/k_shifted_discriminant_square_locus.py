#!/usr/bin/env python3
"""Geometric square-locus charts for the shifted seven-parameter cubic net.

Sage Python. Each completed chart is checkpointed. No intermediate
Groebner expansion or full log is retained.
"""
import argparse
import json
from pathlib import Path
import time
from sage.all import GF,PolynomialRing,prod

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('net',type=Path)
    p.add_argument('--output',type=Path,required=True);p.add_argument('--first-chart',type=int,default=6)
    p.add_argument('--last-chart',type=int,default=0);args=p.parse_args()
    data=json.loads(args.net.read_text());assert data['O_shift']==1
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'v')([2,4,1]));alpha=k.gen()
    decode=lambda n:k(n%5)+(n//5)*alpha
    result={'status':'RUNNING','scope':'Projective square locus, including zero and every lower-degree square.','charts':[]}
    for chart in range(args.first_chart,args.last_chart-1,-1):
        names=['p'+str(i) for i in range(chart+1,7)]+['z'+str(i) for i in range(8)]
        R=PolynomialRing(k,names,order='degrevlex');gs=R.gens();np=6-chart
        pars=[R.zero()]*chart+[R.one()]+list(gs[:np]);z=gs[np:]
        coeff=[sum(decode(a)*prod(v**i for v,i in zip(pars,e)) for a,e in zip(row,data['parameter_monomials']) if a)
               for row in data['x_coefficients']]
        eq=[coeff[n]-sum(z[i]*z[n-i] for i in range(8) if 0<=n-i<8) for n in range(15)]
        start=time.time();print('START chart',chart,'variables',len(gs),flush=True)
        I=R.ideal(eq);gb=I.groebner_basis(algorithm='singular:slimgb')
        empty=list(gb)==[R.one()]
        row={'chart':chart,'empty':empty,'dimension':-1 if empty else int(I.dimension()),
             'variables':names,'groebner_basis':[str(g) for g in gb],'seconds':time.time()-start}
        result['charts'].append(row);args.output.write_text(json.dumps(result,indent=2)+'\n')
        print('DONE chart',chart,'empty',empty,'dimension',row['dimension'],'seconds',row['seconds'],flush=True)
    result['status']='COMPLETE';args.output.write_text(json.dumps(result,indent=2)+'\n')

if __name__=='__main__':main()
