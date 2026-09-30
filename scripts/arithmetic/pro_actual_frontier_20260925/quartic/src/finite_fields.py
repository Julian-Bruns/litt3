"""Exact small finite fields; stdlib only. F25 codes a+5*b, beta^2=beta+3."""
from functools import lru_cache

ADD = [[((x%5+y%5)%5)+5*((x//5+y//5)%5) for y in range(25)] for x in range(25)]
NEG = [((-x%5)%5)+5*((-(x//5))%5) for x in range(25)]
MUL = [[((x%5*(y%5)+3*(x//5)*(y//5))%5)+5*((x%5*(y//5)+(x//5)*(y%5)+(x//5)*(y//5))%5) for y in range(25)] for x in range(25)]
def add(x,y): return ADD[x][y]
def sub(x,y): return ADD[x][NEG[y]]
def mul(x,y): return MUL[x][y]
def pow25(x,n):
    if n<0: return pow25(inv(x),-n)
    r=1
    while n:
        if n&1:r=MUL[r][x]
        x=MUL[x][x];n>>=1
    return r
def inv(x):
    if not x:raise ZeroDivisionError
    return pow25(x,23)
def div(x,y):return MUL[x][inv(y)]

class Extension:
    """F25[z]/(monic f), ascending coefficients, immutable tuple elements."""
    def __init__(self, modulus):
        assert modulus[-1]==1
        self.f=tuple(modulus);self.n=len(modulus)-1
        self.zero=(0,)*self.n;self.one=(1,)+(0,)*(self.n-1)
        self.gen=(0,1)+(0,)*(self.n-2)
    def const(self,c):return (c,)+(0,)*(self.n-1)
    def add(self,a,b):return tuple(ADD[x][y] for x,y in zip(a,b))
    def neg(self,a):return tuple(NEG[x] for x in a)
    def sub(self,a,b):return tuple(ADD[x][NEG[y]] for x,y in zip(a,b))
    def scale(self,a,c):return tuple(MUL[x][c] for x in a)
    def mul(self,a,b):
        n=self.n;t=[0]*(2*n-1)
        for i,x in enumerate(a):
            if x:
                for j,y in enumerate(b):
                    if y:t[i+j]=ADD[t[i+j]][MUL[x][y]]
        for i in range(2*n-2,n-1,-1):
            x=t[i]
            if x:
                for j in range(n):t[i-n+j]=ADD[t[i-n+j]][NEG[MUL[x][self.f[j]]]]
        return tuple(t[:n])
    def pow(self,a,n):
        if n<0:return self.pow(self.inv(a),-n)
        r=self.one
        while n:
            if n&1:r=self.mul(r,a)
            a=self.mul(a,a);n>>=1
        return r
    def inv(self,a):
        if a==self.zero:raise ZeroDivisionError
        return self.pow(a,25**self.n-2)
    def div(self,a,b):return self.mul(a,self.inv(b))
    def eval(self,coeffs,a):
        r=self.zero
        for c in reversed(coeffs):r=self.add(self.mul(r,a),self.const(c))
        return r

def rref_mod5(rows,nvars):
    """RREF of an augmented matrix; returns matrix and pivot columns."""
    a=[[int(x)%5 for x in r] for r in rows];piv=[];r=0
    for col in range(nvars):
        p=next((i for i in range(r,len(a)) if a[i][col]),None)
        if p is None:continue
        a[r],a[p]=a[p],a[r];iv=pow(a[r][col],-1,5)
        a[r]=[(x*iv)%5 for x in a[r]]
        for i in range(len(a)):
            if i!=r and a[i][col]:
                q=a[i][col];a[i]=[(x-q*y)%5 for x,y in zip(a[i],a[r])]
        piv.append(col);r+=1
        if r==len(a):break
    return a,piv

# Polynomial arithmetic over F25, ascending rows.
def trim(p):
    p=list(p)
    while p and p[-1]==0:p.pop()
    return p

def padd(a,b):
    return trim([ADD[a[i] if i<len(a) else 0][b[i] if i<len(b) else 0] for i in range(max(len(a),len(b)))])
def pneg(a):return trim([NEG[x] for x in a])
def psub(a,b):return padd(a,pneg(b))
def pscale(a,c):return trim([MUL[x][c] for x in a])
def pmul(a,b):
    if not a or not b:return []
    t=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):t[i+j]=ADD[t[i+j]][MUL[x][y]]
    return trim(t)
def pdivmod(a,b):
    a=trim(a);b=trim(b)
    if not b:raise ZeroDivisionError
    q=[0]*max(0,len(a)-len(b)+1);iv=inv(b[-1])
    while a and len(a)>=len(b):
        j=len(a)-len(b);c=MUL[a[-1]][iv];q[j]=c
        for i,x in enumerate(b):a[i+j]=ADD[a[i+j]][NEG[MUL[c][x]]]
        a=trim(a)
    return trim(q),a
def pgcd(a,b):
    a=trim(a);b=trim(b)
    while b:a,b=b,pdivmod(a,b)[1]
    return pscale(a,inv(a[-1])) if a else []
def pderivative(a):return trim([MUL[i%5][a[i]] for i in range(1,len(a))])
def peval(a,x):
    r=0
    for c in reversed(a):r=ADD[MUL[r][x]][c]
    return r
def ppowmod(a,n,f):
    r=[1]
    while n:
        if n&1:r=pdivmod(pmul(r,a),f)[1]
        a=pdivmod(pmul(a,a),f)[1];n>>=1
    return r

def determinant(matrix):
    a=[list(r) for r in matrix];n=len(a);d=1
    assert all(len(r)==n for r in a)
    for j in range(n):
        k=next((k for k in range(j,n) if a[k][j]),None)
        if k is None:return 0
        if k!=j:a[k],a[j]=a[j],a[k];d=NEG[d]
        p=a[j][j];d=MUL[d][p];iv=inv(p)
        for k in range(j+1,n):
            q=MUL[a[k][j]][iv]
            for l in range(j,n):a[k][l]=ADD[a[k][l]][NEG[MUL[q][a[j][l]]]]
    return d

def resultant(f,g):
    f=trim(f);g=trim(g)
    if not f or not g:return 0
    m=len(f)-1;n=len(g)-1
    rows=[]
    for i in range(n):rows.append([0]*i+list(reversed(f))+[0]*(n-1-i))
    for i in range(m):rows.append([0]*i+list(reversed(g))+[0]*(m-1-i))
    return determinant(rows)
