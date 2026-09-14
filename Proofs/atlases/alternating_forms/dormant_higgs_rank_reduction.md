# Proof: quotient scalar Higgs fields and use the Bol product identity

[Statement](../../../Theorems/atlases/alternating_forms/dormant_higgs_rank_reduction.md).
The scalar implementation assumes a dormant oper; the last application
uses the actual atlas R equations.

## 1. The square quotient has dimension3(g-1)

The [canonical-divisor evaluation theorem](canonical_divisor_evaluation.md)
proves the scalar-quotient exact sequence for every semistable V, without
acyclicity. Stability gives h0(End(V))=1, so M_s is square of size3n
and corank A_s=1+dim ker M_s. Its odd nullity gives the stated minor
criterion and the higher-corank condition rank M_s<=3n−3.

For a basepoint-free pencil in the fixed genus-nine case, its common
kernel is ku and its normal corank is one of2,4,6,8,10, by the preceding
canonical-radical and constant-kernel theorems. A maximum-rank principal
Pfaffian has degree at most15 in the pencil parameter. Sixteen distinct
parameters therefore include a maximum-rank member. Apply (1) at each
member. This proves the finite exact rank-test assertion without a new
generic-rank hypothesis.

## 2. A complete inverse-free source for the dormant Higgs fields

The untwisted case of `dormant_bol_complex` identifies the middle
kernel bundle with Sym^2(W) omega. Since det W=O and2 is invertible,
this is End_0(W) omega. In the fixed scalar model its global sections
are exactly ker(Q:L64->L112), of dimension24. These assertions also
follow from the symmetric-square identification and regular local
Frobenius ranks in `dormant_differential_projection`.

Now impose H0(W(8O))=0, the acyclicity hypothesis. The first half of
the exact Bol complex gives

    L:L32 -> ker(Q:L64->L112)

as an isomorphism on global sections: its kernel is H0(W8)=0, its
cokernel is H1(W8)=0, and both spaces have dimension24. Therefore the
24 fixed affine monomials in L32 give all trace-free Higgs fields,
without computing a coefficient-field-dependent horizontal kernel.
At the55 nonacyclic opers this shortcut is INVALID: those24 images
have rank21, not24. The full Q kernel must then be retained.

We check the action, including its determinant convention. On a rational
horizontal frame f,g with f delta(g)-g delta(f)=1, the usual map
Sym^2(W)->End_0(W) sends a product H=fg to the endomorphism

    z |-> f Wh(g,z)+g Wh(f,z)
       = 2H delta(z)-delta(H) z.

For f^2,fg,g^2 these matrices are linearly independent and trace-free,
so this is the required isomorphism. The scalar twist by omega has
the fifth-power module convention; differentiation commutes with all
such twist factors. Thus this local identity is the action of the
global Higgs section, not merely a rational formula with untested poles.

For a horizontal U, expand Q(Uh) using delta^2 U=PU:

    Q(Uh)=(delta^3 h-P delta h-delta(P)h)U
                  +(-2 delta^2 h+2Ph)delta U.

This is exactly -[2(Lh)delta U-delta(Lh)U]. It proves (2) directly
in characteristic5. No atlas equation is used. The bundle action puts
this horizontal function in the scalar space S40 inside L192; its
apparent larger leading pole in an uncollected expression cancels.

The scalar canonical Higgs fields act by r^5 U, with r in L16.
The two spaces are disjoint by the trace splitting. Evaluation on a
nowhere-zero u is injective globally, because its sheaf kernel is
E^vee omega, which has no H0 by stability. These33 scalar actions
therefore give the complete evaluation image used in Section1.

All scalar vector spaces here have the same coefficient-Frobenius
transport as the original oper system. This preserves ranks over a
perfect field. It is NOT permission to treat fifth powers of atlas
parameters as independent variables. A canonical pencil parameter t
appears as t^5 in its scalar multiplication; the F25 parameter set is
permuted by this power.

## 3. Thirty-two fixed rows and eight explicit trace pivots

Here theta=dx/y^2 is the canonical differential, not a theta
characteristic. At s=theta, divisibility by s in the descended bundle
means precisely
membership in S_U inside S40. Define pi by the monomial coefficients
at the32 nongap poles greater than112 and at most192 congruent to1
or2 modulo5. These are116,117,121,122,...,191,192.

The horizontal indicial equation forces every nonzero horizontal
function to have leading pole congruent to1 or2 modulo5. Hence an
element of S40 killed by all these rows lies in L112, and is in S_U.
Conversely S_U is killed by them. Dimensions are64-32=32, so pi
identifies S40/S_U with k^32. This proves the correctness of these
fixed quotient rows, not just their generic independence.

Apply pi to -Q(Uh) for the24 h monomials to get X(U), and to r^5 U
for the eight nonconstant r monomials to get T(U). The scalar direction
r=1 vanishes in this quotient. These matrices have32 rows. They use
only the fixed curve operations, U, and the oper coefficients in Q.

Suppose pole U=d is111 or112 and its leading coefficient is c!=0.
The eight positive poles of L16 are

    e_1,...,e_8=3,6,9,10,12,13,15,16.

The product r_j^5 U has leading pole d+5e_j and coefficient c.
All eight selected poles belong to the32 quotient rows. In increasing
order, the submatrix T_I at those rows is upper triangular: a column
of lower leading pole contributes nothing at a higher selected pole.
Its diagonal is c, so det T_I=c^8.

Let J be the remaining24 rows. Quotienting the trace image by ordinary
Schur elimination gives

    C_theta(U)=X_J-T_J T_I^-1 X_I.                       (5)

This is precisely M_theta in an explicit quotient basis, so (3)
follows from Section1. Only the leading coefficient is inverted.
Equivalently multiply (5) by c^8 and replace T_I^-1 by adj(T_I)/c^8.
The fraction-free entries have degree at most9 in U coefficients;
expanding them is not required or recommended here.

In the affine Q frame U=M[:,I]v, U has degree1 in the ORIGINAL oper
coordinates. Formula (2) applies Q
once more, so X has oper-degree at most2 and T at most1, both linear
in v. The claim concerns these FACTORED input matrices, not an assertion
that the rational Schur output still has oper-degree2. For example the
fraction-free output has oper-degree at most10. No expanded large-field
tensor was needed to derive or test any of these identities.

On either leading-pole chart, a22-minor of C_theta can also be tested
without expanding its denominators. Adjoin the eight selected trace
rows and columns to that minor; the resulting30-square block minor
of [T X] is c^8 times the chosen Schur minor, up to its fixed column
ordering sign. This is a degree30 polynomial in U coordinates.
All such minors vanish exactly when rank C_theta<=21 on this chart.
These degree counts are NOT lower than every previous Pfaffian degree
and are not an elimination-speed claim.

## 4. What the full atlas equations add, and what they do not yet add

The audited `compact_etale_atlas_system` uses N=0, all32 projected R
equations, and beta(U)=2. Together these force Wronskian1, a nowhere-
zero descended section, and pole U111/112. Thus every ACTUAL solution
lies on exactly one of the leading-pole strata used above, and its
alternating pencil is the pencil of the actual extension required in
Section1. No invalid quotient boundary has been discarded.

If a22-minor is nonzero at such a solution, (3) and parity prove
corank2 at theta and hence normal corank2. Conversely, a higher-normal-
corank solution lies in the determinantal closed locus defined by ALL
these22-minors. Repeat at16 pencil members for an exact normal-rank test.
The formula by itself supplies no codimension estimate for that locus
inside the weak incidence, and no reason the R fixed points avoid it.

In particular the already proved full Jacobian rank cannot be reused
as a rank23 proof. The atlas tangent calculation only needs the common
kernel of A_0,A_1 to be a line; it is valid for every one of the possible
normal coranks. Extra vectors in one member's radical need not satisfy
the other N block or the linearized R equations. No such vectors have
been promoted to atlas deformations here.

## 5. Retained exact checks

[The Higgs checker](../../../scripts/connections/dormant_higgs_rank_check.sage)
verifies all768 polynomial identities in(2), horizontality, the pole bound,
the rank24 source and the triangular determinant. Its five saved
Wronskian-normalized sections cover both leading-pole strata and have
Schur rank23; all fail R. The receipt is
`../litt3-computation-data/orbit11-structure/dormant_higgs_rank_check.json`.

[The genus-two checker](../../../scripts/genus_two/alternating_kernel_genus_two_check.sage)
tests the quotient against all33 actual normalized atlas points and all26
F25 pencil members. Its3-square quotient has rank2 throughout. Rescaled
weak points satisfying N and normalization are rejected by R.

These checks verify the implementation and its controls. Rank23 for
every actual genus-nine atlas point, and exclusion of higher-normal-corank
strata, remain unproved.
