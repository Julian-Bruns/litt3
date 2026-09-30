"""Small exact extensions of F_25, polynomial basis, no dependencies."""
from __future__ import annotations
import ff25 as f

class Extension:
    def __init__(self, modulus: list[int]):
        self.modulus = f.pscale(modulus, f.inv(modulus[-1]))
        self.degree = len(modulus)-1
        self.zero = (0,)*self.degree
        self.one = (1,)+(0,)*(self.degree-1)
    def elt(self, p):
        if isinstance(p, int): p=[p]
        p=f.pdivmod(list(p), self.modulus)[1]
        return tuple(p+[0]*(self.degree-len(p)))
    def add(self,a,b): return tuple(f.add(x,y) for x,y in zip(a,b))
    def neg(self,a): return tuple(f.neg(x) for x in a)
    def sub(self,a,b): return self.add(a,self.neg(b))
    def mul(self,a,b): return self.elt(f.pmul(list(a),list(b)))
    def pow(self,a,n):
        if n<0:return self.pow(self.inv(a),-n)
        r=self.one
        while n:
            if n&1:r=self.mul(r,a)
            a=self.mul(a,a);n>>=1
        return r
    def inv(self,a):
        if a==self.zero:raise ZeroDivisionError
        g,b,c=f.pxgcd(list(a),self.modulus)
        if g != [1]:raise ZeroDivisionError("not a unit")
        return self.elt(b)
    def div(self,a,b):return self.mul(a,self.inv(b))
    def eval(self,p,a):
        r=self.zero
        for c in reversed(p):r=self.add(self.mul(r,a),self.elt(c))
        return r

def determinant(matrix):
    a=[list(row) for row in matrix];d=1;n=len(a)
    for c in range(n):
        pivot=next((r for r in range(c,n) if a[r][c]),None)
        if pivot is None:return 0
        if pivot!=c:a[c],a[pivot]=a[pivot],a[c];d=f.neg(d)
        p=a[c][c];d=f.mul(d,p)
        a[c]=[f.mul(x,f.inv(p)) for x in a[c]]
        for r in range(c+1,n):
            q=a[r][c]
            a[r]=[f.sub(x,f.mul(q,y)) for x,y in zip(a[r],a[c])]
    return d
