"""Exact arithmetic over K in the problem's tower codes. Python 3 + NumPy."""
from pathlib import Path
import numpy as np
import subprocess
ROOT=Path(__file__).resolve().parents[1]
N=390625
if not (ROOT/'data/field.bin').exists():
    subprocess.run(['g++','-O3',str(ROOT/'src/make_field.cpp'),'-o',str(ROOT/'make_field')],check=True)
    subprocess.run([str(ROOT/'make_field'),str(ROOT/'data/field.bin')],check=True)
v=np.fromfile(ROOT/'data/field.bin',dtype=np.int32)
EX=v[:2*(N-1)]; LOG=v[2*(N-1):]
ex=EX.tolist(); log=LOG.tolist()
ADD=np.zeros((625,625),dtype=np.int32)
for p in (1,5,25,125):
    ar=np.arange(625)//p%5
    ADD+=((ar[:,None]+ar[None,:])%5)*p
addtab=ADD.ravel().tolist()
NEG=np.array([sum((-((a//p)%5))%5*p for p in (1,5,25,125)) for a in range(625)],dtype=np.int32)
neglist=NEG.tolist()
def add(a,b):return addtab[(a%625)*625+b%625]+625*addtab[(a//625)*625+b//625]
def neg(a):return neglist[a%625]+625*neglist[a//625]
def sub(a,b):return add(a,neg(b))
def mul(a,b):return ex[log[a]+log[b]] if a and b else 0
def inv(a):
    if not a:raise ZeroDivisionError
    return ex[(N-1)-log[a]]
def div(a,b):return mul(a,inv(b))
def power(a,n):
    if n==0:return 1
    if not a:
        if n<0:raise ZeroDivisionError
        return 0
    return ex[(log[a]*n)%(N-1)]
def va(a,b):return ADD[a%625,b%625]+625*ADD[a//625,b//625]
def vn(a):return NEG[a%625]+625*NEG[a//625]
def vm(a,b):
    aa=np.asarray(a);bb=np.asarray(b)
    return np.where((aa!=0)&(bb!=0),EX[np.maximum(LOG[aa]+LOG[bb],0)],0)
def trim(a):
    while a and not a[-1]:a.pop()
    return a
def padd(a,b):
    c=[0]*max(len(a),len(b))
    for i in range(len(a)):c[i]=a[i]
    for i in range(len(b)):c[i]=add(c[i],b[i])
    return trim(c)
def pneg(a):return [neg(c) for c in a]
def psub(a,b):return padd(a,pneg(b))
def pscale(a,c):return trim([mul(t,c) for t in a])
def pmul(a,b):
    if not a or not b:return []
    c=[0]*(len(a)+len(b)-1)
    for i,aa in enumerate(a):
        if aa:
            for j,bb in enumerate(b):
                if bb:c[i+j]=add(c[i+j],mul(aa,bb))
    return trim(c)
def ppow(a,n):
    b=[1]
    while n:
        if n&1:b=pmul(b,a)
        n>>=1
        if n:a=pmul(a,a)
    return b
def pdivrem(a,b):
    if not b:raise ZeroDivisionError
    a=a[:];q=[0]*max(0,len(a)-len(b)+1);ib=inv(b[-1])
    while len(a)>=len(b):
        k=len(a)-len(b);c=mul(a[-1],ib);q[k]=c
        for j,v in enumerate(b):a[k+j]=sub(a[k+j],mul(c,v))
        trim(a)
    return trim(q),a
def pexact(a,b):
    q,r=pdivrem(a,b)
    assert not r,(a,b,r)
    return q
def pmod(a,b):return pdivrem(a,b)[1]
def pgcd(a,b):
    while b:a,b=b,pmod(a,b)
    return pscale(a,inv(a[-1])) if a else []
def peval(a,t):
    v=0
    for c in reversed(a):v=add(mul(v,t),c)
    return v
P=[11,22,18,5,19,20,15,16,9,22,1]
A=[1,21,14,22,13]
Q=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
B0=[8,14,19,2,10,19,3,24,18,16]
L0=[18,20,20,15]
alpha=25
t=pscale(pexact(A,[neg(alpha),1]),inv(13))
Epsilon=add(add(24,mul(4,alpha)),mul(23,power(alpha,3)))
Eta=add(add(11,mul(18,power(alpha,2))),mul(20,power(alpha,3)))
Cd=add(add(3,mul(10,alpha)),add(power(alpha,2),mul(14,power(alpha,3))))
def czero():return [[],[],[]]
def cscalar(a):return [a,[],[]]
def cadd(a,b):return [padd(x,y) for x,y in zip(a,b)]
def cneg(a):return [pneg(x) for x in a]
def csub(a,b):return cadd(a,cneg(b))
def cscale(a,b):return [pscale(x,b) for x in a]
def cmul(a,b):
    c=czero()
    for i in range(3):
        for j in range(3):
            d=pmul(a[i],b[j])
            if i+j>=3:d=pmul(d,P)
            c[(i+j)%3]=padd(c[(i+j)%3],d)
    return c
def cpow(a,n):
    b=cscalar([1])
    while n:
        if n&1:b=cmul(b,a)
        n>>=1
        if n:a=cmul(a,a)
    return b
def mon(i,j):
    a=czero();a[j]=[0]*i+[1];return a

def rref(M, ncols=None):
    """RREF over K, preserving all rows including an augmented column."""
    M=np.array(M,dtype=np.int32,copy=True)
    if ncols is None:ncols=M.shape[1]
    piv=[];k=0
    for j in range(ncols):
        js=np.nonzero(M[k:,j])[0]
        if not len(js):continue
        i=k+int(js[0]);M[[i,k]]=M[[k,i]]
        M[k]=vm(M[k],inv(int(M[k,j])))
        ids=np.nonzero(M[:,j])[0];ids=ids[ids!=k]
        if len(ids):M[ids]=va(M[ids],vn(vm(M[ids,j,None],M[k,None,:])))
        piv.append(j);k+=1
        if k==len(M):break
    return M,piv

def affine_solve(M,b):
    MM,piv=rref(np.column_stack([M,b]),len(M[0]))
    n=len(M[0]);rank=len(piv)
    assert not np.any(MM[rank:,-1]),'inconsistent equations'
    part=np.zeros(n,dtype=np.int32)
    for i,j in enumerate(piv):part[j]=MM[i,-1]
    free=[j for j in range(n) if j not in piv]
    ker=np.zeros((len(free),n),dtype=np.int32)
    for k,j in enumerate(free):
        ker[k,j]=1
        for i,s in enumerate(piv):ker[k,s]=neg(int(MM[i,j]))
    return part,ker,piv
