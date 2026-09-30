"""Verify every degree-twelve cube identity and its polynomial Bezout obstruction.

Uses independent standard-library field arithmetic from the degree-ten
verifier. Run with the JSON produced by pole_twelve_norm_support.sage.
"""
import json
import sys
import verify_pole_ten_norm_support as f

def trim(a):
    a=list(a)
    while a and not a[-1]:a.pop()
    return a
def add(a,b):
    return trim([f.padd(a[i] if i<len(a) else [],b[i] if i<len(b) else [])
                 for i in range(max(len(a),len(b)))])
def neg(a):return [[f.neg(c) for c in b] for b in a]
def sub(a,b):return add(a,neg(b))
def mul(a,b):
    if not a or not b:return []
    c=[[] for _ in range(len(a)+len(b)-1)]
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]=f.padd(c[i+j],f.pmul(x,y))
    return trim(c)
def cube(a):return mul(mul(a,a),a)
def decode(a):return [f.code(x) for x in a]
def polys(a):return [decode(x) for x in a]
cert=json.load(open(sys.argv[1]))
assert cert['nonzero_c_patterns']==[] and len(cert['rows'])==455
seen=set(); rational=0
for row in cert['rows']:
    weights=tuple(row['weights'])
    assert len(weights)==4 and min(weights)>=0 and sum(weights)==12
    assert weights not in seen;seen.add(weights)
    S=[1]
    for r,m in zip(f.roots,weights):
        for _ in range(m):S=f.pmul(S,[f.neg(r),1])
    target=sub([[a] if a else [] for a in S],[[0,a] if a else [] for a in f.P])
    root=polys(row['root'])
    residual=polys(row['residual'])
    assert sub(target,cube(root))==trim(residual)
    bezout=polys(row['bezout'])
    assert len(bezout)==len(residual)
    total=[]
    for a,b in zip(bezout,residual):total=f.padd(total,f.pmul(a,b))
    gcd=decode(row['gcd']);r=row['zero_root_multiplicity']
    assert total==gcd==[0]*r+[1]
    if r:
        assert all(not a or a[0]==0 for a in residual)
        assert all(m%3==0 for m in weights)
        rational+=1
    else:assert any(m%3 for m in weights)
assert rational==cert['zero_c_patterns']==35
print('PASS: 455 exact geometric ideals; only 35 polynomial degree-twelve functions remain.')
