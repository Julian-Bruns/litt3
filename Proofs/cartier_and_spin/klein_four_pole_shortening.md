# Proof of the Klein-four pole and character bounds

Use the exact hypotheses of [the theorem](../../Theorems/cartier_and_spin/klein_four_pole_shortening.md).
The [quadratic trace theorem](quadratic_trace_noncollapse.md) supplies
the endpoint jets, their finite separation certificates and trace
noncollapse. Retain the actual functions throughout.

## Shortening and primitivity

At a common pole above t=c in mu29, the leading ratio is ell=epsilon*c^4.
Let lambda(t)^4=epsilon^4*t^-13, with lambda(c)=ell. The quartic gives
\[
v=\lambda(t)u+\frac{[22](\lambda(t)-1)}{4[13]}+O(u^{-1}).
\]
Its logarithmic derivative is3/t, while that of epsilon*t^4 is4/t.
Their difference has a simple zero at c. A simple common pole is
unramified for t, so w is regular there. At a triple common pole the
parameter index is2, so w has pole exactly1. At0 and infinity it has
orders3 and7. This proves its pole divisor; order3 makes it separating.

If a nontrivial sigma fixed w, then
v-sigma(v)=epsilon*t^4*(u-sigma(u)). At an unramified branch over0,
this makes the v-leading constants agree. Their certified separation
also makes the u-values alpha agree. For
D_A(X,Y)=(A(X)-A(Y))/(X-Y), the first divided difference is a unit
at u,sigma(u), while the one at v,sigma(v) has valuation-9.
Subtracting the quartic identities gives
\[
\epsilon t^4 D_A(v,\sigma v)
=\epsilon^4t^{-13}D_A(u,\sigma u).
\]
Its two sides have valuations-5 and-13. This contradiction proves
primitivity. In particular w has at least two nonzero nontrivial
character components.

## Character denominators

Index the involutions sigma_i and characters chi_i so that sigma_i
is the kernel involution. Let g_i be the corresponding quadratic
quotient genus and h_i=g_i+1. Then sum h_i=g+3. Let q_i count
triple-pole parameter fibers with inertia sigma_i; sum q_i=j.
Write the actual quadratic field as k(t,z_i), z_i^2=d_i(t), with
d_i monic squarefree of degree2h_i, nonzero at0. Its roots are the
branch values with inertia different from sigma_i.

The chi_i component of w is a rational multiple of z_i. At a
triple-pole fiber with inertia sigma_i, parity makes that component
regular. At each other such fiber, its rational coefficient has at
most one simple pole. Other branch values introduce no denominators:
a regular anti-invariant function vanishes there and cancels the
zero of z_i. If its end pole bounds are a_i,b_i, a nonzero component
therefore satisfies
\[
h_i\le a_i+b_i+j-q_i.\tag{1}
\]
Always a_i<=3,b_i<=7. For an endpoint component, the denominator
away from0,infinity has degree at most s+2j-q_i, giving
h_i<=3+s+2j-q_i whenever u_i or v_i is nonzero. At least one is
nonzero for every i by quadratic trace noncollapse.
Two instances of(1) and one endpoint bound give g<=20+s+3j<=n+8.
If all three w_i are nonzero, summing(1) gives g<=27+2j<=85.

## The leading labels when a component is missing

Suppose w_k=0. Then v_k=epsilon*t^4*u_k, and u_k is nonzero by
noncollapse. At a fixed completion above0 label the four endpoint
branches by gamma in V4. Their expansions are
\[
u_\gamma=\alpha_\gamma+a_\gamma t+e_\gamma t^2+O(t^3),\qquad
v_\gamma=\epsilon t^{-3}(B_\gamma+c_\gamma t+O(t^2)).
\]
All of alpha,a,c,e are determined by B, using the supplied formulas.
Regularity of v_k at0 says that the sum of the two B-labels with
chi_k=+1 equals the sum of the two with chi_k=-1. The certified Sidon
property implies equality of the unordered multisets, including
repetitions. Consequently u_k=O(t^3).

The four B-labels are therefore either all equal or two copies each
of two distinct values. We next exclude the latter possibility,
and then exclude the missing component altogether. This replaces
the earlier version1 argument, which only gave conditional pole
bounds and the weaker uniform genus90 conclusion.

## Logarithmic variation forces a single label

We now improve the preceding version1 bound. Put V=t^3*v/epsilon.
For a fixed endpoint label (alpha,B), the quartic identity gives a
unique formal function u=U(t,V) near(0,B). Write
\[
U(t,V)=\alpha+a(V)t+b(V)t^2+O(t^3),\quad
a(V)=a_4V^4/A'(\alpha),\quad
b(V)=-\frac{A''(\alpha)}{2A'(\alpha)}a(V)^2.
\]
Indeed the right side of A(U)=epsilon^-4*t^13*A(epsilon*t^-3*V)
starts with a4*V^4*t, and its next term is of order4. All denominators
above are units. Put ell=P'(alpha)/P(alpha), d=ell-A''(alpha)/A'(alpha).

Taking the unique local cube root in the differential identity,
with its value prescribed by this branch, gives
\[
tV'+2V=R(t,V)(U_t+U_VV'),\qquad
R(t,V)=R_0(V)(1+\ell a(V)t+O(t^2)),
\]
where R0(V)^3=V^20/P(alpha)^2 and R0(B)*a(B)=2B. In characteristic5,
R0'(V)=0. The denominator t-R*U_V is t times a unit with constant3,
so the equation has the form tV'=F0(V)+tF1(V)+O(t^2).
Direct differentiation gives
\[
F_0'(B)=2,\qquad F_0''(B)=0,\qquad
F_1'(B)=a(B)d=:\Lambda(B).
\]
For an explicit check, set N0=R0*a-2V and D0=1-R0*a'. Then
F0=N0/D0 and
\[
F_1=\frac{R_0d a^2}{D_0}
     +\frac{N_0R_0d a a'}{D_0^2}.
\]
At B the values are D0=3, N0=0, N0'=1, D0'=1/B.
These identities give the displayed derivatives by ordinary rational
differentiation. Also the known endpoint coefficient satisfies c/B=Lambda(B).

For two distinct formal branches with the same label, V1 and V2
agree through order1. Their difference Delta is nonzero and has
order at least2. Subtract the two scalar differential equations.
The nonlinear error divided by t*Delta has order at least1, and
F0''(B)=0 removes the first-jet contribution to the constant term.
Consequently
\[
d\log(V_1-V_2)=\left(\frac2t+\Lambda(B)+O(t)\right)dt.\tag{3}
\]
The difference is nonzero because v is primitive over k(t); two
different deck conjugates cannot agree in a completion. Formula(3)
is valid for arbitrary higher characteristic-five resonance terms.

The116 possible Lambda-values are distinct. To check this finite
input it suffices to take the unique29th root B in K for each
alpha, since gcd(29,|K*|)=1. For alpha=alpha0^(25^j), j=0,1,2,3,
the four values Lambda(B)^29, in the verified K coding, are
\[
68043,\quad140725,\quad52980,\quad386664.
\]
They are nonzero and distinct. On the mu29 orbit of one label,
Lambda(zeta*B)=zeta^4*Lambda(B), so these four values prove the
claimed separation over the whole algebraic closure. The exact
[script](../../scripts/arithmetic/klein_four_log_variation.py) and
[executed data](../../../litt3-computation-data/remaining_structural_replies_20260925/local_checks/v4_log_variation.json)
record this four-value check.

If w_k=0 and two distinct labels B,C occurred, the Sidon argument
already proved that each occurs once in either sign class of chi_k.
Pair the equal labels across those two classes. Let DeltaV_B and
DeltaV_C be the two differences. Since U_V=O(t), the corresponding
differences of w satisfy
Delta w=epsilon*t^-3*Delta V*(1+O(t^8)). The equality of the two
signed sums of w therefore implies
\[
\Delta V_B/\Delta V_C=-1+O(t^8).
\]
Its logarithmic derivative vanishes to order at least7. Formula(3)
instead makes its constant term Lambda(B)-Lambda(C), which is
nonzero. This contradiction proves that all four labels coincide.
The same argument holds at infinity after exchanging the endpoints.

## A missing character contradicts the next local coefficient

Put W=t^3*w/epsilon=V-t^7*U(t,V). This is an invertible formal
coordinate change in V and changes its scalar differential equation
only in order at least7. Write the new equation as tW'=G(t,W).
All four W-branches have the same B and the same first coefficient
c=B*Lambda. If chi_k were missing, their character expansion would
be W=W0+chi_i*a+chi_l*b, with a,b nonzero by primitivity and both
of order at least2. Here W0=B+c*t+O(t^2) is invariant.

The crucial coefficient is
\[
G_{WW}(t,W_0)=\frac{4\Lambda}{B}t+O(t^2),\qquad\Lambda\ne0.\tag{4}
\]
This uses one more derivative of the same formulas, not an assumption
on later branch coefficients. To verify it, put z=V/B. Since the
variation of R0 begins in degree5 in z-1, the needed coefficients are
those of the rational functions
\[
F_0/B=\frac{2(z^4-z)}{1-3z^3},\qquad
F_1/(B\Lambda)=\frac{z^8}{(1-3z^3)^2}.
\]
Their series at z=1 start respectively with
2(z-1)+2(z-1)^3 and4+(z-1)+(z-1)^2. Thus
F0'''(B)=2/B^2 and F1''(B)=2*Lambda/B. Substituting
W0=B+B*Lambda*t+O(t^2) gives(4); the coordinate change contributes
nothing this early. The exact script also verifies these universal
characteristic-five rational-series coefficients.

Now project tW'=G(t,W) to chi_k=chi_i*chi_l. The left side is zero.
On the right, only terms with odd positive powers of both a and b
contribute. Its quadratic term is G_WW(t,W0)*a*b. Every further
contributing term has total degree at least4, hence is a*b times
O(t^4), since a,b have order at least2. Formal power-series expansion
justifies this statement in characteristic5 without dividing by
factorials of order5 or higher. Therefore
\[
0=a b\left(\frac{4\Lambda}{B}t+O(t^2)\right).
\]
This is impossible in k((t)), as a,b,B,Lambda are nonzero. It excludes
every missing nontrivial character under the actual endpoint hypotheses,
without a bound on the endpoint degree. The abstract function z1+z2
does not meet those hypotheses and is not a counterexample.

All three instances of(1) can consequently be used simultaneously.
They give g<=27+2j<=85; together with the previous endpoint bound,
g<=min(n+8,27+2j). This closes the character-noncollapse gap in the
returned V4 pole argument, while leaving the actual comparison
existence problem open.

## Cubic branch count

Let a count endpoint index-three points above the eleven marked values,
and b those of index one. Hurwitz gives a=g+n-1, and b+3a=11n.
Thus b=8n-3g+3. Exactly these b points have P(u)-valuation not divisible
by3, so they are the branch points of the actual cubic extension.
The old g<=3n-30 and new g<=n+8 give
R3>=max(93-n,5n-21)>=74.

The differential identity itself reconstructs the ratio cube root:
if delta^3=epsilon^-17 and J=dv/du, then
r=delta*t^16*(P(v)/P(u))/J has r^3=P(v)/P(u).
The separate noncube condition is retained for connectedness.

## Full marked field bound

The fixed tame cubic X has a smooth proper characteristic-zero lift.
[Surjective specialization](https://stacks.math.columbia.edu/tag/0C0P)
and its genus-nine complex lift give at most18 topological generators
for its geometric fundamental group. By the
[finite-etale classification](https://stacks.math.columbia.edu/tag/0BND),
there are at most(n!)^18 connected degree-n covers up to isomorphism.
The actual common source T has genus G=8n+1.

Its finite automorphism group acts faithfully on H1_et(T,Z3): a kernel
element would give a quotient of the same genus by invariant rational
cohomology, contradicting Hurwitz. The congruence kernel of
GL_(2G)(Z3)->GL_(2G)(F3) is torsion-free, since cubing increases the
least3-adic valuation of a nonidentity principal congruence by exactly1.
Thus |Aut(T)|<3^(4G^2). Counting two covers and their possible source
identifications gives at most(n!)^36*3^(4G^2) ordered actual endpoint
pairs.

Such a pair fixes u,v,r and L=k(u,v). Put H=A(v)/A(u) and
J=(dv/du)^3*P(u)^2/P(v)^2. The identities recover
t^29=H^-17*J^-4 and epsilon=t^-4*H^-4*J^-1, so there are at most29
marked tuples per pair. The25-Frobenius orbit length is bounded by
N_n=29(n!)^36*3^(4(8n+1)^2). A marked tuple has no automorphisms,
since it fixes u,v. The unique Frobenius identifications satisfy the
descent cocycle, yielding a model over some F_(25^d), d<=N_n.
For n<=182, N_n<=3^8524160. Neither an enumeration nor an exclusion
is inferred from this enormous bound.

The returned [report](../../../litt3-computation-data/remaining_structural_replies_20260925/extracted/v4/klein_four_comparison/REPORT.md)
also gives a finite polynomial ansatz in all three actual quadratic
fields. Its branches and endpoint equations have not been solved.
The [verifier](../../scripts/arithmetic/pro_remaining_structural_20260925/v4/src/verify.py)
and archive audit passed; their numerical profile search concerns only
necessary integers. The endpoint-jet and logarithmic-variation improvements
received focused author review and are new local continuations, not returned claims.
