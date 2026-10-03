# Proof: the dormant pair has too large a residue orbit

[Statement](../../Theorems/curve_arithmetic/backup_arithmetic_reduction_exclusion.md).
The [complete atlas reduction](backup_characteristic_zero_atlases.md)
has excluded every nonhyperelliptic complete uniform atlas of a
potential lift of $Y$. Thus an arithmetic candidate $C$ has maximal
hyperelliptic orbifold group $\Delta$ of signature $(0;2^6)$.
Its actual map to that orbifold is Galois of degree two.

## The selected arithmetic place is good

Let $F,B$ be the invariant trace field and quaternion algebra.
The [adjoint component argument](six_cone_arithmetic_residue_filter.md)
defines the orbifold and its canonical adjoint data over an
elementary abelian two-extension $M/F$. The genus-two double cover
is unique geometrically. Thus its moduli point is fixed over $M$.

Choose the place $v$ of $F$ induced by the purported geometric
reduction to $Y$. That curve has exact moduli degree three over
$\mathbf F_5$, so $3\mid f(v/5)$. The general arithmetic genus-two
degree bound is $[F:\mathbf Q]\le10$. The
[local level theorem](six_cone_local_level_filter.md) now gives
\[
f:=f(v/5)\in\{3,6,9\},\qquad B_v\simeq M_2(F_v),
\qquad v\nmid\mathfrak n.
\tag{1}
\]
The ramification index of $F_v$ has not been discarded, nor have
conditions been imposed at its other places over five.

## Actual good covers carrying the arithmetic connection

Choose a sufficiently small normal congruence subgroup of the
orbifold group, with unchanged maximal level at $v$. Its curve
$H$ is an actual finite etale Galois atlas of the generic orbifold.
Carayol's good models at a split maximal place apply with arbitrary
ramification of $F_v/\mathbf Q_5$. The precise form needed here,
including the height-two, dimension-one $\mathcal O_{F_v}$-divisible
group, is recalled in
[Liu--Zhang--Zhang, Section2.2](https://web.math.princeton.edu/~shouwu/publications/pWalds.pdf).
The other finite levels may be made sufficiently small; they are
part of the level away from $v$, including other places over five.
Connected components and all the data in use descend from the
maximal unramified extension to a finite extension.

No assertion that this atlas has degree prime to five is needed.
Form the ACTUAL generic fiber product of $H$ and $C$ over their
orbifold. A connected component $D$ is an etale cover of $H$ of
degree one or two. Prime-to-five specialization gives it good
reduction. Its other projection to $C$ is Galois and etale, with
possibly five-divisible degree. Both curves have good reduction,
so the [Galois good-model theorem](../quotient_geometry/galois_good_reduction.md)
extends this projection as finite etale. We retain both projections
from this same $D$.

On $H$ there is an integral rank-two bundle $\mathcal L$, connection,
and line $\omega^+\subset\mathcal L$. They are the structure-
character eigensubbundle of the integral de Rham module of the
$\mathcal O_{F_v}$-divisible group. The source proves algebraizability
in Lemma2.2.4 and the integral Kodaira--Spencer isomorphism in
Proposition2.2.6. In particular its projectivization is an
unbranched oper on each fiber. On the generic fiber it is the
arithmetic uniformizing projective connection; this identification
also follows from the unitary realization in Section2.5.

Pull this integral projective oper to the good model of $D$.
Every deck comparison for $D\to C$ preserves the specified generic
uniformizing projective connection. Both special pullbacks are
opers, hence are stable as projective connections and stay so
under finite etale pullback. The
[projective lattice uniqueness argument](../deformations/projective_coefficient_lifting.md)
extends each generic comparison uniquely to the integral models.
The comparisons satisfy their cocycle because they do generically.
Finite etale descent therefore gives an integral projective oper
on the good model of the ORIGINAL $C$. No linear spin lift or
congruence description of its surface subgroup was assumed.

## Dormancy, including ramified coefficient fields

Here is the Frobenius check on the fine curve $H$. Put
$K=F_v$, $e=e(K/\mathbf Q_5)$, and $f=f(K/\mathbf Q_5)>1$.
Use the contravariant convention for the Dieudonne module of the
one-dimensional $\mathcal O_K$-divisible group. Its special de Rham
bundle $\mathcal D$ has rank $2ef$, with Hodge line
$\omega_G\subset\mathcal D$. The unramified coefficient subring
decomposes it as
\[
\mathcal D=\bigoplus_{i\in\mathbf Z/f}\mathcal D_i,
\qquad \operatorname{rk}\mathcal D_i=2e.
\tag{2}
\]
The action on $\omega_G$ is the structure character. Index this
component by $0$. The reduced crystalline Frobenius has kernel
$F_H^*\omega_G$, lies between the successive coefficient components,
and has constant total rank $2ef-1$. It follows that
\[
F_H^*\mathcal D_i\longrightarrow\mathcal D_{i+1}
\quad\hbox{is an isomorphism for every }i\ne0.
\tag{3}
\]
In particular the incoming map to $\mathcal D_0$ is an isomorphism,
since $f>1$. It is horizontal for the canonical connection on the
Frobenius pullback. Therefore $\mathcal D_0$ has zero $p$-curvature.
This uses the actual coefficient permutation, not an identification
of relative Frobenius twists.

It remains to check the rank-two eigensubbundle rather than a
possibly nonflat coefficient quotient. The integral module
$\mathcal L$ used above is
\[
\{m\in\mathcal D_{\rm formal}: am=\tau(a)m
\text{ for every }a\in\mathcal O_K\},
\tag{4}
\]
where $\tau$ is the structure homomorphism. It is a locally free
rank-two bundle by the cited construction. It is saturated for
the base uniformizer: if a uniformizer times $m$ satisfies all
equations in (4), then so does $m$, since the ambient module is
uniformizer-torsion-free. Consequently its reduction injects into
the special de Rham bundle. It lands in $\mathcal D_0$ and is
horizontal. Zero $p$-curvature therefore restricts to it.

This argument works for ramified $K$ as well. Locally, the
eigensubbundle can be described by the annihilator of the
coefficient uniformizer minus the base uniformizer; it is not
being replaced by an unjustified direct coefficient quotient.
No large-prime Higgs semistability theorem is used at five.

Thus the oper on $H_0$, its pullback to $D_0$, and its descended
projective oper on $C_0$ are dormant. Dormancy descends because
the latter pullback is finite etale and faithfully flat.

## The special pair retains its small field of moduli

The canonical adjoint automorphic connection on the generic
orbifold is defined with that orbifold over $M$. This can be
obtained from the linear unitary realization and projectivized;
central choices disappear. Its pullback to the unique geometric
double cover defines a generic pair fixed by
$\operatorname{Gal}(\overline{\mathbf Q}/M)$.

The auxiliary good models may use a larger field, but this does
not enlarge the moduli field of their special pair. Compare two
conjugate good models. The generic curve isomorphism extends by
uniqueness of stable reduction. Their integral projective
connections have oper special fibers. Projective lattice uniqueness
extends the specified generic connection comparison, and the unique
Harder--Narasimhan sections preserve their oper reductions.
Consequently specialization of the pair is equivariant under the
decomposition group of $M$ at the selected place.

For $w\mid v$ in $M$, the residue extension has degree at most two,
because $M/F$ is elementary abelian two and its residue Galois group
is cyclic. Hence the geometric moduli degree of the special dormant
pair divides
\[
f(w/5)\mid2f(v/5).
\tag{5}
\]
This comparison uses the prescribed generic connection and its
stable integral extension, not an assertion that every connection
on the special curve has a small field of definition.

## Every dormant pair on the backup has degree fifteen

The [exact dormant calculation](../deformations/frobenius_residue_escape.md)
shows that the entire regular dormant projective-connection scheme
on the specified $Y/\mathbf F_{125}$ is one reduced point of
degree five. The curve itself has exact moduli degree three over
$\mathbf F_5$ and geometric automorphism group $C_2$.

Its hyperelliptic involution acts trivially on every projective
connection. It acts trivially on $H^0(Y,\omega_Y^2)$, with basis
$u^i(du/v)^2$, $0\le i\le2$. Its affine action on the connection
torsor is therefore a translation, which is zero because the
involution has order two in characteristic five.

Any Frobenius isomorphism of a pair must first identify its curve,
so its exponent is divisible by three. After three steps the
remaining action on the five dormant connections is a five-cycle,
and curve automorphisms cannot shorten it. Every dormant pair on
$Y$ consequently has exact geometric moduli degree fifteen.
Equation (5) would imply $15\mid2f$ for $f=3,6,9$, a contradiction.

This excludes the remaining six-cone arithmetic family. Combining
it with the complete atlas theorem excludes every arithmetic
genus-two candidate. Finally a fully liftable coreless finite
etale correspondence in characteristic zero has arithmetic
endpoints by [the established commensurator criterion](liftable_coreless_target_finiteness.md).
Its genus-two
endpoint would give exactly the excluded potentially good curve.
The intrinsically characteristic-five coreless case is unaffected.

## Coefficient consequences on the same original source

Let an actual coreless span with endpoint Y carry the supplied
rank-two rational coefficient data in the statement. The
[ramified lifting theorem](../deformations/ramified_rapoport_oper.md)
constructs the required Y-lattice and lifts BOTH original maps,
contradicting the preceding arithmetic exclusion. No integral
model, coefficient unramifiedness or prescribed gap denominator
is an additional hypothesis.

For the stated projective data,
[projective coefficient lifting](../deformations/projective_coefficient_lifting.md)
gives a full lift or an ACTUAL singleton clump. When singleton
clumps are excluded, only the forbidden lift remains. The theorem
already descends any necessary comparison refinement to the
original source. This argument excludes supplied coefficients;
it does not supply one on an arbitrary span.
