"""Exact cached monomial transport, adapted from A18 sparse export.

No coefficient specialization is made. Cache powers and partial products
shared by different source monomials; construct each target polynomial
with the native polynomial operations instead of repeated generic subs.
"""
import time


class SparsePolynomialTransport:
    def __init__(self,source,target,images,max_cached_terms=1500000):
        assert len(images)==source.ngens()
        self.source=source;self.target=target
        self.images=[target(x) for x in images]
        self.powers=[{0:target.one(),1:v} for v in self.images]
        self.products={};self.cached_terms=0
        self.max_cached_terms=max_cached_terms
        self.operations=0;self.calls=0

    def power(self,i,n):
        cache=self.powers[i]
        if n not in cache:cache[n]=self.images[i]**n
        return cache[n]

    def monomial(self,exponent):
        key=tuple((i,int(n)) for i,n in enumerate(exponent) if n)
        return self.product(key)

    def product(self,key):
        if not key:return self.target.one()
        if key in self.products:return self.products[key]
        i,n=key[-1]
        answer=self.product(key[:-1])*self.power(i,n)
        self.operations+=1
        terms=answer.number_of_terms()
        if self.cached_terms+terms<=self.max_cached_terms:
            self.products[key]=answer;self.cached_terms+=terms
        return answer

    def __call__(self,polynomial):
        self.calls+=1
        pieces=[c*self.monomial(e) for e,c in polynomial.dict().items()]
        # Pairwise summation limits repeated rebuilding of a large prefix.
        while len(pieces)>1:
            pieces=[pieces[i]+pieces[i+1] if i+1<len(pieces) else pieces[i]
                    for i in range(0,len(pieces),2)]
        return pieces[0] if pieces else self.target.zero()

    def stats(self):
        return dict(calls=self.calls,product_operations=self.operations,
                    cached_products=len(self.products),cached_terms=self.cached_terms)
