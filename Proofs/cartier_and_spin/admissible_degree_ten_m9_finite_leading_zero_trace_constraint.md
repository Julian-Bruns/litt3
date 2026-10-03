# Proof of the finite leading-zero trace constraints

ID: `admissible_degree_ten_m9_finite_leading_zero_trace_constraint`.
Version3, 2 October2026. No program or numerical calculation is used.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_finite_leading_zero_trace_constraint.md).

## Actual finite lattice and the exact cancellation

Use the actual source and critical square from
[the sign-norm theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_critical_sign_norm_cone.md).
The finite coefficients and all finite moments $n_j$, $0\le j\le5$,
are affine regular by
[critical incidence](admissible_critical_quadratic_incidence.md).
This includes selected points and zeros of primitive content. Explicitly,
$\operatorname{div}\xi=E+5G-10H$, and the finite primitive $w$ has
pole order $g_i$ only at $G$; hence $\xi w^j$ is finite regular for
$j\le5$, and the actual étale trace is regular. At every ordinary
point the short remainders also have unit denominator $P(x)$ and
$a_s=Z/y$ is regular. Thus $t$ need not be a unit for the local trace
assertions. These facts use the original coefficient lattice.
All ten original roots are distinct Laurent series over the base
uniformizer, because the original source is primitive and étale.

The critical equation gives the EXACT identity
\[
Q_f(c)=-dn_2+(fn_1+hn_0)/c+hn_1/c^2.
\]
Indeed the $n_0$ contribution is
$-n_0(dc^2+ec+f)=hn_0/c$, and the $n_1$ contribution is
$-n_1(dc+e)=fn_1/c+hn_1/c^2$.
This is the cancellation needed below; regularity of the separate
terms of the original expression would not suffice.

## Unit quadratic coefficient and arbitrary odd leading order

Let $r$ be the base uniformizer, $d=d_a r^a+\cdots$, $d_a\ne0$,
and $e=e_0+\cdots$, $e_0\ne0$. The reciprocal equation
$d+e\zeta+f\zeta^2+h\zeta^3=0$ has a simple integral root
$\zeta=-d/e+O(d^2)$. Thus the corresponding critical branch is
unramified, $c=\zeta^{-1}$ has pole $a$, and
$\beta=r^a c$ has nonzero residue $\beta_0=-e_0/d_a$.

Put $m=\operatorname{ord}_P v\ge0$. If $m<2a$, the $v c^{10}$
term dominates and $F(c)$ has exact pole $10a-m$.
For $0<m<2a$, the high Newton edge of the ORIGINAL source polynomial
joins $(8,0)$ to $(10,m)$; the degree-nine point $(9,a)$ is strictly
above it. Exactly two original source roots have pole $m/2$.
Their Laurent valuations are integral, so $m$ is even. The case $m=0$
already has even pole $10a$.

If $m>2a$, the two terms of largest pole have leading sum
\[
\beta_0^8(d_a\beta_0/4+e_0/3)=\beta_0^8e_0/12\ne0.
\]
Thus $F(c)$ has exact even pole $8a$.

For $m=2a$, normalize the ORIGINAL source polynomial by
$G(z)=r^{8a}F(r^{-a}z)$. It is integral with unit leading coefficient,
and its reduction is
\[
\bar G(z)=z^8K(z),\qquad
K(z)=v_{2a}z^2+(d_a/4)z+e_0/3.
\]
The critical equation implies $G'(\beta)=0$. If $K(\beta_0)\ne0$,
the critical value again has pole $8a$. Otherwise
$K'(\beta_0)=0$, so this is an exact double root of $K$.
The ten normalized ORIGINAL roots are integral Laurent series;
exactly two have residue $\beta_0$, while the other eight have
residue zero. Factor out this actual pair. The arbitrary-contact
pair lemma proved in
[the sign-norm proof](admissible_degree_ten_m9_critical_sign_norm_cone.md)
says $G(\beta)$ has even order. It uses only the critical derivative,
the integral actual split pair, and a unit cofactor. Subtracting
the even normalization shift $8a$ preserves parity.
Therefore $F(c)$ has even order in every case.

The exact reciprocal cancellation now gives
\[
\left.(Q_f(c)/d)\right|_P
=-n_2(P)-(f(P)n_1(P)+h(P)n_0(P))/e(P).
\]
If this residue were nonzero, $Q_f(c)$ would have exact odd order
$a$, contradicting the square $F(c)Q_f(c)$. This proves the first
assertion and its forced parameter line.

## The two boundary cases at a simple leading zero

Suppose $\operatorname{ord}_P d=1$ and $e(P)=0$.
If $f(P)\ne0$, the reciprocal critical polynomial has an edge of
width two and slope $1/2$. In characteristic five it gives one
auxiliary branch of ramification index two, on which $c$ has pole
one in its own uniformizer. No étaleness of this auxiliary branch
is asserted.

The original source polynomial has a unit degree-seven coefficient,
degree-eight coefficient of positive order, and degree-nine coefficient
of order one. If $m=\operatorname{ord}v=1$, its high edge from
degree seven to degree ten forces three original poles $1/3$.
If $m\ge2$, its edge from degree seven to degree nine forces two
original poles $1/2$. Both contradict original Laurent splitting.
Consequently $m=0$. The critical value $F(c)$ then has exact pole
ten in the auxiliary uniformizer, an even integer.

Let $R=fn_1+hn_0$. If $R(P)\ne0$, the exact contraction has
$R/c$ of order one; $hn_1/c^2$ has order at least two and $dn_2$
has order at least two on this auxiliary branch. Thus $Q_f(c)$
has odd order one, a contradiction. Hence $R(P)=0$, which is the
required trace row when $e(P)=0$.

If also $f(P)=0$ but $h(P)\ne0$, the reciprocal critical edge has
width three and slope $1/3$. The auxiliary branch has index three
and $c$ has pole one in its own uniformizer. Here a positive order
of $v$ forces four original poles $1/4$ when $m=1$, or three original
poles $1/3$ when $m\ge2$: the relevant original edges are respectively
degree six to ten and degree six to nine. Thus again $v$ is a unit,
and $F(c)$ has even pole ten. If $n_0(P)\ne0$, the term $hn_0/c$
has order one, whereas $fn_1/c$ has order at least four,
$hn_1/c^2$ has order at least two, and $dn_2$ has order at least
three. This contradicts the square. Therefore $n_0(P)=0$ and the
trace row holds. Finally, if $e(P)=f(P)=h(P)=0$, the asserted row
is already zero. These cases exhaust the boundary.

## Exact character equations and parameter-plane consequence

Let $d$ be squarefree and coprime to $P$. Its three roots each have
three distinct ordinary points on $X$. The preceding trace row holds
at all nine points, so it vanishes in the reduced algebra
$\mathcal A=(k[x]/(d))[y]/(y^3-P(x))$.

For an explicit coefficient recipe, write in this algebra
$e=e_0+ye_1+y^2e_2$, $f=f_0+yf_1+y^2f_2$,
$h=h_0+yh_1+y^2h_2$, and similarly
$n_1=a_0+ya_1+y^2a_2$, $n_2=b_0+yb_1+y^2b_2$.
In the homogeneous B0 application $n_0=\lambda q_3$ is a polynomial.
The nine scalar constraints are exactly the three congruences modulo $d$
\[
e_0b_0+P(e_1b_2+e_2b_1)+f_0a_0+P(f_1a_2+f_2a_1)+h_0n_0=0,
\]
\[
e_0b_1+e_1b_0+Pe_2b_2+f_0a_1+f_1a_0+Pf_2a_2+h_1n_0=0,
\]
\[
e_0b_2+e_1b_1+e_2b_0+f_0a_2+f_1a_1+f_2a_0+h_2n_0=0.
\]
No division by an endpoint value of $e$ is made here. For an actual
source these equations are linear in its moment coefficients when
its source coefficients are fixed.

Finite and short variables obey $T_f=T_s+a_s$,
$n_1=\mu_1+a_sn_0$, $n_2=\mu_2+2a_s\mu_1+a_s^2n_0$.
Modulo $d$ the critical coefficients obey
$e=\delta_2$, $f=\delta_1-2a_s\delta_2$,
$h=\delta_0-a_s\delta_1+a_s^2\delta_2$.
Substitution proves
$en_2+fn_1+hn_0=\delta_2\mu_2+\delta_1\mu_1+\delta_0n_0\pmod d$.
Thus short-frame rational remainder terms remain in the exact
congruences; they are not replaced by affine parts.

At a selected simple leading zero, the established ordinary selected
constant row is $d\mu_2+\delta_2\mu_1+\delta_1n_0=0$, and
$\delta_0=0$ there. Combine its specialization with the new row.
For a unit $\delta_2$, eliminating $\delta_1$ gives exactly
$n_0\mu_2=\mu_1^2$.

Changing $\mu_2$ by $t(s+rx)$ changes $n_2$ by the same amount.
At a good endpoint the trace row therefore gives precisely the
parameter line in the statement. Distinct $x$ coordinates make two
such lines nonparallel and leave at most one point. Equal $x$
coordinates with unequal constants make the lines disjoint.
This narrows the necessary square support for each fixed source;
it does not decide whether any source supplies the surviving point.

## Uniform both-strata single-candidate corollary

In BOTH B0 infinity strata the actual finite coefficient lattice gives
$e=A+yb_1-3y^2K_d$, $K_d=\operatorname{quo}(Zd,P)$, with
$\deg b_1\le1$. The bound $\delta_2\le13$ kills its proper short
remainder gaps seventeen and fourteen, forcing the same leading
pencil $d\in\langle q,q_3\rangle$; its exact pole nine forces a
nonzero $q_3$ coefficient. The half stratum further makes $b_1$
constant, but the following argument does not need this improvement.
Use the accepted fixed polynomials
$q=([13],[18],[24])$ and $q_3=([1],[22],[9],[1])$.
Here $[a+5b]=a+b\beta$, $\beta^2=\beta+3$, and tuples are in
increasing coefficient order. Their small exact quotient data are
\[
K_q=([22],[15]),\qquad K_3=([20],[13],[16]).
\]
Direct multiplication in this field gives
\[
qK_3=([4],[2],[1],[21],[15]),\qquad
q_3K_q=([22],[2],[1],[21],[15]),
\]
and hence $qK_3-q_3K_q=[7]\ne0$. These displayed products are
a complete small arithmetic certificate; no source-space matrix
or parameter enumeration is used. The quotient $K_3$ is recorded
in the accepted [fixed-leading coefficient proof](admissible_degree_ten_m9_zero_moment_denominator_exclusion.md).
The candidate $K_q$ is also verified from this identity: writing
$Zq_3=PK_3+R_3$, one obtains
$q_3(Zq-PK_q)=P[7]+qR_3$.
The right side has degree at most eleven, so $Zq-PK_q$ has degree
at most eight, strictly less than ten. Thus $K_q$ is the actual
Euclidean quotient, without needing another calculation.

For arbitrary actual scale $d=pq_3+rq$, $p\ne0$, quotient linearity
gives $K_d=pK_3+rK_q$ and
$qK_d-dK_q=p[7]\ne0$. Thus $d$ and $K_d$ have no common root,
including at repeated, selected and branch leading parameters.
At an ordinary leading root $s$, the coefficient of $y^2$ in $e$
is therefore nonzero. Its quadratic polynomial cannot vanish at
all three distinct cubic-sheet values. There is an $e$-unit endpoint
over EVERY ordinary leading root. Whenever $b_1(s)=0$ there are
at least two, since the three $y^2$ values are distinct.

If $d$ is squarefree and coprime to $P t$, choose good endpoints
over two of its distinct roots. The two forced parameter lines
intersect in at most one point. Every square candidate must be that
point and must additionally satisfy every other endpoint row and
the global square. The pole-thirteen stratum's additional infinity
row can only reduce this support. The actual scale $p$ was retained throughout,
and neither original source map nor target coordinate was changed.
