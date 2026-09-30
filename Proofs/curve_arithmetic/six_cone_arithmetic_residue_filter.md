# Proof: the adjoint component field and the unique double cover

[Statement](../../Theorems/curve_arithmetic/six_cone_arithmetic_residue_filter.md).
Only the maximal orbifold is required to be congruence. The double
cover is recovered from its branch divisor, not from a presumed
congruence description of its surface group.

## The arithmetic orbifold has an elementary two component field

Let $B/F$ be the invariant quaternion algebra, split at the selected
real embedding and ramified at all other real embeddings. By Borel's
normalizer theorem, the maximal lattice is the positive projective
normalizer of an Eichler order of square-free level. This is
[Long--Maclachlan--Reid, Theorem3.1 and Lemma4.2](https://web.math.ucsb.edu/~long/pubpdf/genus0_final.pdf).

Put $G=\operatorname{Res}_{F/\mathbf Q}\operatorname{PGL}_1(B)$ and
let $K\subset G(\mathbf A_f)$ be the compact open normalizer of the
completed order. The orbifold $\Delta\backslash\mathbb H$ is the
component represented by the identity in the corresponding adjoint
quaternionic Shimura curve. Its reflex field is the selected copy of
$F$: the cocharacter is nontrivial at exactly that real embedding.

The connected components, with their abelian group structure, are
\[
\Pi_K=G(\mathbf Q)^+\backslash G(\mathbf A_f)/K.
\]
Here this double-coset set is a finite abelian group of exponent two.
To check this directly, use reduced norm modulo squares:
\[
G(\mathbf A_f)\longrightarrow
\mathbf A_{F,f}^{\times}/\mathbf A_{F,f}^{\times2}.
\]
Its kernel is the image of the simply connected norm-one group.
Strong approximation for that group, using the split real place,
identifies $\Pi_K$ with the quotient by the images of $F_+^\times$
and $K$. Thus it is a quotient of an exponent-two abelian group.
The norm-one lifting at finite places and the positive global norm
condition are the usual quaternionic norm and strong-approximation
statements; no odd-order class-group factor survives after quotienting
by the full adelic center.

The canonical-model reciprocity law acts on connected components
by translations through this finite abelian quotient. Consequently
the stabilizer of the identity component cuts out a Galois extension
$M/F$ with elementary abelian two Galois group. The orbifold component
and its order-two stabilizer divisor are defined over $M$. One may
describe the latter without stacks as the branch divisor of a neat
normal level cover; its definition is independent of that level.

The canonical-model and component reciprocity statements used here
are those of [Deligne, Sections2.6--2.7](https://www.jmilne.org/math/Documents/DeligneSV.pdf);
the norm calculation above specializes their component group to this
adjoint quaternionic situation. Passing to the adjoint group is
essential: a smaller linear level can retain an irrelevant cyclotomic
or class-field extension.

## The source moduli descend without assuming a congruence subgroup

Over an algebraic closure the coarse orbifold is $\mathbf P^1$ with
six distinct order-two points. There is exactly one connected double
cover branched at all six, up to isomorphism over that coarse curve.
For example, two rational functions defining such covers have the
same divisor modulo two; their ratio is a square over the algebraic
closure. This is exactly the torsion-free index-two source.

Every element of $\operatorname{Gal}(\overline{\mathbf Q}/M)$ fixes
the orbifold and its unordered branch divisor. It therefore fixes
the geometric isomorphism class of $C$. A possible conic or descent
obstruction to a particular equation does not affect this moduli
statement, and no congruence claim about the surface subgroup enters.

## Potentially good reduction preserves this bound

Let $w$ be the place of $M$ induced by the fixed algebraic $p$-adic
embedding, and let $v$ be its restriction to $F$. Uniqueness of stable
reduction makes specialization of geometric curve isomorphism classes
equivariant under the decomposition group. Since that group fixes
the generic moduli point, the smooth special moduli point is fixed
by the residue Galois group of $M_w$. This uses potential good
reduction of the source only; no extension of the orbifold map is
assumed.

Because $M/F$ is elementary abelian two, its decomposition quotient
by inertia is cyclic of order at most two. Therefore
\[
f(w/p)\mid2f(v/p).
\]
The exact moduli residue degree of $C_0$ divides $f(w/p)$, proving
the bound. The backup has exact degree three by its
[settled arithmetic](../../Theorems/curve_arithmetic/backup_curve_arithmetic.md),
so $3\mid f(v/5)$ is necessary.

This does not enumerate the higher trace fields. In particular,
cubic residue fields do occur in arithmetic tables; the filter is
not a replacement for their evaluation.
