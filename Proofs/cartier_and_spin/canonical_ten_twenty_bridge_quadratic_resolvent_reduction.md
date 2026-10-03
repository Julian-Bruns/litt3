# Proof: reduce imprimitive twenty-sheet monodromy to its quadratic block field

Version1, 3 October2026. Root consequence of [the primitive exclusion](canonical_ten_primitive_twenty_bridge_exclusion.md) and [the pair-block exclusion](canonical_ten_pair_block_twenty_bridge_exclusion.md). Their whole-scope audits carry the substantive conductor and group steps.

Let L/F be the normal closure of the SINGLE actual bridge E/F. Write M for its group and H=Gal(LA/A)⊂M. The actual component T/Γ selects a TEN-element orbit Δ with full S₁₀ action. The primitive sector is excluded. Any proper block system restricts to an H-stable partition of Δ, so its common size is TWO orTEN by the intersection count in the pair-block proof. Pair blocks leave only the central C₂×S₁₀ product action, which also preserves the TWO TEN-element blocks. Hence all remaining cases admit such a system.

Let J⊂M stabilize one TEN-element block. The H-orbit Δ must be this entire block: otherwise intersecting Δ with the two blocks would give a nontrivial H-stable partition of its primitive S₁₀ action. H consequently fixes both blocks, so H⊂J. A point stabilizer defining E also fixes its block and is contained in J. Thus
\[
R=L^J\subset A\cap E,\qquad[R:F]=2.
\]
This is a field INSIDE the actual source, not a replacement abstract resolvent. Degree equalities give [E:R]=TEN and [A:R]=m. Since AE=T and [T:A]=[E:R], E⊗_R A is a field with normalization T. In particular this whole base change is connected, in contrast to the degreeTWENTY base change over F.

Riemann–Hurwitz for Γ→R yields
\[
2g(\Gamma)-2=16m\ge m(2g(R)-2),
\]
so g(R)≤NINE. Its degreeTEN E-cover has S₁₀ monodromy, since the block-preserving subgroup contains H's full S₁₀ action on Δ.

The block kernel M⁰⊂S₁₀×S₁₀ has surjective projections in both factors: the first follows from H and the second from conjugation by an element exchanging blocks. The normal subgroups of S₁₀ are ONE,A₁₀,S₁₀. Goursat's description therefore makes M⁰ diagonal S₁₀, equal-sign, or full product. In the diagonal case relabeling removes its inner automorphism; a block-exchanging element acts on the diagonal S₁₀ by an inner automorphism, so multiplying by a diagonal element makes it commute with that group. Its square lies in the trivial center of the diagonal S₁₀, giving the product C₂×S₁₀. The other two cases contain A₁₀×A₁₀.

All these cases remain subject to the actual étaleness T/E, the simple folds of T/Γ, and the original two-X spin identities. Their existence or nonexistence is not established by this reduction. The split degreeTEN indexONE class is a separate open case.
