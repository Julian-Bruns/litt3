"""Small exact finite-field/polynomial layer. Python standard library only.

F25 elements are integer codes a+5*b, with iota^2=iota+3.
Polynomial coefficient lists ascend; [] is the zero polynomial.
No floating-point arithmetic, randomized search, or CAS dependency is used.
"""
from itertools import permutations
from math import isqrt

class F25:
    zero = 0
    one = 1
    order = 25
    def add(self, a, b):
        return ((a % 5 + b % 5) % 5) + 5*((a//5 + b//5) % 5)
    def neg(self, a):
        return (-a % 5) + 5*((-(a//5)) % 5)
    def sub(self, a, b):
        return self.add(a, self.neg(b))
    def mul(self, a, b):
        a0,a1,b0,b1 = a%5,a//5,b%5,b//5
        return (a0*b0+3*a1*b1)%5 + 5*((a0*b1+a1*b0+a1*b1)%5)
    def pow(self, a, n):
        if n < 0:
            return self.pow(self.inv(a), -n)
        r = self.one
        while n:
            if n & 1: r = self.mul(r, a)
            a = self.mul(a, a); n >>= 1
        return r
    def inv(self, a):
        if a == self.zero: raise ZeroDivisionError('inverse of zero')
        return self.pow(a, 23)
    def div(self, a, b):
        return self.mul(a, self.inv(b))
    def integer(self, n):
        return n % 5

F = F25()

def trim(p, K=F):
    p = list(p)
    while p and p[-1] == K.zero: p.pop()
    return p

def add(a,b,K=F):
    a,b=list(a),list(b)
    return trim([K.add(a[i] if i<len(a) else K.zero,
                       b[i] if i<len(b) else K.zero)
                 for i in range(max(len(a),len(b)))],K)

def neg(a,K=F): return [K.neg(x) for x in a]
def sub(a,b,K=F): return add(a,neg(b,K),K)
def scale(a,c,K=F): return trim([K.mul(c,x) for x in a],K)

def mul(a,b,K=F):
    if not a or not b: return []
    out=[K.zero]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): out[i+j]=K.add(out[i+j],K.mul(x,y))
    return trim(out,K)

def divmod_poly(a,b,K=F):
    a,b=trim(a,K),trim(b,K)
    if not b: raise ZeroDivisionError('zero polynomial divisor')
    q=[K.zero]*max(0,len(a)-len(b)+1)
    inv=K.inv(b[-1])
    while len(a)>=len(b):
        j=len(a)-len(b); c=K.mul(a[-1],inv); q[j]=c
        for i,x in enumerate(b): a[i+j]=K.sub(a[i+j],K.mul(c,x))
        a=trim(a,K)
    return trim(q,K),a

def mod(a,b,K=F): return divmod_poly(a,b,K)[1]

def gcd(a,b,K=F):
    while b: a,b=b,mod(a,b,K)
    return scale(a,K.inv(a[-1]),K) if a else []

def power(a,n,K=F):
    if n<0: raise ValueError('negative polynomial power')
    r=[K.one]
    while n:
        if n&1: r=mul(r,a,K)
        a=mul(a,a,K);n>>=1
    return r

def powmod(a,n,h,K=F):
    r=[K.one];a=mod(a,h,K)
    while n:
        if n&1: r=mod(mul(r,a,K),h,K)
        a=mod(mul(a,a,K),h,K);n>>=1
    return r

def derivative(a,K=F):
    return trim([K.mul(K.integer(i),a[i]) for i in range(1,len(a))],K)

def compose_mod(a,b,h,K=F):
    out=[]
    for c in reversed(a): out=add(mod(mul(out,b,K),h,K),[c],K)
    return out

def evaluate(a,x,K=F):
    out=K.zero
    for c in reversed(a): out=K.add(K.mul(out,x),c)
    return out

def determinant(m,K=F):
    n=len(m);a=[list(row) for row in m];out=K.one
    for j in range(n):
        pivot=next((i for i in range(j,n) if a[i][j]!=K.zero),None)
        if pivot is None:return K.zero
        if pivot!=j:a[j],a[pivot]=a[pivot],a[j];out=K.neg(out)
        pivot_value=a[j][j];out=K.mul(out,pivot_value);inv=K.inv(pivot_value)
        for i in range(j+1,n):
            c=K.mul(a[i][j],inv)
            for k in range(j,n):a[i][k]=K.sub(a[i][k],K.mul(c,a[j][k]))
    return out

def solve(m,b,K=F):
    n=len(m);a=[list(row)+[rhs] for row,rhs in zip(m,b)]
    for j in range(n):
        pivot=next((i for i in range(j,n) if a[i][j]!=K.zero),None)
        if pivot is None: raise ValueError('singular basis matrix')
        a[j],a[pivot]=a[pivot],a[j]
        inv=K.inv(a[j][j]);a[j]=[K.mul(inv,x) for x in a[j]]
        for i in range(n):
            if i!=j:
                c=a[i][j]
                a[i]=[K.sub(x,K.mul(c,y)) for x,y in zip(a[i],a[j])]
    return [a[i][-1] for i in range(n)]

def multiplication_matrix(element,h,K=F):
    n=len(h)-1
    cols=[mod([K.zero]*j+list(element),h,K) for j in range(n)]
    return [[cols[j][i] if i<len(cols[j]) else K.zero for j in range(n)]
            for i in range(n)]

def characteristic_poly(m,K=F):
    """Leibniz determinant det(SI-M), not Newton identities divided by 5."""
    n=len(m);out=[]
    for p in permutations(range(n)):
        term=[K.one]
        for i,j in enumerate(p):
            entry=[K.neg(m[i][j])]
            if i==j:entry.append(K.one)
            term=mul(term,entry,K)
        parity=sum(p[i]>p[j] for i in range(n) for j in range(i+1,n))%2
        out=add(out,neg(term,K) if parity else term,K)
    return out

def norm_polynomial(h,A,K=F):
    return characteristic_poly(multiplication_matrix(mod(A,h,K),h,K),K)

def inverse_primitive(h,A,K=F):
    """Return U_A(S), det(T_A), T_A, with U_A(A(U))=U modulo h."""
    n=len(h)-1;p=[K.one];cols=[]
    for _ in range(n):
        cols.append(p+[K.zero]*(n-len(p)))
        p=mod(mul(p,A,K),h,K)
    matrix=[[cols[j][i] for j in range(n)] for i in range(n)]
    target=[K.zero,K.one]+[K.zero]*(n-2)
    coeffs=trim(solve(matrix,target,K),K)
    return coeffs,determinant(matrix,K),matrix

class Extension:
    """Finite field K[U]/h; caller must verify h irreducible."""
    def __init__(self,h,base=F):
        self.base=base;self.h=trim(h,base);self.n=len(self.h)-1
        if self.h[-1]!=base.one:raise ValueError('modulus must be monic')
        self.zero=(base.zero,)*self.n
        self.one=(base.one,)+(base.zero,)*(self.n-1)
        self.order=base.order**self.n
    def element(self,p):
        p=mod(p,self.h,self.base)
        return tuple(p+[self.base.zero]*(self.n-len(p)))
    def embed(self,a):return self.element([a])
    def integer(self,n):return self.embed(self.base.integer(n))
    def add(self,a,b):return tuple(self.base.add(x,y) for x,y in zip(a,b))
    def neg(self,a):return tuple(self.base.neg(x) for x in a)
    def sub(self,a,b):return self.add(a,self.neg(b))
    def mul(self,a,b):return self.element(mul(a,b,self.base))
    def pow(self,a,n):
        if n<0:return self.pow(self.inv(a),-n)
        r=self.one
        while n:
            if n&1:r=self.mul(r,a)
            a=self.mul(a,a);n>>=1
        return r
    def inv(self,a):
        if a==self.zero:raise ZeroDivisionError('inverse of zero')
        return self.pow(a,self.order-2)
    def div(self,a,b):return self.mul(a,self.inv(b))


def irreducible_prime_degree(h,K=F):
    """Rabin test in prime degree: X^(q^n)=X and gcd(h,X^q-X)=1."""
    n=len(h)-1
    if n<2 or any(n%d==0 for d in range(2,isqrt(n)+1)):
        raise ValueError('test implemented only for prime degree')
    x=[K.zero,K.one]
    return powmod(x,K.order**n,h,K)==x and len(gcd(h,sub(powmod(x,K.order,h,K),x,K),K))==1
