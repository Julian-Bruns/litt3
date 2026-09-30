"""Exact F25 and Laurent coordinate-ring arithmetic. No external CAS required."""
from __future__ import annotations
import numpy as np
from numba import njit
from dataclasses import dataclass

ADD=np.zeros((25,25),dtype=np.uint8)
MUL=np.zeros((25,25),dtype=np.uint8)
for a in range(25):
    a0,a1=a%5,a//5
    for b in range(25):
        b0,b1=b%5,b//5
        ADD[a,b]=(a0+b0)%5+5*((a1+b1)%5)
        MUL[a,b]=(a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
NEG=np.array([(-a%5)%5+5*((-a//5)%5) for a in []],dtype=np.uint8)
NEG=np.array([(-int(a%5))%5+5*((-int(a//5))%5) for a in range(25)],dtype=np.uint8)
INV=np.zeros(25,dtype=np.uint8)
for a in range(1,25):
    INV[a]=next(b for b in range(1,25) if MUL[a,b]==1)
P=np.array([11,22,18,5,19,20,15,16,9,22,1],dtype=np.uint8)

@njit(cache=True)
def matmul(a,b):
    out=np.zeros((a.shape[0],b.shape[1]),dtype=np.uint8)
    for i in range(a.shape[0]):
        for k in range(a.shape[1]):
            if a[i,k]:
                for j in range(b.shape[1]):
                    out[i,j]=ADD[out[i,j],MUL[a[i,k],b[k,j]]]
    return out

@njit(cache=True)
def rref(a,ncols=-1):
    m=a.copy()
    if ncols<0:ncols=m.shape[1]
    piv=np.empty(min(m.shape[0],ncols),dtype=np.int64)
    rank=0
    for c in range(ncols):
        p=rank
        while p<m.shape[0] and m[p,c]==0:p+=1
        if p==m.shape[0]:continue
        for j in range(m.shape[1]):
            tmp=m[p,j];m[p,j]=m[rank,j];m[rank,j]=tmp
        s=INV[m[rank,c]]
        for j in range(m.shape[1]):m[rank,j]=MUL[s,m[rank,j]]
        for i in range(m.shape[0]):
            if i!=rank and m[i,c]:
                t=NEG[m[i,c]]
                for j in range(m.shape[1]):m[i,j]=ADD[m[i,j],MUL[t,m[rank,j]]]
        piv[rank]=c;rank+=1
        if rank==m.shape[0]:break
    return m,piv[:rank]

def kernel(m):
    rr,piv=rref(np.asarray(m,dtype=np.uint8)); n=m.shape[1]
    free=[i for i in range(n) if i not in set(piv)]
    out=np.zeros((n,len(free)),dtype=np.uint8)
    for j,c in enumerate(free):
        out[c,j]=1
        out[piv,j]=NEG[rr[:len(piv),c]]
    return out

def elimination(c):
    n=c.shape[0]
    rr,piv=rref(np.column_stack((c,np.eye(n,dtype=np.uint8))),c.shape[1])
    assert len(piv)==c.shape[1],(len(piv),c.shape)
    return rr[:len(piv),c.shape[1]:],rr[len(piv):,c.shape[1]:]

@njit(cache=True)
def poly_mul(a,b):
    n=a.shape[1]+b.shape[1]-1
    temp=np.zeros((5,n),dtype=np.uint8)
    for j in range(3):
        for h in range(3):
            for i in range(a.shape[1]):
                if a[j,i]:
                    for k in range(b.shape[1]):
                        if b[h,k]:
                            temp[j+h,i+k]=ADD[temp[j+h,i+k],MUL[a[j,i],b[h,k]]]
    out=np.zeros((3,n+10),dtype=np.uint8)
    out[:,:n]=temp[:3,:]
    for j in range(3,5):
        for i in range(n):
            if temp[j,i]:
                for k in range(11):
                    out[j-3,i+k]=ADD[out[j-3,i+k],MUL[temp[j,i],P[k]]]
    return out

@dataclass
class LP:
    a:np.ndarray
    lo:int=0
    def __post_init__(self):
        self.a=np.asarray(self.a,dtype=np.uint8)
        nz=np.nonzero(np.any(self.a!=0,axis=0))[0]
        if len(nz):
            i,j=int(nz[0]),int(nz[-1])+1
            self.a=self.a[:,i:j].copy();self.lo+=i
        else:self.a=np.zeros((3,1),dtype=np.uint8);self.lo=0
    @staticmethod
    def term(i=0,j=0,c=1):
        a=np.zeros((3,1),dtype=np.uint8);a[j,0]=c
        return LP(a,i)
    @staticmethod
    def from_terms(ts):
        if not ts:return LP.term(c=0)
        lo=min(t[0] for t in ts);hi=max(t[0] for t in ts)
        a=np.zeros((3,hi-lo+1),dtype=np.uint8)
        for i,j,c in ts:a[j,i-lo]=ADD[a[j,i-lo],c]
        return LP(a,lo)
    def __add__(self,b):
        if not isinstance(b,LP):b=LP.term(c=b)
        lo=min(self.lo,b.lo);hi=max(self.lo+self.a.shape[1],b.lo+b.a.shape[1])
        a=np.zeros((3,hi-lo),dtype=np.uint8)
        a[:,self.lo-lo:self.lo-lo+self.a.shape[1]]=self.a
        k=b.lo-lo;a[:,k:k+b.a.shape[1]]=ADD[a[:,k:k+b.a.shape[1]],b.a]
        return LP(a,lo)
    __radd__=__add__
    def __neg__(self):return LP(NEG[self.a],self.lo)
    def __sub__(self,b):return self+-b
    def __mul__(self,b):
        if isinstance(b,(int,np.integer)):return LP(MUL[int(b),self.a],self.lo)
        return LP(poly_mul(self.a,b.a),self.lo+b.lo)
    __rmul__=__mul__
    def __pow__(self,n):
        out=LP.term();base=self
        while n:
            if n&1:out=out*base
            n>>=1
            if n:base=base*base
        return out
    def plus(self):
        if self.lo>=0:return self
        if self.lo+self.a.shape[1]<=0:return LP.term(c=0)
        return LP(self.a[:,-self.lo:],0)
    def minus(self):return self-self.plus()
    def coeff(self,i,j):
        k=i-self.lo
        return int(self.a[j,k]) if 0<=k<self.a.shape[1] else 0
    def terms(self):
        return [(i+self.lo,j,int(self.a[j,i])) for j in range(3) for i in range(self.a.shape[1]) if self.a[j,i]]
    def __eq__(self,b):return self.lo==b.lo and np.array_equal(self.a,b.a)
    def eval(self,x,y):
        out=0
        for i,j,c in self.terms():out=int(ADD[out,MUL[c,MUL[fpow(x,i),fpow(y,j)]]])
        return out

def fpow(x,n):
    if n<0:x=int(INV[x]);n=-n
    out=1
    while n:
        if n&1:out=int(MUL[out,x])
        x=int(MUL[x,x]);n>>=1
    return out

def basis(d):return [(i,j) for j in range(3) for i in range(max(0,(d-10*j)//3+1))]
def forbidden(d):return [(i,j) for j in range(3) for i in range((d-10*j)//3+1,0)]
def residual(p,d):return np.array([p.coeff(i,j) for i,j in forbidden(d)],dtype=np.uint8)
def linear_combination(cs,bs):
    out=LP.term(c=0)
    for c,b in zip(cs,bs):
        if c:out=out+b*int(c)
    return out

C=[2,16,16,7,1,2,7,1,24,11]
e=LP.from_terms([(-m,2,c) for m,c in enumerate(C,1)])
E=e**25
UB=[LP.term(-1,1)]+[LP.term(i,2) for i in range(-5,0)]
VB=[LP.term(-2,0),LP.term(-1,0)]+[LP.term(i,1) for i in range(-5,0)]+[LP.term(i,2) for i in range(-6,0)]
XIB=UB+VB
ZERO=LP.term(c=0)

def uv(xi):return linear_combination(xi[:6],UB),linear_combination(xi[6:],VB)

def lower(U,V,f,alpha,g0=ZERO,q0=ZERO):
    a=(e*f).plus()+alpha;p=a-e*f
    g=-(U*f).plus()+g0
    q=(e*g-U*p).plus()+q0
    B=E*g+(V+U*E)*f;h=-B.plus()
    D=-e*h+E*(q-e*g)+(V+U*E)*p;r=-D.plus()
    res=np.concatenate((residual(B,-144),residual(D,-155)))
    return (a,q,r,f,g,h),res

def top_res(U,V,eta,phi,s0=ZERO,t0=ZERO):
    u,v=uv(eta);a,q,r,f,g,h=phi
    n=(u*a+v*f).plus()+s0;nV=n-u*a-v*f
    na=(u*q+v*g-U*nV).plus()+t0
    D=-u*r-v*h+E*(na-u*q-v*g)+(V+U*E)*nV
    nb=-D.plus()
    return (n,na,nb),residual(D,-151)
