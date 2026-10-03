# Finite leading-zero trace constraints for an actual degree-ten source

ID: `admissible_degree_ten_m9_finite_leading_zero_trace_constraint`.
Version3, 2 October2026. Computation-free conceptual implication.
The local parity argument, selected-leading-zero extension, fixed
Bézout identity and BOTH-strata single-candidate corollary passed
focused review.

Retain the actual primitive degree-ten finite étale source, both
original maps from the same source, the actual m9 coefficient lattice,
and homogeneous $\rho=0$ critical square identity. Work in the finite
frame at an ordinary finite point $P$ of $X$. Selected points with
$t(P)=0$ are included in the trace assertions.
Write
\[
D_f=dT^3+eT^2+fT+h,\qquad
Q_f(T)=-d(n_0T^2+n_1T+n_2)-e(n_0T+n_1)-fn_0.
\]
All finite source coefficients and these three finite moments are
regular at $P$. The original source polynomial has regular coefficients
and its high terms are
$vT^{10}+(d/4)T^9+(e/3)T^8+(f/2)T^7+hT^6$.
The original ten source roots split in the base Laurent field.
On the auxiliary critical normalization $C$, $F(c)Q_f(c)$ is a nonzero
square. This auxiliary curve is not presumed étale over $X$.

1. If $\operatorname{ord}_P d=a$ is positive and odd, and $e(P)\ne0$,
then
\[
e(P)n_2(P)+f(P)n_1(P)+h(P)n_0(P)=0.
\]
The pole-$a$ critical branch is unramified over $P$, $F(c)$ has even
valuation there, and $Q_f(c)/d$ is regular with residue
$-n_2(P)-(f(P)n_1(P)+h(P)n_0(P))/e(P)$.

2. If $d$ has a simple zero at $P$, the same trace relation holds
without assuming $e(P)\ne0$. The proof includes the index-two and
index-three auxiliary critical branches; only the original source
roots must have integral Laurent valuations.

Consequently, if the leading cubic $d\in k[x]$ is squarefree and
coprime to $P(x)$, every actual homogeneous source satisfies
\[
en_2+fn_1+hn_0\equiv0
\quad\text{in }(k[x]/(d))[y]/(y^3-P(x)).
\]
Equivalently its three cubic characters vanish modulo $d$, giving
nine scalar necessary trace constraints. The same relation in the
short frame is
$\delta_2\mu_2+\delta_1\mu_1+\delta_0n_0\equiv0\pmod d$;
proper short-frame remainder terms are retained.

At a selected simple leading zero, the additional selected row and
$\delta_0=0$ give
$\delta_2\mu_1+\delta_1n_0=0$ and
$\delta_2\mu_2+\delta_1\mu_1=0$.
If $\delta_2$ is a unit there, these force
$n_0\mu_2=\mu_1^2$ at the endpoint. No division by $\delta_2$
is made in the general trace assertions.

For a fixed source and fixed first-moment pair in either homogeneous
B0 infinity stratum with $d$ unit on the selected divisor, let
$Q_{s,r}=Q_0-dt(s+rx)$ be its remaining second-moment
kernel plane. At every odd-order leading zero with
$e(P)t(P)\ne0$, the
necessary square support lies on the explicit parameter line
\[
s+r x(P)=-\frac{e(P)n_{2,0}(P)+f(P)n_1(P)+h(P)n_0(P)}{e(P)t(P)}.
\]
Two such endpoints with distinct $x$ coordinates leave at most one
candidate. Endpoints with the same $x$ coordinate and different right
hand sides leave none. In particular, a squarefree leading cubic
coprime to $P t$ and with a good endpoint over two of its roots has
at most one critical-square candidate in that kernel plane.
This is a necessary source reduction, not source existence or exclusion.

In fact BOTH actual homogeneous B0 strata have the following uniform
open corollary. For EVERY squarefree leading cubic $d=pq_3+rq$, $p\ne0$,
coprime to $P t$, and for every fixed compatible first pair, the
entire remaining two-parameter kernel plane has at most ONE
critical-square candidate. The exact fixed-field identity
$qK_3-q_3K_q=[7]\ne0$, where
$K_3=\operatorname{quo}(Zq_3,P)$ and
$K_q=\operatorname{quo}(Zq,P)$, ensures an $e$-unit endpoint above
every leading root, including every zero of the degree-at-most-one
polynomial $b_1$ in the finite quadratic coefficient.
The surviving point, if any, must satisfy all nine leading-zero rows,
the original full-source equations and the global square identity.

See [proof](../../Proofs/cartier_and_spin/admissible_degree_ten_m9_finite_leading_zero_trace_constraint.md).
