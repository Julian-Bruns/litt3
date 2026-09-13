"""A specified finite-field embedding, evaluated by native modular composition."""


def from_power_coordinates(field,values):
    """Use Sage's coordinate-vector constructor, never implicit Horner.

    For PARI fields Sage interprets a short list as a polynomial and
    substitutes the generator. A FULL degree-length list instead directly
    constructs its vector. Zero padding is essential for Kummer/subfield
    coefficients, which systematically have trailing zero coordinates.
    """
    values=list(values);degree=int(field.degree())
    assert len(values)<=degree
    if len(values)<=1:return field(values[0] if values else 0)
    return field(values+[0]*(degree-len(values)))


def verified_embedding(source,target,generator_image):
    from sage.all import pari
    generator_image=target(generator_image)
    # Sage's public generic hom is an independent definition/check, but its
    # evaluation is coefficient-by-coefficient Horner arithmetic, NOT ffmap.
    reference=source.hom([generator_image],target)
    a=source.gen().__pari__();b=generator_image.__pari__()
    if a.type()!='t_FFELT' or b.type()!='t_FFELT':return reference
    mapping=pari([a,b])
    def apply(value):return target(mapping.ffmap(source(value).__pari__()))
    probes=[source.zero(),source.one(),source.gen(),source.gen()**2+2*source.gen()+3]
    assert all(apply(v)==reference(v) for v in probes)
    return apply


def inverse_frobenius_map(field):
    """One inverse-Frobenius map, not a cache of all d-1 intermediate maps.

    Sage's pth_power(-1) constructs O(d) cached field maps. A single PARI
    automorphism avoids O(d^2) retained coefficients in the largest fields.
    Every atlas coefficient is still checked by taking its fifth power.
    """
    assert field.characteristic()==5
    if int(field.degree())<=4:
        exponent=5**(int(field.degree())-1)
        return lambda value:value**exponent
    generator=field.gen();mapping=generator.__pari__().fffrobenius(-1)
    def apply(value):return field(mapping.ffmap(field(value).__pari__()))
    assert apply(generator)**5==generator and apply(field.one())==1 and apply(field.zero())==0
    return apply
