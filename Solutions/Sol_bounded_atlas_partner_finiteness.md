# Proof: bounded effective atlases give finitely many partners

Canonical [statement](../Theorems/Thm_bounded_atlas_partner_finiteness.md).
Audited PASS, /root/x_elliptic_quotient_maps, 2026-09-05; metadata is
in the registry. The equivalent proof was shortened on 2026-09-06.

The etale fundamental group of a smooth projective curve over an
algebraically closed field is topologically finitely generated. In
positive characteristic this follows from a lift and the surjective
[specialization map](https://stacks.math.columbia.edu/tag/0C0P).
Consequently a fixed curve has finitely many connected etale covers
of bounded degree: use its finitely many homomorphisms to each S_d.

Given X -> S of degree n<=B, take its Galois closure W -> S in the
finite-etale covering category. Then W -> X is a connected etale
curve cover of degree at most (n-1)! <= (B-1)!, the order of a point
stabilizer in the permutation group. Thus there are finitely many W.
Since g(W)>=2, Aut(W) is finite. Effectivity makes the action of the
Galois group G on W faithful, so S=[W/G] for one of finitely many
subgroups of Aut(W). This proves finiteness of S.

For any one S, pi_1(S) contains the finitely generated pi_1(W) as an
open subgroup and is therefore finitely generated. Its canonical degree
delta=(2g(X)-2)/n is positive. A genus-h curve atlas Y -> S must have
the single degree (2h-2)/delta=(h-1)n/(g(X)-1), or none exists if this
is not integral. There are finitely many such covers of S, proving
the partner assertion.

A uniform bound B in a positive-dimensional family of varying genus-h
curves therefore leaves only finitely many common-orbifold partners.
Removing a finite set from such a family still leaves geometric points
even over an algebraic closure of a finite field. This does not remove
a merely countable union.

The Galois closure above is over an orbifold ALREADY given. No step
constructs a simultaneous Galois envelope for an arbitrary coreless
span, and no bound B is supplied by this lemma.
