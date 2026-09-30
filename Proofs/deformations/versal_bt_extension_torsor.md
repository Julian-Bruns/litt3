# Proof: local group objects glue as a coherent additive torsor

[Statement](../../Theorems/deformations/versal_bt_extension_torsor.md).
The new issue is extending the actual classification from a
nonempty global fiber to the small etale site without assuming
such a fiber exists. The hypotheses on the actual BT1 remain
in force throughout.

## The coherent Cartier kernel

Use the tame logarithmic character cover and the Cartier-fixed
form $\Omega$ from [the Cartier bridge](versal_bt_cartier_rigidity.md).
The rule in (1) is defined as a rational map of sheaves. Its
output lies in $L$ by the same character and pole calculation
that identifies $H^0(L)$ with a regular differential eigenspace.
The rule
\[
\mathscr C_H(a^5h)=a\mathscr C_H(h)
\]
makes it $\mathcal O_C$-linear on $F_{{\rm abs}*}L$.
Absolute Frobenius here includes scalar Frobenius; a relative
formulation would retain the corresponding coefficient twist.

We verify surjectivity on completed local rings. Off $S$, pass
to the unramified character cover and write $\Omega=b(t)dt$,
with $b$ a unit. For any regular target $g$,
$h=t^4b^4g^5$ satisfies $C(h\Omega)=g\Omega$.
At a point of $S$, write $t=s^2$ on the tame character double
and $\Omega=s^2\nu(t)ds$, with $\nu$ a unit. For any
$g\in t^{-1}k[[t]]$, put
\[
h=t^6\nu(t)^4g(t)^5\in t\,k[[t]].
\tag{7}
\]
Then $h\Omega=s^{14}(g\nu)^5ds$, whose Cartier image is
$s^2g\nu ds=g\Omega$. Thus the map is onto at every completion.
Faithful flatness of completion proves surjectivity on the actual
stalks. Frobenius is finite flat on the smooth curve, so the kernel
$\mathcal B_H$ is a vector bundle of rank four.

For finite Frobenius on a curve,
$\deg F_{{\rm abs}*}L=\deg L+4(g-1)$. Since the quotient is $L$,
$\deg\mathcal B_H=4(g-1)$, and its Euler characteristic is zero.
Moreover $\deg L=4(g-1)>2g-2$, so
$H^1(C,L)=H^1(C,F_{{\rm abs}*}L)=0$. The cohomology sequence of
(2) gives (3). Its kernel on global sections is precisely the
already proved Cartier difference space, with the scalar twist
explicit in the domain of (1).

Finite etale maps give Cartesian squares with absolute Frobenius.
Cartier and the tame character construction commute with their
base change. Therefore $\mathcal B_H$ commutes with every actual
etale pullback, not just Galois covers.

## Actual extensions are locally available and have no automorphisms

The truncation morphism of the algebraic stacks of actual BT groups
is smooth and surjective. See
[Lau, Section1.3, p5](https://arxiv.org/pdf/1006.2723), which states
this consequence of Grothendieck--Illusie for
$\mathrm{BT}_{N+1}\to\mathrm{BT}_N$.
After pulling back along $A_N$ and choosing a smooth presentation,
a smooth surjection of schemes has sections etale locally. Thus
there are actual marked next extensions on an etale cover of $C$.
The last-digit scalar character twist normalizes their determinants
without changing their given BT$_N$ markings.

On a connected etale curve $U\to C$, a normalized marked
automorphism of a next extension is the identity. Indeed, over
its function field the ordinary BT1 is nonsplit after every finite
separable extension: its Kummer logarithmic form is nonzero.
The [generic scalar calculation](versal_bt_display_descent.md)
therefore gives only the scalars $1+5^Na$, $a\in\mathbf F_5$,
for an automorphism trivial on BT$_N$. Its determinant is
$1+2\cdot5^Na$, so determinant preservation forces $a=0$.
Equality of finite-flat Hopf algebra maps holds globally if it
holds generically. This argument uses no properness of $U$.

Consequently the isomorphism-class presheaf is already a sheaf
for the etale topology: local isomorphisms are unique, satisfy
the cocycle, and finite locally free Hopf algebras descend.
There is no residual gerbe automorphism on this site.

## Exact realization remains valid on open etale curves

Let $U\to C$ be a smooth etale curve and suppose a normalized
marked next extension $A$ exists on $U$. Differences define
\[
[B]\longmapsto\Delta_N(A,B)\in
\ker\!\left(\mathscr C_H:
\Gamma(U,F_{{\rm abs}*}L_U)\to\Gamma(U,L_U)\right).
\tag{8}
\]
This is the group of sections $\Gamma(U,\mathcal B_H)$.
Injectivity is the ordinary Kummer comparison and the traitwise
extension theorem; neither requires a proper base.

Here is why surjectivity also survives removal of points. Given
$h$ in (8), use the ordinary Artin--Schreier/Kummer construction
from [exact realization](versal_bt_cartier_realization.md) on
$U-S_U$. Its normalized marked comparisons are unique over this
reduced curve, by the preceding argument, so it gives an ACTUAL
ordinary group there. At each of the finitely many points of
$S_U$, the completed-disc criterion realizes the same $h$ by an
effective integral window relative to $A$.

The generic Kummer comparison identifies the ordinary group and
the disc group over the punctured completed field, because their
actual invariant is the same. Beauville--Laszlo patching of finite
projective modules, together with every Hopf structure map, glues
them on $U$. This patching theorem applies to an affine curve as
well as a proper one; one can perform it on affine neighborhoods
and use the already unique comparisons to glue the neighborhoods.
No condition is imposed at points deleted from $C$. The resulting
group is BT$_{N+1}$ and has the specified marking and determinant
by faithfully flat verification on the ordinary open and the
completed discs. Thus (8) is a bijection.

For a non-quasicompact etale object, work on its quasicompact
opens and use uniqueness to glue. These bijections commute with
restriction and with etale pullback, because the actual invariant
does so. They therefore define a simply transitive action of the
additive sheaf $\mathcal B_H$ on the locally nonempty sheaf of
actual next extensions.

## The absolute class and its geometric meaning

The sheaf just constructed is a torsor under a quasi-coherent
vector bundle. Etale and Zariski degree-one cohomology agree for
this additive sheaf. Thus it has a canonical class (4), is
represented by an affine vector-bundle torsor, and is Zariski
locally trivial. A section over $C$ is exactly an actual extension
class: the unique local group isomorphisms glue it effectively.
This proves (5), not just a necessary cohomology test.

Equivalently choose local actual references and their difference
sections $h_{ij}$. Glue $\mathcal B_H\oplus\mathcal O$ by
\[
(v,c)_j\longmapsto(v+c\,h_{ij},c)_i,
\]
using the chosen torsor sign. This gives (6), with the ends fixed;
its inverse image of $1$ is the extension torsor. This construction
does not give a universal group over a higher-dimensional
parameter space, a claim not needed for the result.

Everything was built from actual group pullback and its invariant.
Hence the extension class and the affine torsor commute with etale
base change. If $q:D\to C$ trivializes the torsor by an actual
next extension $B$, its deck differences are the usual cocycle of
that trivialization. Under the cohomology sequence of (2), this
is exactly the primitive/Carter-image representative described in
[the five-group theorem](bt_p_cover_cartier_obstruction.md), with
the same cocycle sign. This proves the asserted identification of
ACTUAL classes, without identifying them with higher-Witt classes.

Finally, if marked BT$_N$ data agree on the two actual maps of a
span, all the sheaves and their pullback torsors agree there.
Compatible next groups correspond exactly to compatible sections
or splittings. Their existence remains a separate condition.
On an affine curve the coherent $H^1$ vanishes, so the torsor
does have a section. On the original proper curve its possible
obstruction space has dimension $\dim\mathcal K_H$, which need
not be zero. No vanishing of the class itself is inferred from
the torsor construction.
