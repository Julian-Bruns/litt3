#!/usr/bin/env python3
"""Standard-library verification of all three explicit square-locus identities."""
import argparse
import hashlib
import json
from pathlib import Path

def add_term(p,e,c):
    c=(p.get(e,0)+c)%5
    if c:p[e]=c
    else:p.pop(e,None)

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('net',type=Path)
    p.add_argument('certificate',type=Path);p.add_argument('--output',type=Path,required=True)
    a=p.parse_args();net=json.loads(a.net.read_text());cert=json.loads(a.certificate.read_text())
    assert cert['status']=='PASS';results=[]
    for row in cert['charts']:
        chart=row['chart'];n=len(row['variables']);nparams=2-chart
        zero=(0,)*n;eq=[]
        field={}
        for power,c in ((2,1),(1,4),(0,2)):
            e=list(zero);e[0]=power;add_term(field,tuple(e),c)
        eq.append(field)
        for degree in range(11):
            f={}
            for powers,code in zip(net['parameter_monomials'],net['x_coefficients'][degree]):
                if any(powers[j] for j in range(chart)):continue
                e=list(zero)
                for j in range(chart+1,3):e[1+j-chart-1]=powers[j]
                add_term(f,tuple(e),code%5)
                e[0]+=1;add_term(f,tuple(e),code//5)
            for i in range(6):
                if not 0<=degree-i<6:continue
                e=list(zero);e[1+nparams+i]+=1;e[1+nparams+degree-i]+=1
                add_term(f,tuple(e),4)
            eq.append(f)
        recorded=[{tuple(e):c for e,c in f} for f in row['equations']]
        assert eq==recorded
        total={}
        for f,entries in zip(eq,row['multipliers']):
            for e,c in entries:
                for ee,cc in f.items():add_term(total,tuple(x+y for x,y in zip(e,ee)),c*cc)
        assert total=={zero:1}
        count=sum(len(v) for v in row['multipliers'])
        assert count==row['terms']
        results.append({'chart':chart,'witness_terms':count,'identity_verified':True})
        print('PASS: prime-field identity1 for chart',chart,'with',count,'witness terms',flush=True)
    assert {r['chart'] for r in results}=={0,1,2}
    a.output.write_text(json.dumps({'status':'PASS','scope':'Reconstructed every equation from the discriminant net and verified each Bezout identity by elementary F5 arithmetic, without a computer algebra package.',
        'net_sha256':hashlib.sha256(a.net.read_bytes()).hexdigest(),
        'certificate_sha256':hashlib.sha256(a.certificate.read_bytes()).hexdigest(),'charts':results},indent=2)+'\n')

if __name__=='__main__':main()
