"""Strict power-basis decoding, without evaluating thousands of powers.

This recognizes only canonical Sage finite-field polynomial strings. Any
other expression is explicitly left to the old decoder, never guessed.
The native-image equality check is mandatory: a tower generator is not
silently identified with the native field generator.
"""
import re


def power_basis_digits(description):
    generator=description['generator'];degree=int(description['degree'])
    escaped=re.escape(generator)
    monomial=re.compile(r'(?:(?P<c>[1-4])\*)?'+escaped+r'(?:\^(?P<e>[1-9][0-9]*))?')
    def decode(value):
        if not isinstance(value,str):return None
        if value in ('0','1','2','3','4'):return [int(value)]
        coefficients=[0]*degree;seen=set()
        for term in value.split(' + '):
            if term in ('1','2','3','4'):exponent=0;coefficient=int(term)
            else:
                match=monomial.fullmatch(term)
                if match is None:return None
                exponent=int(match['e'] or '1');coefficient=int(match['c'] or '1')
            if exponent>=degree or exponent in seen:return None
            seen.add(exponent);coefficients[exponent]=coefficient
        return coefficients
    return decode


def native_power_basis_decoder(field,description,images):
    if description.get('kind')!='finite_field':return None
    generator=description['generator'];degree=int(description['degree'])
    if int(field.degree())!=degree or images[generator]!=field.gen():return None
    digits=power_basis_digits(description)
    def decode(value):
        coefficients=digits(value)
        return None if coefficients is None else field(coefficients)
    return decode


def top_level_sum(text):
    depth=0;begin=0;terms=[]
    for index,c in enumerate(text):
        if c=='(':depth+=1
        elif c==')':
            depth-=1
            if depth<0:return None
        elif c=='+' and depth==0:
            terms.append(text[begin:index].strip());begin=index+1
    if depth:return None
    terms.append(text[begin:].strip())
    return terms if all(terms) else None


def canonical_coefficient_decoder(field,description,images):
    """Decode actual finite/tower power bases through the VERIFIED images.

    A finite-field homomorphism uses cached native modular composition;
    it does not exponentiate the image separately for every monomial.
    This works equally for a native field and an optional cubic extension.
    Unsupported textual forms return None for the unchanged old fallback.
    """
    from sage.all import GF,PolynomialRing
    direct=native_power_basis_decoder(field,description,images)
    if direct is not None:return direct
    if description['kind']=='finite_field':
        degree=int(description['degree']);generator=description['generator']
        source=GF(5**degree,name=generator,
                  modulus=PolynomialRing(GF(5),'z')(description['modulus']),
                  check_irreducible=False)
        embedding=source.hom([images[generator]],field)
        assert embedding(source.gen())==images[generator]
        digits=power_basis_digits(description)
        def decode(value):
            coefficients=digits(value)
            return None if coefficients is None else embedding(source(coefficients))
        return decode
    if description['kind']!='polynomial_quotient_field':return None
    base=canonical_coefficient_decoder(field,description['base'],images)
    if base is None:return None
    degree=int(description['degree']);generator=description['generator']
    monomial=re.compile(r'(?:(?P<c>.+)\*)?'+re.escape(generator)+r'(?:\^(?P<e>[1-9][0-9]*))?')
    powers=[field.one()]
    for _ in range(1,degree):powers.append(powers[-1]*images[generator])
    def decode(value):
        if not isinstance(value,str):return None
        terms=top_level_sum(value)
        if terms is None:return None
        coefficients=[[] for _ in range(degree)]
        for term in terms:
            match=monomial.fullmatch(term)
            if match is None:exponent=0;coefficient=term
            else:
                exponent=int(match['e'] or '1');coefficient=match['c'] or '1'
                if exponent>=degree:return None
                if coefficient.startswith('(') and coefficient.endswith(')'):
                    coefficient=coefficient[1:-1]
            coefficients[exponent].append(coefficient)
        answer=field.zero()
        for exponent,texts in enumerate(coefficients):
            if not texts:continue
            coefficient=base(' + '.join(texts))
            if coefficient is None:return None
            answer+=coefficient*powers[exponent]
        return answer
    return decode
