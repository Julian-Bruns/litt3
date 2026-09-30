#!/usr/bin/env python3
"""Exact auxiliary exclusion: Delta is never a function-field square for q != 0.
This does NOT exclude a square of the requested residual W.
"""
from pathlib import Path
import importlib.util,json,sys
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('field',ROOT/'src/verify_evidence.py')
f=importlib.util.module_from_spec(spec);spec.loader.exec_module(f)

def xgcd(a,b):
    u,v,s,t=[1],[],[],[1]
    while b:
        q,r=f.pr(a,b);a,b=b,r;u,s=s,f.ps(u,f.pm(q,s));v,t=t,f.ps(v,f.pm(q,t))
    if not a:return a,u,v
    c=f.inv(a[-1]);return f.sc(a,c),f.sc(u,c),f.sc(v,c)

def add(a,b):
    o=a.copy()
    for e,c in b.items():
        v=f.add(o.get(e,0),c)
        if v:o[e]=v
        else:o.pop(e,None)
    return o

def scale(a,c):return {e:f.mul(v,c) for e,v in a.items() if v and c}
def neg(a):return scale(a,4)
def mul(a,b):
    c={}
    for (i,j),u in a.items():
        for (k,l),v in b.items():c=add(c,{(i+k,j+l):f.mul(u,v)})
    return c

def uq(a):return {(0,j):c for j,c in enumerate(a) if c}
def power(a,n):
    b={(0,0):1}
    while n:
        if n&1:b=mul(b,a)
        n>>=1
        if n:a=mul(a,a)
    return b

def rows(a):return [[i,j,c] for (i,j),c in sorted(a.items())]
def polyq(a):
    assert all(i==0 for i,j in a)
    v=[0]*(max((j for i,j in a),default=-1)+1)
    for (i,j),c in a.items():v[j]=c
    return f.trim(v)

raw=json.loads((ROOT/'elimination/evidence/critical_delta.json').read_text())
p=[{(h,q):c for h,q,r,s,c in a} for a in raw['rank_equations']]
F=polyq({(i,j-4):c for (i,j),c in p[14].items()})
A=polyq({(0,j-3):c for (i,j),c in p[13].items() if i==0})
B=polyq({(0,j-3):c for (i,j),c in p[13].items() if i==1})
assert all(i<=1 and j>=3 for (i,j) in p[13])
g,u,v=xgcd(B,F);assert g==[1],('pivot has exceptional roots',g)
H0=f.pn(f.pr(f.pm(u,A),F)[1])
p12sub=[]
for (i,j),c in p[12].items():p12sub=f.pa(p12sub,f.sc([0]*j+f.pp(H0,i),c))
g,r,s=xgcd(F,p12sub);assert g==[1],('candidate q remains',g)
# H-H0 = u*(A+B*H)+F*(v*H-k).
k=f.pd(f.pa(f.pm(u,A),H0),F)
# Difference quotient T=(p12(H,q)-p12(H0,q))/(H-H0).
T={}
for (i,j),c in p[12].items():
    for l in range(i):T=add(T,mul({(i-1-l,j):c},uq(f.pp(H0,l))))
assert add(p[12],neg(uq(p12sub)))==mul(T,add({(1,0):1},neg(uq(H0))))
VHk=add(mul({(1,0):1},uq(v)),neg(uq(k)))
c12=mul({(0,4):1},uq(s))
c13=neg(mul({(0,1):1},mul(uq(s),mul(T,uq(u)))))
c14=add(uq(r),neg(mul(uq(s),mul(T,VHk))))
cert=add(mul(c12,p[12]),add(mul(c13,p[13]),mul(c14,p[14])))
assert cert=={(0,4):1}
report={'status':'proved auxiliary critical-discriminant nonsquareness, not the requested residual decision','coefficient_variables':['H','q'],'equations':'p_i=[x^i](Dhat1^2-4 Dhat0 Dhat2)','identity':'c12*p12+c13*p13+c14*p14=q^4','F':F,'A':A,'B':B,'pivot_bezout':{'u':u,'v':v,'identity':'u*B+v*F=1'},'H_mod_F':H0,'p12_at_H_mod_F':p12sub,'final_bezout':{'r':r,'s':s,'identity':'r*F+s*p12_at_H_mod_F=1'},'multipliers':{'c12':rows(c12),'c13':rows(c13),'c14':rows(c14)},'nonzero_terms':[len(c12),len(c13),len(c14)],'localization':'q!=0; no other parameter inverted','complete_polynomial_identity_verified':True}
text=json.dumps(report,sort_keys=True,indent=2)+'\n'
if len(sys.argv)==2:Path(sys.argv[1]).write_text(text)
elif len(sys.argv)>2:raise SystemExit('Usage: critical_exclusion.py [output.json]')
print('Exact pivot and final Bezout identities: PASS')
print('Full bivariate identity c12*p12+c13*p13+c14*p14=q^4: PASS')
print('Multiplier terms:',report['nonzero_terms'])
print('Delta is not a square in k(X) for any q!=0, arbitrary H.')
print('This does NOT establish nonsquareness of W; original finite scheme UNRESOLVED.')
