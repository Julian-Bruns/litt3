# Finite target sets for liftable coreless correspondences

Fix a prime p and genus h≥2. The set E_(h,p) of
[geometric potential good reductions of compact arithmetic genus-h curves](../../Definitions/arithmetic_curve_reductions.md)
is finite.

Let k be any algebraically closed field of characteristic p. For a
coreless finite étale correspondence X←Z→Y over k with g(Y)=h, a
simultaneous smooth proper lift over a mixed-characteristic DVR, retaining
both finite étale maps, makes Y a base change of a class in E_(h,p).
This allows ramified base extensions and twists. The set depends only
on h,p.

## The selected genus-two partner

Let X be the fixed genus-nine curve and Y_t the partner of the
[bounded-atlas theorem](../quotient_geometry/bounded_atlas_partner_finiteness.md):
put

    D=335999!,  G=1+8D,  L=336000²,
    K=D·(D!)¹⁸·3^(4G²L)·(42000!)^(2G+L),

and choose a prime r>K and t of degree r over F25.
The [arithmetic bound](low_genus_arithmetic_bounds.md) gives
|E_(2,5)|<2^2000000<K, while [Y_t] has a Frobenius25 orbit of length r.

Hence every hypothetical common finite étale span for X,Y_t is coreless
and has no simultaneous smooth proper mixed-characteristic DVR lift,
even after finite ramified base extension or common étale refinement.

A compatible common nilpotent connection is therefore nonordinary in
the indigenous sense. An admissible active match nevertheless gives a
simultaneous W₂ lift. This ordinariness statement concerns the nilpotent
moduli space; it does not assert a nonzero tangent in the dormant locus.
See [shared negative extensions](../deformations/two_leg_negative_extensions.md)
for the resulting deformation-ring bounds.

This excludes lifted spans, not all common covers.

Version4,2026-09-14. Source-based author proof; the arithmetic count has
its separate scoped audit.
[Proof](../../Proofs/curve_arithmetic/liftable_coreless_target_finiteness.md).
