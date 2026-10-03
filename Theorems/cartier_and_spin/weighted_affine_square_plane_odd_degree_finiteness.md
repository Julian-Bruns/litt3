# Odd-degree coordinates give finite weighted affine square-plane support

ID: `weighted_affine_square_plane_odd_degree_finiteness`.
Version2, 2 October2026. The Version1 conceptual finiteness theorem
passed independent whole-implication review. The exceptional-support
recipe and cardinality bound passed a separate focused extension review.
No numerical computation is used.

Let $k$ be algebraically closed of odd positive characteristic,
$C/k$ a smooth connected projective curve and $L=k(C)$.
Let $x\in L$ be nonconstant of ODD degree, $g\in L^*$,
and $H\in L\setminus k(x)$. Then
\[
\{(s,r)\in k^2:g(H+s+rx)\in L^{*2}\}
\]
is FINITE. The weight $g$ need not be a square or have even divisor.
The curve may have arbitrary genus; the plane image of $[1:x:H]$
may be singular or strange, and the map to that image may be inseparable.

There is an explicit geometric support and cardinality bound.
Let $\Gamma$ be the plane image of $[1:x:H]$, let $\bar\Gamma$
be its normalization, and put
$\delta=\deg\Gamma\ge3$, $h=g_{\bar\Gamma}$,
$\nu=[L:k(\Gamma)]$, and
$d=\nu\delta=\deg\max(\operatorname{div}_\infty x,\operatorname{div}_\infty H)$.
Let $q$ be the generic tangent contact of $\Gamma$: it is two
or an odd power of the characteristic.
Let $E$ be the union of the plane images of the support of
$\operatorname{div}g$, the separable branch set of
$C\to\bar\Gamma$, the singular points of $\Gamma$, and its
points at infinity. Write $m=|E|$ and $A_d=1+\lfloor\log_2d\rfloor$.
Then the square-support cardinality is at most
\[
m A_d+T,\qquad
T=\begin{cases}
0,&\delta\text{ odd},\\
(\deg\Gamma^*-1)(\deg\Gamma^*-2)/2,&\delta\text{ even},\ q=2,\\
(q+1)(2h-2)+3\delta,&\delta\text{ even},\ q\text{ odd}.
\end{cases}
\]
Here $\deg\Gamma^*\le\delta(\delta-1)$ in the $q=2$ case,
and the last expression is at most $\delta^2(\delta-2)$.
One may use the source-only upper bound
$m\le2\deg(g)+2g_C-2+2\nu+\delta+(\delta-1)(\delta-2)/2$,
where $\deg(g)$ is its pole degree, zero for a constant weight.

The finite-support recipe consists of the weighted square pencils
on parameter lines through points of $E$, plus singular dual points
when $q=2$, or Gauss images of zeros of the order-$(0,1,q)$
Hasse-Wronskian when $q$ is odd. Every proposed parameter still
requires its square-class test. This is a mathematical recipe,
not an assertion that a source-specific list has been computed.

For the actual m9 critical normalization $C\to X$ of degree three,
$\deg_C x=9$ is odd. Suppose a fixed actual source and fixed moment
data leave the selected-kernel family
$Q_{s,r}=Q_0-dt(s+rx)$, with $d=\delta_3$, and
$Q_0(c)\notin k(x)$.
Then only FINITELY MANY pairs $(s,r)$ satisfy the necessary nonzero
critical square identity $F(c)Q_{s,r}(c)=U(c)^2$.
In particular this applies whenever the fixed first-moment pair
$(n_0,\mu_1)$ is nonzero: the original critical contraction has
degree two or one in $c$, so it is not in $k(X)$.
No condition on $\rho$ is needed for this implication.

For the homogeneous low-trace B0 half stratum on the unit-selected
open, the new nonzero quadratic-trace theorem supplies $n_0\ne0$,
so this decides finiteness of its full two-parameter critical-square
support without any combined-rank14 or generic-source rank assumption.
The abstract bound does not decide source existence or exclude m9.
When selected leading zeros enlarge the second-moment
kernel beyond $tL_3$, that larger family is outside this application.
Both original actual étale maps remain on the same source; the
auxiliary critical normalization does not replace them.

[Proof](../../Proofs/cartier_and_spin/weighted_affine_square_plane_odd_degree_finiteness.md).
