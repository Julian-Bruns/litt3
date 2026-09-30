"""Small exact polynomial arithmetic over the user's F_25 code convention.
No external dependencies. All rows are ascending and padded to field degree.
"""
import itertools

ADD = [[(a % 5 + b % 5) % 5 + 5 * ((a // 5 + b // 5) % 5)
        for b in range(25)] for a in range(25)]
NEG = [(-a % 5) % 5 + 5 * (-(a // 5) % 5) for a in range(25)]
MUL = [[((a % 5)*(b % 5) + 3*(a // 5)*(b // 5)) % 5
       + 5 * (((a % 5)*(b // 5) + (a // 5)*(b % 5) + (a // 5)*(b // 5)) % 5)
       for b in range(25)] for a in range(25)]
INV = [0]+[next(b for b in range(1,25) if MUL[a][b]==1) for a in range(1,25)]

class Field:
    def __init__(self, modulus):
        assert modulus[-1] == 1
        self.modulus = tuple(modulus)
        self.n = len(modulus)-1
        self.zero = (0,)*self.n
        self.one = (1,)+(0,)*(self.n-1)
        self.gen = (0,1)+(0,)*(self.n-2)
    def scalar(self, a): return (a,)+(0,)*(self.n-1)
    def add(self,a,b): return tuple(ADD[x][y] for x,y in zip(a,b))
    def neg(self,a): return tuple(NEG[x] for x in a)
    def sub(self,a,b): return self.add(a,self.neg(b))
    def scale(self,a,c): return tuple(MUL[x][c] for x in a)
    def mul(self,a,b):
        c=[0]*(2*self.n-1)
        for i,x in enumerate(a):
            if x:
                for j,y in enumerate(b):
                    if y: c[i+j] = ADD[c[i+j]][MUL[x][y]]
        for i in range(2*self.n-2,self.n-1,-1):
            if c[i]:
                z=NEG[c[i]]
                for j,m in enumerate(self.modulus[:-1]):
                    c[i-self.n+j]=ADD[c[i-self.n+j]][MUL[z][m]]
        return tuple(c[:self.n])
    def pow(self,a,n):
        assert n>=0
        r=self.one
        while n:
            if n&1:r=self.mul(r,a)
            a=self.mul(a,a);n>>=1
        return r
    def inv(self,a):
        assert a!=self.zero
        return self.pow(a,25**self.n-2)
    def div(self,a,b):return self.mul(a,self.inv(b))
    def frob(self,a,n):return self.pow(a,5**n)
    def ev(self,p,a):
        r=self.zero
        for c in reversed(p):r=self.add(self.mul(r,a),self.scalar(c))
        return r
    def projection(self,a,lam):
        r=self.zero
        for i in range(4):
            r=self.add(r,self.scale(self.pow(a,25**i),pow(lam,-i,5)*4%5))
        return r
