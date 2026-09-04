# The complex triangle-group input and its limits

This file records one external complex theorem and separates it from the
unproved specialization statements needed in characteristic `5`. The title
of the old file referred to a “profinite orbifold group,” but no profinite
commensurator theorem is proved in the retained material.

Whenever a characteristic-`5` special fiber occurs below,
`k=\bar F_5`.

## THM-TAME-COMMENSURATOR — external complex input

**Status: `missing dependency`; the classical theorem is used only as an
explicit hypothesis below.**

Let `Delta(a,b,c)` denote the orientation-preserving Fuchsian triangle group
of signature `(a,b,c)`. The external claim needed by this route is

`Comm^+_{PSL_2(R)}(Delta(31,31,31))=Delta(2,3,62)`.          `(1)`

The subgroup inclusion
`Delta(31,31,31) < Delta(2,3,62)` has index `6`.

The existence of an index-`6` inclusion is reflected algebraically by the
proved quotient

`P^1(31,31,31) -> P^1(2,3,62)`

in [file `10`](10_PROOF_SELF_CORRESPONDENCE.md). The index is also checked
by orbifold Euler characteristics:

`chi(31,31,31)=-28/31`,

`chi(2,3,62)=-14/93`,

whose ratio is `6`. What is not proved here is the maximality assertion in
`(1)`, namely that the triangle group lies in no larger orientation-
preserving commensurator.

No bibliography or source map for the labels in the former version of this
file survives. Until an exact source is supplied and its conventions are
checked, `(1)` must be treated as a hypothesis.

## What `(1)` says over characteristic zero

Assuming `(1)`, a finite étale self-correspondence of the complex orbifold
`P^1_C(31,31,31)` is visible after quotienting by
`P^1_C(2,3,62)`: analytic uniformization and GAGA identify such a
correspondence with a commensurating element, and `(1)` places that element in
`Delta(2,3,62)`.

This is a complex-orbifold statement. It is not automatically a theorem
about either

- arbitrary algebraic correspondences over `\bar F_5`, or
- a vaguely defined “prime-to-`5` correspondence.”

In particular, the fact that the two covering degrees are prime to `5` does
not, in the retained argument, produce one characteristic-zero curve carrying
both lifted maps.

## PROP-TAME-SELF-CORRESPONDENCE — corrected liftable version

**Status: `conditional-proof`, conditional on `(1)` and on the stated
simultaneous lift.**

Let `R` be an excellent mixed-characteristic discrete valuation ring (for
example, a complete one) with residue field `k`, and let `S_R` be the
three-point root-stack lift of `S`, with symmetric quotient `(S_0)_R`.
Suppose a self-correspondence

`u,v:C -> S`

is the special fiber of one smooth proper connected Deligne–Mumford curve
`C_R` over `R`, carrying two representable finite étale maps

`u_R,v_R:C_R -> S_R`.

If `(1)` holds, then

`pi_0 u ~= pi_0 v`.

### Proof

The generic-fiber curve and its two maps are of finite presentation, so the
data descend to a finitely generated characteristic-zero subfield, which can
be embedded in `C`. Assuming `(1)`, the complex commensurator statement gives
an isomorphism after that base change. The functor of global 2-isomorphisms
between the two maps is a finite algebraic space over the ground field: the
source is proper and the target has finite separated diagonal. Its geometric
point is therefore defined over a finite extension of the original fraction
field. After normalizing `R` in that extension and localizing at a prime over
its maximal ideal, the two generic-fiber maps to `(S_0)_R` are isomorphic.
The isomorphism sheaf
between the two maps is finite over `C_R`, because `(S_0)_R` has finite
separated diagonal. A generic section of this finite sheaf extends over the
normal integral stack `C_R`: on a normal atlas, the closure is finite and
birational, hence is the atlas itself. Uniqueness follows from trivial
generic inertia, so the local extensions descend. Restricting the resulting
isomorphism to the special fiber proves the assertion.

Thus simultaneous liftability is a sufficient condition. The old statement
that every “purely tame / prime-to-`5`” correspondence has this property had
no definition and no proof, so it has been removed.

## OPEN-TAME-SPECIALIZATION — missing characteristic-`5` input

**Status: `open`.**

The over-orbifold route needs more than `(1)`. A sufficient precise input is:

> For every tame finite over-orbifold `f:S -> O` over `k`, there is a
> representable finite étale map `h:O -> S_0` and a 2-isomorphism
> `h f ~= pi_0`.

One possible proof would establish a specialization/lifting equivalence that
preserves the whole map `f` and then apply `(1)`. No such argument is present
here. An isomorphism between prime-to-`5` fundamental groups, without a
compatibility theorem for the algebraic maps under consideration, does not
by itself prove the displayed factorization.

For arbitrary self-correspondences an additional simultaneous-lift or
finite-envelope issue remains even after this over-orbifold input; see file
[`10`](10_PROOF_SELF_CORRESPONDENCE.md).

## REF-SINGERMAN-TAKEUCHI — reference audit still required

**Status: `open`.**

An exact classical reference must verify all of the following in compatible
orientation-preserving conventions:

1. the inclusion `Delta(31,31,31) < Delta(2,3,62)`;
2. the index `6` (independently checked above);
3. the non-arithmetic/maximal-commensurator assertion `(1)` for `31`; and
4. the translation from `(1)` to finite étale complex orbifold
   correspondences.

The names “Singerman/Takeuchi” in earlier notes are search hints, not a
usable citation. No claim in this file should be cited as an unconditional
characteristic-`5` result.
