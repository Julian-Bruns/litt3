# Proof of m3 critical irreducibility

Version2,1 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m3_rational_critical_root_locus.md).
The inputs are the actual coefficient infinity bounds of the
[profile theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md)
and the fixed affine/short translation calculus used in the
[critical coprimality proof](admissible_degree_ten_m3_critical_coprimality.md).
The new finite support and irreducibility implications receive
focused parent review and independent source-agent review; they
require no source enumeration.

Let $c\in K$ satisfy $D(c)=0$. In the finite frame the polynomial
$D_f$ has affine coefficients and the same leading coefficient
$\delta_3$, with root $c_f=c+Z/y$. The cubic root equation shows
that $\delta_3c_f$ satisfies a monic equation with affine
coefficients. Normality of the affine curve therefore makes
$\delta_3c_f$ affine. This conclusion also follows from the
finite valuation leading-term argument and retains every
coefficient drop.

If $c$ had infinity pole at most10, then $\delta_3c$ would have
pole at most13. Subtract the fixed affine polynomial part of
$Z\delta_3/y$ from $\delta_3c_f$. The remaining translation error
has candidate leading gaps17,14,11. Its gap17 must vanish: an
affine function with leading bound17 has bound16. Once it
vanishes, the same argument at14 lowers the affine bound to13
and kills the gap14 coefficient. On $L_3=\langle1,x\rangle$
these two forms have invertible fixed matrix
\[
\begin{pmatrix}[16]&[5]\\[18]&[16]\end{pmatrix},
\qquad \det=[24]\ne0.
\]
Thus $\delta_3=0$, impossible. These are successive LEADING
pole arguments, not assertions that affine functions lack
subleading Laurent terms at gaps.

For a root of pole $r>11$, the cubic term in $D(c)$ has pole
$3+3r$, exceeding $14+2r$, $16+r$, and18. Thus $r\le11$,
so $c$ has exact pole11. Its cubic term has pole36 and can
only cancel with $\delta_2c^2$; consequently $\delta_2$ has
exact pole14 and its leading term equals that of $-\delta_3c$.

Since $\delta_3c$ has pole14, only the gap17 translation form
must vanish. Writing $\delta_3=\kappa(x+a_0)$, the fixed row
gives $[16]a_0+[5]=0$, hence $a_0=[12]$. Literal division
in the fixed field gives
\[
(x+[12])Z=[16]P+R,
\quad R=([9],[8],[6],[11],[8],[5],[13],[22],[5]).
\]
The remainder has degree8 with nonzero leading coefficient[5].
Since $y^3=P$, its quotient $R/y$ has exact infinity pole14.
The affine function
\[
g=(x+[12])c_f-[16]y^2
=(x+[12])c+R/y
\]
has infinity pole at most14, hence belongs to $L_{13}$.
This proves the stated normal form. Conversely every function
of the displayed form has exact short infinity pole11, because
$g$ has pole at most13 while $R/y$ has exact pole14.
The converse concerns the pole and form, not the equation $D(c)=0$.

The numerator of $c_f=([16]y^2+g)/(x+[12])$ is affine.
The literal evaluation $P([18])=[12]\ne0$ shows that
$x+[12]$ has three distinct simple zeros on $X$. Thus the
finite poles are supported at those three unramified points
and are at most simple. There must be at least one: otherwise
$c_f$ would be affine with exact infinity pole17, since its
$[16]y^2/(x+[12])$ term has pole17 and its $g/(x+[12])$ term
has pole at most10. Pole17 is a gap. Equivalently, at this
fiber the numerator is a nonzero quadratic polynomial in $y$
with leading coefficient[16], so cannot vanish at all three
distinct values of $y$.

Now suppose such a root exists and factor
\[
D/\delta_3=(T-c)(T^2+bT+e).
\]
The constant coefficient gives
$e=-\delta_0/(\delta_3c)$, hence $e$ has short infinity pole
at most $18-3-11=4$. The linear coefficient gives
$b=(e-\delta_1/\delta_3)/c$, hence $b$ has pole at most
$\max(4,16-3)-11=2$.

In the finite frame the complementary quadratic coefficient is
$b_f=b-2Z/y$. Every root $r_i$ of $D_f$ has $\delta_3r_i$
integral over the affine ring, since it satisfies the monic equation
\[
Z^3+\delta_{2,f}Z^2+\delta_3\delta_{1,f}Z
+\delta_3^2\delta_{0,f}=0.
\]
The rational function $\delta_3b_f$ is minus the sum of two such
integral roots, so is affine by normality. But $\delta_3b$ has
infinity pole at most five. In
\[
\delta_3b=\delta_3b_f+2(Z/y)\delta_3
\]
the same successive gap17 and gap14 argument forces BOTH
translation forms of $\delta_3$ to vanish. The scalar two is
nonzero in characteristic five, and the fixed $2\times2$ matrix
above is invertible. This contradicts $\delta_3\ne0$.
Thus $D$ has no rational root and, being cubic, is irreducible.
An irreducible cubic in characteristic five is separable.

The earlier squarefreeness conclusion can also be seen directly:
any repeated irreducible factor of a cubic in
characteristic five has degree one: degree two repeated would
already exceed degree three, and an inseparable irreducible
factor would have degree at least five. Thus a nonsquarefree
$D$ would have a repeated rational root $c$. At every rational
root the pole36 cancellation gives the leading relation
$\delta_2\sim-\delta_3c$. Therefore
\[
D'(c)=3\delta_3c^2+2\delta_2c+\delta_1
\sim(3-2)\delta_3c^2,
\]
whose pole is25 and whose leading coefficient is nonzero.
The last term has pole at most16 and cannot cancel it. This
contradicts repeatedness and proves function-field squarefreeness.
Repeated specialized finite critical fibers remain allowed.

Irreducibility makes $\gcd(D,U)$ constant or equal to $D$.
The latter would make $u=U/D$ a polynomial of degree at most two,
excluded by the established
[polynomial-annihilator theorem](../../Theorems/cartier_and_spin/admissible_linear_annihilator_exclusion.md).
This proves critical coprimality while retaining a full cubic
rational denominator.

The literal division and evaluation are reproduced by
[the tiny source script](../../scripts/oct01_annihilator_transfer/m3_rational_root_normal_form.py),
with exact data in
[the external certificate](../../../litt3-computation-data/oct01_local_continuation/annihilator_transfer/m3_rational_root_normal_form.json).
The check ran in less than0.1 seconds on a borrowed idle core,
returned immediately afterward. An earlier incorrect hand
normalization was discarded before this verified record.
