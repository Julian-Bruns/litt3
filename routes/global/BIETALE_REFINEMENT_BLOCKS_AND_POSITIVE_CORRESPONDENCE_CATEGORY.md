# Refinement blocks and a positive category of actual bi-etale correspondences

Date: 2026-09-05. Status: author proofs of structural statements; not a
solution of Litt3 and not independently audited. These statements organize
actual maps of curves, rather than hypothetical group isomorphisms.
No novelty claim is made for the standard correspondence algebra.

Work over an algebraically closed field. Curves are smooth, projective,
connected, and have genus at least two.

## 1. The exact connected components of the refinement category

Fix curves \(X,Y\). An object is a connected finite bi-etale span
\[
s=(X\xleftarrow f Z\xrightarrow g Y).
\]
A morphism between objects is a morphism of sources commuting with both
maps. Such a morphism is finite etale and surjective: it is a morphism
between connected finite etale covers of \(X\).

Let \(\Gamma_s\subset X\times Y\) be the reduced image, and let \(C_s\) be
its normalization. There are finite etale maps
\[
Z\longrightarrow C_s\longrightarrow X,Y.
\]
Indeed, the function field of \(C_s\) is the compositum of the two endpoint
fields inside \(k(Z)\); it is intermediate in each unramified extension.
Ramification indices multiply, and all field extensions here are separable.
Thus the intermediate maps are unramified, hence etale for smooth curves.

Call a span **joint-minimal** if its map to \(X\times Y\) is birational onto
its image. This is not permutation-theoretic primitivity.

**Theorem 1.** The connected-source refinement category is the disjoint
union, indexed by the distinct joint-minimal images \(\Gamma\), of the
categories of connected finite etale covers of their normalizations
\(C_\Gamma\). Each such block has terminal object \(C_\Gamma\).
Two spans have a common refinement commuting with both endpoint maps
if and only if their images \(\Gamma\) agree.

**Proof.** A morphism of spans is surjective on sources and therefore
preserves the image in \(X\times Y\). Thus no morphism connects different
images, even in a zigzag. For a fixed image, the unique factorization
through its normalization identifies a span with a connected finite etale
cover of \(C_\Gamma\). Conversely such a cover supplies both endpoint maps.
Morphisms agree under these identifications. Two covers of \(C_\Gamma\)
have a common connected refinement: take any connected component of their
fiber product. Each projection is finite etale and surjective. The converse
follows from preservation of the image. \(\square\)

This gives a precise answer to what refinements cannot create: they never
produce a new joint-minimal image. Taking a Galois closure over one endpoint
does not escape the block either. All further covers within one block have
the usual profinite Galois-category structure.

Composition can escape a block. For spans \(X\leftarrow Z\to Y\) and
\(Y\leftarrow W\to T\), each component of \(Z\times_Y W\) is already smooth
and bi-etale over \(X,T\). Its joint-minimal image can be new. Transpose
and composition therefore organize interactions between the blocks.

## 2. A positive linear category retaining all joint-minimal images

For every pair \(X,Y\), let \(\mathcal E(X,Y)\) be the complex vector space
with basis the joint-minimal images in \(X\times Y\). Elements are finite
linear combinations. Retain its distinguished cone with nonnegative real
coefficients; these coefficients are not reduced modulo the characteristic.

A span \(s\) with connected source represents
\[
[s]=[k(Z):k(C_s)]\,[\Gamma_s]. \tag{1}
\]
For a disconnected source, add its component contributions.

Define composition of basis elements by taking the fiber product of their
normalizations over the middle curve and applying (1) to each component.
Extend bilinearly. Structure constants are nonnegative integers.

**Theorem 2.** These spaces form a category enriched in complex vector
spaces with a positive integral basis. The diagonal is the identity.
Transpose is a conjugate-linear involution \(s\mapsto s^*\), reversing
composition.

**Proof.** Fiber products of finite etale maps remain finite etale; their
components give allowable spans. Replacing a source by an etale refinement
of degree \(e\) multiplies its cycle (1) by \(e\). Refining two sources by
degrees \(e,f\) multiplies the resulting composed cycle by \(ef\), because
the map of fiber products is finite etale of that degree. This proves
compatibility with all intermediate minimalizations and multiplicities.

For three composable spans both parenthesizations are obtained by pushing
the same triple fiber product to the two outer endpoints, with its generic
degrees. They give identical coefficients at every joint-minimal image.
Thus composition is associative. The diagonal and transpose assertions
follow directly from the same constructions. \(\square\)

This category forgets the internal monodromy of refinements but does not
identify distinct joint-minimal images. In particular
\[
\mathcal E(X,Y)\ne0
\quad\Longleftrightarrow\quad
X,Y\text{ have an actual common finite etale cover}. \tag{2}
\]
Formal linear combinations alone cannot make this space nonzero.

## 3. A faithful positive diagonal trace

Let \(\tau_X\) extract the coefficient of \(\Delta_X\) in
\(\mathcal E(X,X)\). For a basis correspondence \(\Gamma:X\to Y\), put
\[
a_\Gamma=\deg(C_\Gamma/X),\qquad
b_\Gamma=\deg(C_\Gamma/Y).
\]

**Theorem 3.** For joint-minimal \(\Gamma,\Lambda:X\to Y\),
\[
\tau_X(\Lambda^*\Gamma)=
\begin{cases}
a_\Gamma,&\Gamma=\Lambda,\\
0,&\Gamma\ne\Lambda.
\end{cases} \tag{3}
\]
Consequently
\[
\langle s,t\rangle_{X,Y}=\tau_X(t^*s),\qquad
\langle s,s\rangle=\sum_\Gamma a_\Gamma|c_\Gamma|^2>0
\quad(s=\sum c_\Gamma\Gamma\ne0). \tag{4}
\]

**Proof.** A component of \(C_\Gamma\times_Y C_\Lambda\) mapping to
\(\Delta_X\) gives a generic pair with the same \(X\)- and \(Y\)-coordinates.
Its common image belongs to \(\Gamma\cap\Lambda\). Distinct integral curves
in the surface \(X\times Y\) intersect in a finite set, so this cannot
happen unless \(\Gamma=\Lambda\).

In that case joint minimality makes the two lifts of a generic point equal.
The only component mapping to the diagonal is the diagonal copy of
\(C_\Gamma\). It has generic degree \(a_\Gamma\) over \(\Delta_X\).
This proves (3), and sesquilinear expansion gives (4). \(\square\)

Riemann--Hurwitz for the two etale legs gives
\[
(g(X)-1)a_\Gamma=(g(Y)-1)b_\Gamma. \tag{5}
\]
Therefore the normalized functionals
\(\widetilde\tau_X=(g(X)-1)\tau_X\) satisfy the categorical trace identity
\[
\widetilde\tau_X(ts)=\widetilde\tau_Y(st)
\quad(s:X\to Y,\ t:Y\to X). \tag{6}
\]
It suffices to check on basis elements, where both sides vanish unless
the two are transposes, and then (5) applies. In particular \(\tau_X\)
is a positive faithful trace on the algebra \(\mathcal E(X,X)\).
No analytic completion is asserted or needed here.

## 4. Which invariants lose this positive information?

The usual Jacobian realization sends \(\Gamma\) to \(g_*f^*\), and respects
composition and transpose (Rosati adjoints). It is not faithful even on
the positive cone.

For example, let a hyperbolic curve \(X\) have a finite automorphism group
\(G\) with \(X/G\) of genus zero. The positive sum of the graphs of all
\(\sigma\in G\) is a nonzero element of \(\mathcal E(X,X)\), but acts as
\[
\sum_{\sigma\in G}\sigma_*=q^*q_*=0
\quad\text{on }J_X,\qquad q:X\to X/G.
\]
Every graph here has two isomorphisms as its legs, hence is bi-etale,
even though \(q\) is ramified. Hyperelliptic involution gives \(1+\sigma\)
as the simplest example. Thus a vanishing Jacobian operator is not
evidence that its positive correspondence cycle is absent.

The same warning applies to a proposed linearized obstruction for
Jacobian-orthogonal endpoints. A useful replacement must retain enough
information to detect (4), or impose an additional condition on the
actual geometric basis elements. Merely assigning a vector-space structure
does not give a faithful cohomological invariant.

## 5. Closure of one seed is a sharper target than all unrelated covers

For this seed construction keep the two endpoint roles formally labelled,
even if the underlying curves coincide. Starting with one span and its
transpose, repeated alternating composition, component
selection, and joint minimalization produce its generated positive
subcategory. The earlier generic-graph theorem proves that a coreless
seed produces infinitely many distinct joint-minimal images of unbounded
degree. These need not account for all covers of either endpoint.

The monodromy groups in this generated family remain in one fixed
subgroup/quotient/extension-closed class determined by the finite
monodromy groups of the seed. See
[finite-seed closure and its precise limitations](FINITE_SEED_MONODROMY_CLOSURE_AND_UNBOUNDED_PRIMITIVE_COVERS.md).

Accordingly, a viable all-degree obstruction need not classify every
unrelated cover separately. It would suffice to show that no nonzero
cross-endpoint seed can support its entire required closure, while handling
the finite-core case separately. No such obstruction is established here.

References: [structural primary-source review](BIETALE_CORRESPONDENCE_STRUCTURE_LITERATURE_2026_09_05.md);
[generic-graph growth theorem](CORELESS_GENERIC_GRAPH_FORCES_UNBOUNDED_PRIMITIVE_CORRESPONDENCES.md).
