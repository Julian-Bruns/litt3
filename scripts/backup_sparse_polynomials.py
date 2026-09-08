"""Tiny exact sparse polynomial arithmetic for backup certificate replay.

Coefficients remain elements of the frozen finite field.  This avoids
implicit generic-polynomial/Singular coefficient conversions; it is not
a Groebner solver and has no reduction or ideal-membership oracle.
"""
from atlas_field_maps import from_power_coordinates


class SparsePolynomials:
    def __init__(self,field,variables=3):
        self.field=field;self.variables=variables;self.zero=(0,)*variables
        self.one={self.zero:field.one()}
        self.gens=[{tuple(int(i==j) for i in range(variables)):field.one()}
                   for j in range(variables)]

    def clean(self,poly):
        return {ex:co for ex,co in poly.items() if co}

    def constant(self,value):
        value=self.field(value)
        return {self.zero:value} if value else {}

    def monomial(self,exponent,coefficient=1):
        exponent=tuple(int(n) for n in exponent);coefficient=self.field(coefficient)
        assert len(exponent)==self.variables and min(exponent)>=0
        return {exponent:coefficient} if coefficient else {}

    def add(self,first,second,scale=1):
        scale=self.field(scale);result=dict(first)
        if scale:
            for ex,co in second.items():result[ex]=result.get(ex,self.field.zero())+scale*co
        return self.clean(result)

    def scaled(self,poly,scale):
        scale=self.field(scale)
        return {ex:co*scale for ex,co in poly.items()} if scale else {}

    def shift(self,poly,shift,scale=1):
        scale=self.field(scale)
        return {tuple(a+b for a,b in zip(ex,shift)):co*scale for ex,co in poly.items()} if scale else {}

    def multiply(self,first,second):
        result={}
        for a,c in first.items():
            for b,d in second.items():
                ex=tuple(i+j for i,j in zip(a,b))
                result[ex]=result.get(ex,self.field.zero())+c*d
        return self.clean(result)

    def sum(self,polys):
        result={}
        for poly in polys:result=self.add(result,poly)
        return result

    def frobenius(self,poly,iterations=1):
        power=5**int(iterations)
        return {tuple(power*n for n in ex):co**power for ex,co in poly.items()}

    def decode(self,terms):
        result={}
        for ex,co in terms:
            ex=tuple(int(n) for n in ex)
            assert len(ex)==self.variables and min(ex)>=0 and ex not in result
            result[ex]=from_power_coordinates(self.field,co)
        return self.clean(result)

    def encode(self,poly):
        return [[list(ex),[int(c) for c in co.polynomial().list()]]
                for ex,co in sorted(self.clean(poly).items())]
