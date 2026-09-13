# Proof: bounded deck orbits of an endpoint defect function

[Statement](../../../Theorems/deformations/section_growth/two_leg_defect_orbit_bound.md).

## 1. A nonzero defect gives a nonconstant function of bounded degree

The normalized quartic s_X is a nonzero regular section of omega_X^4.
For any nonzero nilpotent tangent quadratic phi_X, put a_X=phi_X²/s_X.
Its pole divisor is bounded by div(s_X), so

    [k(X):k(a_X)] <= deg(omega_X^4)=8(g(X)−1),             (3)

provided it is nonconstant. The degree here includes any inseparable
factor; we do not infer that a_X is a separating variable.

To prove nonconstancy, suppose a_X=c in k*. Rescale phi_X to q with
q²=s_X. This is now a global quadratic. The
[canonical dormant-pair identity](../../projective_connections/etale_double_dormant_pairs.md#2-factorization-of-the-linearized-curvature-on-the-same-curve)
gives r_X=q''/q in a local separating coordinate. For B(v)=(v''−r_Xv)/q,
the EXACT determinant-curvature derivative is

    dDelta_(r_X)(v)=q^4(B²v−v).

But B(q)=0, hence dDelta_(r_X)(q)=−q^5!=0. A nilpotent tangent must
lie in the kernel of dDelta, contradiction. This argument works whether
the original canonical double was split or not: the hypothesized
constant ratio itself supplies its global square root.

## 2. Use the specified two fields, not a replacement correspondence

Inside K=k(Z), write A=f*k(X), B=g*k(Y), M=AB. The actual extension
K/B is finite Galois. For a=f*a_X, its minimal polynomial over B has
the distinct elements of its deck orbit as roots. Thus

    [B(a):B]=b.

Since M=A B(a) and k(a) is a common subfield for that compositum,
the elementary field-degree inequality gives

    [M:B(a)] <= [A:k(a)] <= 8(g(X)−1).

Multiplying proves the first inequality in(1). Intermediate covers of
the original two finite etale maps show that the smooth projective
normalization R of M is finite etale over BOTH X,Y. Hurwitz gives

    (g(X)−1)deg(R/X)=(g(Y)−1)deg(R/Y),

and proves the second inequality. K/M can be arbitrarily large. Nor
is M/B presumed normal; neither issue enters this argument.

## 3. Ten conjugates in the nontrivial five-action case

The nilpotent tangent space on Z is realized as regular quadratics,
functorially for the actual deck action. Its identification with the
sections of E_(r_Z) is the one in
[the tangent-bundle theorem](../../projective_connections/tangent_bundle_cyclic_refinements.md).
Thus the image in the audited
[two-defect deck theorem](two_defect_deck_reduction.md) is the actual
image acting on phi=f*phi_X. It preserves s_Z.

For Gamma=C10, its scalar subgroup {+I,−I} acts trivially on phi²/s_Z,
so the orbit has at most5 elements. For Gamma=D10 the whole group has
order10. For Gamma=C2×D10, the scalar {+I,−I} again gives a quotient
of order10. Therefore b<=10 in all cases. The first two bounds in(2)
follow directly from(1).

Notice what was used from the X-leg: a NONZERO tangent on X, not just
two sections on Z. If r_X is ordinary this function is unavailable.
The ordinary-X case is treated by uniform cyclic descent in the later
[full nontrivial-action exclusion](two_defect_nontrivial_five_exclusion.md).

## 4. The existing main parameter also avoids bounded joint covers

Recall the already fixed constants

    B0=336000, D=(B0−1)!, G0=1+8D, L=B0²,
    K0=D*(D!)^18*3^(4G0² L)*(42000!)^(2G0+L).

The parameter t has prime degree r>max(K0,120) over F25. These are
the ORIGINAL constants in
[effective cored avoidance](../../quotient_geometry/bounded_atlas_partner_finiteness.md);
no endpoint or parameter is changed here.

Consider ANY actual jointly minimal common source R for X and a genus-two
curve Y with n=deg(R/Y)<=B0−1. Its X-degree is n/8. Take the Galois
closure V→Y of this ONE etale map. It is finite etale, and V→R has
degree at most(n−1)!. Consequently

    deg(V/X) <= (n/8)(n−1)! <= D,
    g(V)<=G0,
    |Gal(V/Y)|<=n!<=D.

All arrows used are composites or the Galois closure of the single
Y-leg; there is no presumed simultaneous Galois closure over X and Y.

The existing counting proof establishes the following two facts in
characteristic five: pi1(X) has at most18 topological generators; and
Aut(V) embeds in GL_(2g(V))(F3), including wild automorphisms. Hence
there are at most D*(D!)^18 possibilities for the covering object V→X,
and |Aut(V)|<3^(4G0²).

Any subgroup of order at most D has at most floor(log2 D)<=B0²=L
generators. Counting ordered generating L-tuples, padded by identities,
there are therefore at most3^(4G0² L) possible subgroups H⊂Aut(V)
which could be Gal(V/Y). The quotient V/H determines Y. Thus the number
of genus-two partners with n<=B0−1 is at most

    K_bounded=D*(D!)^18*3^(4G0² L) <= K0.                 (4)

This finite set is F25-Frobenius stable. The
[affine branch-family theorem](../../curve_arithmetic/prime_field_branch_family.md) gives
moduli orbit length r for the selected prime degree r>K0>5.
It cannot lie in the set counted in(4).

This proves the bounded-joint-degree exclusion WITHOUT a cored or
connection hypothesis. Applied to(2), it excludes the stated two-defect
nonordinary-X/nontrivial-five stratum.

## 5. What remains if five-elements act trivially on the defects

The audited normal form gives a prime-to-five faithful self-dual
two-dimensional image Gamma. Every scalar in it is +I or−I: restricting
a self-dual representation to a scalar cyclic subgroup pairs each
eigencharacter with its inverse, so lambda=lambda^-1. Therefore phi²/s
has at most |barGamma| conjugates, with barGamma the projective image.

If |barGamma|<=5249, (1) gives

    deg(R/Y)<=64*5249=335936<=335999,

contradicting Section4 for the selected pair. Thus |barGamma|>=5250.

The finite prime-to-five subgroups of PGL2(k) are cyclic, dihedral,
A4, S4, A5; the A5 case has order divisible by5 and is absent here.
This is the prime-to-characteristic part of
[Faber's classification](https://arxiv.org/pdf/1112.1999).
The A4 and S4 cases have orders12 and24 and are already excluded by
the degree inequality. Reducible images have cyclic projective image.
Thus only LARGE cyclic or dihedral projective defect images remain
in the nonordinary-X/source-two-defect/Galois-Y branch.

No upper bound on those orders, no all-level lift of r_X, and no
ordinary-source conclusion is asserted. In the complementary ordinary-X
branch the finite-orbit construction starts without a tangent quadratic
on X and does not apply. These distinctions are part of the statement.
