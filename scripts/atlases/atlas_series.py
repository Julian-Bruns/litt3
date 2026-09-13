"""Coefficient-safe Laurent primitives, including native large finite fields.

Sage10.9 misindexes some exact monomial Laurent series over PARI fields.
Explicit valuation-relative lists avoid that path. Finite precision is
checked before any requested coefficient is used in an exact identity.
"""

def coefficients(series,exponents):
    requested=list(exponents)
    precision=series.precision_absolute()
    if any(e>=precision for e in requested):
        raise ValueError('Requested Laurent coefficient is not known at the saved precision')
    values=series.list(); zero=series.parent().base_ring().zero()
    if not values: return [zero]*len(requested)
    shift=series.valuation()
    return [values[int(e-shift)] if 0<=e-shift<len(values) else zero for e in requested]


def coefficient(series,exponent):
    if exponent>=series.precision_absolute():
        raise ValueError('Requested Laurent coefficient is not known at the saved precision')
    # The affected Sage optimization indexes a scalar unit part without an
    # upper support check. Supply that check explicitly. In-support access
    # is exact; no full coefficient-list copy is needed for every pivot.
    if exponent<series.valuation() or exponent>series.degree():
        return series.parent().base_ring().zero()
    return series[exponent]


def transport(series,target,coefficient_map):
    """Exact coefficient transport; no symbolic Laurent-polynomial evaluation."""
    values=series.list()
    if not values: return target.zero().add_bigoh(series.precision_absolute())
    return target([coefficient_map(c) for c in values],n=series.valuation(),
                  prec=series.precision_absolute())


def from_terms(target,terms,precision=None):
    terms={int(e):c for e,c in terms.items() if c}
    if not terms:
        return target.zero() if precision is None else target.zero().add_bigoh(precision)
    lower,upper=min(terms),max(terms)
    zero=target.base_ring().zero()
    values=[terms.get(e,zero) for e in range(lower,upper+1)]
    return target(values,n=lower) if precision is None else target(values,n=lower,prec=precision)
