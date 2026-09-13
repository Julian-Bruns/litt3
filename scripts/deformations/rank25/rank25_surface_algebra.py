"""Exact finite checks for the surface input. No fifth comparison is run."""
import json
from math import prod
from pathlib import Path

Z=(0,0,0,0);O=(1,0,0,0)
def digits(n):return tuple((n//5**i)%5 for i in range(4))
def add(a,b):return tuple((x+y)%5 for x,y in zip(a,b))
def mul(a,b):
    c=[0]*7
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]+=x*y
    for i in range(6,3,-1):
        for j,v in enumerate((3,4,1,4)):c[i-4+j]-=v*c[i]
    return tuple(v%5 for v in c[:4])
def power(a,n):
    if n<0:assert a!=Z;return power(power(a,623),-n)
    r=O
    while n:
        if n&1:r=mul(r,a)
        a=mul(a,a);n//=2
    return r
def total(values):
    r=Z
    for a in values:r=add(r,a)
    return r
def mv(A,v):return [total(mul(a,b) for a,b in zip(row,v)) for row in A]
def polyadd(a,b):
    r=[add(a[i] if i<len(a) else Z,b[i] if i<len(b) else Z) for i in range(max(len(a),len(b)))]
    while r and r[-1]==Z:r.pop()
    return r
def polymul(a,b):
    r=[Z]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):r[i+j]=add(r[i+j],mul(x,y))
    return polyadd(r,[])
def unpack(x):
    if isinstance(x,dict) and set(x)=={'shape','nonzero'}:
        flat=[Z]*prod(x['shape'])
        for i,c in x['nonzero']:flat[i]=digits(c)
        it=iter(flat)
        def nest(shape):return [nest(shape[1:]) for _ in range(shape[0])] if shape else next(it)
        return nest(x['shape'])
    if isinstance(x,dict):return {k:unpack(v) for k,v in x.items()}
    if isinstance(x,list):return [unpack(v) for v in x]
    return x
def load():return unpack(json.loads((Path(__file__).resolve().parent/'surface.json').read_text()))
def check():
    d=load();M=d['matrix'];normal={(i,j):r for i,j,r in d['normal4']}
    for a,b,z in d['fourth_digit']:assert mv(M,[power(v,5) for v in z])==normal[5*a,5*b]
    if 'optional_replacement_fourth_digit_10_0' in d:
        z=d['optional_replacement_fourth_digit_10_0']
        assert mv(M,[power(v,5) for v in z])==normal[50,0]
        assert max(i//15+(i//3)%5 for i,c in enumerate(z) if c!=Z)==2
    for v in d['kernel']:assert mv(M,[power(c,5) for c in v])==[Z]*75
    for row in d['dual']:assert mv(list(zip(*M)),row)==[Z]*75
    R=[Z,Z,Z,(3,0,0,0),O,Z,Z,(1,0,4,1),(0,2,3,0)]
    assert mv(list(zip(*d['dual'])),R)==d['omega']
    for _,_,J in d['relative_J']:assert mv(list(zip(*J)),R)==[Z]*9
    G=list(map(digits,d['known_curve_G']));co={int(e):digits(c) for e,c in d['known_curve_L'].items()}
    assert {5*i:power(c,5) for i,c in enumerate(G) if c!=Z}=={e+75:c for e,c in co.items() if c!=Z}
    e=d['established_curve_exclusion'];dec=lambda a:list(map(digits,a))
    Gm=dec(e['G_monic']);r0,r1=map(dec,e['residual_polynomials_mod_G'])
    separator=polyadd(r0,[mul(digits(e['separating_combination_coefficient']),v) for v in r1])
    assert polyadd(polymul(dec(e['bezout_G']),Gm),polymul(dec(e['bezout_separator']),separator))==[O]
    assert Gm==[mul(power(G[-1],-1),v) for v in G]
    print('PASS all fourth coefficient equations, kernel/dual identities, fixed relative row and known scalar fifth-root identity.')
    print('The surface fifth-lift locus and candidate trace remain the new question.')
    print('PASS finite Bezout identity for the established whole-curve exclusion.')
if __name__=='__main__':check()
