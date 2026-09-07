# Proof: quotient scalar Higgs fields and use the Bol product identity

[Statement](../Theorems/Thm_dormant_higgs_rank_reduction.md).
The original two-leg common-cover problem and orbit0011 remain open.
The first argument concerns all stable V with the stated
determinant. The scalar implementation additionally assumes a dormant
oper; only the last application invokes the ACTUAL atlas R equations.

## 1. The square quotient has dimension3(g-1)

The radical construction of `canonical_divisor_pencil_radical` does
not need acyclicity for a SINGLE canonical section. To check this
larger scope directly, evaluation at the actual nowhere-zero u gives

    0 -> E^vee omega -> End(E) omega -> E omega ->0.

Its connecting homomorphism is cup product with the actual extension
class. Its left term has negative stable slope and hence no H0. Thus
s v is the evaluation of a unique global Higgs field precisely when
A_s(v,-)=0. Division by s is regular precisely on sections vanishing
on the scheme D_s. This identifies rad A_s with the kernel of

    H0(End(E) omega) -> H0((E omega)|D_s),  phi |-> phi(u).

The source has dimension4n+1 and the target4n. Since2 is invertible,
End(E)=O+End_0(E). Stability gives H0(End_0(E))=0, hence Serre duality
and Riemann--Roch give h0(End_0(E) omega)=3n. The scalar summand has
dimension h0(omega)=n+1.

The scalar evaluation map sends r to (r u)|D_s. Because u is nowhere
zero, its kernel consists exactly of canonical sections vanishing on
the entire scheme D_s. These are ks. Its image has dimension n, so
the quotient target in the statement has dimension4n-n=3n.

Projection to the trace-free summand yields an exact sequence

    0 -> k(s Id_E) -> rad A_s -> ker M_s(u) ->0.           (4)

Indeed a trace-free phi in the last kernel has phi(u)|D_s=(r u)|D_s
for some global canonical r; then phi-r Id lies in the radical.
The choice of r is unique modulo ks. Conversely every radical has this
property, and a scalar radical is precisely a multiple of s Id.
This proves (1), including nonreduced canonical divisors.

The alternating form A_s acts on the even-dimensional space H0(E),
contains u in its radical, and consequently has positive EVEN corank.
Thus the nullity of M_s is odd, at least1. Its rank is at most3n-1
and cannot be3n-2. A nonzero(3n-2)-minor therefore forces rank3n-1.
Corank at least4 is equivalent to rank at most3n-3.

For a basepoint-free pencil in the fixed genus-nine case, its common
kernel is ku and its normal corank is one of2,4,6,8,10, by the preceding
canonical-radical and constant-kernel theorems. A maximum-rank principal
Pfaffian has degree at most15 in the pencil parameter. Sixteen distinct
parameters therefore include a maximum-rank member. Apply (1) at each
member. This proves the finite exact rank-test assertion without a new
generic-rank hypothesis.

## 2. A complete inverse-free source for the dormant Higgs fields

The untwisted case of `twisted_bol_complex` identifies the middle
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

## 5. Bounded exact checks and their scopes

`scripts/dormant_higgs_rank_check.sage` reads the saved first F25 oper,
its section frame, and the five pre-existing scalar Wronskian samples.
It checks all32 times24 polynomial action identities in (2), verifies
that all outputs are horizontal and have pole at most192, and verifies
rank24 of the L32 image. For every saved sample it independently checks
the actual constant Wronskian1 with its saved T, evaluates all33 Higgs
directions, checks the triangular determinant c^8, and verifies the
24-square rank formula. This includes both pole111 and pole112 strata.

All five samples have rank23 in (5), and rank31 in the original
evaluation map at each of16 finite pencil parameters and at infinity.
All five samples FAIL R and are explicitly labeled NON-atlas controls.
The report is external:

    /Users/julian/Documents/litt3-computation-data/orbit11-structure/
        dormant_higgs_rank_check.json

It records both input hashes; elapsed exact computation10.49seconds,
excluding Sage startup. It reads no orbit0011 coefficient field.

The separate actual positive control is
`scripts/alternating_kernel_genus_two_check.sage`. Its existing complete
original-equation check covers all33 normalized genus-two atlas points.
The cohomological Higgs image is5-dimensional; its scalar images are
(u,0) and(0,u) in the full canonical-pencil decomposition. Quotienting
them in source and target as in Section1 leaves a3-square matrix of
rank2 at all26 F25 pencil parameters, for every positive point.
This quotient calculation is independent of the choice of complement
to the scalar Higgs fields; it need not label that complement trace-free.
The33 weak rescalings that fail R are still rejected by R. The updated
complete positive-control report takes0.37seconds, excluding startup.

This is an exact smaller rank interface and a factored dormant formula.
Neither test proves that orbit0011 has rank23 at every actual point,
and neither excludes its higher-normal-corank atlas strata. No production
process or input was changed and no common-cover conclusion is claimed.
