#!/usr/bin/env python3
"""Exact global degree-47 leading-ideal certificate, independently reconstructed.
This proves a uniform bound, NOT emptiness of the square locus.
"""
from pathlib import Path
from array import array
from itertools import combinations_with_replacement, product
from math import factorial
import json, sys, time
ROOT=Path(__file__).resolve().parents[1]
N=390625
add25=lambda a,b:(a%5+b%5)%5+5*((a//5+b//5)%5)
neg25=lambda a:(-a%5)+5*(-(a//5)%5)
def mul25(a,b):
    a0,a1,b0,b1=a%5,a//5,b%5,b//5
    return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
# Independent nested-quotient field implementation, with verified alpha cycle.
ADD25=[[add25(a,b) for b in range(25)] for a in range(25)]
MUL25=[[mul25(a,b) for b in range(25)] for a in range(25)]
NEG25=[neg25(a) for a in range(25)]
EXP=array('I',[0])*(N-1); LOG=array('i',[-1])*N
v=1
for i in range(N-1):
    assert v and LOG[v]<0
    EXP[i]=v;LOG[v]=i
    c0=v%25;c1=v//25%25;c2=v//625%25;c3=v//15625
    v=(NEG25[MUL25[5][c3]] + 25*ADD25[c0][NEG25[MUL25[2][c3]]]
       +625*ADD25[c1][NEG25[MUL25[6][c3]]]+15625*ADD25[c2][NEG25[MUL25[7][c3]]])
assert v==1 and min(LOG[1:])>=0
ADD625=array('H',(ADD25[a%25][b%25]+25*ADD25[a//25][b//25] for a in range(625) for b in range(625)))
def add(a,b):return ADD625[(a%625)*625+b%625]+625*ADD625[(a//625)*625+b//625]
def neg(a):return NEG25[a%25]+25*NEG25[a//25%25]+625*NEG25[a//625%25]+15625*NEG25[a//15625]
def mul(a,b):return 0 if not a or not b else EXP[(LOG[a]+LOG[b])%(N-1)]
def inv(a):
    assert a
    return EXP[-LOG[a]%(N-1)]
def power(a,n):
    if not n:return 1
    assert n>=0 or a
    return EXP[LOG[a]*n%(N-1)] if a else 0
# Sparse bivariate polynomials, keys (H exponent,q exponent).
def padd(a,b):
    c=dict(a)
    for k,v in b.items():
        w=add(c.get(k,0),v)
        if w:c[k]=w
        else:c.pop(k,None)
    return c
def pscale(a,s):return {k:mul(v,s) for k,v in a.items() if mul(v,s)}
def psub(a,b):return padd(a,pscale(b,4))
def pmul(a,b):
    c={}
    for (h,q),v in a.items():
        for (i,j),w in b.items():
            k=(h+i,q+j);z=add(c.get(k,0),mul(v,w))
            if z:c[k]=z
            else:c.pop(k,None)
    return c
def ppow(a,n):
    if n in (5,25,125):return {(h*n,q*n):power(v,n) for (h,q),v in a.items()}
    c={(0,0):1}
    while n:
        if n&1:c=pmul(c,a)
        n//=2
        if n:a=pmul(a,a)
    return c
def qshift(a,n):return {(h,q+n):v for (h,q),v in a.items()}
def stripq(a):
    v=min(q for h,q in a)
    return qshift(a,-v),v
# Dense univariate polynomials.
def trim(a):
    while a and not a[-1]:a.pop()
    return a
def uadd(a,b):return trim([add(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def uscale(a,s):return trim([mul(v,s) for v in a])
def usub(a,b):return uadd(a,uscale(b,4))
def umul(a,b):
    if not a or not b:return []
    c=[0]*(len(a)+len(b)-1)
    for i,v in enumerate(a):
        if v:
            for j,w in enumerate(b):
                if w:c[i+j]=add(c[i+j],mul(v,w))
    return trim(c)
def upow(a,n):
    c=[1]
    while n:
        if n&1:c=umul(c,a)
        n//=2
        if n:a=umul(a,a)
    return c
def udivmod(a,b):
    assert b
    r=a[:];q=[0]*max(0,len(a)-len(b)+1);il=inv(b[-1])
    while len(r)>=len(b):
        e=len(r)-len(b);v=mul(r[-1],il);q[e]=v
        for j,w in enumerate(b):r[e+j]=add(r[e+j],neg(mul(v,w)))
        trim(r)
    return trim(q),r
def rem(a,b):return udivmod(a,b)[1]
def xgcd(a,b):
    u,v,s,t=[1],[],[],[1]
    while b:
        q,r=udivmod(a,b);a,b=b,r;u,s=s,usub(u,umul(q,s));v,t=t,usub(v,umul(q,t))
    z=inv(a[-1]);return uscale(a,z),uscale(u,z),uscale(v,z)
def row(a,h):
    qs=[q for hh,q in a if hh==h]
    return [a.get((h,q),0) for q in range(max(qs)+1)] if qs else []
def subst(a,b0,b1):
    n=max(h for h,q in a);out=[]
    for h in range(n+1):out=uadd(out,umul(umul(row(a,h),upow(uscale(b0,4),h)),upow(b1,n-h)))
    return out
def substmod(a,b0,b1,f):
    d,bi,v=xgcd(b1,f);assert d==[1]
    hh=rem(umul(uscale(b0,4),bi),f);out=[]
    for h in range(max(h for h,q in a),-1,-1):out=rem(uadd(umul(out,hh),row(a,h)),f)
    return out,bi,v

def main():
    st=time.monotonic();tab={};count=0
    for line in (ROOT/'inputs/E_records.tsv').read_text().splitlines()[1:]:
        j,h,q,m,x,c=map(int,line.split());tab.setdefault((j,m,x),{})[h,q]=c;count+=1
    assert count==89481
    P=[11,22,18,5,19,20,15,16,9,22,1];P2=umul(P,P)
    bounds=[[46,45,43],[43,42,39],[40,38,35]]
    cache={}
    def prod(js,m,x):
        key=js,m,x
        if key in cache:return cache[key]
        out={}
        for ms in product(range(3),repeat=3):
            if sum(ms)!=m:continue
            ds=[bounds[j][mm] for j,mm in zip(js,ms)]
            for x0 in range(max(0,x-ds[1]-ds[2]),ds[0]+1):
                for x1 in range(max(0,x-x0-ds[2]),min(ds[1],x-x0)+1):
                    x2=x-x0-x1
                    if x2>ds[2]:continue
                    f=[tab.get((j,mm,xx),{}) for j,mm,xx in zip(js,ms,(x0,x1,x2))]
                    out=padd(out,pmul(pmul(f[0],f[1]),f[2]))
        cache[key]=out;return out
    def wcoeff(m,x):
        out=qshift(prod((0,0,0),m,x),2)
        for i,p in enumerate(P):
            out=padd(out,pscale(qshift(prod((1,1,1),m,x-i),1),p))
            out=padd(out,pscale(qshift(prod((0,1,2),m,x-i),1),mul(2,p)))
        for i,p in enumerate(P2):out=padd(out,pscale(prod((2,2,2),m,x-i),p))
        return out
    inds=[(5,131),(5,130),(5,129),(5,128),(6,129),(6,128),(3,136),(4,133)]
    ww={k:wcoeff(*k) for k in inds}
    c5,c51,c52,c53,c6,c61,c3,c4=[ww[k] for k in inds]
    assert c6=={(0,50):242747} and c61=={(0,50):270402}
    b,bq=stripq(c5);r,rq=stripq(c51)
    assert (bq,rq)==(47,46) and max(h for h,q in b)==1
    b0,b1=row(b,0),row(b,1)
    d,u,v=xgcd(b0,b1);assert d==[1] and uadd(umul(u,b0),umul(v,b1))==[1]
    raw=subst(r,b0,b1);qv=next(i for i,a in enumerate(raw) if a);lc=raw[-1]
    f=uscale(raw[qv:],inv(lc));assert qv==3 and len(f)==31
    p=padd(pscale(pmul(ppow(c3,3),psub(pmul(c6,c53),pmul(c61,c52))),3),ppow(c4,5))
    pn,pq=stripq(p);assert pq==220
    g,bi,bv=substmod(pn,b0,b1,f)
    d,s,t=xgcd(f,g);assert d==[1] and uadd(umul(s,f),umul(t,g))==[1]
    assert uadd(umul(bi,b1),umul(bv,f))==[1]
    # Complete finite support check for the two leading coefficient levels.
    deficit=[0,2,3,4,7,9,11]
    alloc={}
    for mu,limit in [(47,74),(48,74)]:
        a=[]
        for aa in combinations_with_replacement(range(7),3):
            for bb in combinations_with_replacement(range(7),2):
                for cc in combinations_with_replacement(range(7),2):
                    mm=sum(aa)+5*sum(bb)+25*sum(cc)
                    tt=sum(deficit[i] for i in aa)+5*sum(deficit[i] for i in bb)+25*sum(deficit[i] for i in cc)
                    if mm==mu and tt<=limit:a.append([list(aa),list(bb),list(cc),tt])
        alloc[str(mu)]=a
    assert alloc['47']==[[[3,3,6],[3,4],[0,0],74],[[5,6,6],[3,3],[0,0],71]]
    assert alloc['48']==[[[6,6,6],[3,3],[0,0],73]]
    enc=lambda a:[[h,q,c] for (h,q),c in sorted(a.items())]
    out={'status':'PASS','decision':'UNRESOLVED','claim':'Uniform scheme-theoretic fixed-ratio scale length at most 47',
         'field_alpha_cycle_verified':N-1,'E_records':count,'frontier_coefficients':{f'{m},{x}':enc(ww[m,x]) for m,x in inds},
         'b0':b0,'b1':b1,'r':enc(r),'p_after_q220_removed':enc(pn),
         'b0_b1_bezout':{'u':u,'v':v,'identity':'u*b0+v*b1=1'},
         'affine_resultant':{'q_valuation':qv,'scalar':lc,'monic_degree30':f,'identity':'b1^3*r(-b0/b1,q)=scalar*q^3*f(q)'},
         'b1_inverse_mod_f':{'inverse':bi,'f_multiplier':bv,'identity':'inverse*b1+f_multiplier*f=1'},
         'third_image':g,'f_image_bezout':{'s':s,'t':t,'identity':'s*f+t*third_image=1'},
         'monomial_allocations':alloc,
         'certificate_scope':'The three degree-47 leading coefficients generate the unit ideal after only the original localization. This is not a decision of common roots in mu.'}
    path=Path(sys.argv[1]) if len(sys.argv)>1 else ROOT/'build/degree47_certificate.json'
    path.parent.mkdir(parents=True,exist_ok=True);path.write_text(json.dumps(out,indent=2)+'\n')
    print('GLOBAL DEGREE-47 CERTIFICATE PASS')
    print('Independent field cycle, 89481 E records, 8 symbolic frontier coefficients, and three Bezout identities verified.')
    print('First-two-leading boundary: degree30; third-leading image coprime. No new ratio localization.')
    print('All parameters remain symbolic. Global square locus UNRESOLVED.')
    print('elapsed_seconds',round(time.monotonic()-st,3))
if __name__=='__main__':main()
