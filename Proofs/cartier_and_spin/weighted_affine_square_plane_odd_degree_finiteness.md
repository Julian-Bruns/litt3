# Proof of finite odd-degree weighted square-plane support

Version2, 2 October2026. The Version1 finiteness argument below
passed independent whole-implication review. Its new quantitative
addendum follows the actual-source application.
This proof separates the fixed weight,
generic plane intersections and positive-characteristic contact.
It proves the plane-geometry facts used below directly. Primary
corroboration is Kaji, *On the Gauss maps of space curves in
characteristic p*, Compositio Mathematica70(1989), pp177–197:
[Corollary2.2, p180, and the proof/remark on p181](https://www.numdam.org/item/CM_1989__70_2_177_0.pdf).
The former applies to a birational curve morphism, without assuming
its plane image smooth; the latter distinguishes contact two from
inseparable generic contact. No smooth-plane special case is presumed.

## Constructible support and affine lines

Choose a fixed effective divisor $D$ bounding the poles of
$gH,g,gx$. If $g(H+s+rx)=u^2$, then $u$ belongs to the fixed
finite-dimensional space $H^0(C,\lfloor D/2\rfloor)$.
The coefficient identity defining $u^2=g(H+s+rx)$ is a finite
system of polynomial equations in $s,r$ and the coordinates of $u$.
Its image in $\mathbb A^2$ is constructible. All values are nonzero,
since $H\notin k(x)$. Thus an infinite support contains a dense
open subset of an irreducible positive-dimensional curve $B$;
if its closure has dimension two, intersect its dense open with
a suitable affine line to obtain such a curve.

No affine line contains infinitely many support points. Indeed,
write it as $(s,r)=(s_0,r_0)+\theta(a,b)$, $(a,b)\ne(0,0)$.
The square condition is a weighted constant-parameter pencil
\[
g(a+bx)\left(\theta+\frac{H+s_0+r_0x}{a+bx}\right)\in L^{*2}.
\]
Its ratio is nonconstant, since constancy would put $H$ in $k(x)$.
The accepted [constant square-support lemma](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_critical_square_pencil_finite_support.md)
therefore gives finite support on this line. Hence $B$ must be
a NONLINEAR curve in the affine parameter plane.

At its generic point the identity is a square after a finite
extension of the parameter function field: the coefficient variety
above dominates $B$. Consequently divisor parity can be tested
after an algebraic closure of that field.

## Odd pullback degree removes the fixed weight from moving intersections

Let $\Gamma\subset\mathbb P^2$ be the irreducible plane image
of $[1:x:H]$, with plane coordinates $[z_0:z_1:z_2]$.
It is not a line: a linear dependence of $1,x,H$ would put $H$
in $k(x)$. Put $K=k(\Gamma)=k(x,H)$ and
$\nu=[L:K]$. The tower formula
$\deg_C x=\nu[K:k(x)]$ makes $\nu$ ODD.
The normalization map $C\to\bar\Gamma$ factors into a purely
inseparable map and a separable map. Outside the finite separable
branch set, all pullback ramification indices equal the purely
inseparable degree, an ODD power of the characteristic.

The parameter $(s,r)$ represents the plane line
$z_2+r z_1+s z_0=0$. Since $B$ is nonlinear, its generic line
avoids ANY prescribed finite set of plane points: containing one
fixed point imposes a linear equation on $(s,r)$ and cannot hold
identically on $B$.
In particular it avoids the singular points of $\Gamma$, its
points at infinity, the images of the separable branch points,
and the images of the zero and pole support of $g$ on $C$.
Every intersection is therefore a moving smooth affine point,
and $g$ is a unit at every preimage.

The square condition forces all pullback intersection multiplicities
to be even. Their ramification multiplier is odd, so ALL original
intersection multiplicities of the generic line with $\Gamma$
are even. In particular the line is tangent to $\Gamma$.
Thus $B$ is contained in its irreducible dual curve $\Gamma^*$,
and, being a curve, is dense in that dual. The dual cannot be a
line, since that would make $B$ linear, already excluded.
This treats strange curves rather than silently assuming them absent.

## Plane contact and the separable Gauss field

We now prove the needed generic plane-curve facts in odd characteristic.
Choose affine plane coordinates $u,v$ on $\Gamma$ with $du\ne0$;
such a choice exists because $K=k(u,v)$ and $k$ is perfect.
The rational coordinate $u$ is separating, and its Hasse derivatives
$D^{(j)}$ extend uniquely to $K$. At a generic smooth point,
$u-u(P)$ is a uniformizer. Its tangent has contact
$\epsilon=\min\{j\ge2:D^{(j)}v\ne0\}$.
This minimum exists since the plane image is not a line.

If $D^{(2)}v\ne0$, the generic contact is exactly two.
Put $M=Dv$, $N=v-uDv$. These are the slope and intercept
coordinates of the Gauss map. Then
$DM=2D^{(2)}v\ne0$ and $DN=-uDM$.
The extension $K/k(M)$ is separable, so differentiating $N$
with respect to $M$ inside $k(M,N)$ gives
$dN/dM=-u$. Thus $u\in k(M,N)$ and
$v=N+uM\in k(M,N)$. The Gauss map is BIRATIONAL onto its image.
This argument uses the normalized function field and remains valid
for singular plane images.

If $D^{(2)}v=0$, $D(Dv)=0$ because two is invertible.
The kernel of $D$ is $K^p$, and $1,u,\ldots,u^{p-1}$ is a
basis of $K$ over $K^p$. Expanding $v$ in this basis shows
\[
v=a^p+u b^p.
\]
All Hasse derivatives of orders two through $p-1$ vanish, and
$D^{(p)}v=(Da)^p+u(Db)^p$.
If that derivative is zero, $u\notin K^p$ forces
$Da=Db=0$, so $v\in K^{p^2}+uK^{p^2}$.
Inductively, if $v=a^{p^e}+u b^{p^e}$, then all orders between
two and $p^e-1$ vanish and
$D^{(p^e)}v=(Da)^{p^e}+u(Db)^{p^e}$.
Vanishing again raises the exponent. This cannot continue forever:
it would give $Dv\in\bigcap_eK^{p^e}=k$ and
$v-uDv\in\bigcap_eK^{p^e}=k$, making $\Gamma$ a line.
Therefore its generic contact is some $p^e$, which is ODD.

## Even intersections force a conic and contradict the odd coordinate degree

Because $B$ is dense in $\Gamma^*$, its generic line is a generic
tangent. Its contact cannot be odd, as all intersection multiplicities
were even. Hence the generic contact is two and the Gauss map is
birational by the preceding calculation.
The generic tangent thus has just ONE point of tangency. Every
other intersection is transverse: a second multiple intersection
at a smooth point would give a second point in the generic Gauss
fiber. All intersections avoid the finite singular and infinity
exceptional set. Therefore the condition that EVERY intersection
multiplicity is even forces $\deg\Gamma=2$.

An irreducible plane conic over algebraically closed $k$ is smooth.
The rational coordinate $x=z_1/z_0$ is its projection from
$P=[0:0:1]$. If $P\notin\Gamma$, the projection has degree two,
so $\deg_C x=2\nu$ is even, contrary to the hypothesis.
If $P\in\Gamma$, it has degree one; then $K=k(x)$ and
$H\in k(x)$, again contrary to the hypothesis.
The supposed infinite square support is impossible, proving finiteness.

## Actual m9 application and precise limits

For the auxiliary critical normalization, $[L:k(X)]=3$ and
$[k(X):k(x)]=3$, hence $\deg_C x=9$. The original incidence
has the exact critical contraction
\[
Q(c)=v\rho^2-d(n_0c^2+\mu_1c+\mu_2)
-\delta_2(n_0c+\mu_1)-\delta_1n_0.
\]
Changing only the selected-kernel second moment gives
$Q_{s,r}=Q_0-dt(s+rx)$.
Take $g=-F(c)dt$ and $H=-Q_0(c)/(dt)$; their weighted square
condition is exactly the original necessary critical square.
If $n_0\ne0$, its polynomial in $c$ has degree two;
if $n_0=0,\mu_1\ne0$, it has degree one.
Since the critical cubic is irreducible, either nonzero first-moment
pair makes $Q_0(c)\notin k(X)$ and thus $H\notin k(x)$.
The added $v\rho^2$ term has degree zero in $c$ and does not
change this argument. Therefore the finiteness implication is valid
for arbitrary fixed $\rho$ whenever this two-parameter family and
a nonzero first-moment pair are supplied by the actual-source model.

In the homogeneous low-trace half stratum with $d$ unit on the
selected divisor, the original finite compatibility leaves precisely
the kernel $tL_3=t\langle1,x\rangle$, and
[nonzero quadratic trace](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_homogeneous_B0_nonzero_quadratic_trace.md)
supplies $n_0\ne0$. Thus the theorem applies to its whole remaining
critical square PLANE for each fixed compatible source.
This is finiteness, not emptiness. It does not decide the remaining
source locus or justify replacing
either original étale source map by an auxiliary map.

## Version2: exact exceptional support and a quantitative bound

Retain the general notation $\Gamma,\bar\Gamma,\nu$ above and set
$\delta=\deg\Gamma$, $h=g_{\bar\Gamma}$.
Let $\mathcal L$ be the pullback of $\mathcal O_\Gamma(1)$ to
$\bar\Gamma$, a basepointfree degree-$\delta$ plane linear series.
Its further pullback to $C$ is represented by the pole divisor
$D=\max(\operatorname{div}_\infty x,\operatorname{div}_\infty H)$.
The sections $1,x,H$ have no common base point after this pole
divisor is absorbed. Thus $d=\deg D=\nu\delta$.
The conic argument above already shows $\delta\ge3$.

Choose the finite plane set $E$ exactly as in the statement.
For a point $P=[a:b:c]\in E$, the parameter equation
$c+br+as=0$ is an affine line unless $a=b=0$; in the latter case
it has no solutions. Every such affine line gives a constant-parameter
weighted square pencil. Its ratio is a ratio of TWO sections of
the degree-$d$ basepointfree series on $C$, so its degree is at most
$d$ (common zeros only decrease it). Its ratio is nonconstant,
as in the line argument above. The accepted pencil bound gives at
most $1+v_2(N)\le1+\lfloor\log_2d\rfloor=A_d$ actual square
parameters on that line. Counting all $m$ lines, even with overlaps,
there are at most $mA_d$ support points whose plane lines meet $E$.

For every remaining support point, all intersections with $\Gamma$
are smooth affine points away from branch and weight support.
Odd pullback indices give even intersection multiplicities exactly
as above. If $\delta$ is odd, their sum cannot equal the odd
degree $\delta$; there are NO remaining parameters.

Suppose $\delta$ is even and generic contact is $q=2$.
The Gauss map $\bar\Gamma\to\Gamma^*$ is birational and hence
is the normalization morphism of the dual curve.
If a candidate dual point were smooth, this morphism would be an
isomorphism locally at its unique preimage. Thus it has nonzero
differential there. A tangent contact greater than two at a smooth
plane point makes both slope and intercept derivatives vanish,
contradicting that local isomorphism. Its unique point of tangency
therefore has contact exactly two. Any second multiple intersection
would give another preimage of the same smooth dual point, also
impossible. The other intersections would be transverse and odd,
unless $\delta=2$, already excluded. Every candidate avoiding $E$
therefore lies at a SINGULAR point of $\Gamma^*$.

An irreducible degree-$\delta^*$ dual plane curve has at most
$p_a(\delta^*)=(\delta^*-1)(\delta^*-2)/2$ singular points:
each consumes at least one unit in its genus drop.
The polar linear series defining the Gauss map has degree at most
$\delta(\delta-1)$ before its fixed base divisor is removed.
Since this Gauss map is birational, $\delta^*\le\delta(\delta-1)$.
This proves the stated classical bound and gives the witness recipe:
compute the singular dual points, retain those in the affine chart
of the parameter family, then perform the original square-class test.

## The nonclassical Hasse-Wronskian bound

Suppose the generic tangent contact is an ODD power $q$ of $p$.
For a local frame of $\mathcal L$, write its three sections as
regular functions $f_0,f_1,f_2$ and choose a local parameter $t$.
The determinant of the Hasse-derivative rows of orders $(0,1,q)$
is a local expression of a NONZERO global section
\[
\mathcal W\in H^0\!\left(\bar\Gamma,
\mathcal L^3\otimes\omega_{\bar\Gamma}^{q+1}\right).
\]
Here is the change-of-coordinate justification. By generic contact
$q$, every determinant of rows $(0,1,j)$ with $2\le j<q$
vanishes identically. Since rows zero and one are generically
independent, all such intermediate rows lie in their span.
Under a parameter change, the order-$q$ chain rule gives its
leading row multiplied by $(dt/du)^q$, plus lower rows; wedging
with rows zero and one kills those extra rows. The order-one row
contributes $dt/du$. A common change of local frame contributes
the third power of its multiplier; all derivative terms of that
multiplier likewise wedge to zero. These are exactly the transition
rules for $\mathcal L^3\otimes\omega^{q+1}$.
Local sections and their Hasse derivatives are regular, so the
zero divisor $R=\operatorname{div}\mathcal W$ is EFFECTIVE and
\[
\deg R=3\delta+(q+1)(2h-2).
\]
No finite-field Frobenius divisor or rational-point estimate is
being invoked here.

At a smooth plane point with tangent contact $j$, the adapted
local section orders are $(0,1,j)$ and $j\ge q$; a smaller
contact would make one of the identically zero lower minors
nonzero at that point. In the determinant of rows $(0,1,q)$,
the valuation of every summand is at least $j-q$. Thus
$\operatorname{ord}_P R\ge j-q$.
If a tangent has even contact, $j$ cannot equal the odd $q$;
it lies in the support of $R$ with weight at least one.

Every candidate line avoiding $E$ has an even tangency at a smooth
plane point, so it is the Gauss image of at least ONE point in
$\operatorname{supp}R$. Different tangent lines need not give
different zero points in the reverse direction, but each point
has just one tangent line; the number of such lines is therefore
at most $\deg R$. This gives both the stated nonclassical bound
and its finite witness recipe. It includes strange curves: no
separability or nonlinear-dual assumption is made in this step.

By Bézout $q\le\delta$, and $h\le p_a(\delta)$.
If $h\ge1$, substitution gives
$\deg R\le(\delta+1)((\delta-1)(\delta-2)-2)+3\delta
=\delta^2(\delta-2)$.
If $h=0$, the expression is $3\delta-2(q+1)$;
for $\delta\ge3,q\ge3$ it is again at most
$\delta^2(\delta-2)$. Thus the same crude cubic bound holds
without incorrectly reversing an inequality when $2h-2<0$.

## Counting the fixed exceptional set and the exact scope of the recipe

Write $g_C=g(C)$ and $b=\deg(g)$, with $b=0$ for constant $g$.
Its zero and pole support has at most $2b$ points.
The separable part of $C\to\bar\Gamma$ has degree
$\nu_s\le\nu$; the intervening Frobenius twist retains genus
$g_C$. Riemann–Hurwitz bounds its branch-point count by its
different degree
$2g_C-2-\nu_s(2h-2)\le2g_C-2+2\nu$.
The singular-point count of $\Gamma$ is at most $p_a(\delta)$,
and the number of its points at infinity is at most $\delta$.
Taking images and unions only decreases these counts, so
\[
m\le2b+2g_C-2+2\nu+\delta+p_a(\delta).
\]
This proves the complete quantitative statement.

To obtain the finite support for a GIVEN curve and weight, compute
the displayed exceptional set and its parameter-line pencils,
then add the singular dual points or the Gauss images of
$\operatorname{supp}R$, as appropriate. On each exceptional line,
the accepted pencil procedure provides a finite divisor-parity
support, whose actual square classes must still be tested.
The cardinality bound above counts ACTUAL square parameters, not
all intermediate parity proposals. No source-specific list, square
test or polynomial elimination has been executed here. This
Version2 refinement does not change the original actual-source
or common-cover exclusion scope.
