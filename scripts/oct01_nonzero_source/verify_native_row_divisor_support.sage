#!/usr/bin/env sage
"""Focused domain check: can the existing module specialize to m3?"""
from sage.all import *
import argparse,json,time,numpy as np
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('directory',type=Path);args=p.parse_args();d=args.directory;start=time.time()
meta=json.loads((d/'metadata.json').read_text());r=PolynomialRing(GF(5),'z');z=r.gen();K=GF(5**8,'zz',modulus=sum((GF(5)(c)*z**i for i,c in enumerate(meta['field_modulus'])),r.zero()));R=PolynomialRing(K,'eta',implementation='NTL');eta=R.gen()
def decode(raw):return R([K.from_integer(int(c)) for c in raw])
raw=np.fromfile(d/'units.bin',dtype='<u4');pos=0;units=[]
while pos<len(raw):
    n=int(raw[pos]);pos+=1;units.append(decode(raw[pos:pos+n]));pos+=n
assert len(units)==3
Jsmall=units[0]*units[2];bad=[];records=[]
for item in json.loads((d/'row_divisors.json').read_text())['divisors']:
    f=decode(item['coefficients']);remaining=f
    while remaining.degree()>0:
        g=remaining.gcd(Jsmall)
        if g.degree()==0:break
        remaining=remaining//g
    records.append({'degree':int(f.degree()),'uses':int(item['uses']),'unsupported_degree':int(remaining.degree()),'unsupported_coefficients':[int(c.to_integer()) for c in remaining.list()]})
    if remaining.degree()>0:bad.append(remaining)
report={'status':'PASS' if not bad else 'm6leading_still_required','root':int(meta['root']),'scope':'all literal row divisors supported on H times selected critical leading; exact m6 leading removed only if PASS','divisors':records,'seconds':time.time()-start}
(d/'row_divisor_support.json').write_text(json.dumps(report,separators=(',',':'))+'\n');print(json.dumps(report))
