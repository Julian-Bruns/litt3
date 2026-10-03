#!/usr/bin/env sage
"""Exact source-line determinants at one fixed contact slope, not all slopes."""
from sage.all import *
import argparse,json,time
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);args=ap.parse_args();data=args.work/'data';start=time.time()
E=GF(5**24,'z');B=PolynomialRing(E,'Z');Z=B.gen();beta=(Z**2-Z-3).roots(multiplicities=False)[0]
def bcode(c):return E(c%5)+E(c//5)*beta
alpha=sum((bcode(c)*Z**i for i,c in enumerate((5,2,6,7,1))),B.zero()).roots(multiplicities=False)[0];rho=(Z**3-bcode(6)).roots(multiplicities=False)[0]
cache={}
def decode(c):
    c=int(c)
    if c not in cache:
        n=c;v=E.zero()
        for j in range(3):
            q=n%390625;n//=390625;s=E.zero()
            for i in range(4):s+=bcode(q%25)*alpha**i;q//=25
            v+=s*rho**j
        cache[c]=v
    return cache[c]
first=json.loads((data/'critical_quadratic_endpoint_probe.json').read_text())['records'];second=json.loads((data/'critical_quadratic_endpoint_probe_lambda2.json').read_text())['records'];R=PolynomialRing(E,'lam');lam=R.gen();results=[]
for left in first:
    if 'concentrated' not in left['name']:continue
    right=next(r for r in second if r['name']==left['name']);assert left['row_tags']==right['row_tags'] and len(left['homogeneous_source_kernel'])==2
    l1=decode(left['lambda']);l2=decode(right['lambda']);assert l1!=l2
    M1=matrix(E,[[decode(c) for c in row] for row in left['matrix']]);M2=matrix(E,[[decode(c) for c in row] for row in right['matrix']]);direction=(M2-M1)/(l2-l1)
    M=matrix(R,15,15,[R(M1[i,j])+(lam-l1)*direction[i,j] for i in range(15) for j in range(15)])
    det=M.det();assert det.degree()<=15 and det(l1)==M1.det() and det(l2)==M2.det()
    lead=R(decode(left['critical_cubic_leading_at_endpoint']))+(lam-l1)*(decode(right['critical_cubic_leading_at_endpoint'])-decode(left['critical_cubic_leading_at_endpoint']))/(l2-l1)
    fac=list(det.factor());remaining=det
    power=0
    if lead.degree()==1:
        while remaining and not remaining%lead:remaining//=lead;power+=1
    print('SLICE',left['name'],'DETDEG',det.degree(),'A3FACTORPOWER',power,'REMAININGDEG',remaining.degree(),'FACTORS',[(f.degree(),n) for f,n in fac],'SECONDS',time.time()-start,flush=True)
    results.append({'name':left['name'],'matrix':M,'determinant':det,'factorization':fac,'critical_leading':lead,'leading_factor_power':power,'remaining':remaining,'scope':'all source tuples on the affine kappa=1 source line at eta=1 only'})
save({'E':E,'beta':beta,'alpha':alpha,'rho':rho,'R':R,'records':results},str(data/'critical_quadratic_endpoint_source_slices.sobj'))
(data/'critical_quadratic_endpoint_source_slices.json').write_text(json.dumps({'scope':'source-line determinants at one fixed slope only','records':[{'name':r['name'],'determinant_degree':int(r['determinant'].degree()),'leading_factor_power':int(r['leading_factor_power']),'remaining_degree':int(r['remaining'].degree()),'factor_degrees_multiplicities':[(int(f.degree()),int(n)) for f,n in r['factorization']]} for r in results]},separators=(',',':'))+'\n')
