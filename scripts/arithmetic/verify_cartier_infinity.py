"""Independent portable replay of the infinity Cartier image calculation."""
import argparse
import importlib.util
import json
import sys
from pathlib import Path
sys.dont_write_bytecode=True
ap=argparse.ArgumentParser()
ap.add_argument('--portable-source',type=Path,required=True)
ap.add_argument('--certificate',type=Path,required=True)
args=ap.parse_args()
spec=importlib.util.spec_from_file_location('portable',args.portable_source)
p=importlib.util.module_from_spec(spec);spec.loader.exec_module(p)
data=json.loads(args.certificate.read_text())
M=p.cartier_matrix()
assert M==data['Cartier_matrix']
assert [list(a) for a in p.BASIS]==data['basis']
def rref(rows):
    a=[row[:] for row in rows];pivot=[]
    for col in range(21):
        i=len(pivot)
        found=next((j for j in range(i,len(a)) if a[j][col]),None)
        if found is None:continue
        a[i],a[found]=a[found],a[i]
        z=p.inverse(a[i][col]);a[i]=[p.mul(z,v) for v in a[i]]
        for j in range(len(a)):
            if j!=i and a[j][col]:
                z=a[j][col];a[j]=[p.sub(x,p.mul(z,y)) for x,y in zip(a[j],a[i])]
        pivot.append(col)
    return a[:len(pivot)],pivot
initial=[p.BASIS.index((6,1))] if data['mode']=='no_constant_term' else [p.BASIS.index(a) for a in ((9,0),(6,1),(3,2))]
block=[[int(j==i) for j in range(21)] for i in initial]
rows=[];nullities=[]
for _ in data['constraint_nullities']:
    rows+=block
    rr,pivots=rref(rows);nullities.append(21-len(pivots))
    block=[[p.power(x,5) for x in row] for row in p.multiply(block,M)]
assert nullities==data['constraint_nullities']
kernel=[]
for f in range(21):
    if f in pivots:continue
    v=[0]*21;v[f]=1
    for i,j in enumerate(pivots):v[j]=p.neg(rr[i][f])
    kernel.append(v)
expected=[p.BASIS.index((i,2)) for i in range(4 if data['mode']=='no_constant_term' else 3)]
images=[]
for v in kernel:
    w=[a[0] for a in p.multiply(M,[[p.power(c,5)] for c in v])]
    assert all(not a for i,a in enumerate(w) if i not in expected)
    images.append(w)
_,piv=rref(images)
assert len(piv)==len(expected)
print('PASS',data['mode'],'nullities',nullities,'Cartier image is exactly the rational differential space of dimension',len(expected))
