# Proof: common-pole residues couple the two quartic endpoints

25 September2026. The curve and the actual two-map reconstruction are
those of [cubic descent](pole_twelve_cubic_descent.md). This proof
integrates the returned quartic result, retaining its exact scope.
The original report and data are in
[the preserved archive directory](../../../litt3-computation-data/quartic_quotient_trace_replies_20260925/extracted/quartic_simultaneous_quotient/REPORT.md).
The source has been retained in
[the comparison directory](../../scripts/arithmetic/pro_quartic_quotient_trace_20260925/comparison/verify.py).

## Local calculation

The actual equations are
\[
A(v)=\epsilon^4t^{-13}A(u),\qquad
(dv/du)^3P(u)^2=\epsilon^{-17}t^{48}P(v)^2.
\]
At a common pole p, its u- and v-pole order e is1 or3. Choose u=z^-e
and write v=ell z^-e/h, t=cq, with h(0)=q(0)=1. Leading coefficients
give ell=epsilon c^4 and c^29=1. With calA(s)=s^4A(1/s)/A_4 and
calP(s)=s^10P(1/s), the complete local identities are
\[
q^{13}=h^4\frac{\mathcal A(z^e)}{\mathcal A(\ell^{-1}z^e h)},\qquad
q^{48}=h^{14}(h+(z/e)h')^3
 \left(\frac{\mathcal P(z^e)}{\mathcal P(\ell^{-1}z^e h)}\right)^2.
\]
Their first terms give q_e=4P_9(1-ell^-1). For e=3, h_1=q_1=0
and q_2=3h_2. If ell=1 and j is the first nonconstant order, comparison
of the two identities gives j=-e modulo five. Since deg(t)=4, its
ramification index is at most four. The exhaustive possibilities are:

| e | ell | parameter ramification index |
| --- | --- | --- |
| 1 | not1 | 1 |
| 1 | 1 | 4 |
| 3 | not1 | 2 or3 |
| 3 | 1 | 2 |

Only one c can satisfy epsilon c^4=1. In a degree-four fiber, the
weighted sum of e is at most (3/2) times the sum of parameter indices,
so d_c<=6.

Tame trace of a local Laurent series keeps exactly the terms whose
exponents are divisible by the ramification index, multiplying by that
index. Applying this to the displayed identities shows that Tr(u) and
Tr(v) have at most simple poles at the common-pole values. For a=[8]=4P_9,
their residues there are
\[
R_u(c)=a d_c(c-\epsilon^{-1}c^{-3}),\qquad
R_v(c)=a d_c(\epsilon c^5-c).
\]
For index two at an e=3 pole, the difference v-ell u has pole order
at most one, so its trace is regular. The index-three case follows
from q_3. This includes every case in the table.

## The global trace identities

At t=infinity the four unramified branches have expansions
\[
u=\epsilon^{-1}(b t^3+c_1t^2+\cdots),\qquad
v=\alpha+\lambda t^{-1}+\mu t^{-2}+\cdots.
\]
Define C_infinity=sum c_1 and M_infinity=sum mu. At t=0, exchange
u,v and replace t by1/t; the scalar is epsilon^-1. Thus the opposite
expansions are v=epsilon(b_0t^-3+c_0t^-2+...),
u=alpha_0+lambda_0t+mu_0t^2+..., with independent four-label sums
C_0=sum c_0, M_0=sum mu_0. No leg-exchanging automorphism is assumed.

In Tr(u), compare the polynomial coefficient of t^2 at infinity with
the coefficient at zero, using (t-c)^-1=-c^-1-tc^-2-t^2c^-3+... .
For Tr(v), compare the t^-2 coefficient at infinity with its Laurent
part at zero. The residue formulas give
\[
\epsilon(M_0+aS_{-2})=C_\infty+aS_{-6},\quad
M_\infty+aS_2=\epsilon(C_0+aS_6).
\]
In particular, without division,
\[
(C_\infty+aS_{-6})(C_0+aS_6)
=(M_\infty+aS_2)(M_0+aS_{-2}).
\tag{1}
\]

## The finite endpoint assertion

Use K_0=F25[alpha]/(alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]).
Its four A-roots are alpha_i=alpha^(25^i). The leading parameter b
satisfies b^29=3A'(alpha_i)^3P(alpha_i)^2/A_4^3. Each right side has
a unique29th root b_i in K_0; all choices are b_i zeta^j for j=0..28.
Here zeta has exact order29 and degree seven over F25, with polynomial
\[
Z^7+[9]Z^6+[24]Z^5+[20]Z^4+[21]Z^3+[22]Z^2+[5]Z+[4].
\]
Let K_1=F25(zeta). The two fields are linearly disjoint over F25;
their compositum is E=F_(5^56). The endpoint coefficients are
C_ij=C_i zeta^(5j), M_ij=M_i zeta^(8j), where rows below use the
basis1,alpha,alpha^2,alpha^3:

| i | C_i | M_i |
| --- | --- | --- |
| 0 | (22,7,9,23) | (1,3,8,15) |
| 1 | (15,11,10,2) | (0,23,3,0) |
| 2 | (21,17,6,23) | (16,24,14,5) |
| 3 | (2,20,5,12) | (5,10,10,5) |

The coefficient formulas are reconstructed from P,A by the supplied
constant generator, not treated as unchecked tables. The four C_i
form a basis: their determinant is[2], and their sum is beta=[5].
Any at most four distinct29th roots are independent over F25, as
checked exhaustively by the small exact field verifier. Consequently
if a four-label sum C(L) lies in K_1, each root type occurs once and
all four zeta-labels agree. Then C(L)=beta zeta^(5j). It follows that
C(L)+a delta never vanishes for delta in F5: beta/a=[13] is not inF5,
and mu_29 intersects F25^* only in1.

The exact finite assertion is
\[
(C(L)+a\delta)(C(L')+a\delta)
\ne(M(L)+a\delta)(M(L')+a\delta)
\tag{2}
\]
for every delta in F5 and every pair of four-label multisets L,L'.
It is verified by forming all ratios (M+a delta)/(C+a delta) and
checking that no nonzero ratio has its inverse in the same set.
There are7,940,751 multisets. For delta=0 the free simultaneous
rotation reduces to273,819 representatives and ratios are compared
modulo mu_29. For delta=1..4 every multiset is enumerated. Exactly
one numerator is zero at delta=1; it cannot form a reciprocal pair.
All denominators are nonzero, and all five cases have zero hits.
Hash tables compare the full exact field element after a hash match.
Every computed inverse is multiplied back, and field irreducibility,
endpoint formulas and exhaustive counts are checked separately.

The five entire enumerations and the small checks were executed locally
again and passed. The
[audit](../../Research/audits/QUARTIC_QUOTIENT_TRACE_REPLIES_2026_09_25.md)
records commands and evidence. This is a finite exact assertion over
all possible endpoint labels, not a bounded search for curve models.

## Profile and scalar consequences

If S_j=delta c_0^j at the four exponents, replace t by t/c_0 and
epsilon by epsilon c_0^4. The equations preserve their form and all
four moments become delta. Equation(1) contradicts(2).

These moment profiles are exactly the residues constant except at
one point. Indeed multiplication by five partitions the nonzero
exponents modulo29 into the two disjoint orbits2<5> and6<5>, each
of size14. Frobenius propagates the specified moments to all nonzero
exponents. After subtracting the delta mass at c_0, the residue
polynomial vanishes at every nontrivial29th root, so is a multiple
of1+Z+...+Z^28. More generally S_0,S_2,S_6 determine every residue
by inverse Fourier transform. Integer lifts are still required:
0 may lift to0 or5,1 to1 or6, and2,3,4 lift uniquely; their sum is n-12.

At n=12,13 the total common-pole weight is0,1. At n=186,185 its
deficiency from29*6 is0,1. All these profiles are excluded. At
n=183,184 an unexcluded deficiency profile must contain a weight-five
fiber. Its points have weights3,1,1 and indices2,1,1, giving a
transposition. A transitive subgroup of S4 containing a transposition
is D4 or S4. A cyclic quartic cover needs at least two order-four
branch values, by its quadratic quotient and Hurwitz; the local table
allows at most one such value in D.

Finally all trace coefficients lie in E, and all moments in K_1.
The two quantities C_infinity+aS_-6 and C_0+aS_6 cannot both vanish.
Otherwise the basis lemma gives C_infinity=beta zeta_infinity^5 and
C_0=beta zeta_0^5. Conjugation z->z^(5^7) on K_1 sends zeta to
zeta^-1 and S_6 to S_-6. With gamma=beta/a, this would give
(zeta_infinity zeta_0)^5=bar(gamma)/gamma=[19], impossible since
the right side is in F25^* and is not1. At least one trace equation
therefore expresses epsilon as a ratio in E. Only the scalar, not
the curve's model field, is bounded by this argument.

For a counterexample of covering degree at most twelve, the earlier
small-pole theorem forces comparison pole twelve. The n=12 exclusion
just proved rules it out. Covering degree thirteen additionally allows
pole thirteen; this corollary alone says nothing about that case.
