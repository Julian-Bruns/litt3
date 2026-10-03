# Finite square support and the actual m9 critical trace pencil

ID: `admissible_degree_ten_m9_critical_square_pencil_finite_support`.
Version3, 2 October2026. The underlying Version2 [whole-implication review](../../Research/audits/M9_CRITICAL_FINITE_SQUARE_SUPPORT_AUDIT_2026_10_02.md) and Version3 [independent correspondence/four-bound audit](../../Research/audits/HOM_DISJOINT_CORRESPONDENCE_GONALITY_AUDIT_2026_10_02.md) passed with their stated scopes. The combined-rank witness is restricted to the necessary coefficient model specified below.

Let $k$ be algebraically closed of odd characteristic $p$, $C/k$ a
smooth connected proper curve, $L=k(C)$, $g\in L^*$ and $q\in L$.
If $q$ is nonconstant, write $q=r^{p^e}$ with $dr\ne0$ and put
$N=[L:k(r)]$. Then the constants $\theta$ for which
$g(\theta-q)$ is a NONZERO square form a finite set of cardinality
at most $1+v_2(N)$. No assumption that $g$ is square is made.

There is an explicit divisor-parity support containing this set.
If an odd-order point of $g$ is not a pole of $r$, every possible
$\theta$ equals its $q$-value; incompatible values give empty
support. Otherwise check the fixed parity at poles of $r$ and
retain only finite fibers of $r$ whose multiplicities are ALL even.
For $N$ even their number is at most
$\lfloor4+4(g_C-1)/N\rfloor$; for $N$ odd there are none in this
second alternative. Their square classes still require checking.
If $q$ is constant, the nonzero square support may instead be
empty or cofinite; it is not covered by the finite-support claim.

For the fixed genus-nine curve $X$ and an ACTUAL primitive degree-ten
m9 source with its actual annihilator, let $D_s$ be the short critical
cubic and assume its quadratic coefficient has exact infinity pole14.
Retain the same actual source, all finite contact conditions and the
original incidence $U^2-FQ=DV_2$. By
[critical irreducibility](admissible_degree_ten_m9_critical_irreducibility.md),
$D$ is irreducible and separable and $F(c),U(c)$ are nonzero in its
cubic field $k(C)=k(X)[c]$.

Fix $\rho\in\langle1,x,x^2\rangle$ and
$m_5=\operatorname{Tr}(u)\in L_{10}$.
Take the exact fifteen-dimensional first-three quadratic-moment model
of [critical incidence](admissible_critical_quadratic_incidence.md).
Impose the five infinity equations of poles23 through19 and the nine
ordinary selected SHORT equations $Q_s(0)=0$, as written in the proof.
ASSUME their combined matrix has rank14. If consistent, these necessary
moment data form an affine line $Q_\theta=Q_0+\theta Q_1$, with
$Q_1\ne0$ and $\deg_TQ_i\le2$.

The following conclusions hold on this stated rank-fourteen locus:

* Both $Q_i(c)$ are integral at every finite point of $C$, including
  above zeros of the critical leading coefficient. The genus satisfies
  $g_C\le55$, and the ratio $q=-Q_0(c)/Q_1(c)$, if nonconstant,
  has degree at most74.
* The ratio is nonconstant whenever $\rho\ne0$ OR $m_5$ has exact
  pole ten. For each fixed actual source and fixed such $\rho,m_5$,
  at most FOUR affine trace parameters satisfy the necessary NONZERO
  critical square identity $F(c)Q_\theta(c)=U(c)^2$.
  This sharpens the general seven-value bound using the accepted absolute
  simplicity and unique trigonal pencil of $X$, and the basepointfree
  Hom-disjoint correspondence lemma.
* A necessary branch-support polynomial of degree at most256 can be
  constructed from the finite different images of the separable part
  of $q$, or a zero-or-one support can be obtained from an odd divisor
  point. Complete fiber parity leaves at most112 parity candidates;
  actual square classes leave at most four.
* If $\rho=0$ and $m_5\in L_9$, the fourteen equations are homogeneous.
  Their rank-fourteen solution is a vector line, so one may take
  $Q_\theta=\theta Q_1$. The ratio is constant and the critical square
  test either excludes all nonzero parameters or permits all. This
  boundary is retained, as is the combined rank-drop locus.

There is a stronger necessary SOURCE condition on the last homogeneous
boundary, without any combined-rank14 assumption. Let $c_\infty$ be
the formal pole-five root, put $G=vx^6/c_\infty^2$, and write $Q_j,G_j$
for the Laurent coefficients of pole $j$. Every actual source with
$\rho=0,m_5\in L_9$ satisfies
$Q_{17}-(G_{17}/G_{18})Q_{18}=0$.
Together with the original fourteen homogeneous rows this gives a
fifteen-by-fifteen matrix whose determinant MUST vanish. One NEW rank15
witness proves that this is a proper additional Fitting support in the
necessary coefficient family with $v\in L_{10}$ of exact pole ten.
Its necessity does not assume that the original fourteen rows have
rank14. The witness does not realize an actual source.

When the original rank is14 and its homogeneous kernel has
$Q_{18}\ne0$, this determines the normalized leading content coefficient:
$v_9/v_{10}=Q_{17}/Q_{18}+2(\delta_2)_{13}/(\delta_2)_{14}$,
using the local parameter $x^3/y$.
If $m_5\in L_6$, all four coefficients $Q_{18},Q_{17},Q_{16},Q_{15}$
must vanish; no ranks for these additional four rows are asserted.
The new pole17 row requires the second Newton approximation specified
in the proof, not the first approximation used for the original five rows.

One exact rank14 witness exists in the eighteen-dimensional LINEAR
model of necessary source-critical coefficient conditions detailed in
the proof. Hence its rank-at-most13 Fitting support is proper in that
model. The witness is NOT an actual source and does not prove that
any actual source lies in the open. No uniform combined-rank claim,
full m9 exclusion, source existence result or common-cover decision
is made. The remaining interpolation and both original actual finite
etale maps are retained. Version2 incorporated the stronger homogeneous
boundary row and its changed-input rank15 witness; it does not enlarge
the source or common-cover exclusion scope. Version3 sharpens the
nonconstant trace-pencil bound from six to four by a conceptual
correspondence argument; no numerical checks are repeated.

[Proof](../../Proofs/cartier_and_spin/admissible_degree_ten_m9_critical_square_pencil_finite_support.md).
