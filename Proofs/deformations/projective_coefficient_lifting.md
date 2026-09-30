# Proof: descend the projective branch before removing the center

[Statement](../../Theorems/deformations/projective_coefficient_lifting.md).
The argument first constructs connection lattices; these intermediate
lattices are NOT asserted to preserve integral Frobenius and Verschiebung.
Only after the geometric central obstruction vanishes is the existing
[linear theorem](ramified_rapoport_oper.md) applied.

## Potential tame spin lifting

Let $\mathcal P$ be a projective coefficient on a positive-genus curve
$C$. After a finite coefficient extension and a connected finite étale
double $T\to C$, it has a determinant-one rank-two coefficient
$F$-isocrystal lift. If a coefficient component already has an integral
projective crystalline model with zero special-fiber spin obstruction,
the same assertion holds on $C$ itself, without the geometric double.

Here is the obstruction calculation, including Frobenius. Evaluate a
component on an auxiliary smooth proper lift of $C$, over a strictly
henselian coefficient DVR $A$ with algebraically closed residue field
$k$; put $L=\operatorname{Frac}(A)$. Since $2$ is invertible, spin
lifting is governed by $H^2(C_L,\mu_2)$. Good reduction and
$\operatorname{cd}_2(L)=1$ give
\[
0\to H^1(L,H^1(C_{\overline L},\mu_2))
\to H^2(C_L,\mu_2)\to\mathbf F_2\to0.
\tag{1}
\]
The arithmetic class is killed after a finite coefficient extension.
Pullback along an étale double kills the remaining geometric class,
since it multiplies its degree by two. Such doubles exist for positive
genus. The lift of the bundle carries the unique compatible determinant-one
connection, since the central isogeny induces an isomorphism on Lie algebras.

This connection is convergent. A horizontal projective frame on a
geometric residue disc has spin lifts forming a $\mu_2$-torsor.
On closed subdiscs the Picard group is zero and units have square roots
after prescribing their value at the center. The normalized choices
agree on nested subdiscs and give horizontal spin frames. Thus the
given convergent projective Taylor isomorphism lifts convergently.

In the integral version, zero special-fiber obstruction supplies a spin
bundle on the formal lift. The crystalline stratification lifts uniquely
with its identity on the diagonal: the étale kernel $\mu_2$ has unique
lifts through infinitesimal thickenings. This constructs a spin crystal,
not merely a spin bundle with an arbitrary connection.

Let $r$ be the coefficient residue degree and $E$ the chosen component's
spin connection. Its specified $r$-step projective Frobenius has a
$\mu_2$-torsor of linear lifts. After a further finite coefficient
extension that torsor extends étale over the special-fiber curve.
For degree-one cohomology, good reduction extends the geometric part;
the remaining constant class in $L^*/L^{*2}$ is killed by a ramified
quadratic extension. Frobenius pullback of the resulting finite étale
torsor is canonically itself, with relative twists retained.

If local spin representatives are $U_a$ and
$U_b=\epsilon_{ab}U_a$, the maps
\[
U_a\circ\varphi^{r*}U_a
\tag{2}
\]
glue: their transition signs multiply to
$\epsilon_{ab}\varphi^{r*}\epsilon_{ab}=1$.
They lift the specified $2r$-step projective Frobenius. An unramified
quadratic coefficient extension gives $2r$ components. Place successive
Frobenius pullbacks of $E$ in them and close the cycle by (2). This is
an honest one-step coefficient $F$-isocrystal whose projectivization,
including its arrows, is the original object after scalar extension.
Only the arithmetic and cycle obstructions were removed this way;
a nonzero geometric degree-mod-two class was not.

## A stable connection lattice in some component

A rank-two coefficient $F$-isocrystal of constant determinant connection
and nonconstant Newton polygon, on ANY proper hyperbolic curve, has a
crystalline connection lattice whose reduction $H$ has a positive line
$L$ with nonzero second fundamental form.

Begin with a locally free crystalline lattice, retaining the integral
coefficient action. Coherent lattices can be made reflexive componentwise;
on the regular formal surface a reflexive module is locally free. Its
reduction has degree zero. If its positive Harder--Narasimhan line is
horizontal, replace the lattice $M$ by
\[
M'=\ker(M\to H/L),\qquad
0\to H/L\to\overline{M'}\to L\to0.
\tag{3}
\]
This preserves the crystalline connection. The next positive maximal
line, if present, has degree at most $\deg L$. An infinite constant-degree
tail would identify the successive positive lines and give compatible
horizontal lines on all coefficient thickenings. Formal existence would
then produce a positive-degree line with connection on the proper
characteristic-zero generic fiber. This contradicts its degree zero.
Thus the modifications reach a positive nonhorizontal line, or a
semistable underlying reduction.

In the latter case, if the bundle is not strongly semistable, take its
first unstable Frobenius pullback. Its positive line is not horizontal
for the canonical Cartier connection, since descent would destabilize
the preceding semistable bundle. The actual rational Frobenius identifies
this pulled-back lattice with a lattice in the appropriate component.

Strong semistability is impossible. Normalize every $nr$-step Frobenius
by the integer $a_n$ so that
\[
\pi^{-a_n}\varphi^{nr}:\varphi^{nr*}M\to M
\tag{4}
\]
is integral and nonzero modulo $\pi$. Both reductions are semistable of
degree zero. Every nonzero map between such bundles has constant rank:
the quotient/image slope inequalities remove any torsion defect, and a
rank-two map has degree-zero determinant and is an isomorphism.
Consequently the minimum elementary-divisor valuation of the unnormalized
map is the SAME $a_n$ at every point. The smallest Newton slope at every
point is $\lim_n a_n/(ern)$, where $e=v_\pi(5)$. The determinant fixes
the sum of the slopes, so the Newton polygon would be constant.

Finally the positive nonhorizontal reduction is stable as a connection,
also after every finite étale pullback. Any horizontal line differs from
$L$ and maps nontrivially to the negative-degree quotient $H/L$; it has
negative degree. Étale pullback preserves positivity and the nonzero
second fundamental form. This proves the claimed universal stability.

## Uniqueness of the projective integral model

Suppose two integral projective crystalline models have these universally
stable reductions and a specified rational projective isomorphism.
After an auxiliary étale double, both special-fiber spin classes vanish.
The integral spin argument above gives rank-two lattices $M_1,M_2$.
The rational projective map is a line in their rational Hom bundle.
Saturate it to $\Lambda\subset\operatorname{Hom}(M_1,M_2)$.
A saturated rank-one subsheaf of a locally free sheaf on this regular
surface is reflexive, hence invertible. It is horizontal. Its generic
fiber is a line with connection, so has degree zero; the special fiber
also has degree zero.

Evaluation gives $\Lambda\otimes M_1\to M_2$. Saturation makes its
special-fiber map nonzero. It is horizontal between stable connections
of the same slope, and therefore is an isomorphism. Nakayama gives
an integral projective isomorphism. It is unique with its prescribed
rational restriction. Hence it descends from the auxiliary double,
and all cocycle identities hold automatically.

## Descent through the original maps and the branch

Apply potential spin lifting to $\mathcal P_Y$ on a double $T\to Y$.
Its spin Newton polygon is nonconstant. The lattice construction supplies
a stable connection lattice there. The actual rational projective descent
on $T\times_YT$ extends by uniqueness and descends to an integral
projective crystalline model on $Y$.

Pull it back to the original $Z$. On $Z\times_XZ$ the specified rational
comparison with $\mathcal P_X$ supplies projective descent. Universal
étale stability and uniqueness extend it integrally. Thus the same
model descends to $X$, using no simultaneous Galois source.

Its positive Harder--Narasimhan projective section defines an ordinary
line bundle $N_C$. On a spin cover it is
$L^2(\det H)^{-1}$. The second fundamental form gives
\[
0\ne N_C\to\omega_C,\qquad N_C=\omega_C(-B_C).
\tag{5}
\]
Uniqueness of the Harder--Narasimhan section and compatibility of the
connection make its zeros common:
\[
f^*B_X=g^*B_Y.
\tag{6}
\]
On $Y$, $0<\deg N_Y\le2$, so $\deg B_Y=0$ or $1$. In the latter
case $B_Y=[y]$. Étaleness makes $B_X$ reduced as well, and
Riemann--Hurwitz gives $\deg B_X=g(X)-1$. This is the stated
singleton alternative.

Otherwise both divisors vanish. For a projective bundle represented
geometrically by $\mathbf P(V)$ and a section $A\subset V$,
$N=A^2(\det V)^{-1}$. Thus
\[
w_2(P_C)=c_1(N_C)\pmod2=\deg B_C\pmod2.
\tag{7}
\]
The unbranched case therefore has zero geometric spin obstruction on
both ORIGINAL endpoints. The half-degree twisted-line alternative is
exactly the discarded degree-one branch, not an obstruction silently
removed by coefficient extension.

## Linearization and removal of the source refinement

The integral version of tame spin lifting now gives determinant-one
rank-two coefficient $F$-isocrystals on $X$ and $Y$ after a common
finite coefficient extension. In each component the lifts of their
specified projective comparison on $Z$ form a $\mu_2$-torsor.
After coefficient extension these are finite étale torsors over $Z$.
Choose a connected finite étale $h:Z'\to Z$ trivializing them all.

The resulting linear comparisons have only central sign discrepancies
with Frobenius. They are constant on connected $Z'$. Multiplying the
corresponding arrows on one endpoint by those signs gives compatible
linear coefficient $F$-isocrystals on $X\leftarrow Z'\to Y$,
without changing the original projective arrows or Newton slopes.
Their generic slopes are $(-\delta/2,\delta/2)$; a common constant
normalization changes them to $(0,\delta)$.

The [linear rank-two theorem](ramified_rapoport_oper.md) lifts this refined
span. The existing [source-refinement theorem](etale_refinement_deformations.md)
then lifts the ORIGINAL span. Concretely, lift $f$ uniquely through each
nilpotent thickening of the lifted $X$. On the lifted relation for
$h$, the two maps to the lifted $Y$ agree uniquely: their differences
at a square-zero step lie in sections of the negative line pulled back
from $T_Y$, and hence vanish. Effective descent and proper algebraization
produce both original finite étale maps. This is the final use of a
source cover; no change of endpoint remains in the conclusion.

The construction is the returned Pro proof. The integration reuses
the canonical source-refinement result and records explicitly the
reduced singleton divisor and the actual geometric central class.
No common coefficient is manufactured from a bare correspondence.
