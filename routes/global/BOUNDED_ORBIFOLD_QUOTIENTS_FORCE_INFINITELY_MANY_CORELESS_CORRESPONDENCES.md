# Bounded orbifold quotients force infinitely many minimal coreless correspondences

**Status:** author proof, 2026-09-05. Author: `/root`.
The degree bound and iteration argument passed focused independent checks
by `/root/canonical_trace_algebra` and `/root/x_elliptic_quotient_maps`,
respectively, on this date, with no breaking objection. The literature
comparison was checked by `/root/gluing_cohomology_rigidity`. These checks
do not re-audit the ordinary-genus-two atlas bound, whose own independent
audit is linked from its theorem. No claim about the full common-cover
problem follows from this note alone.
[Focused check record and scope](audits/BOUNDED_ORBIFOLD_QUOTIENTS_CORELESS_ITERATION_AUDIT.md).
Section 7 is a subsequently appended author corollary, outside that
independent-check scope.

## 1. Parameterized theorem

Let `k` be an algebraically closed field, and let `X,Y/k` be smooth
projective connected curves of genus at least two. Suppose that there is
an integer `B` such that every representable finite etale atlas

\[
                         Y\longrightarrow S
\]

of a smooth proper connected effective Deligne--Mumford orbifold curve
has degree at most `B`. Wild stabilizers are permitted.

A bi-etale correspondence `X <- C -> Y` is **minimal** if its two
function fields generate `k(C)`. We distinguish correspondences by their
actual images in the fixed product `X x Y`, or equivalently by isomorphisms
of their minimal normalizations commuting with both endpoint maps.

Then:

1. Every minimal bi-etale correspondence with a core satisfies
   \[
                  \deg(C/X)\le B.                       \tag{1}
   \]
   In particular, there are only finitely many such cored minimal
   correspondence images between the fixed endpoints.

2. If there is one coreless bi-etale correspondence between `X` and `Y`,
   there are infinitely many pairwise distinct **minimal coreless**
   bi-etale correspondences between the same endpoints. Their degrees
   over either endpoint are unbounded. They can all be obtained by
   normalizing joint images of connected components of odd alternating
   fiber products of the original correspondence and its transpose.

The second assertion is a restricted affirmative answer to
[Krishnamoorthy's Question 3.21](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).
The added hypothesis is the uniform orbifold-atlas bound on one endpoint,
not a degree bound on the original correspondence.

## 2. Minimalization and bounded-degree finiteness

We record two elementary facts used below.

### Lemma 2.1: minimalization preserves both etale maps

For any actual bi-etale diagram `X <- D -> Y`, normalize its joint image
in `X x Y` to obtain `C`. Its function field is the compositum
`k(X)k(Y)` inside `k(D)`. Thus `D -> C` and both maps from `C` are finite
separable maps of smooth projective curves.

At any point, ramification indices multiply in each tower. Since the
composites `D -> X,Y` are etale, all these indices are one. Residue
extensions are trivial over the algebraically closed ground field. Hence
`D -> C` and `C -> X,Y` are etale. This also follows directly from the
finite-etale intermediate-cover category. The intersection of the two
endpoint function fields is unchanged by minimalization.

### Lemma 2.2: finitely many minimal images of bounded degree

For fixed `X,Y` and `b`, there are only finitely many minimal bi-etale
correspondence images `C` with `deg(C/X)<=b`.

The fundamental group of a smooth projective curve is topologically
finitely generated. Consequently there are finitely many connected etale
covers `C -> X` of degree at most `b`, up to isomorphism over `X`. One
justification in positive characteristic is smooth proper lifting and
surjective specialization from the characteristic-zero surface group;
see [Stacks, Lemma 58.30.1](https://stacks.math.columbia.edu/tag/0C0P).

Every second etale leg has degree

\[
                   \deg(C/Y)=\frac{g(C)-1}{g(Y)-1}
                      \le\frac{b(g(X)-1)}{g(Y)-1}.
\]

Thus there are also only finitely many covers `D -> Y` that can occur
as the second leg, up to isomorphism over `Y`. For each pair of covers
from these two finite lists, the set `Isom_k(C,D)` is empty or a torsor
under the finite group `Aut_k(C)`; finiteness of automorphisms holds
because `g(C)>=2`. Every actual correspondence is obtained by one such
identification. This proves the lemma, without any boundedness assertion
about arbitrary ramified or inseparable maps.

## 3. Proof of the cored degree bound

Let `X <- C -> Y` be minimal and cored. The bridge proved in
[CORED_BIETALE_CORRESPONDENCES_HAVE_COMMON_ORBIFOLDS.md](CORED_BIETALE_CORRESPONDENCES_HAVE_COMMON_ORBIFOLDS.md)
gives an actual finite etale refinement `W -> C` such that `W -> X` and
`W -> Y` are both Galois. It is important that this refinement is
constructed by alternating unramified Galois closures inside a finite
simultaneous field envelope; the possibly ramified closure over the
coarse core is not used as an etale atlas.

Put

\[
 A=\operatorname{Gal}(W/X),\qquad
 D=\operatorname{Gal}(W/Y),\qquad
 G=\langle A,D\rangle\subset\operatorname{Aut}_k(W).
\]

The finite group `G` acts faithfully, and `S=[W/G]` is a common effective
orbifold with `X=[W/A]` and `Y=[W/D]`. All displayed atlas maps are
representable finite etale, whether or not their degrees are divisible
by the characteristic.

Minimality and Galois correspondence give

\[
        k(C)=k(W)^A k(W)^D=k(W)^{A\cap D}.
\]

Thus `C = W/(A cap D)` **with the original two maps**. Equivalently it is
the identity-double-coset component of `X x_S Y`. The elementary injection
of coset sets `A/(A cap D) -> G/D` yields

\[
 \deg(C/X)=[A:A\cap D]\le[G:D]=\deg(Y/S)\le B.
\]

This proves (1). Lemma 2.2 then gives finiteness of the cored minimal
images. In particular, no argument about infinitely many choices of
stack automorphisms or presentations is needed.

## 4. Proof of the iteration assertion

The part of the following proof producing infinitely many minimal images
of unbounded degree is valid for **any** fixed hyperbolic endpoints with
a coreless bi-etale correspondence. The bound `B` is used only at the
last step to ensure that infinitely many of those images are coreless.
More generally, finiteness of the cored minimal images would suffice for
that last step.

First replace the given correspondence by its minimalization using
Lemma 2.1, and write it as `X <- Z -> Y`. It is still coreless.

Fix an algebraically closed field `Omega` of transcendence degree one
over `k`, an embedding `k(Z) -> Omega`, and its restriction `P` to
`k(X)`. Use the **two-colored generic graph** of this one correspondence:
blue vertices are embeddings of `k(X)`, red vertices are embeddings of
`k(Y)`, and edges are compatible embeddings of `k(Z)`; take the connected
component of the chosen edge. Degrees at blue and red vertices equal
the two finite degrees of `Z`. No identification of the two colors is
made, even if `X` and `Y` are isomorphic.

By [Krishnamoorthy, Proposition 5.10](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf),
this graph is infinite because the correspondence has no core. It has
infinitely many red vertices: if there were only finitely many, their
finite neighbor sets would contain every blue vertex of this connected
graph, making the graph finite.

For each reachable red vertex `Q`, choose a path of odd length starting
at `P` and ending at `Q`. A path of length `2r+1` is a generic point of

\[
 Z\mathbin{\times_Y} Z\mathbin{\times_X} Z
   \mathbin{\times_Y}\cdots\mathbin{\times_X} Z,         \tag{2}
\]

where each fiber product identifies the endpoint shared by the
corresponding consecutive edges. Select the connected component
containing that generic point. Successive base changes of the original
finite etale maps show that the component is a smooth projective curve
finite etale over the first `X` and the last `Y`. Apply Lemma 2.1 to
its joint image, obtaining a minimal bi-etale image `C_Q` in `X x Y`.

A fixed minimal image `C` can account for at most `deg(C/X)` distinct
vertices `Q` when the initial embedding `P` is fixed. Indeed the pair
`(P,Q)` factors through an embedding `k(C) -> Omega` extending `P`, and
there are exactly `deg(C/X)` such embeddings because `C -> X` is
separable. The second endpoint embedding is determined by that
embedding of `k(C)` and the fixed map `C -> Y`.

Consequently infinitely many reachable red vertices give infinitely
many distinct minimal images `C_Q`. Lemma 2.2 makes their degrees over
`X` unbounded. By (1), every one of degree greater than `B` is coreless.
In particular infinitely many of the images are coreless. Finally

\[
 \deg(C_Q/X)(g(X)-1)
       =g(C_Q)-1
       =\deg(C_Q/Y)(g(Y)-1)
\]

makes the degrees over `Y` unbounded as well. This proves the theorem.

Notice that growing degrees of the unreduced products (2) alone would
not suffice: they can contain repeated or backtracking components.
The fixed-generic-vertex count is what proves growth of the distinct
minimal images.

## 5. Ordinary genus two in characteristic five

Over `k=Fbar_5`, the independently audited
[ordinary genus-two atlas theorem](ORDINARY_GENUS_TWO_UNIFORM_ORBIFOLD_DEGREE_BOUND.md)
supplies the hypothesis with `B=42000` for **every** ordinary genus-two
curve `Y`. Hence the theorem applies with arbitrary hyperbolic `X`.

Explicitly, every cored minimal correspondence obeys

\[
 \deg(C/X)\le42000,\qquad
 \deg(C/Y)\le42000(g(X)-1),\qquad
 g(C)\le1+42000(g(X)-1).                                 \tag{3}
\]

If such an `X,Y` admit even one coreless bi-etale correspondence, they
admit infinitely many minimal coreless ones of unbounded degrees.
For ordinary genus-two `Y` outside the finite exceptional set in
[the combined reduction](GENUS_TWO_COMMON_COVERS_REDUCE_TO_INTRINSIC_CHARACTERISTIC_FIVE.md),
any hypothetical common cover would therefore force infinitely many
minimal coreless correspondences, none admitting a full joint
mixed-characteristic lift.

## 6. A fixed monodromy class for the entire family

Let `G_X,G_Y` be the geometric Galois-closure groups of the two initial
minimal legs. Let `F(G_X,G_Y)` be the smallest class of finite groups
containing these two groups and closed under subgroups, quotients,
finite direct products, and extensions.

Every leg of every path component in (2), and every leg of every minimal
image constructed from it, has geometric Galois-closure group in
`F(G_X,G_Y)`.

Indeed, adjoining one edge to a path is a connected component of a base
change of an initial leg. Its relative Galois-closure group is a subgroup
of `G_X` or `G_Y`. In the normal closure of a tower, the kernel over the
preceding normal closure is a subgroup of a finite product of conjugate
step groups. The quotient is a subgroup of the preceding normal-closure
group. Induction proves membership in `F(G_X,G_Y)`; equivalently one can
use the usual iterated wreath-product embeddings. The normal closure of
an intermediate field is a quotient of the path's normal-closure group.
Reverse the path to obtain the same assertion on the other endpoint leg.

In particular the entire family has a fixed finite set of possible
prime divisors of monodromy orders, namely those dividing `|G_X||G_Y|`.
If both initial groups have order prime to the characteristic, or if
both are solvable, that respective property persists throughout.

This does **not** bound exponent or nilpotency class: even iterated
wreath products of one cyclic group of prime order have unbounded
prime-power exponent. Thus it does not by itself meet the hypotheses
of the bounded-exponent Raynaud exclusion in this repository.

## 7. Reduction to self-correspondences of one curve

The same argument, using even paths starting and ending at red vertices,
gives a useful one-curve criterion.

### Corollary 7.1

Under the atlas-bound hypothesis on `Y`, the following are equivalent:

1. `Y` has only finitely many minimal bi-etale self-correspondence images.
2. Every bi-etale self-correspondence of `Y` has a core.
3. For every hyperbolic `X`, every bi-etale correspondence between `X`
   and `Y` has a core.

If these equivalent conditions hold, then for each fixed genus `h>=2`
there are only finitely many isomorphism classes of genus-`h` curves
sharing a finite etale cover with `Y`.

**Proof.** Condition 3 implies 2 by taking `X=Y`. Condition 2 implies 1
by the cored degree bound and Lemma 2.2. If 1 holds, the theorem applied
with both endpoints `Y` rules out a coreless self-correspondence, giving
2 as well.

It remains to prove that 2 implies 3. Suppose instead that `X <- Z -> Y`
is coreless. In its infinite two-colored generic graph, fix a red vertex
`Q`. Infinitely many other red vertices are reachable from `Q` by even
paths. Their endpoint images in `Y x Y`, after normalization, are actual
minimal bi-etale self-correspondences. The same fixed-vertex counting
argument as in Section 4 makes these images infinite in number and their
degrees unbounded. Every cored one has degree at most `B`, so at least
one (indeed infinitely many) is coreless, contradicting 2.

Finally any common cover with `Y` now has a core, and therefore yields
a common effective orbifold `S`. The atlas `Y -> S` has degree at most
`B`. Apply the
[bounded-atlas finiteness theorem](BOUNDED_ATLAS_DEGREE_GIVES_FINITE_ORBIFOLD_PARTNERS.md)
to the fixed curve `Y` and partner genus `h`. This proves the last
assertion. No Galois hypothesis on either original cover was introduced.

Thus a negative answer to Litt's problem would follow from finding **one**
ordinary genus-two curve over `Fbar_5` with finitely many minimal bi-etale
self-correspondences. There would then be only finitely many of its
common-cover partners in each genus, while the full genus-`h` moduli
space has infinitely many geometric points. This is a sufficient
one-curve criterion, not a proof that such a curve exists.

Conversely, if Litt's proposed assertion holds, then every ordinary
genus-two curve in characteristic five must admit infinitely many
minimal coreless self-correspondences of unbounded degree. For curves
outside the finite genus-two arithmetic reduction set in the combined
reduction, none of those coreless self-correspondences can have a full
joint mixed-characteristic lift.

## 8. Exact scope and remaining obstruction

This is an all-degree structural consequence, not a negative answer to
Litt's problem. Infinitely many minimal coreless correspondences are
compatible with known Shimura examples. The proof does not assert that
all components of all iterations are coreless, that a lift of an
individual curve lifts the diagram, or that the growing correspondences
have bounded monodromy or bounded prime-to-characteristic exponent.

The new condition usable in a negative argument would have to prohibit
the resulting **infinite family of actual two-leg etale diagrams** for
a chosen pair, not merely prohibit a small degree or an abstract
Jacobian factor. No such prohibition is proved here.
