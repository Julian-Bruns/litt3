# A 24-square scalar test for the higher-corank dormant atlas strata

Let C have genus g>=2 in characteristic different from2, n=g-1, and
let V be stable of rank two with det V=omega. Set E=V omega,
and fix a nowhere-zero u in H0(E). All alternating forms A_s below use
the ACTUAL extension 0->O --u--> E->omega^3->0.

For nonzero s in H0(omega), put D_s=div(s), retaining multiplicities.
There is a natural square map of dimension3n,

    M_s(u):H0(End_0(E) omega)
       -> H0((E omega)|D_s)/{(r u)|D_s:r in H0(omega)}.

It satisfies the exact rank formula

    corank A_s = 1+dim ker M_s(u).                         (1)

Thus M_s has odd nullity. Corank2 at s is equivalent to rank3n-1;
equivalently, some minor of size3n-2 is nonzero. Higher NORMAL corank
requires rank M_s<=3n-3 for EVERY pencil member. This is a restriction
on the higher-corank locus, not a proof that the locus is empty.

Formula (1) applies to ALL dormant V, including the nonacyclic ones,
provided u is nowhere zero. For an ACYCLIC dormant oper on the fixed
genus-nine curve, (1) has an
explicit factored scalar implementation. Write L=delta^2-P and
Q=delta^3+P delta+3 delta(P). The24 fixed monomials h in L32 parametrize
the entire trace-free Higgs space through H=Lh. Their action on a
horizontal U is exactly

    2H delta(U)-delta(H) U = -Q(Uh).                      (2)

The other nine Higgs directions are r^5 U for the monomials r in L16.
No kernel over the oper coefficient field has to be calculated.

For the canonical section s=theta=dx/y^2, the divisor is16O. Read the32
coefficients at pole orders
116,117,121,122,...,191,192 of the24 columns -Q(Uh) and the eight
nonconstant columns r^5 U. This gives [X(U) T(U)]. For d=pole U=111 or112,
the eight rows of T at poles

    d+5e,       e=3,6,9,10,12,13,15,16,

form a triangular matrix of determinant c^8, where c is U's leading
coefficient. Eliminating these eight scalar-Higgs columns leaves an
EXACT24-square Schur matrix C_theta(U) with

    corank A_theta =1+nullity C_theta(U).                 (3)

All these operations retain compositions over the original oper field.
Before this final small Schur division, the coefficients have degree at
most2 in the ORIGINAL oper coordinates in the existing affine Q frame,
and are linear
in U coordinates. A fraction-free version is available by multiplying
by c^8, but no degree or runtime improvement for expanded elimination
is claimed.

At an ACTUAL normalized atlas for the acyclic oper above, the full N,
R and bilinear normalization
automatically give a nowhere-zero u and d=111/112. Hence the two displayed
leading-coefficient charts cover every such point. If any22-minor of
C_theta is nonzero, the canonical pencil has normal corank2. A higher-
normal-corank point must make all22-minors zero. Using the analogous
maps at any16 distinct F25 pencil parameters gives an exact test for
normal corank2, by the already proved all-corank pencil bound.

These facts do NOT prove rank23 for every dormant U, for every actual
atlas U, or specifically for orbit0011. They do not show that R excludes
the higher-normal-corank locus. The full32 R equations and normalization
remain required; the rank test alone is not an atlas criterion.

Status: author proof,2026-09-07; no independent audit claimed. All768
first-oper product identities are checked exactly. Five saved admissible
sections have rank23; all five FAIL R. Separately, all33 actual genus-two
atlas points pass the3-square quotient test at all26 F25 pencil members,
with the existing R-sensitive negative controls retained.
[Proof](../Solutions/Sol_dormant_higgs_rank_reduction.md).
