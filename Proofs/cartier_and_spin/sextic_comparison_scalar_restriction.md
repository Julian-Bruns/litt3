# Proof: complementary phase ranks rule out the quadratic scalar extension

[Statement](../../Theorems/cartier_and_spin/sextic_comparison_scalar_restriction.md).
The first two actual trace identities used in the quartic and quintic
cases are additive in the endpoint branches; their derivation does not
depend on the number of branches. They therefore apply to the SIX
branches of the pole18 cubic quotient. Here is the necessary common-pole
check: its order e is1 or3. At the exceptional slope epsilon*c^4=1,
the first parameter order j satisfies j=-e mod5, and j<=6. Thus j=4
for e=1 and j=2 for e=3. At other slopes the first coefficient gives
j=1 for e=1 and j=2 or3 for e=3. All these points are tame, exactly as
in the [quintic proof](pole_fifteen_quotient_constraints.md); the latter's
five-sheet capacity bound is replaced by the six-sheet bound d_c<=9.
Other branches contribute integral traces, even if they are wild.
Thus the same Laurent residue calculation applies. With X=M2,Y=M6 in K0 and
eta0=[22], they are
\[
\epsilon(E_{Q0}-\eta0\overline X)=C_{Q\infty}-\eta0\overline Y,
\qquad
\epsilon(C_{Q0}-\eta0Y)=E_{Q\infty}-\eta0X.
\tag{1}
\]
Here M_j=sum d_c c^j over common-pole values c in mu29. All four
endpoint sums belong to F_(5^56)=E8 K0. The already proved scalar
bound puts epsilon in F_(5^16). If epsilon is outside E8, then it is
outside F_(5^56), since the intersection of these fields is E8.
Equation(1) would force C_Q0 and E_Q0 to belong to K0 simultaneously.

We exclude this using a complete small phase calculation and integer
multiplicity bookkeeping. Express E8 over B in the alpha0-basis,
alpha0^4+[7]alpha0^3+[6]alpha0^2+[2]alpha0+[5]=0. The nonconstant
coordinates of the four values c(alpha_i) form
\[
\begin{pmatrix}
[7]&[11]&[17]&[20]\\
{}[9]&[10]&[6]&[5]\\
{}[23]&[2]&[23]&[12]
\end{pmatrix}.
\]
Its first three columns have determinant[9]!=0, and its rows sum to
zero. Its kernel is exactly the line(1,1,1,1). All four c-values and
all four e-values lie outside B. These claims are reconstructed by
[the coefficient verifier](../../scripts/arithmetic/verify_sextic_endpoint_coefficients.py).

If L has at most five distinct phases, the established independence
of any five phases over B separates its phase coefficients. Thus
C_L in K0 requires the four root multiplicities at each phase to be
equal modulo five. At one phase their total is consequently4r+5b,
with0<=r<=4 and b>=0. With total cardinality SIX, r is0 or1, so the
total over all phases is4a+5b. No nonnegative a,b give six.

If L has six distinct phases, each has a single root label. If its
six fifth powers are independent over B, C_L in K0 would force each
c-value into B, a contradiction. Similarly independence of the six
eighth powers contradicts E_L in K0. At least one of these sets is
always independent, by the following exhaustive certificate.

Use the irreducible factor
\[
x^7+[24]x^6+[7]x^5+[21]x^4+[20]x^3+[7]x^2+[22]x+[4]
\]
for xi over B. Normalize one phase to1. Of all98,280 six-subsets
containing1,126 have rank five and98,154 have rank six. For EACH of
the126 deficient subsets, its eighth powers have rank six. Fifth
power preserves B-linear rank, being a semilinear field automorphism.
Normalization multiplies every vector by one nonzero field element,
and therefore loses no subset. The exact
[rank-complement program](../../scripts/arithmetic/verify_six_phase_rank_complement.cpp)
checks the whole domain with assertions enabled. In particular the
false assertion that all SIX phases are independent is not used.

This proves the six-label statement and contradicts(1) for every
epsilon outside E8. The desired scalar restriction follows.

For the noncube refinement, put H=E8^*mu29 and choose gamma^3=epsilon.
The full-fibre identity gives gamma^g in H, where g is the gcd of
the integer differences of the four root multiplicities. Their sum
is six, so they cannot all be equal. If epsilon is a noncube in E8,
it is also a noncube in H, since29 is coprime to three. Thus the class
of gamma modulo H has exact order three and3 divides g. All four
multiplicities are equal modulo three; summing shows each is zero
modulo three. The two asserted profiles are the only possibilities.

The [arithmetic output](../../../litt3-computation-data/pole18_descent_reply_20260927/local_extension/sextic_endpoint_coefficients.json)
and [rank output](../../../litt3-computation-data/pole18_descent_reply_20260927/local_extension/six_phase_rank_complement.log)
are retained. No classification of actual curves is inferred from
this scalar restriction.
