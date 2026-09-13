"""Independent F5 polynomial arithmetic using carry-free integer packing.

This is a verifier, not the Sage/native search arithmetic. Every packing
width follows an explicit integer bound; the slow algorithm is retained
for regression checks.
"""
from functools import lru_cache


class ExactPolynomialField:
    def __init__(self,modulus):
        self.modulus=tuple(modulus);self.degree=len(modulus)-1
        assert self.modulus[-1]==1 and all(0<=c<5 for c in self.modulus)
        d=self.degree
        self.convolution_bits=(16*d).bit_length()
        self.reduction_bits=(16*(2*d-1)).bit_length()
        self.reductions=[]
        for i in range(2*d-1):
            coeff=self.reduce([0]*i+[1])
            self.reductions.append(sum(c<<(self.reduction_bits*j) for j,c in enumerate(coeff)))
        self.pack=lru_cache(maxsize=32768)(self._pack)
        self.multiply=lru_cache(maxsize=131072)(self._multiply)

    def reduce(self,coefficients):
        d=self.degree;v=list(coefficients)
        for i in range(len(v)-1,d-1,-1):
            c=v[i]%5
            for j in range(d):v[i-d+j]=(v[i-d+j]-c*self.modulus[j])%5
        return tuple(c%5 for c in (v+[0]*d)[:d])

    def _pack(self,a):
        assert len(a)<=self.degree and all(0<=c<5 for c in a)
        return sum(c<<(self.convolution_bits*i) for i,c in enumerate(a))

    def _multiply(self,a,b):
        product=self.pack(a)*self.pack(b)
        mask=(1<<self.convolution_bits)-1
        reduced=sum((((product>>(self.convolution_bits*i))&mask)%5)*r
                    for i,r in enumerate(self.reductions))
        mask=(1<<self.reduction_bits)-1
        return tuple(((reduced>>(self.reduction_bits*j))&mask)%5 for j in range(self.degree))

    def slow_multiply(self,a,b):
        v=[0]*(2*self.degree-1)
        for i,c in enumerate(a):
            for j,e in enumerate(b):v[i+j]+=c*e
        return self.reduce(v)
