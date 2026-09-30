# Proof of the uniform pencil gap

Use the [statement](../../Theorems/cartier_and_spin/klein_four_uniform_pencil_gap.md),
the strict Hermite theorem and the complete endpoint analysis in the
[small-pencil proof](klein_four_small_character_pencils.md). We retain
both actual maps; all functions and characters are their specified ones.

The strict bound leaves only c=15+2d to exclude. It is automatic when
e<=14 or d>=8. The case d=0 is already excluded by the small-pencil
theorem. Thus first consider1<=d<=6 and c=15+2d.

## The endpoint map of a pencil

Write M=F_(25^7), let C be the product of the c nodes, and retain
\[
F\in S_d,\quad C\mid F,\quad
\epsilon K=\frac{t^{22}T-F}{(t^{29}-1)T}. \tag{1}
\]
The MDS theorem gives a two-dimensional M-space of such F. Its linear
map to (T(0),F(0)) is an isomorphism: a kernel element could be divided
by t to give an S_(d-1) polynomial with15+2d roots, above its bound
14+2d. This includes d=6 by using the established S_5 bound.

One additional forced-label fact handles the denominator boundary:
\[
B_i=0\ \Longrightarrow\ A_i=0,
\qquad
B_i\ne0\ \Longrightarrow\ a_iB_i-A_ic_i\ne0. \tag{2}
\]
Here the capital and lower-case letters are the Fourier sums of the
leading labels and their first jets, not divisor degrees. Both assertions
are checked on all804837 normalized character-label cases. There are345
zero denominators, zero exceptions to the first implication, and zero
vanishing derivative numerators on the complement. All leading-label
collisions are retained. The exact constructor and evaluator are
[zero_endpoint_derivative.py](../../scripts/arithmetic/klein_four_zero_endpoint_derivative.py)
and [zero_endpoint_derivative.cpp](../../scripts/arithmetic/klein_four_zero_endpoint_derivative.cpp).
They use precisely the previously verified root field and first-jet
formulas, without imposing extra formal distinctness.

If T(0)=0 in(1), then B_i=0, hence A_i=0 by(2). The actual polynomial
U_i consequently vanishes at0, so F(0)=0 as well. The pencil isomorphism
would make F=T=0, a contradiction. Therefore T(0)!=0. Normalize it to1
and set r=F(0), s=(F/T)'(0). The projective polynomial is defined over
M(r), and s is a quadratic polynomial in r over M. If r is in M then
so is s; the coefficient-field lemma forces the rational target
([22],[8]), up to the stated common phase.

The complete Moore calculation from the small-pencil proof covers all
other possibilities. It gives142 quadratic-extension targets
\[
r^2=\tau r+\upsilon,\quad s=\lambda r+\nu,
\]
and two additional degree-four targets, whose quadratic jet polynomials
are respectively
\[
s=[10]r^2+[15]r,\qquad
s=[24]r^2+[18]r+[14]. \tag{3}
\]
Their root patterns are(0,0,1,2) and(0,0,2,3), all initial phases zero.
The independent verifier reconstructs both identities and checks the
rank-three coefficient matrix, so the displayed coefficients are unique.
There are no other nonrational cases. A_i=0 cannot occur: it would give
r=0 in M and violate the coefficient-field lemma.

## Exact coefficient construction for an arbitrary pencil

Let J be the complementary set, of size14-2d. Set
\[
h_k=(-1)^k e_k(J),\quad h_0=1,\quad h_k=0\text{ outside }0\le k\le|J|.
\]
The polynomial T=sum_(r=0)^d t_r t^r satisfies exactly the d-1 equations
\[
\sum_{r=0}^d t_r h_{8-2d+l+r}=0\qquad(0\le l<d-1). \tag{4}
\]
These follow by requiring the remainder of t^22*T modulo C to have
degree at most15+d. Conversely, every vector satisfying(4) gives the
word F=2C*floor(t^22*T/C). The matrix has rank d-1.

Choose any basis(T_0,T_1) of its kernel, with corresponding(F_0,F_1).
For index l=0,1 abbreviate
\[
A_l=T_l(0),\ B_l=F_l(0),\ C_l=T_l'(0),\ D_l=F_l'(0).
\]
These letters refer only to this basis, not to the endpoint Fourier
sums. Put
\[
\Delta=A_0B_1-A_1B_0\ne0,
\quad a=C_0A_1-C_1A_0,
\quad b=D_1A_0-D_0A_1-C_0B_1+C_1B_0,
\quad c=D_0B_1-D_1B_0.
\]
Solving the two endpoint normalization equations gives exactly
\[
s=(a r^2+b r+c)/\Delta. \tag{5}
\]
For a quadratic-extension target the two tests are
\[
\lambda\Delta-a\tau=b,\qquad \nu\Delta-a\upsilon=c.
\]
For a degree-four target all three coefficients in(3) must equal
(a,b,c)/Delta. For the rational target, substitute r,s into(5).

The complete verifier forms(4), obtains a kernel by nonzero minors,
checks Delta!=0 and performs all these tests. It retains a safe superset
closed under coefficient Frobenius and common phases:3364 quadratic-
extension targets,116 degree-four targets and58 rational targets. No
presumed coefficient-field bound for an unknown actual curve enters.
Rotations and Frobenius act only on this explicitly closed necessary
finite system.

The results are
\[
\begin{array}{c|r|r|c}
d&\text{normalized subsets}&\text{orbit representatives}&\text{matches of any type}\\
1&21474180&128037&0\\
2&6906900&49478&0\\
3&1184040&10645&0\\
4&98280&1196&0\\
5&3276&65&0\\
6&28&2&0.
\end{array}
\]
Each row's orbit sizes sum to the full count binom(28,13-2d). Thus
every boundary for1<=d<=6 is excluded, already at the first endpoint.

## The final boundary d=7,c=29

Here E=C=t^29-1, H=t^22 and the polynomial called B in the Hermite
construction is zero. The degree bounds give
\[
F=2t^{22}T-N=\kappa(t^{29}-1),\quad \deg N\le22,\quad
T=t_0+(\kappa/2)t^7.
\]
The coefficient kappa is allowed to be zero. If t_0=0, then B_i=0
and A_i=0 by(2), so U_i(0)=0. But U_i(0)=kappa, which would make
T=0. Hence t_0!=0. Formula(1) is now
\[
\epsilon K=\frac{t^{22}}{t^{29}-1}-\frac{\kappa}{T}.
\]
Its derivative at0 is zero, contradicting the second assertion of(2).
This includes F=0, which was not possible in the disjoint coefficient
blocks for d<=6. The final boundary is therefore excluded as well.

## Verification and consequence

The exhaustive source is
[pencil_boundary_all.cpp](../../scripts/arithmetic/klein_four_pencil_boundary_all.cpp).
Run the C++17 executable with the generated linear_pencil_targets.dat
and a range1 6 (the retained complete run was split as1 4 and5 6).
The optional compile-time KLEIN_FOUR_PENCIL_PROBE mode is only a bounded
diagnostic; its output is explicitly not used for exhaustive coverage.

[The independent checker](../../scripts/arithmetic/check_klein_four_pencil_boundary.py)
uses direct polynomial divisions and Gaussian solving, instead of the
complementary-root Hankel matrix and cofactors. On42 retained probes it
reconstructs the normalized words with(T(0),F(0))=(1,0),(0,1), verifies
all coefficient gaps, and compares every coefficient in(5). It also
reconstructs(3), checks full-log counts and retains source/evidence hashes.
All checks passed. An initial missing zero-quotient guard in this
independent checker was fixed before its successful run; it did not
affect the separate exhaustive calculation.

The exact data and logs with prefixes pencil_boundary and
zero_endpoint_derivative are in
[overnight_three_replies_20260926](../../../litt3-computation-data/overnight_three_replies_20260926/).
The derivative test shares the exact first-jet construction already
independently checked in the preceding theorem.

Finally c_i<=14+2d_i and d_i=10+c_i-h_i imply
h_i<=17+floor(c_i/2). Sum using sum h_i=g+3 and sum c_i=2j.
The odd c_i count is zero or two. This proves the asserted genus
bound and preserves the prior exclusion of89..182. Neither this
character calculation nor the finite node tests supply actual maps
or resolve either original common-cover problem.
