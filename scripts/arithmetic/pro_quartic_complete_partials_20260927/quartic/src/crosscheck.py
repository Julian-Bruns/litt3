"""Independent exact-tower replay of C++ field and endpoint samples.

Usage: python src/crosscheck.py /path/to/field_dump
Both implementations use exact arithmetic, but different polynomial bases.
"""
import json,sys,subprocess,time
from exact_fields import *

def digits(n):
    d=[]
    for _ in range(7): d.append(n%5); n//=5
    assert n==0
    return d

t=zeta+zeta**28
tp=[K.one]
for _ in range(6):tp.append(tp[-1]*t)

def kplus(n):return sum((v*a for v,a in zip(digits(n),tp)),K.zero)
def kelt(row):return kplus(row[0])+embed(beta,K)*kplus(row[1])
theta=T_to_F(pi(evaluate(CODES['c'],alpha_T),2))
th=[F.one]
for _ in range(3):th.append(th[-1]*theta)
def felt(row):return sum((embed(kelt(v),F)*a for v,a in zip(row,th)),F.zero)

def endpoint(Q):
    out=[]
    for name,m in [('c',5),('e',8),('f',17),('g',4)]:
        v=F.zero
        for i,j in Q:
            ct=evaluate(CODES[name],alpha_T**(25**i))
            v+=T_to_F(ct)*embed(zeta**((m*j)%29),F)
        out.append(v)
    return out

start=time.monotonic()
data=json.loads(subprocess.check_output([sys.argv[1]],text=True))
assert data['raw_field_checks']==10000
for sample in data['samples']:
    a,b=map(kelt,[sample['a'],sample['b']])
    assert a*b==kelt(sample['product'])
    assert a.frob(7)==kelt(sample['frob7'])
    assert endpoint(sample['Q'])==list(map(felt,sample['traces']))
print(json.dumps({'status':'PASS','independent_basis_samples':len(data['samples']),
                  'trace_evaluations':4*len(data['samples']),
                  'raw_vs_log_field_checks':data['raw_field_checks'],
                  'seconds':round(time.monotonic()-start,3)},indent=2))
