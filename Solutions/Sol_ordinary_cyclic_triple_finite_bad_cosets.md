# Proof: finite bad cosets for ordinary cyclic triples

[Canonical statement](../Theorems/Thm_ordinary_cyclic_triple_finite_bad_cosets.md).
Ordinary theorem audited PASS by /root/ordinary_triple_finite_bad_fibers_check
2026-09-05; elementary grid bound separately checked by
/root/elliptic_grid_divisor_bound. [Audit metadata](../routes/global/audits/ORDINARY_CYCLIC_TRIPLE_FINITE_BAD_FIBERS_AUDIT.md)
is reference-only. The direct coordinate-fiber proof below retains the
2026-09-07 exposition; no separate new audit is claimed.
Section1 incorporates the formerly separate algebraic Prym input.
Section5 retains its AUTHOR-only nonordinary component bounds, outside
the audited canonical statement. No hypothesis on U is silently removed.

## 1. Actual Prym isomorphism, not merely an isogeny class

Over k=bar(F5), let q:U→Y be connected finite etale cyclic of degree3,
Y ordinary of genus2, and σ a generator. Then g(U)=4. Put
J=J(U), A=q^*J(Y), P=(ker Nm_q)^0, Q=J/A.
For Raynaud calculations below use their SCALAR Frobenius twists;
this is not polarization pullback by a degree-five isogeny.

The hyperelliptic involution inverts the defining three-torsion line,
so lifts to j on U with jσj^(-1)=σ^(-1). Its square lies in C3 and
is fixed by this conjugation, so j²=1. It fixes exactly one point
above each of the six Weierstrass points. Hurwitz makes the quotient
r:U→E=U/<j> elliptic, with six ramification points.

The pullback i=r^*:E→J is injective. Its kernel is killed by2;
a nontrivial kernel character would factor r through an etale double
of E, contrary to ramification and equality of degrees.
Since j is identity on i(E) but−1 on J(Y), Nm_q i=0 by connectedness.
Thus i(E)⊂P. For Φ:E²→P, (x,y)↦i(x)+σi(y), put b=i^†σi.
The identities i^†i=2, ji=i and jσ=σ^(-1)j give b=b^†.
As1+σ+σ²=0 on P, 2+b+b^†=0, hence b=−1. Therefore

    Φ^*L_P ↔ H=[[2,−1],[−1,2]],   deg λ_H=9.               (1)

This makes Φ an isogeny onto P. Meanwhile ker(q^*) has order3 and
q^* pulls L_A back to three times the genus-two principal polarization,
so deg λ_LA=3^4/3²=9. Complementarity in principally polarized J
gives deg λ_LP=9 too. Thus(deg Φ)²=1 and Φ is an ISOMORPHISM.
Both restricted polarization types are(1,3).

With the product principal identification (E²)^∨=E², we obtain

    P=E², Q=P^∨=E², ψ=π|P=H, deg ψ=9, ker ψ=C3²,
    L_P↔H, L_Q↔H#=[[2,1],[1,2]],
    L_P²=L_Q²=6, ψ^*L_Q≡3L_P,
    σ_P↔S=[[0,−1],[1,−1]], σ_Q↔R=S^(-T)=[[-1,−1],[1,0]]. (2)

No ordinarity of E or U was needed. With Y ordinary, U is ordinary
IFF E is ordinary, by the isogeny J(U)∼J(Y)×E².
This is an algebraic norm/polarization proof in characteristic5.
Compare Lange–Ortega, [Theorem2.1(a)](https://arxiv.org/pdf/1601.04082),
and Agostini, [equation(2.2)](https://arxiv.org/pdf/2001.06264);
no analytic lifting argument is being substituted.

## 2. The two grid counts needed

For a finite set S⊂E(k), |S|=n≥2, a Hermitian divisor class
[[a,b],[b^†,c]] meets horizontal/vertical fibers in degrees a/c.
An effective divisor without a vertical GRID fiber meets S² in≤nc
distinct points, including tangencies and inseparable projections.

For a=c=2 and b≠0 there is at most one vertical component, counted
with multiplicity: removing two would leave horizontal intersection0,
hence a union of horizontal fibers, impossible with off-diagonal b≠0.
Thus its grid support has size≤n+2(n−1)=3n−2, or≤2n if it has
no vertical grid fiber. The
[sharp general lemma](../routes/global/SHARP_ELLIPTIC_GRID_DIVISOR_INTERSECTION_BOUNDS.md)
retains arbitrary-degree bounds, norm refinements and sharp examples.

## 3. Ordinary U forces the bad-fiber locus finite

NOW assume U ordinary. For π:J→Q define
B={z:π^(-1)(z)⊂Θ_U}. Its complement π(J∖Θ_U) is open since π
is smooth. Also0∉B: the C3 character decomposition restricts Θ_U
to a union of three proper translated theta divisors on J(Y).
Ordinary U gives0∉Θ_U, so Θ_U|P is effective of class4H.

Suppose B has curve components. Their inverse images under π are
irreducible divisor components of Θ_U. Sum the curves with their
ACTUAL multiplicities to obtain D_Q≠0, invariant under R and
inversion and avoiding0. The residual

    D_P=Θ_U|P−ψ^*D_Q

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
G=S² is used in P and Q and ψ=H permutes it, since det H=3.
For every0≠α∈G, F_U^*α=O_U and the twisted Frobenius sequence
injects k into H⁰(B_U⊗α). Thus Θ_U|P contains all24 nonzero points.
But D_Q meets G in≤10 points (or zero in the vertical case), while
D_P meets it in≤13 by(3) and Section2. The residual equation would
cover24 mandatory points with≤23, contradiction.

Thus B has no curve component. Being a proper closed subset of the
projective surface Q, it is finite. Every other coset has a nonempty
open good locus, including geometric points of arbitrary torsion order.
Neither emptiness of B nor the theorem without ordinary U follows.

## 4. Generic defects stabilize in unbounded abelian degree

For α∈P(k), put δ_α=generic_L h⁰(B_U⊗α⊗q^(1)*L).
It is positive exactly when ψ(α)∈B, hence for finitely many α.
Let Λ_0 be the finite subgroup generated by exceptional α of
prime-to-five order.

For any finite prime-to-five character subgroup Λ⊂P(k), construct
its connected abelian etale character cover on U^(1), then untwist
to b_Λ:W_Λ→U. Character decomposition gives

    generic_L h⁰(B_WΛ⊗(q b_Λ)^(1)*L)=∑_(α∈Λ) δ_α.          (4)

The generic open is a finite intersection for EACH Λ; no one point
is assumed good for infinitely many covers. The right side is uniformly
bounded and constant once Λ contains Λ_0. It may be positive.
If Λ avoids every nonzero exception it is zero, since δ_0=0.
No bound on degree or prime support is required.

This is NOT a uniform a-number bound, ordinarity of those covers,
or vanishing for every abelian cover. An existing second etale map
is preserved; none is constructed. The cofinal correspondence-tower
bridge and arbitrary monodromy remain outside the statement.

## 5. Retained author-only nonordinary component boundary

Keep Y ordinary but do NOT assume U or E ordinary. This section is
the formerly separate author's necessary-condition argument, not an
extension of the audited theorem. The geometry(2) still holds.
The zero A-fiber is good as before. Also Θ_U|P is proper of class4L_P
because J/P is ordinary, by the
[ordinary-complement criterion](../routes/global/RESTRICTED_RAYNAUD_THETA_SUFFICIENT_CONDITIONS_AND_STABILITY_BOUNDARY.md),
Section2. Unlike the ordinary case it may pass through0.

For a curve component D⊂B let k be its orbit size under⟨R,−1⟩,
m the multiplicity of π^(-1)(D) in Θ_U, and d=L_Q·D. Then

    m∑_(D' in orbit) ψ^*D'≤Θ_U|P,
    L_P·ψ^*D=3d,   mkd≤8.                                 (5)

Different component orbits share the TOTAL budget∑m_j k_j d_j≤8.
These are component intersections, not counts of isolated bad fibers.

Any irreducible D has d≥2. For an elliptic subgroup T⊂E², the
degree of L_Q on T is the sum of the degrees of x,y,x+y:T→E.
A zero map gives a coordinate/anti-diagonal direction and the other
two are isomorphisms, giving d=2; otherwise all three are positive.
This allows arbitrary endomorphism slopes. For a nonelliptic D,
D²≥2 and Hodge index gives

    6D²≤d²,   d≥4,   p_a(D)≤1+floor(d²/12).                (6)

If R(D)=D, writing its Hermitian class as M yields equal diagonal
entries a and b+b^†=a, so d=3a. An R-stable elliptic translate has
an underlying subgroup with a nontrivial order-three automorphism:
R−1 is an isogeny, so cannot kill that subgroup. In characteristic5
this makes it, and its isogenous E, supersingular.

Since k∈{1,2,3,6}, (5)–(6) give exactly these NECESSARY rows:

| Orbit size k | Curve and degree d | Multiplicity |
| --- | --- | --- |
| 6 | Impossible | — |
| 3 | Inversion-stable elliptic translates, d=2 | m=1 |
| 2 | R-stable elliptic translates, d=3; E supersingular | m=1 |
| 1 | Elliptic, d=3; E supersingular | m≤2 |
| 1 | d=6, p_a≤4; if elliptic, E supersingular | m=1 |

Every listed curve avoids0, and all orbits share(5).
The symmetry configurations themselves need not be empty: for
0≠a∈E[2], the three curves x=a,y=a,x+y=a avoid0, form an
inversion-stable R-orbit and have class L_Q and total d-degree6.
This is a genuine divisor configuration, NOT a claim that its inverse
images occur in Θ_U. Section3 rules that out for ordinary U.
Isolated points of B give codimension-two A-fibers in J, so this
divisorial table does not address them.

Raynaud's numerical class and symmetry are recorded in
[Tong, Corollaries1.2.3.2/1.2.3.4](https://arxiv.org/pdf/0712.2046).
All quotient and covering maps above are actual. No fixed-pair
exclusion or unrestricted common-cover theorem is asserted.
