"""Field and exact input audit; no computer algebra package is required."""
from __future__ import annotations
import argparse, json, time
from pathlib import Path
from reference_field import *

def fadd(a,b): return (a%5+b%5)%5+5*((a//5+b//5)%5)
def fneg(a): return (-a%5)%5+5*((-(a//5))%5)
def fsub(a,b): return fadd(a,fneg(b))
def fmul(a,b): return (a%5*(b%5)+3*(a//5)*(b//5))%5+5*((a%5*(b//5)+(a//5)*(b%5)+(a//5)*(b//5))%5)
def fpow(a,n):
    b=1
    while n:
        if n&1: b=fmul(b,a)
        a=fmul(a,a);n//=2
    return b

def trim(p):
    p=list(p)
    while p and not p[-1]:p.pop()
    return p

def pdiv(A,B,prime=False):
    A,B=trim(A),trim(B)
    if not B:raise ZeroDivisionError
    plus=(lambda x,y:(x+y)%5) if prime else fadd
    minus=(lambda x,y:(x-y)%5) if prime else fsub
    times=(lambda x,y:x*y%5) if prime else fmul
    bi=pow(B[-1],-1,5) if prime else fpow(B[-1],23)
    Q=[0]*max(0,len(A)-len(B)+1)
    while len(A)>=len(B):
        j=len(A)-len(B);c=times(A[-1],bi);Q[j]=c
        for i,b in enumerate(B): A[i+j]=minus(A[i+j],times(c,b))
        A=trim(A)
    return trim(Q),A

def pgcd(A,B):
    A,B=trim(A),trim(B)
    while B:A,B=B,pdiv(A,B)[1]
    if not A:return []
    z=fpow(A[-1],23)
    return [fmul(z,a) for a in A]

def order(a,m):
    x=a%m; n=1
    while x!=1:x=x*a%m;n+=1
    return n

def audit(vectors: Path) -> dict:
    start=time.monotonic()
    assert {i*i%5 for i in range(5)}=={0,1,4}
    assert order(5,29)==14 and order(25,29)==7
    assert not pdiv([1]*29,MOD,prime=True)[1]
    assert not pdiv([1]*29,FIELD['extension_minimal_polynomial_over_F25_ascending'])[1]
    assert power(Q,29)==ONE and len(set(ROOTS))==29
    assert sub(sub(mul(A,A),A),scalar(3))==ZERO and power(A,25)==A
    tr=ZERO
    for i in range(7):tr=add(tr,power(Q,25**i))
    assert tr==A
    r=ZERO
    for c in reversed(FIELD['extension_minimal_polynomial_over_F25_ascending']):r=add(mul(r,Q),base(c))
    assert r==ZERO
    assert sorted(c for c in range(25) if fpow(c,8)==1)==sorted(MU_CODES)
    for i in range(25):
        assert from_code(i)==base(i)
        assert to_code(base(i))==i
    problem=json.loads((ROOT/'inputs'/'problem.json').read_text())
    P,Apoly=problem['P'],problem['A']
    derivative=lambda row:[fmul(i%5,row[i]) for i in range(1,len(row))]
    assert len(P)==11 and len(Apoly)==5 and Apoly[-1]!=0
    assert pgcd(P,derivative(P))==[1]
    assert pgcd(Apoly,derivative(Apoly))==[1]
    assert pgcd(P,Apoly)==[1]
    count=0
    for line in vectors.read_text().splitlines():
        if not line.strip() or line.startswith('#'):continue
        ac,bc,s,p,ai,a5=map(int,line.split());a,b=from_code(ac),from_code(bc)
        assert add(a,b)==from_code(s)
        assert mul(a,b)==from_code(p)
        assert mul(a,from_code(ai))==ONE
        assert power(a,5)==from_code(a5)
        count+=1
    assert count==256
    return {'status':'PASS','field_presentations':2,'native_arithmetic_vectors':count,
            'all_29_roots_checked':True,'complete_mu8_checked':True,
            'P_and_A_squarefree_and_coprime':True,'seconds':time.monotonic()-start}

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--vectors',type=Path,default=ROOT/'logs'/'field_vectors.txt');p.add_argument('--output',type=Path)
    args=p.parse_args();result=audit(args.vectors);text=json.dumps(result,indent=2)+'\n'
    if args.output:args.output.write_text(text)
    print(text,end='')
