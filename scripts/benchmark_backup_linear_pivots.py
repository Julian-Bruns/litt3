#!/usr/bin/env python3
"""Compare exact affine pivot choices, not just the number of variables.

The two additional linear rows must be independently replayed consequences.
Every candidate preserves the same ideal and uses the same degree-two
multiplier rule, in a different explicitly recorded affine coordinate chart.
The support score is diagnostic; a smaller score is not a solve verdict.
"""
import argparse
import itertools
import json
import subprocess
import sys
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix
from export_polynomial_macaulay import export_system

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('source',type=Path);p.add_argument('consequences',type=Path)
p.add_argument('out',type=Path);p.add_argument('--seconds',type=int,default=90)
args=p.parse_args();args.out.mkdir(exist_ok=False)
scripts=Path(__file__).resolve().parent;start=time.monotonic()
data=json.loads(args.source.read_text())
K=GF(5**data['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(data['field_modulus']))
R=PolynomialRing(K,data['variables'],order='degrevlex')
equations=[R({tuple(e):K(c) for e,c in f}) for f in data['equations']]
linear=[];certificates=[]
for path in sorted(args.consequences.glob('consequence*.json')):
    if not path.stem[len('consequence'):].isdigit():continue
    cert=json.loads(path.read_text())
    f=R({tuple(e):K(c) for e,c in cert['polynomial']})
    if f.total_degree()!=1:continue
    subprocess.run(['python3',str(scripts/'verify_field_macaulay_certificate.py'),
        str(args.source),str(path),'--kind','consequence'],check=True,capture_output=True)
    linear.append(f);certificates.append(str(path.resolve()))
assert len(linear)==2
active=sorted({v for f in linear for v in f.variables()},key=str)
records=[];complete=True;singular=[]
for pivots in itertools.combinations(active,2):
    if time.monotonic()-start>args.seconds:
        complete=False;break
    coefficients=matrix(K,[[f.monomial_coefficient(v) for v in pivots] for f in linear])
    if not coefficients.is_invertible():
        singular.append(list(map(str,pivots)));continue
    names=list(map(str,pivots))+[n for n in data['variables'] if n not in set(map(str,pivots))]
    ring=PolynomialRing(K,names,order='degrevlex')
    folder=args.out/('_'.join(map(str,pivots)))
    t=time.monotonic()
    export_system(ring,[ring(f) for f in equations+linear],folder,
                  c_degree=0,full_degree=2,field_only=True)
    source=json.loads((folder/'source.json').read_text())
    assert set(source['substitutions'])==set(map(str,pivots))
    (folder/'predecessors.json').write_text(json.dumps(dict(
        previous_source=str(args.source.resolve()),certificates=certificates,
        variable_order=names,scope='Same equations reordered by variable names; certified affine consequences'),indent=2)+'\n')
    proc=subprocess.run([sys.executable,str(scripts/'diagnose_macaulay_field_support.py'),
        str(folder/'source.json'),'--preserve-degree','2',
        '--receipt',str(folder/'peeling_low2.json')],check=True,capture_output=True,text=True)
    peel=json.loads(proc.stdout)
    record=dict(pivots=list(map(str,pivots)),equation_terms=sum(map(len,source['equations'])),
        monomial_columns=len(source['monomials']),remaining_rows=peel['remaining_rows'],
        remaining_columns=peel['remaining_columns'],remaining_terms=peel['remaining_nonzeros'],
        seconds=time.monotonic()-t,source=str((folder/'source.json').resolve()))
    records.append(record);print(json.dumps(record),flush=True)
result=dict(status='complete' if complete else 'bounded_candidate_scan',
    seconds=time.monotonic()-start,candidates=records,singular_pivot_pairs=singular,
    ranking=sorted(records,key=lambda r:(r['remaining_terms'],r['remaining_columns'])),
    scope='Exact equivalent-ideal affine charts, finite support diagnostic only')
(args.out/'result.json').write_text(json.dumps(result,indent=2)+'\n')
print('PIVOT_COMPARISON_COMPLETE',len(records),flush=True)
