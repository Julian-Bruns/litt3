# Hodge bound for ordinary abelian covers of genus-two families

Version 3, 2026-09-14. Let F_q have odd characteristic p, let
a_0,a_1,a_2,a_3 be distinct elements of F_q, and put

    C_t: y²=∏_(i=0)^3(u−a_i)(u−t),
    U=P1_t minus {a_0,a_1,a_2,a_3,∞}.

For m≥2 prime to p, let C_(m),t→C_t be the maximal abelian exponent-m
étale cover: the pullback of [m]:J(C_t)→J(C_t) along the Abel map
based at infinity. It is geometrically connected, of degree N=m^4
and genus N+1.

If one smooth fiber C_(m),t is ordinary, there is a nonzero
E∈F_q[T] with

    deg E≤(p−1)m^4+4

such that E(t)≠0 implies that C_(m),t is ordinary. Equivalently,
every connected abelian étale cover of C_t with exponent dividing m
is then ordinary. In particular it suffices that
[F_q(t):F_q]>(p−1)m^4+4.

The bound comes from deg λ_cover≤N deg λ_base for tame admissible
covers, followed by the Hasse section of λ_cover^(p−1).

## The prescribed characteristic-five family

For p=q=5, (a_0,a_1,a_2,a_3)=(0,1,2,3), m=4, the complete finite
certificate supplies an ordinary fiber. Thus deg E≤1028, and

    [F5(t):F5]>1028

makes the degree-256, genus-257 maximal exponent-four cover ordinary.
This includes the parameter already selected in
[bounded-atlas partner finiteness](../../quotient_geometry/bounded_atlas_partner_finiteness.md).

For every nonordinary X over bar(F5) and such a t, there is consequently
no finite étale span X←Z→C_t whose C_t-leg Galois closure has group

    1→P→G→A→1,   P a 5-group, A abelian of exponent dividing 4.

There is no bound on P, and the original legs need not be Galois.
The general theorem is conditional on an ordinary fiber; no such
fiber is asserted here for exponent 8.

[Proof](../../../Proofs/jacobians/ordinary_covers/genus_two_abelian_cover_families.md) ·
[Exact four-torsion certificate](../../../scripts/genus_two/verify_genus_two_four_torsion.sage).
