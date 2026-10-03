# Proof: properness turns constant Newton polygons into finite monodromy

[Statement](../../Theorems/shared_tensors/common_companion_jump.md).
The general Newton-jump conclusion does not require corelessness;
clump uniqueness and the selected-pair consequences use it.

## 1. Infinite irreducible coefficients have a Newton jump somewhere

Let $\mathcal L$ be an absolutely irreducible finite-determinant
arithmetic local system on a smooth projective curve $C/\mathbf F_q$.
The companion theorem for curves gives a number field $E$ containing
all Frobenius coefficients and crystalline companions at every
embedding into $\overline{\mathbf Q}_p$.
The companions are absolutely irreducible and have finite determinant.
We use the Abe--Lafforgue theorem in the formulation of
[Krishnamoorthy, Theorem6.5](https://arxiv.org/pdf/1711.04797).

Suppose every such companion has constant Newton polygon on $C$.
A constant-polygon convergent isocrystal has its unique global slope
filtration, by
[Kedlaya, Corollary4.2](https://arxiv.org/pdf/1606.01321).
This filtration respects a coefficient-field action by uniqueness.
On a proper curve the convergent and overconvergent categories
coincide. Absolute irreducibility therefore forces each companion
to be isoclinic. Finite determinant forces its sole slope to be zero.
The use of properness here is essential: on an open ordinary locus,
the slope subobject need not be overconvergent.

All crystalline companions are thus unit-root. The finite-image
criterion of
[Krishnamoorthy, Lemma7.3](https://arxiv.org/pdf/1711.04797)
applies in every rank. One can also see its mechanism directly.
Purity gives complex absolute value one for Frobenius eigenvalues;
companions give valuation zero at every finite place. Each eigenvalue
is consequently a root of unity. Their degrees over $\mathbf Q$
are bounded by $\operatorname{rank}(\mathcal L)[E:\mathbf Q]$, so
only finitely many eigenvalues, hence traces, occur.
Frobenius density and the irreducible finite-trace criterion then
give finite image.

Taking the contrapositive, infinite image supplies a companion
$\mathcal E$ with nonconstant Newton polygon. Its generic polygon
occurs on a dense open. Newton semicontinuity makes the complement
a nonempty finite set of geometric points.

## 2. The two actual maps identify the jump sets

First apply [geometric coefficient descent](geometric_common_coefficients.md).
After a finite extension of constants both endpoint systems are
semisimple arithmetic objects with finite-determinant irreducible
constituents, and the GIVEN geometric source isomorphism is arithmetic.

Choose an infinite-image irreducible constituent on $Y$ and apply
Section1. Form the companions of the whole endpoint systems at the
same embedding of their algebraic Frobenius coefficients. A jump
cannot disappear on taking this direct sum: for every real $t$,
$\sum_\lambda\max(0,t-\lambda)$ over slopes is nonincreasing under
Newton specialization. At least one of these inequalities is strict
for a changed polygon. Adding across constituents preserves that
strict inequality. Thus the full companion $\mathcal E_Y$ has a
nonconstant Newton polygon.

The arithmetic pullback isomorphism
makes their Frobenius characteristic polynomials equal on $Z$.
Thus their pulled-back Newton polygons agree pointwise.
This conclusion uses characteristic polynomials only; irreducibility
of the pulled-back systems is unnecessary.

Newton slopes are normalized by the residue-field degree.
They do not change under extension of a closed point's residue
field. Hence at every geometric point $z$,
\[
\operatorname{NP}(\mathcal E_X)_{f(z)}
=\operatorname{NP}(\mathcal E_Y)_{g(z)}.
\]
The two generic polygons are equal because both maps are surjective.
Write $T_X,T_Y$ for the finite non-generic loci. The equality gives
\[
f^{-1}(T_X)=g^{-1}(T_Y)=S.
\]
The chosen companion makes $S$ nonempty. This is precisely a clump
for the original span after extending the constant field to $k$.
It was not selected in advance as a common puncture set.

For completeness, if only the X-system was initially known to
have infinite image, the Y-system also does. Restriction to a
finite-index subgroup cannot turn an infinite image into a finite
one, and the two restricted representations are isomorphic.

## 3. One clump synchronizes all Newton exceptions

Assume the geometric span is coreless.
The [one-clump theorem](matched_section_rings.md) identifies every
nonempty exceptional set produced in Section2 with the same $S$.
For a fixed companion, the subset where its polygon is one
specified exceptional polygon is itself saturated under both maps.
It is therefore a clump if nonempty. Two different exceptional
polygons would give disjoint nonempty clumps, which is impossible.

Thus all nonconstant companion stratifications have one generic
and one exceptional polygon, with the same exceptional support.
This proves the asserted all-rank restriction.

## 4. Rank two: remove all trace-field conditions

Assume the compatible arithmetic objects are absolutely irreducible
of rank two, finite determinant and infinite image. Section1 gives
a companion with nonconstant Newton polygon. Its generic slope
gap satisfies $0<\delta\le1$ by the rank-two slope bound. A constant
rank-one twist makes its generic slopes $(0,\delta)$; enlarging the
finite coefficient field to realize this twist is harmless now.
Newton specialization and the constant determinant slope put all
its slopes in $[0,\delta]\subseteq[0,1]$.

These are the same companion and normalization steps used in the
[unramified proof](../deformations/unramified_bt_genus_two.md).
No descent to the minimal trace completion is needed here: any
finite coefficient field on which the two objects and their
source isomorphism are defined may be used.

At a nongeneric point both slopes are strictly between $0$ and
$\delta$. This also shows that a pullback to a connected finite
étale cover stays irreducible: a rank-one subobject would have
constant slope, equal generically to $0$ or $\delta$, inconsistent
with that fiber. Companion uniqueness therefore identifies the
actual source pullbacks. After a finite coefficient extension
the isomorphism is defined over that same coefficient field.

The [ramified rank-two lifting theorem](../deformations/ramified_rapoport_oper.md)
applies directly to these supplied compatible rational coefficients.
Its coefficient-preserving lattice, maximum-height oper and
one-endpoint descent supply the full lift of BOTH original maps.
An integral model on the other endpoint need not be supplied.
No trace-field residue degree or ramification condition is used.

## 5. The selected pairs have only finite common coefficients in rank at most two

For the main pair, the established
[mixed-characteristic exclusion](../curve_arithmetic/liftable_coreless_target_finiteness.md)
rules out the lift in Section4. For the backup, its
[cored-span exclusion](../quotient_geometry/endpoint_exclusions/backup_cored_span_exclusion.md)
first makes every hypothetical selected span coreless. The later
[complete arithmetic exclusion](../curve_arithmetic/backup_arithmetic_reduction_exclusion.md)
then rules out that SAME full lift. Thus neither selected pair
admits the infinite-image absolutely irreducible rank-two case.

It remains to handle reducible semisimple geometric systems of rank
at most two. After the constant extension in
[normalized arithmetic descent](geometric_common_coefficients.md),
their arithmetic and geometric monodromy identity components coincide
and are semisimple. A semisimple representation with only
one-dimensional constituents has diagonal, hence abelian, geometric
monodromy. Its connected semisimple identity component is therefore
trivial. The geometric monodromy is finite, as claimed.

These are restrictions on SUPPLIED compatible arithmetic-origin
coefficients. Finite-image systems and higher-rank infinite systems
are not excluded, and no coefficient is constructed from a bare span.
