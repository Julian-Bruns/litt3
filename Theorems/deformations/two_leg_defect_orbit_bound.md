# A defect section bounds the actual joint degree by its deck orbit

Version1,2026-09-10. Focused medium audit PASS. The bound uses
both ORIGINAL etale legs. It does not bound the degree of a redundant
common source over its joint normalization.

Let X←f−Z−g→Y be actual finite etale maps of smooth projective connected
curves of genus at least two over k=bar(F5). Suppose g is Galois, and
admissible active nilpotent connections r_X,r_Y match on Z. Write s_i
for their normalized square-Hasse quartics. Suppose r_X has a nonzero
nilpotent tangent quadratic phi_X. Set

    a_X=phi_X²/s_X, a=f*a_X,
    b=the size of the actual Gal(Z/Y)-orbit of a.

Then a_X is nonconstant, of degree at most8(g(X)−1). On the smooth
joint normalization R with k(R)=f*k(X)g*k(Y), both induced maps are
finite etale, and

    deg(R/Y) <= 8(g(X)−1)b,
    deg(R/X) <= 8(g(Y)−1)b.                               (1)

The joint Y-leg need not be Galois. No separability of a_X is required.

## The source-defect-two application

Suppose g(Y)=2, r_Y is ordinary, the source has exactly two nilpotent
tangent directions, and some five-element in Gal(Z/Y) acts nontrivially
on that two-dimensional space. The audited deck-group theorem gives
one of C10,D10,C2×D10 as its faithful image. Each acts on quadratic
ratios phi²/s through a group of order at most TEN. Hence, whenever
r_X is nonordinary,

    deg(R/X)<=80;
    deg(R/Y)<=640 if g(X)=9.                              (2)

This applies even if Z is NOT jointly minimal and even if R→Y is
NOT Galois. It does not infer r_X ordinary from source defect two alone.

## Exclusion for the already selected main pair

The original large-parameter choice also excludes EVERY common cover
whose joint Y-leg has degree at most335999. This follows from the
existing effective counting ingredients, without a cored hypothesis.

Consequently the main genus-nine/high-degree-genus-two pair admits no
matched active span satisfying all three conditions:

1. the actual Y-leg is Galois and the source defect is two;
2. a five-element acts nontrivially on its two defects;
3. the X connection is nonordinary.

More generally, in a source-defect-two Galois Y-leg span with nonordinary
r_X, the faithful PROJECTIVE defect image must have order at least5250.
In the remaining prime-to-five-action branch it can therefore only be
cyclic or dihedral; the exceptional projective A4,S4 images are excluded.
The cyclic/dihedral orders remain unbounded. This last classification
uses the established self-dual two-dimensional representation, not an
arbitrary monodromy representation.

The later [two-defect exclusion](two_defect_nontrivial_five_exclusion.md)
settles the ordinary-X/nontrivial-five branch as well. Higher defects,
non-Galois sources outside the stated hypotheses, dormant matches and
absent connection matches remain outside these conclusions.

[Proof](../../Solutions/deformations/two_leg_defect_orbit_bound.md) ·
[Audit metadata](../../Research/audits/TWO_LEG_DEFECT_ORBIT_BOUND_AUDIT_2026_09_10.md).
