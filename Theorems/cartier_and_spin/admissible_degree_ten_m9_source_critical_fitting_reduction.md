# Source-only critical irreducibility and finite parameter support in m9

ID: `admissible_degree_ten_m9_source_critical_fitting_reduction`.
Version1,2 October2026. The focused whole-argument
[independent audit](../../Research/audits/M9_SOURCE_ONLY_FINITE_REDUCTION_AUDIT_2026_10_02.md)
passed; no numerical replay was needed.

Retain an ACTUAL nontrivial admissible degree-ten source in the
$d=10,m=9$ profile, with its ORIGINAL source polynomial and short
critical cubic $D_s$. No restriction on the fourth annihilator
moment $\rho$ is imposed, and no cancellation $U(c)=0$ is assumed.
Work over $k=\overline{\mathbf F}_5$, with fixed curve $y^3=P(x)$,
$x$ of pole three, $y$ of pole ten and $a=Z/y$. Codes $[a+5b]$
mean $a+b\beta$, $\beta^2=\beta+3$. Ascending rows are
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\quad A=(1,21,14,22,13),
\]
\[
Z=(15,19,24,12,10,19,3,24,18,16),\quad
q=(13,18,24),\quad q_3=(1,22,9,1).
\]
The actual selected finite divisor consists of all three cubic
sheets over three of the four roots of $A$, retaining every omission.

Every rational critical root has infinity pole at most four and
forces $\delta_3\in\langle q,q_3\rangle$ of exact pole nine.
Normalize its scalar so $\delta=\delta_3=q_3+\lambda q$.
Write
\[
D_s=\delta(T-c)(T^2+bT+e),\quad
c_f=c+a,\quad b_f=b-2a,\quad e_f=e-a b_f-a^2.
\]
Then the following source-only exclusions hold for EVERY $\rho$:

* No rational critical root has infinity pole at most one; pole
  two is also impossible. The whole leading line $\lambda=0$
  has IRREDUCIBLE critical cubic, including poles three and four.
* If $c$ has pole three, $b$ has pole four and $e\le5$.
  There must be an unramified critical fiber on which $c_f$
  has maximal pole support on exactly one of its three cubic sheets.
  The complementary no-singleton branch is excluded at all repeated,
  branch, endpoint and coefficient-drop boundaries.
* If $c$ has pole four, $b$ has pole three and $e\le4$.
  There must be an unramified critical fiber on which $b_f$
  has maximal pole support on exactly one cubic sheet. Its
  complementary branch is likewise excluded at all boundaries.

Moreover there is an explicitly defined FINITE set
$\Sigma\subset k$, depending only on the fixed data above, with
$0\notin\Sigma$, such that EVERY actual m9 source with reducible
critical cubic has $\lambda\in\Sigma$. This is a source-only
necessary parameter reduction. It does not decide the exceptional
fibers, assert irreducibility for the entire moving pencil, or
exclude the whole m9 profile or unmarked common-cover problem.

The support is defined by finite images of boundary, sheet-value
coincidence, cubic interpolation and selected-zero concurrence
sections, and a compact augmented-source obstruction on the
degree81 sheet cover of the leading pencil. On its ordinary
locus choose the pole-three member of $(c,-b/2)$, its distinguished
singleton sheet, and one complementary sheet on each other fiber.
All components and all omissions are retained; no source Galois
closure or finite-field restriction on geometric coefficients is used.

Here is the explicit small source matrix. Put
$Z\delta=PK+R$, $B_4=B_0+\delta(\mu_b+\nu_bx)$ and
\[
H_0=\operatorname{rem}(ZB_0,P)/P,\quad
H_\mu=\operatorname{rem}(Z\delta,P)/P,\quad
H_\nu=\operatorname{rem}(Z\delta x,P)/P,
\quad T_\delta=\operatorname{rem}(Z^2\delta,P)/P.
\]
For a selected zero pair $J=\{(s_1,z_1),(s_2,z_2)\}$ on
distinct selected fibers, let $s_0$ be the third selected root,
$z_0=0$, and $\ell_i=\prod_{j\ne i}(s_i-s_j)^{-1}$.
Every actual source in this stratum requires
\[
\det\begin{pmatrix}
H_\mu(s_0)&H_\nu(s_0)&-H_0(s_0)\\
\sum\ell_i z_iH_\mu(s_i)&\sum\ell_i z_iH_\nu(s_i)&
\sum\ell_i(T_\delta(s_i)-z_iH_0(s_i))\\
[x^9]\operatorname{rem}(Z\delta,P)&
[x^9]\operatorname{rem}(Z\delta x,P)&
-[x^9]\operatorname{rem}(ZB_0,P)
\end{pmatrix}=0.
\]
An empty or singleton selected-zero set may be enlarged to such
a pair as a necessary relaxation. Pole-four roots satisfy an
additional degree-eight gap row, which is not needed to define
this finite overrelaxation. Same-fiber pairs and larger zero sets
lie in the separately retained coincidence/concurrence supports.

For BOTH root poles three and four, every one of the27 cross-fiber
pairs in all72 fixed-leading-line representatives gives a nonzero
three-by-three determinant:3888 explicit minors in total. Hence
each corresponding matrix section is nonzero on every sheet-cover
component, and its discriminant-cleared norm gives a nonzero
polynomial in $\lambda$. Their zero supports and the finite
boundary sections define $\Sigma$. The norm polynomials have
not been expanded or factored; no claimed degree bound is used.

[Proof](../../Proofs/cartier_and_spin/admissible_degree_ten_m9_source_critical_fitting_reduction.md).
