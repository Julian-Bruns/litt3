# Proof of the Hermite pole-matching genus bound

Use all hypotheses and notation of the
[statement](../../Theorems/cartier_and_spin/klein_four_hermite_genus_bound.md).
Here E is monic squarefree and divides t^29-1; C_i is the squarefree
product of the triple-pole values whose inertia acts nontrivially on
character i. All parameter end fibers are unramified.

## Matching the first derivative at every common pole

At t=c in mu29, choose the unique base-field formal unit lambda(t)
with lambda^4=epsilon^4*t^-13 and lambda(c)=epsilon*c^4. The actual
quartic identity gives, at every common pole in that fiber,
\[
v=\lambda(t)u+\frac{[22](\lambda(t)-1)}{4[13]}+O(u^{-1}).
\]
Consequently v-lambda*u is regular throughout the fiber, including
its regular companion points. Since lambda is in the completed base
field, every character projection v_i-lambda*u_i is regular as well.
This does not identify or permute either actual endpoint map.

Put l=t^3*lambda. Then l^4=epsilon^4*t^-1, so
\[
l(c)=\epsilon c^7,\qquad l'(c)=\epsilon c^6.
\]
The polynomial epsilon*t^36 has precisely the same value and first
derivative at every c in mu29, in characteristic5. In the presentation
\[
v_i-lambda*u_i
=\frac{(V_i-lU_i)z_i}{t^3 E C_i},
\]
a simple common-pole value requires one factor t-c in the numerator.
At a triple-pole value in C_i, z_i has local order1 and (t-c) has
local order2, so regularity requires two base factors t-c. At a
triple value not in C_i, z_i is a unit and one base factor suffices.
Replacing l by epsilon*t^36 preserves these requirements. This proves
E C_i divides V_i-epsilon*t^36 U_i, with the multiplicities retained.

## A sparse polynomial vanishing at C_i

Assume e>=13. Write
\[
E=t^7H+R,\quad\deg R\le6,\quad D=(t^{29}-1)/E,
\quad B=(1+DR)/t^7=t^{22}-DH.
\]
Thus B is a polynomial of degree at most28-e (zero when this bound
is negative). From V_i=epsilon*t^7 U_i+E T_i define
\[
N_i=\epsilon U_i+H T_i=(V_i-R T_i)/t^7.
\]
With d_i=10+c_i-h_i, the established degree bounds give
\[
\deg T_i\le d_i,\quad T_i\ne0,\quad
\deg N_i\le e-14+d_i.
\]
The new divisibility is equivalent to
C_i dividing T_i-epsilon*t^7 D U_i, and modulo C_i this is equivalent
to C_i dividing T_i-D V_i, since t^29=1 there. Using
V_i=t^7N_i+R T_i and multiplying by the unit t^22 modulo C_i gives
\[
C_i\mid F_i:=2t^{22}T_i-DN_i-BT_i. \tag{3}
\]
For0<=d_i<=6, F_i belongs to the polynomial space with exponents
\[
S_{d_i}=\{0,\ldots,15+d_i\}\cup\{22,\ldots,22+d_i\}.
\]
The low and high blocks are disjoint, and the high block is the
nonzero polynomial2t^22*T_i. Thus F_i is nonzero and has degree<=28.

## Duality reuses the exact Fourier input

The previously certified Fourier input says that for each0<=r<=5,
evaluation of the monomials
\[
1,t,\ldots,t^r,\quad t^7,t^8,\ldots,t^{7+r}
\]
at any2r+2 distinct points of mu29 gives an invertible square matrix.
This is an exhaustive geometric node statement over k, established by
the exact finite cyclotomic calculation in
[fourier_checks.cpp](../../scripts/arithmetic/pro_pivot_secant_20260925/secant/previous/prior/src/fourier_checks.cpp).
Its original complete check is retained with the simultaneous quotient
evidence; it is reused rather than replaced by a new sampling test.

For0<=d<=5, the evaluation code of S_d on all29 roots has dimension
17+2d. Under the ordinary pairing on k^29, its orthogonal code has
monomial exponents
\[
\{1,\ldots,6-d\}\cup\{8,\ldots,13-d\}.
\]
Indeed sum_(c in mu29) c^m is zero unless29 divides m, and is then
29, a unit in characteristic5. Dividing its columns by c identifies
this orthogonal code with the certified Fourier space for r=5-d.
Every maximal minor of a generator matrix for it is therefore
nonzero. Complementary minors give the same property for the S_d
code. Equivalently, a nonzero polynomial in S_d has at most16+2d
distinct zeros in mu29.

For d=6 the same bound is28 and follows simply from degree<=28.
For d>=7, c_i<=29 already implies c_i<=16+2d. Equation(3) consequently
proves c_i<=16+2d_i for every i. Substituting d_i=10+c_i-h_i gives
the individual genus bound in the statement.

Since sum h_i=g+3 and sum c_i=2j, summing yields
\[
g\le51+j-\tfrac12\#\{i:c_i\text{ is odd}\}.
\]
When e<=12, the prior bound g<=27+2j and j<=12 already imply
g<=50+j. We now exclude the numerical top case g=51+j for e>=13.

## An endpoint coefficient-field obstruction

Let M=F_(25^7), containing all29th roots of unity, and
K0=F_(25^4), containing the four alpha roots of A and their canonical
29th-root labels b_alpha. They are linearly disjoint over F25. Write
alpha_j and b_j in their common Frobenius25 order, starting with the
root alpha of A_monic. The b_j form an F25 basis of K0. The coordinates
of the alpha_j in this basis are the rows
\[
\begin{pmatrix}
[21]&[19]&[13]&[23]\\
[23]&[21]&[19]&[13]\\
[13]&[23]&[21]&[19]\\
[19]&[13]&[23]&[21]
\end{pmatrix}. \tag{4}
\]
Put b_j^*=([13]/A'(alpha_j))*b_j^4. For every pair j<k the four
vectors b_j,b_k,b_j^*,b_k^* form a basis. Their determinants, in
lexicographic pair order, are[8],[22],[22],[22],[8],[8]; the determinant
of the b_j basis is[23]. In particular b_j and b_j^* are independent.

At an endpoint the four branches have labels
B_l=b_(alpha_l)*zeta^(e_l). For a nontrivial Fourier sign row define
A_i,B_i,a_i,c_i as in the
[first-jet proof](klein_four_endpoint_jet_bound.md). If B_i!=0, put
\[
r_i=A_i/B_i,\qquad s_i=(a_iB_i-A_ic_i)/B_i^2.
\]
We claim that at most one of the three characters can have both r_i
and s_i in M. If one does, the four alpha labels must all be distinct,
all four roots-of-unity factors must agree, and all three B_i are nonzero.

Here is a small exact-algebra proof of the claim. For each occurring
alpha_j let X_j be the signed sum of the corresponding roots of unity.
Then
\[
B_i=\sum_j b_jX_j,\qquad
a_i=\sum_j b_j^*X_j^{5^9},
\]
since5^9=4 modulo29 and the signs lie in F5. If A_i=0, (4) shows
that the positive and negative occurrences of every alpha cancel in
number. At most two distinct alpha occur. If a_i/B_i belonged to M,
the independence of b_j,b_k,b_j^*,b_k^* (or its single-root version)
would force every X_j^(5^9)=0, hence B_i=0. Thus s_i is not in M.

If A_i!=0, write its coordinates in the b_j basis as p_j. The identity
B_i=A_i/r_i, with r_i in M, gives X_j=p_j/r_i by linear disjointness.
For a repeated-root tuple, (4) gives a nonzero p_j at a missing alpha,
which is impossible. This finite observation is checked for every signed
root assignment by the small certificate below. For four distinct roots,
permute the branches into Frobenius order. The coordinate rows for the
three Fourier sums, multiplied entrywise by their own signs, are
\[
([17],[9],[17],[9]),\quad
([22],[22],[22],[22]),\quad
([9],[17],[9],[17]).
\]
Ratios of these entries must be29th roots of unity. Since
F25^* intersects mu29 only in1, only the middle row is possible, and
all four roots-of-unity factors must agree. The b_j basis then makes
every B_i nonzero. This proves the claim for all geometric labels.

The basis and (4), the six mixed determinants, and all768 signed root
assignments are checked by
[klein_four_jet_field_linear_algebra.py](../../scripts/arithmetic/klein_four_jet_field_linear_algebra.py).
There are84 zero-alpha-sum cases,612 missing-coordinate obstructions and
72 four-distinct-root cases, of which24 have the unique permitted sign
row after permutation. This small certificate independently confirms
the same obstruction first found by the larger exhaustive cyclic-field
test; no large exponent enumeration is needed for the proof.

## Equality in the Fourier bound is impossible

Suppose g=51+j. Then sum d_i=j-24<=5, and equality in (2) holds for
every character: c_i=16+2d_i. In particular0<=d_i<=5. The S_(d_i)
evaluation code is MDS; imposing zeros at its c_i=dim(S_(d_i))-1
specified nodes leaves a one-dimensional space defined over M.
All nodes and the polynomials E,C_i,D,H,R,B are defined over M.
The map (T_i,N_i) to F_i is injective because of its disjoint high
block, and is defined over M. Thus, after a common scalar normalization,
both T_i and N_i have coefficients in M. It follows that
\[
\epsilon K_i=\epsilon\frac{u_i}{t^3w_i}
=\frac{N_i/T_i-H}{E}\ \in M(t) \qquad(i=1,2,3). \tag{5}
\]

At least one B_i is nonzero. Otherwise normal-basis independence gives
X_j=0 for every signed character sum, hence also c_i=0: explicitly,
c_i=sum_j L_(alpha_j)*b_j^5*X_j^5. Therefore each t^3 w_i has order
at least2 at0. Its other factors z_i/C_i are units there, so every
nonzero T_i is divisible by t^2, contradicting sum d_i<=5.

For any character with B_i!=0, the value and derivative at0 in (5)
are r_i and s_i. The coefficient-field obstruction forces four
distinct alpha labels and makes all three B_i nonzero. Equation(5)
would then put all three pairs (r_i,s_i) in M, whereas the obstruction
permits at most one. This contradiction excludes equality and proves
g<=50+j<=79.

## The next two excluded degrees and verification scope

The genus bounds now give, for m=j1+2j2>=j,
\[
14g-16m\le\min(378+12j,700-2j)\le654.
\]
The grid theorem's first necessary inequality at n=90 is
14g-16m>=R1(90)=657. Hence n=90 is impossible. At n=91 the same
right side is680, also impossible. The old92..182 exclusion is unchanged.

The small [check script](../../scripts/arithmetic/klein_four_hermite_duality.py)
verifies all exponent complements, dimensions, pairing entries and
integer consequences, and checks the symbolic polynomial identity by
elementary substitution. It does not re-enumerate the already certified
Fourier minors or claim that remaining integer profiles are actual curves.
