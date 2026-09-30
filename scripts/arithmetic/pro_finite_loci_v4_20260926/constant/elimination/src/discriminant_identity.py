#!/usr/bin/env python3
"""Universal identity in F_5[a,b,c,d,Q,C]; no numerical specialization."""
from pathlib import Path
import json
N=6
zero=(0,)*N

def constant(c):
    return {zero:c%5} if c%5 else {}

def var(i):
    e=[0]*N;e[i]=1;return {tuple(e):1}

def add(*polys):
    out={}
    for p in polys:
        for e,c in p.items():
            v=(out.get(e,0)+c)%5
            if v:out[e]=v
            else:out.pop(e,None)
    return out

def scale(p,c):
    return {e:(v*c)%5 for e,v in p.items() if v*c%5}

def mul(*polys):
    out=constant(1)
    for p in polys:
        new={}
        for e,a in out.items():
            for f,b in p.items():
                k=tuple(x+y for x,y in zip(e,f));v=(new.get(k,0)+a*b)%5
                if v:new[k]=v
                else:new.pop(k,None)
        out=new
    return out

def power(p,n):
    out=constant(1)
    while n:
        if n&1:out=mul(out,p)
        n>>=1
        if n:p=mul(p,p)
    return out

a,b,c,d,Q,C=map(var,range(6))
a2,a3,a4,a5=(power(a,i) for i in (2,3,4,5))
b2,b3,b4,b5=(power(b,i) for i in (2,3,4,5))
c2,c3,c4,c5=(power(c,i) for i in (2,3,4,5))
E=add(mul(a,d),scale(mul(b,c),-1))
Delta=add(b2,mul(a,c))
T0=add(c5,scale(mul(Q,b5),-1),mul(power(Q,2),a5))
U0=add(scale(mul(Q,a5),2),scale(b5,-1))
V0=add(scale(mul(d,b5),-1),scale(mul(c2,b4),-2),scale(mul(a,b2,c3),-3),scale(mul(a2,c4),-2),mul(Q,add(scale(mul(a5,d),2),scale(mul(a4,b,c),-1),mul(a3,b3))))
W0=add(mul(a2,power(d,2)),scale(mul(a,b,c,d),-1),scale(mul(b2,c2),2),mul(b3,d),mul(a,c3))
M0=add(mul(U0,add(scale(mul(a,E),2),mul(b,Delta))),scale(mul(a2,V0),-1))
D0=add(mul(a3,add(mul(T0,W0),mul(C,M0))),mul(power(C,2),power(a,10)))
D1=add(mul(T0,V0),mul(C,add(power(U0,2),scale(mul(a5,T0),-2))))
D2=power(T0,2)
K0=add(mul(Q,a3),mul(d,Delta),scale(mul(b,c2),2))
V=add(mul(T0,K0),mul(C,Delta,U0))
lhs=add(power(D1,2),scale(mul(D2,D0),-4))
rhs=mul(power(Delta,3),power(V,2))
assert lhs==rhs
out={'ring':'F_5[a,b,c,d,Q,C]','identity':'D1^2-4*D2*D0=(b^2+a*c)^3*(T0*(Q*a^3+d*(b^2+a*c)+2*b*c^2)+C*(b^2+a*c)*U0)^2','scope':'universal polynomial identity, including a=0, Delta=0, T0=0 and all coefficient drops','difference_terms':0,'expanded_side_terms':len(lhs),'D_term_counts':[len(D0),len(D1),len(D2)],'K0_terms':len(K0),'V_terms':len(V)}
if __name__=='__main__':
    import sys
    if len(sys.argv)>2:raise SystemExit('Usage: discriminant_identity.py [output.json]')
    text=json.dumps(out,sort_keys=True,indent=2)+'\n'
    if len(sys.argv)==2:Path(sys.argv[1]).write_text(text)
    print(text,end='')
