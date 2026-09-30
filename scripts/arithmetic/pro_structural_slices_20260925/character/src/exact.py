"""Exact arithmetic for F25 and k[x,x^-1,y]/(y^3-P).
Field code a+5*b denotes a+b*beta, beta^2=beta+3. No floating point.
"""
from __future__ import annotations
import numpy as np

ADD=np.array([[(a%5+b%5)%5+5*((a//5+b//5)%5) for b in range(25)] for a in range(25)],dtype=np.uint8)
NEG=np.array([(-a%5)%5+5*(-(a//5)%5) for a in range(25)],dtype=np.uint8)
SUB=ADD[:,NEG]
MUL=np.array([[((a%5)*(b%5)+3*(a//5)*(b//5))%5+5*(((a%5)*(b//5)+(a//5)*(b%5)+(a//5)*(b//5))%5) for b in range(25)] for a in range(25)],dtype=np.uint8)
INV=np.zeros(25,dtype=np.uint8)
for a in range(1,25): INV[a]=np.where(MUL[a]==1)[0][0]
P_CODES=[11,22,18,5,19,20,15,16,9,22,1]
C_CODES=[2,16,16,7,1,2,7,1,24,11]

def mm(A,B):
    """Matrix multiplication over F25 (also accepts a vector)."""
    A=np.asarray(A,dtype=np.int64); B=np.asarray(B,dtype=np.int64)
    a,b=A%5,A//5; c,d=B%5,B//5
    ac=a@c; bd=b@d
    return ((ac+3*bd)%5+5*((a@d+b@c+bd)%5)).astype(np.uint8)

def rref(A,transform=False):
    A=np.asarray(A,dtype=np.uint8).copy()
    n,m=A.shape; k=0; piv=[]
    H=np.eye(n,dtype=np.uint8) if transform else None
    for j in range(m):
        rows=np.flatnonzero(A[k:,j])
        if not len(rows): continue
        i=k+int(rows[0])
        A[[k,i]]=A[[i,k]]
        if transform: H[[k,i]]=H[[i,k]]
        c=int(INV[A[k,j]])
        A[k]=MUL[c,A[k]]
        if transform: H[k]=MUL[c,H[k]]
        fac=A[:,j].copy(); fac[k]=0
        A=SUB[A,MUL[fac[:,None],A[k]]]
        if transform: H=SUB[H,MUL[fac[:,None],H[k]]]
        piv.append(j); k+=1
        if k==n: break
    return (A,piv,H) if transform else (A,piv)

def rank(A): return len(rref(A)[1])
def kernel(A):
    R,p=rref(A); free=[j for j in range(A.shape[1]) if j not in p]
    N=np.zeros((A.shape[1],len(free)),dtype=np.uint8)
    for c,j in enumerate(free):
        N[j,c]=1
        N[p,c]=NEG[R[:len(p),j]]
    return N

def conv(a,b):
    a=np.asarray(a,dtype=np.int64); b=np.asarray(b,dtype=np.int64)
    a0,a1=a%5,a//5; b0,b1=b%5,b//5
    ac=np.convolve(a0,b0); bd=np.convolve(a1,b1)
    return ((ac+3*bd)%5+5*((np.convolve(a0,b1)+np.convolve(a1,b0)+bd)%5)).astype(np.uint8)

def trim(lo,a):
    a=np.asarray(a,dtype=np.uint8)
    nz=np.flatnonzero(a)
    if not len(nz): return (0,np.zeros(0,dtype=np.uint8))
    i,j=int(nz[0]),int(nz[-1])+1
    return (lo+i,a[i:j].copy())

def padd(a,b):
    la,aa=a; lb,bb=b
    if not len(aa): return (lb,bb.copy())
    if not len(bb): return (la,aa.copy())
    lo=min(la,lb); hi=max(la+len(aa),lb+len(bb))
    out=np.zeros(hi-lo,dtype=np.uint8)
    out[la-lo:la-lo+len(aa)]=aa
    out[lb-lo:lb-lo+len(bb)]=ADD[out[lb-lo:lb-lo+len(bb)],bb]
    return trim(lo,out)

class LP:
    def __init__(self, parts=None):
        self.parts=parts if parts is not None else [(0,np.zeros(0,dtype=np.uint8)) for _ in range(3)]
    @staticmethod
    def mono(i,j=0,c=1):
        assert 0<=j<=2
        a=LP(); a.parts[j]=(int(i),np.array([c],dtype=np.uint8)); return a
    @staticmethod
    def from_terms(terms):
        p=LP()
        for i,j,c in terms: p=p+LP.mono(i,j,c)
        return p
    def __add__(self,b):
        if b==0: return self
        return LP([padd(a,c) for a,c in zip(self.parts,b.parts)])
    __radd__=__add__
    def __neg__(self): return LP([(lo,NEG[a]) for lo,a in self.parts])
    def __sub__(self,b): return self+(-b)
    def scale(self,c): return LP([trim(lo,MUL[c,a]) for lo,a in self.parts])
    def __mul__(self,b):
        parts=[(0,np.zeros(0,dtype=np.uint8)) for _ in range(3)]
        for j,(la,aa) in enumerate(self.parts):
            if not len(aa): continue
            for k,(lb,bb) in enumerate(b.parts):
                if not len(bb): continue
                cc=conv(aa,bb)
                if j+k>=3: cc=conv(cc,P_CODES)
                idx=(j+k)%3
                parts[idx]=padd(parts[idx],trim(la+lb,cc))
        return LP(parts)
    def __pow__(self,n):
        assert n>=0
        out=LP.mono(0); a=self
        while n:
            if n&1: out=out*a
            a=a*a; n//=2
        return out
    def split(self,positive=True):
        parts=[]
        for lo,a in self.parts:
            if positive:
                cut=max(0,-lo)
                parts.append(trim(lo+cut,a[cut:]))
            else:
                cut=max(0,min(len(a),-lo))
                parts.append(trim(lo,a[:cut]))
        return LP(parts)
    def plus(self): return self.split(True)
    def minus(self): return self.split(False)
    def coefficients(self,basis):
        out=[]
        for i,j in basis:
            lo,a=self.parts[j]; k=i-lo
            out.append(int(a[k]) if 0<=k<len(a) else 0)
        return np.array(out,dtype=np.uint8)
    def terms(self):
        return [(int(lo+i),j,int(c)) for j,(lo,a) in enumerate(self.parts) for i,c in enumerate(a) if c]
    def is_zero(self): return all(not np.any(a) for _,a in self.parts)
    def __repr__(self): return repr(self.terms())

P=LP.from_terms([(i,0,c) for i,c in enumerate(P_CODES)])
e=LP.from_terms([(-i-1,2,c) for i,c in enumerate(C_CODES)])

def basis_L(d): return [(i,j) for j in range(3) for i in range((d-10*j)//3+1)]
def basis_bracket(d): return [(i,j) for j in range(3) for i in range((d-10*j)//3+1,0)]
def poly_from_vec(v,basis): return LP.from_terms([(i,j,int(c)) for c,(i,j) in zip(v,basis) if c])

U_BASIS=[(-1,1)]+[(i,2) for i in range(-5,0)]
V_BASIS=[(-2,0),(-1,0)]+[(i,1) for i in range(-5,0)]+[(i,2) for i in range(-6,0)]

def frob25(p):
    # Coefficients are in F25, and so fixed; do NOT use for geometric
    # coefficients in a larger extension field without coefficient Frobenius.
    out=LP()
    for i,j,c in p.terms(): out=out+LP.mono(25*i,j,c)*(P**(8*j))
    return out

if __name__=='__main__':
    assert MUL[5,5]==8
    for a in range(1,25): assert MUL[a,INV[a]]==1
    assert frob25(e).terms()==(e**25).terms()
    print('F25 and Laurent arithmetic basic checks PASS')
