#!/usr/bin/env python3
"""Requested coefficients of high powers modulo5^s by exact ghost recursion.

If f^5=sigma(f)(x^5)+5G and N=5q+r, expand
 f^N=sum_j binomial(q,j)5^j f^r G^j sigma(f^(q-j))(x^5).
At precision s only j<s contributes. No interpolation or pointwise power
is substituted for Witt Frobenius. Every support exponent is a Python tuple.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
from functools import lru_cache
from math import comb
from scripts.arithmetic.toric_prym_unit_roots import multiply


class GhostCoefficients:
    def __init__(self,f,O,phi,digits,report=lambda *a,**kw:None,
                 full_precision_products=False):
        self.O=O;self.phi=phi;self.digits=digits;self.report=report
        self.base=[{(0,0):O.one()}]
        for _ in range(4):self.base.append(multiply(self.base[-1],f))
        difference=multiply(self.base[4],f)
        for (i,j),c in f.items():
            e=(5*i,5*j);difference[e]=difference.get(e,O.zero())-phi(c)
        self.G={}
        for e,c in difference.items():
            assert c.valuation()>=1
            if c:self.G[e]=c>>1
        self.H={};self.groups={};self.low_H={};self.low_base={};self.low_G={}
        self.rings={digits:O};self.full_precision_products=full_precision_products
        self.maxima=(max(e[0] for e in f),max(e[1] for e in f))
        report('ghost_engine_initialized',G_terms=len(self.G),digits=digits)

    def lower_ring(self,precision):
        if precision not in self.rings:
            from sage.all import GF,ZZ,Zq,PolynomialRing
            modulus=list(map(int,self.phi.modulus.list()));d=self.phi.degree
            if precision==1:
                self.rings[precision]=GF(5**d,'b',
                    modulus=PolynomialRing(GF(5),'v')(modulus),impl='pari_ffelt')
            else:
                self.rings[precision]=Zq(5**d,prec=precision,type='fixed-mod',names='b',
                    modulus=PolynomialRing(ZZ,'v')(modulus),implementation='FLINT')
        return self.rings[precision]

    def lower(self,c,precision):
        if precision==self.digits:return c
        return self.lower_ring(precision)(list(map(int,c._flint_rep().list())))

    def lift(self,c,precision):
        if precision==self.digits:return c
        coefficients=c.polynomial().list() if precision==1 else c._flint_rep().list()
        return self.O(list(map(int,coefficients)))

    def weighted(self,r,j,precision):
        if self.full_precision_products:precision=self.digits
        key=(r,j,precision)
        if key not in self.H:
            if (r,precision) not in self.low_base:
                self.low_base[r,precision]={e:self.lower(c,precision) for e,c in self.base[r].items()}
            if precision not in self.low_G:
                self.low_G[precision]={e:self.lower(c,precision) for e,c in self.G.items()}
            if j==0:
                low=self.low_base[r,precision]
            else:
                self.weighted(r,j-1,precision)
                low=multiply(self.low_H[r,j-1,precision],self.low_G[precision])
            self.low_H[key]=low
            self.H[key]={e:self.lift(c,precision) for e,c in low.items() if c}
            groups={}
            for e,c in self.H[key].items():groups.setdefault((e[0]%5,e[1]%5),[]).append((e,c))
            self.groups[key]=groups
            self.report('ghost_weighted_polynomial',r=r,j=j,precision=precision,terms=len(self.H[key]))
        return self.H[key]

    @lru_cache(maxsize=None)
    def twisted_coefficient(self,n,target,precision):
        return self.phi(self.coefficient(n,target,precision))

    @lru_cache(maxsize=None)
    def coefficient(self,n,target,precision):
        if target[0]<0 or target[1]<0 or any(target[i]>n*self.maxima[i] for i in (0,1)):
            return self.O.zero()
        if n<5:return self.base[n].get(target,self.O.zero())
        q,r=divmod(n,5);answer=self.O.zero()
        for j in range(min(q,precision-1)+1):
            product_precision=self.digits if self.full_precision_products else precision-j
            self.weighted(r,j,product_precision);value=self.O.zero()
            for (i,k),c in self.groups[r,j,product_precision].get((target[0]%5,target[1]%5),[]):
                child=((target[0]-i)//5,(target[1]-k)//5)
                if min(child)<0:continue
                value+=c*self.twisted_coefficient(q-j,child,precision-j)
            answer+=(5**j)*comb(q,j)*value
        return answer

    def statistics(self):
        return dict(coefficient_cache=self.coefficient.cache_info()._asdict(),
                    twisted_cache=self.twisted_coefficient.cache_info()._asdict(),
                    weighted_polynomials={str(k):len(v) for k,v in self.H.items()})
