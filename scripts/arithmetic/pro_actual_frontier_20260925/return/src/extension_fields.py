"""Exact finite extensions of F25, encoded in base 25. No CAS dependency.
The modulus is checked for irreducibility by Rabin's criterion.
"""
from functools import lru_cache
from exact import ADD,MUL,NEG,INV

def ptr(a):
    a=list(a)
    while a and a[-1]==0:a.pop()
    return a

def pa(a,b):
    c=a[:]+[0]*max(0,len(b)-len(a))
    for i,x in enumerate(b):c[i]=int(ADD[c[i],x])
    return ptr(c)
def pn(a):return [int(NEG[x]) for x in a]
def pm(a,b):
    if not a or not b:return []
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]=int(ADD[c[i+j],MUL[x,y]])
    return ptr(c)
def pd(a,b):
    if not b:raise ZeroDivisionError
    r=a[:];q=[0]*max(0,len(a)-len(b)+1)
    while r and len(r)>=len(b):
        k=len(r)-len(b);c=int(MUL[r[-1],INV[b[-1]]]);q[k]=c
        for j,v in enumerate(b):r[k+j]=int(ADD[r[k+j],NEG[MUL[c,v]]])
        r=ptr(r)
    return ptr(q),r

def ppow(a,n,m):
    out=[1]
    while n:
        if n&1:out=pd(pm(out,a),m)[1]
        a=pd(pm(a,a),m)[1];n>>=1
    return out

def pgcd(a,b):
    while b:a,b=b,pd(a,b)[1]
    return [int(MUL[x,INV[a[-1]]]) for x in a] if a else []

class Field:
    def __init__(self,modulus=(0,1)):
        self.modulus=list(map(int,modulus));self.d=len(self.modulus)-1
        if self.d<1 or self.modulus[-1]!=1 or any(not 0<=c<25 for c in self.modulus):raise ValueError('monic F25 modulus required')
        self.q=25**self.d
        x=pd([0,1],self.modulus)[1];powers=[x]
        for i in range(self.d):powers.append(ppow(powers[-1],25,self.modulus))
        if powers[self.d]!=x:raise ValueError('reducible modulus')
        n=self.d;prime_div=[];p=2
        while p*p<=n:
            if n%p==0:
                prime_div.append(p)
                while n%p==0:n//=p
            p+=1
        if n>1:prime_div.append(n)
        for p in prime_div:
            if pgcd(pa(powers[self.d//p],pn(x)),self.modulus)!=[1]:raise ValueError('reducible modulus')
    def digits(self,a):
        if not 0<=a<self.q:raise ValueError('coefficient out of range')
        out=[]
        for _ in range(self.d):out.append(a%25);a//=25
        return out
    @staticmethod
    def encode(cs):return sum(int(c)*25**i for i,c in enumerate(cs))
    @lru_cache(maxsize=200000)
    def add(self,a,b):
        if self.d==1:return int(ADD[a,b])
        return self.encode(int(ADD[x,y]) for x,y in zip(self.digits(a),self.digits(b)))
    @lru_cache(maxsize=10000)
    def neg(self,a):return self.encode(int(NEG[x]) for x in self.digits(a))
    def sub(self,a,b):return self.add(a,self.neg(b))
    @lru_cache(maxsize=200000)
    def mul(self,a,b):
        if self.d==1:return int(MUL[a,b])
        if not a or not b:return 0
        if self.d==2:
            a0,a1=a%25,a//25;b0,b1=b%25,b//25;h=int(MUL[a1,b1])
            c0=int(ADD[MUL[a0,b0],NEG[MUL[self.modulus[0],h]]])
            c1=int(ADD[ADD[MUL[a0,b1],MUL[a1,b0]],NEG[MUL[self.modulus[1],h]]])
            return c0+25*c1
        return self.encode(pd(pm(self.digits(a),self.digits(b)),self.modulus)[1])
    def pow(self,a,n):
        if n<0:a=self.inv(a);n=-n
        out=1
        while n:
            if n&1:out=self.mul(out,a)
            a=self.mul(a,a);n>>=1
        return out
    @lru_cache(maxsize=10000)
    def inv(self,a):
        if a==0:raise ZeroDivisionError
        return self.pow(a,self.q-2)

def rref_field(a,F):
    m=[list(map(int,r)) for r in a];nr=len(m);nc=len(m[0]) if nr else 0;piv=[]
    for c in range(nc):
        p=next((i for i in range(len(piv),nr) if m[i][c]),None)
        if p is None:continue
        r=len(piv);m[p],m[r]=m[r],m[p];s=F.inv(m[r][c]);m[r]=[F.mul(s,x) for x in m[r]]
        for i in range(nr):
            if i!=r and m[i][c]:
                s=m[i][c];m[i]=[F.sub(x,F.mul(s,y)) for x,y in zip(m[i],m[r])]
        piv.append(c)
        if len(piv)==nr:break
    return m,piv

def kernel_field(a,F):
    rr,piv=rref_field(a,F);n=len(a[0]);free=[i for i in range(n) if i not in piv];out=[]
    for c in free:
        v=[0]*n;v[c]=1
        for r,p in enumerate(piv):v[p]=F.neg(rr[r][c])
        out.append(v)
    return out

def dot_field(a,b,F):
    out=0
    for x,y in zip(a,b):out=F.add(out,F.mul(int(x),int(y)))
    return out
