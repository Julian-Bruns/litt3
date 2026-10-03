# Proof: modular normal restriction and the simple socle

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_ten_almost_simple_coefficient_reduction.md). Focused review pending. All arguments concern the actual coefficient quotient; both original étale endpoint maps remain on their original source.

## One isotypic restriction for every normal subgroup

Use the finite central lift of R in SL(V), whose scalar kernel is contained in μ₄. For any normal subgroup M of R, restriction of its irreducible V to the inverse image of M is semisimple: take a simple submodule of the restriction; the sum of its translates under the full group is semisimple and is a nonzero invariant submodule, hence all of V. This modular Clifford argument does not assume that FIVE avoids |M|.

The full group acts transitively on the distinct isomorphism types. Their number is at most FOUR, so its permutation quotient is a subgroup of S₄, whose order is prime to FIVE. The accepted absence of such quotients makes that action trivial. There is therefore just ONE type. Write the restriction as W⊗k^m, with W simple of dimension r and rm=FOUR.

If M is nontrivial, r cannot be ONE: a one-isotypic rank-one action would be scalar on all V, contradicting the faithfulness of M in PGL(V). If r=m=TWO, every full-group operator normalizing the M action decomposes as a tensor product. Indeed its intertwiner on W is unique up to scalar, and after dividing by this intertwiner its action is in the full multiplicity centralizer End(k²). These choices define projective representations of R on BOTH two-dimensional factors. Their scalar cocycles sum to the cocycle of V, while determinants kill each factor cocycle by TWO. The resulting order-at-most-TWO multiplier contradicts the accepted exact order-FOUR multiplier. This is precisely the accepted [tensor-product exclusion](positive_finite_coefficient_row_geometry.md), applied to the normal restriction, not an assumption of linear extension of W.

Consequently every nontrivial normal subgroup of R has irreducible dimension-FOUR restriction.

## A minimal normal subgroup has only one simple component

Take a minimal nontrivial normal subgroup M of R. The accepted [whole normal-abelian exclusion](canonical_ten_normal_abelian_trace_exclusion.md) rules out the abelian case. The elementary structure theorem for minimal normal subgroups of finite groups gives M=S^t for a nonabelian simple S.

For clarity, the projective nature of the representation does not obstruct the tensor decomposition across these perfect components. Pull each factor back through a perfect central cover. Distinct lifted components commute: their commutators are scalar, and each scalar commutator as a function of either perfect component is a character, hence trivial. Thus the irreducible restriction to M is an outer tensor product of irreducible projective representations of its t simple factors. Each factor has dimension at least TWO because scalar action would kill that factor in the faithful projective image. Therefore 2^t≤FOUR, so t≤TWO.

If t=TWO, both factor dimensions are TWO. The permutation of the two simple factors is a prime-to-FIVE quotient of R, hence trivial. Every element of R therefore preserves BOTH factors, and the same intertwiner argument gives a global projective tensor decomposition of V into two dimension-TWO factors. This again contradicts the exact order-FOUR multiplier. Thus t=ONE and M=S is simple.

## The centralizer is trivial, giving the actual almost-simple embedding

The restriction to the perfect central cover of S is irreducible of dimension FOUR. Any projective operator centralizing S can have only scalar commutators with its perfect lift; those commutators form a character and hence are trivial. Ordinary Schur's lemma then makes the operator scalar. Its image in PGL(V) is the identity, so C_R(S)=ONE.

Conjugation therefore embeds R into Aut(S), with S identified with Inn(S). Any other minimal normal subgroup of R would commute with S and lie in its trivial centralizer; hence the socle is exactly S. Finally any imprimitivity system of the four-dimensional representation has TWO orFOUR blocks. Its block-permutation image is prime to FIVE and therefore trivial, contradicting irreducibility. The projective representation is primitive.

The accepted [native tame gate](canonical_ten_tame_coefficient_involution_gate.md) and [actual quotient-target lemma](canonical_degree_ten_no_a5_quotient.md) continue to apply to R itself. No stronger conclusion about S's Schur multiplier, outer automorphisms or classification is imported here.
