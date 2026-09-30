"""Exact field F_(25^4), F25 beta^2=beta+3, alpha^4+7alpha^3+6alpha^2+2alpha+5=0.
Elements are integers sum d_i*25^i, d_i the user's F25 encoding.
NumPy lookup acceleration only; all arithmetic is exact.
"""
import numpy as np
from functools import lru_cache
Q=25**4
ORDER=Q-1

def a25(a,b): return ((a%5+b%5)%5)+5*((a//5+b//5)%5)
def n25(a): return ((-a%5)%5)+5*((-(a//5))%5)
def m25(a,b):
    u,v=a%5,a//5; s,t=b%5,b//5
    return ((u*s+3*v*t)%5)+5*((u*t+v*s+v*t)%5)
A25=np.array([[a25(i,j) for j in range(25)] for i in range(25)],dtype=np.int32)
M25=np.array([[m25(i,j) for j in range(25)] for i in range(25)],dtype=np.int32)
NEG25=[n25(i) for i in range(25)]
MOD=[5,2,6,7]

def raw_mul(a,b):
    aa=[];bb=[]
    for i in range(4): aa.append(a%25);bb.append(b%25);a//=25;b//=25
    c=[0]*7
    for i in range(4):
        for j in range(4): c[i+j]=int(A25[c[i+j],M25[aa[i],bb[j]]])
    for i in range(6,3,-1):
        for j in range(4): c[i-4+j]=int(A25[c[i-4+j],NEG25[int(M25[c[i],MOD[j]])]])
    return sum(c[i]*25**i for i in range(4))

def raw_pow(a,e):
    r=1
    while e:
        if e&1:r=raw_mul(r,a)
        a=raw_mul(a,a);e>>=1
    return r

@lru_cache(maxsize=1)
def tables():
    import sympy
    factors=list(sympy.factorint(ORDER))
    gen=next(a for a in range(25,80) if all(raw_pow(a,ORDER//p)!=1 for p in factors))
    # Fast log-table builder in C++ source shipped alongside.
    import subprocess,tempfile,pathlib
    src=pathlib.Path(__file__).with_name('field_tables.cpp')
    with tempfile.TemporaryDirectory() as td:
        exe=pathlib.Path(td)/'field_tables'
        subprocess.run(['g++','-O2','-std=c++17',str(src),'-o',str(exe)],check=True)
        out=subprocess.check_output([str(exe),str(gen)])
    exp=np.frombuffer(out,dtype=np.int32).copy()
    assert exp.size==ORDER and len(np.unique(exp))==ORDER
    log=np.full(Q,-1,dtype=np.int32);log[exp]=np.arange(ORDER,dtype=np.int32)
    idx=np.arange(625,dtype=np.int32)
    add625=A25[(idx%25)[:,None],(idx%25)[None,:]]+25*A25[(idx//25)[:,None],(idx//25)[None,:]]
    neg625=add625[:,0].copy()
    for i in range(625):neg625[i]=NEG25[i%25]+25*NEG25[i//25]
    return exp,log,add625,neg625,gen

def add(a,b):
    _,_,tab,_,_=tables()
    a=np.asarray(a);b=np.asarray(b)
    return tab[a%625,b%625]+625*tab[a//625,b//625]

def neg(a):
    _,_,_,tab,_=tables();a=np.asarray(a)
    return tab[a%625]+625*tab[a//625]

def sub(a,b):return add(a,neg(b))

def mul(a,b):
    exp,log,*_=tables();a=np.asarray(a);b=np.asarray(b)
    return np.where((a==0)|(b==0),0,exp[(log[a]+log[b])%ORDER])

def inv(a):
    exp,log,*_=tables();a=np.asarray(a)
    if np.any(a==0): raise ZeroDivisionError
    return exp[(-log[a])%ORDER]

def pow(a,e):
    exp,log,*_=tables();a=np.asarray(a)
    if e<0 and np.any(a==0):raise ZeroDivisionError
    if e==0:return np.ones_like(a)
    return np.where(a==0,0,exp[(log[a].astype(np.int64)*e)%ORDER])

def div(a,b):return mul(a,inv(b))

def rref(M):
    M=np.array(M,dtype=np.int32,copy=True);r=0;piv=[]
    for c in range(M.shape[1]):
        nz=np.flatnonzero(M[r:,c])
        if not len(nz):continue
        s=r+int(nz[0]);M[[r,s]]=M[[s,r]]
        M[r,c:]=mul(M[r,c:],inv(M[r,c]))
        factors=M[:,c].copy();factors[r]=0
        M[:,c:]=sub(M[:,c:],mul(factors[:,None],M[r,c:][None,:]))
        piv.append(c);r+=1
        if r==M.shape[0]:break
    return M,piv

def kernel(M):
    R,piv=rref(M);free=[j for j in range(M.shape[1]) if j not in piv]
    K=np.zeros((M.shape[1],len(free)),dtype=np.int32)
    for k,j in enumerate(free):
        K[j,k]=1;K[piv,k]=neg(R[:len(piv),j])
    return K,piv
