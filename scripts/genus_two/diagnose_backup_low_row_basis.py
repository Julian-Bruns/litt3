#!/usr/bin/env python3
"""Measured A18 native-RREF transfer to actual backup polynomial rows."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse
import json
import time
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix
from scripts.atlases.native.atlas_native_rref import NativeRref

p=argparse.ArgumentParser(description=__doc__);p.add_argument('source',type=Path)
p.add_argument('--audit-sage',action='store_true')
args=p.parse_args();start=time.monotonic();data=json.loads(args.source.read_text())
K=GF(5**data['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(data['field_modulus']))
low=[f for f in data['equations'] if max(sum(e) for e,c in f)<=2]
monomials=sorted({tuple(e) for f in low for e,c in f},key=lambda e:(sum(e),e),reverse=True)
index={e:i for i,e in enumerate(monomials)}
M=matrix(K,len(low),len(monomials),{(i,index[tuple(e)]):K(c) for i,f in enumerate(low) for e,c in f},sparse=False,implementation='generic')
engine=NativeRref(K);A,C=engine.rref(M,audit_sage=args.audit_sage)
degrees=[];counts=[]
for row in A:
    support=[j for j,c in enumerate(row) if c]
    degrees.append(max(sum(monomials[j]) for j in support));counts.append(len(support))
print(json.dumps(dict(input_rows=len(low),columns=len(monomials),rank=A.nrows(),
    input_nonzeros=sum(len(f) for f in low),rref_nonzeros=sum(counts),
    rref_linear_rows=degrees.count(1),rref_constant_rows=degrees.count(0),
    smallest_row_terms=sorted(counts)[:15],native_records=engine.records,
    total_seconds=time.monotonic()-start,scope='Exact constant row-basis diagnostic; no exclusion'),indent=2))
