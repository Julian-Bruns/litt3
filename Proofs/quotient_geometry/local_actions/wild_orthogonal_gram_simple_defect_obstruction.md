# Proof: a corank-one Gram fiber would split off a trivial summand

Version1,3 October2026. Whole independent review [PASS](../../../Research/audits/RANK_THREE_SOCLE_AND_ORTHOGONAL_ROW_AUDIT_2026_10_03.md); see the [exact statement](../../../Theorems/quotient_geometry/local_actions/wild_orthogonal_gram_simple_defect_obstruction.md). No computation is used.

If the induced determinant has orderONE, its matrix on Q has special-fiber rank n−ONE by Smith normal form. The map U→Q is surjective over A and after reduction, so the original Gram form on U₀ also has rank n−ONE.

Let I be the image of U₀ in F₀. Its restriction of the target pairing has rank n−ONE. Thus dimI≥n−ONE. If dimI=n, the restriction would have rank n because the target pairing is perfect. Therefore dimI=n−ONE and its restriction is nondegenerate.

The image I is invariant. A cyclic p-group acts trivially on the one-dimensional value-line fiber. Thus its orthogonal complement is also invariant and gives the direct sum
\[
F_0=I\oplus I^\perp.
\]
The second summand has dimensionONE and is a trivial C_p-module. This contradicts the assumed absence of a ONE-block in F₀. Unlike a smaller-rank Gram quotient, the corank-one case leaves no room for a larger degenerate row image; this is precisely why the argument is valid here.
