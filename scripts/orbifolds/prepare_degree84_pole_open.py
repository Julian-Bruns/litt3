#!/usr/bin/env python3
"""Use the actual C(0)!=0 open to cancel certified C(0)-factors.

For an actual normalized map, u=0 is a SIMPLE zero, not a pole:
C(0)!=0. The inverse is retained as an equation, not assumed generic.
Each cancellation is g = inv*f - (inv*c0-1)*g with f=c0*g.
Every f has independent original-row replay before it is used.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse
import hashlib
import json
import subprocess
import sys
import time
from pathlib import Path
from sage.all import GF,PolynomialRing
from scripts.atlases.algebra.export_polynomial_macaulay import export_system

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('consequences',type=Path)
p.add_argument('out',type=Path);p.add_argument('--full-degree',type=int,default=2)
args=p.parse_args();start=time.monotonic()
raw=args.source.read_bytes();data=json.loads(raw)
K=GF(5**data['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(data['field_modulus']))
R=PolynomialRing(K,len(data['variables']),names=data['variables'],order='degrevlex')
c0=R('c0');index=data['variables'].index('c0')
equations=[R({tuple(e):K(c) for e,c in f}) for f in data['equations']]
records=[];derived=[];scripts=Path(__file__).resolve().parent
for path in sorted(args.consequences.glob('consequence*.json')):
    if not path.stem[len('consequence'):].isdigit():continue
    cert=json.loads(path.read_text());f=R({tuple(e):K(c) for e,c in cert['polynomial']})
    divided=all(e[index]>=1 for e,c in cert['polynomial'])
    if not divided and f.total_degree()>1:continue
    g=f//c0 if divided else f
    if divided:assert c0*g==f
    if g in equations or g in derived:continue
    check=subprocess.run(['python3',str(scripts/'verify_field_macaulay_certificate.py'),
        str(args.source),str(path),'--kind','consequence'],check=True,capture_output=True,text=True)
    derived.append(g)
    records.append(dict(certificate=str(path.resolve()),replay=json.loads(check.stdout),
        divide_by='c0' if divided else None,
        polynomial=[[list(e),[int(a) for a in c.polynomial().list()]] for e,c in sorted(g.dict().items())]))
S=PolynomialRing(K,R.ngens()+1,names=list(R.variable_names())+['pole0_inv'],order='degrevlex')
inv=S('pole0_inv');guard=inv*S(c0)-1
for record,g in zip(records,derived):
    if record['divide_by']:
        f=S(c0*g)
        assert inv*f-guard*S(g)==S(g)
export_system(S,[S(f) for f in equations]+[guard]+[S(g) for g in derived],args.out,
    c_degree=0,full_degree=args.full_degree,field_only=True,eliminate_linear=False)
receipt=dict(previous_source=str(args.source.resolve()),
    source_sha256=hashlib.sha256(raw).hexdigest(),derived=records,
    geometric_open='C(0)!=0: u=0 is a simple zero of the actual normalized quotient',
    inverse_equation='pole0_inv*c0-1',localization_identity='g=pole0_inv*f-(pole0_inv*c0-1)*g when f=c0*g',
    seconds=time.monotonic()-start,scope='Stronger necessary open system, not an exclusion')
(args.out/'localization_provenance.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(dict(derived=len(derived),divided=sum(bool(r['divide_by']) for r in records),
    linear=sum(g.total_degree()==1 for g in derived),seconds=time.monotonic()-start)),flush=True)
