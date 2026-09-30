"""Boundary-controlled degree-54 monic scale algebra.

The routine uses the original corrected tails. It does NOT certify global
emptiness. The complete fibre decision is a 54-row column-membership test;
three smaller 54-square minors give necessary ratio equations only.
"""
from ext import EP
from residual import Tails
from leading_slope import c72_leading

TAIL_INDICES = [n for n in range(71,141) if n != 72]
PREFIX = [71] + list(range(73,125))
MINOR_INDICES = [PREFIX+[n] for n in [125,126,140]]


def monic_model(A,q,u):
    ts=Tails(A)
    lead=c72_leading(q,u)
    assert ts.tail(72).degree()==54 and ts.tail(72)[54]==lead
    P=ts.tail(72)*lead.inverse()
    assert P.degree()==54 and P[54]==1
    residues={n:ts.tail(n)%P for n in TAIL_INDICES}
    return P,residues


def times_mu(a,P):
    """Companion multiplication; P must be monic, no other unit required."""
    assert P[P.degree()]==1
    return EP([0]+[a[j] for j in range(len(a))])%P


def ideal_columns(residues,P):
    """Yield coefficients of mu^j*r, 0<=j<degree(P), for each residue r.
    Their span over a geometric residue field is exactly the generated ideal.
    """
    for r in residues:
        val=r%P
        for j in range(P.degree()):
            yield val
            val=times_mu(val,P)


def nonzero_scale_target(P):
    d=P.degree()
    return EP([0]*d+[1])%P
