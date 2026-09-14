# Proof: finite bad cosets for ordinary cyclic triples

[Canonical statement](../../../Theorems/jacobians/theta_divisors/ordinary_cyclic_triple_finite_bad_cosets.md).
Finiteness audited PASS by /root/ordinary_triple_finite_bad_fibers_check,
2026-09-05; grid bound checked by /root/elliptic_grid_divisor_bound.
[Audit scope](../../../routes/global/audits/ORDINARY_CYCLIC_TRIPLE_FINITE_BAD_FIBERS_AUDIT.md).
Section 1 cites the Prym product theorem; its characteristic-five
applicability and explicit polarization matrix are explained there.

## 1. The Prym product and its polarization

For a cyclic étale cover of odd degree n of a hyperelliptic curve,
Ortega's product map ψ is an isomorphism:
[Ortega, *Variétés de Prym associées aux revêtements n-cycliques d'une
courbe hyperelliptique*, Proposition 2.5 and Lemma 2.1](https://arxiv.org/pdf/math/0307151#page=4).
In the equal-factor notation of
[Lange–Ortega, Theorem 2.1(a)](https://arxiv.org/pdf/1601.04082#page=3),

    ψ:J(U/⟨j⟩)²→P,       (x,y)↦i(x)+σi(y),

where j lifts the hyperelliptic involution and i is quotient pullback.
The odd-degree argument is algebraic when 2n is invertible: a point
in the intersection of the two factors is fixed by j and σ, is killed
by n on P, and descends through the cyclic cover. The hyperelliptic
involution then also kills it by 2. The intersection scheme is killed
by n and hence étale, so it is trivial. This verifies applicability
in characteristic 5 for n=3, without a complex lifting argument.

Now q:U→Y has degree 3 and g(Y)=2. The involution j fixes one point
above each of the six Weierstrass points, so E=U/⟨j⟩ is elliptic.
Its ramified degree-two quotient gives an injection i:E→J(U),
and ψ identifies P with E². Write Ξ for the restricted polarization,
as in Ortega §3. For b=i^†σi, one has i^†i=2, b=b^† from jσj=σ^−1,
and 2+b+b^†=0 from 1+σ+σ²=0 on P. Thus

    ψ^*Ξ ↔ H=[[2,−1],[−1,2]],             deg λ_Ξ=9.       (1)

Use the product principal identification (E²)^∨=E². For
A=q^*J(Y), Q=J(U)/A and ρ=π|P, complementarity gives

    P=E², Q=P^∨=E², ρ=H, deg ρ=9, ker ρ=C3²,
    L_P=Ξ↔H, L_Q↔H#=[[2,1],[1,2]],
    L_P²=L_Q²=6, ρ^*L_Q≡3L_P,
    σ_P↔S=[[0,−1],[1,−1]], σ_Q↔R=S^(-T)=[[-1,−1],[1,0]]. (2)

Both restricted polarization types are (1,3). With Y ordinary,
U is ordinary exactly when E is, since J(U)∼J(Y)×E².
For the Raynaud calculations below, take scalar Frobenius twists
of these identities.

## 2. The two grid counts needed

For a finite set S⊂E(k), |S|=n≥2, a Hermitian divisor class
[[a,b],[b^†,c]] meets horizontal/vertical fibers in degrees a/c.
An effective divisor without a vertical GRID fiber meets S² in≤nc
distinct points, including tangencies and inseparable projections.

For a=c=2 and b≠0 there is at most one vertical component, counted
with multiplicity: removing two would leave horizontal intersection0,
hence a union of horizontal fibers, impossible with off-diagonal b≠0.
Thus its grid support has size≤n+2(n−1)=3n−2, or≤2n if it has
no vertical grid fiber.

## 3. Ordinary U forces the bad-fiber locus finite

NOW assume U ordinary. For π:J→Q define
B={z:π^(-1)(z)⊂Θ_U}. Its complement π(J∖Θ_U) is open since π
is smooth. Also0∉B: the C3 character decomposition restricts Θ_U
to a union of three proper translated theta divisors on J(Y).
Ordinary U gives0∉Θ_U, so Θ_U|P is effective of class4H by
[Tong, Corollary1.2.3.2](https://arxiv.org/pdf/0712.2046).

Suppose B has curve components. Their inverse images under π are
irreducible divisor components of Θ_U. Sum the curves with their
ACTUAL multiplicities to obtain D_Q≠0, invariant under R and
inversion and avoiding0. The residual

    D_P=Θ_U|P−ρ^*D_Q

is effective. Write D_Q's Hermitian class M. The equation R^†MR=M
and nefness of effective divisors give

    M=[[a,b],[b^†,a]], b+b^†=[a],
    N=4H−HMH=[[8−3a,3a−4−3b],[3a−4−3b^†,8−3a]]≥0.

Here a is a positive integer, so a=1 or2. Arbitrary End(E), including
quaternionic endomorphisms, is allowed.

If a=1, nefness of M gives0<deg b≤1 and b²−b+1=0. Hence E has
an order-three automorphism. In characteristic5 its short Weierstrass
model is y²=x³+c, with Hasse invariant0, contradicting ordinarity.
If a=2, put u=b−1, so u+u^†=0 and

    N=[[2,−1−3u],[−1−3u^†,2]],   1+9deg(u)≤4.

Integrality of endomorphism degree forces u=0. Consequently

    D_Q≡L_Q,   D_P≡L_P.                                   (3)

If D_Q contains a vertical V_a, R-invariance forces
V_a+{y=a}+{x+y=−a}≤D_Q. The left side already has class L_Q;
the effective numerically trivial difference is zero. Inversion
preserves the unique vertical component, so a=−a. Avoidance of0
makes a NONZERO two-torsion. This three-component divisor misses
every odd-primary torsion grid. If there is no vertical component,
Section2 bounds its n×n grid support by2n.
No classification of other components is required.

Take `S=E[5](k)`, of size5 since E ordinary, on the scalar-twisted E.
These are precisely its Verschiebung-kernel points; the same grid
G=S² is used in P and Q and ρ=H permutes it, since det H=3.
For every0≠α∈G, F_U^*α=O_U and the twisted Frobenius sequence
injects k into H⁰(B_{1,U}⊗α). Thus Θ_U|P contains all24 nonzero points.
But D_Q meets G in≤10 points (or zero in the vertical case), while
D_P meets it in≤13 by(3) and Section2. The residual equation would
cover24 mandatory points with≤23, contradiction.

Thus B has no curve component. Being a proper closed subset of the
projective surface Q, it is finite. Every other coset has a nonempty
open good locus, including geometric points of arbitrary torsion order.
Neither emptiness of B nor the theorem without ordinary U follows.

## 4. Generic defects stabilize in unbounded abelian degree

For α∈P(k), put δ_α=generic_L h⁰(B_{1,U}⊗α⊗q^(1)*L).
It is positive exactly when ρ(α)∈B, hence for finitely many α.
Let Λ_0 be the finite subgroup generated by exceptional α of
prime-to-five order.

For any finite prime-to-five character subgroup Λ⊂P(k), construct
its connected abelian etale character cover on U^(1), then untwist
to b_Λ:W_Λ→U. Character decomposition gives

    generic_L h⁰(B_{1,W_Λ}⊗(q b_Λ)^(1)*L)=∑_(α∈Λ) δ_α.          (4)

The generic open is a finite intersection for EACH Λ; no one point
is assumed good for infinitely many covers. The right side is uniformly
bounded and constant once Λ contains Λ_0. It may be positive.
If Λ avoids every nonzero exception it is zero, since δ_0=0.
No bound on degree or prime support is required.

This is NOT a uniform a-number bound, ordinarity of those covers,
or vanishing for every abelian cover. An existing second etale map
is preserved; none is constructed. The cofinal correspondence-tower
bridge and arbitrary monodromy remain outside the statement.
