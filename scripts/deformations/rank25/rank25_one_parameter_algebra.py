"""Exact finite input check; this is not a fifth-obstruction engine."""
import json
from pathlib import Path
from math import prod

ZERO=(0,0,0,0)
ONE=(1,0,0,0)

def digits(n):return tuple((n//5**i)%5 for i in range(4))
def add(a,b):return tuple((x+y)%5 for x,y in zip(a,b))
def mul(a,b):
    if a==ZERO or b==ZERO:return ZERO
    c=[0]*7
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]+=x*y
    for i in range(6,3,-1):
        for j,v in enumerate((3,4,1,4)):c[i-4+j]-=v*c[i]
    return tuple(v%5 for v in c[:4])
def power(a,n):
    if n<0:
        assert a!=ZERO
        return power(power(a,623),-n)
    out=ONE
    while n:
        if n&1:out=mul(out,a)
        a=mul(a,a);n//=2
    return out
def total(values):
    out=ZERO
    for v in values:out=add(out,v)
    return out
def mv(A,v):return [total(mul(a,b) for a,b in zip(row,v)) for row in A]
def unpack(x):
    if isinstance(x,dict) and set(x)=={'shape','nonzero'}:
        flat=[ZERO]*prod(x['shape'])
        for i,c in x['nonzero']:flat[i]=digits(c)
        it=iter(flat)
        def nested(shape):return [nested(shape[1:]) for _ in range(shape[0])] if shape else next(it)
        return nested(x['shape'])
    if isinstance(x,dict):return {k:unpack(v) for k,v in x.items()}
    if isinstance(x,list):return [unpack(v) for v in x]
    return x
def load(directory=None):
    base=Path(directory) if directory else Path(__file__).resolve().parent
    return unpack(json.loads((base/'inputs.json').read_text()))
def evaluate(vector_polynomial,parameter):
    assert parameter!=ZERO
    return [total(mul(power(parameter,e),row[i]) for e,row in vector_polynomial) for i in range(75)]

def check():
    d=load();M=d['matrix'];normal=dict(d['normal4'])
    for e,row in d['fourth_digit']:
        assert mv(M,[power(c,5) for c in row])==normal[5*e]
    assert set(normal)=={5*e for e,_ in d['fourth_digit']}
    assert mv(list(zip(*M)),d['dual_row'])==[ZERO]*75
    assert mv(M,[power(c,5) for c in d['direction']])==[ZERO]*75
    assert mv(M,[power(c,5) for c in d['nu0']])==[ZERO]*75
    parameter=(0,1,0,0)
    assert mv(M,[power(c,5) for c in evaluate(d['fourth_digit'],parameter)])==evaluate(d['normal4'],parameter)
    print('PASS coefficientwise fourth digit, fixed dual row, kernel directions, and off-prime-field parameter.')
    print('The fifth scalar function L remains the requested new calculation.')

if __name__=='__main__':check()
