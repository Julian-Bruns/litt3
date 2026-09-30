# Bounds on atlas degree from wild ramification jumps

Version3,2026-09-14.

Let k be algebraically closed of characteristic p>=3. Let a smooth
projective connected curve X, with h=2g(X)−2>0, be a degree-n finite
étale atlas of an effective proper orbifold with coarse P1 and exactly
two branch points, one wild and one tame. At the wild point put

    e=qt,    q=|I_1|,    p not dividing t,    c=delta−e,

and assume 0<c<e. Either condition below bounds n effectively:

1. Every positive upper jump of the wild-subgroup extension belongs
   to (1/L)Z, for a fixed integer L>=1. The bound depends on p,h,L.
2. Numerically c=j(q−1)−1 for a positive integer j. Then
   q<=(h+2)², and n is bounded in terms of p,h.

The second condition includes a single positive lower jump. For the
first, upper numbering is that of I_1, not the full inertia group.

A bound on the largest irreducible representation degree of I_1 also
bounds n; so does a bound on its minimum abelian-subgroup index.
Indeed every upper-jump denominator divides an irreducible degree,
and those degrees are p-powers. In particular abelian I_1 gives L=1
by Hasse–Arf.

For p=5,h=16:

- Condition1 with L=1, or condition2, forces q=5 and n<=2240.
  Under L=1 there is at most one positive jump. The numerical
  condition2 sieve has24 full necessary tuples.
- Under L=5, every nonintegral possibility has q=125, lower jumps1,6
  and |I_2|=5. The full wild/tame inertia orders and atlas degrees are

      (e,d,n)=(1000,7,112000) or (3000,21,336000).

  Together with the integral cases, this gives n<=336000.

These are necessary bounds for the stated actual atlas; surviving
signatures are not assertions of realizability. No Galois hypothesis
on X over the orbifold or abelian hypothesis on full monodromy is used.

[Proof and exact signature replay](../../../Proofs/quotient_geometry/local_actions/wild_jump_atlas_bounds.md).
