# Proof: the actual wild140 tame distinguished cone

Version1, 3 October2026. Independent review pending. [Statement](../../Theorems/cartier_and_spin/wild140_tame_distinguished_cone_exclusion.md).

## The actual cone ledger, including the differential relation

The intrinsic canonical invariant spaces and coarse degree-one ratio are unchanged from the [ordinary proof](canonical_wild_degree_140_ordinary_spin_reduction.md). Their weight-seven and weight-twenty generators have local orders one at the wild and tame orbits respectively. At the distinguished tame point, φ has index two, so the weight-twenty section pulls back with zero2P. Dividing by the canonical different frame to weight twenty gives exact pole18P. The weight-seven section is nonzero there and gives exact pole7P. Denote the genuine Y ratios by F,G. Their actual quotient coordinate is β=G⁷/F²⁰.

There are seven simple F zeros, each with wild index20 and different23. The tame branch consists of eighteen other simple G zeros with index7, and P itself with index14. These fibers both have degree140. There is no further ramification, since the full different is exactlyqP. At the F zeros ord(dβ)=−17, at the other G zeros ord(dβ)=6, and at P ord(dβ)=13. Since
\[
d\beta=2G^6F^{-20}dG,
\]
these give ord(dG)=3,0,−19 respectively: at P the prefactor has order−108+140=32. Thus div(dG)=3∑₍F=0₎R−19P, exhausting degree2. It equals the divisor of F³σ for divσ=2P, hence dG=cF³σ with c≠0. This is derived from the FULL cone profile; it is not an imposed ordinary hypothesis.

## Pure odd F

Suppose F=yB₁. Then F³σ is invariant under the hyperelliptic involution, so the odd part of G is a fifth power. Its odd fifth root has pole at most3P because G has pole18. Every function in L(3P) is invariant, so G itself is invariant.

The actual primitive coefficient has degree140, and the intrinsic invariant spaces through weight140 still have monomials F̃ᵃG̃ᵇ of weight7a+20b, with0≤b<7 below140. Apply the hyperelliptic involution to the ACTUAL pulled characteristic identity and subtract, exactly as in the accepted ordinary pure-odd proof. Every odd-weight term has exact pole7a+18b. These pole orders are distinct: a coincidence gives7Δa+18Δb=0, hence7 divides Δb; with0≤b<7 one has Δb=0 and Δa=0. Therefore every odd intrinsic coefficient vanishes.

The resulting EVEN primitive polynomial gives an actual source involution fixing Γ and negating its canonical different coefficient. The exact original infinity-section identity sends each actual theta form to its negative. The accepted [theta recognition](../../Theorems/cartier_and_spin/new_line_comparison_normal_form.md), as used in the ordinary proof, would yield an automorphism of X acting on theta by−1, contradicting Aut(X)=C₃. Both actual endpoint maps have remained on T. Neither a Γ involution nor generation of Γ by F,G was presumed.

## Every mixed even-part degree

Write F=A₃+yB₁ with B₁ monic linear. The highest original Cartier row gives a₃³+3a₂+4qa₃−ba₃=0. Thus if a₃=0, exact degree two is impossible.

For cubic A at the moving origin, the [accepted universal cubic identities](wild140_moving_origin_cubic_even_part_exclusion.md) apply: their proof uses only the centered quintic, seven simple F zeros and C(F³σ)=0. Those inputs have just been established from this cone's ledger. The ordinary pole20 assumption was used there to derive that input, not in either resultant or multiplicity contradiction. This cone application is a new implication covered by the present review.

For cubic A at a fixed origin, the [necessary fixed-origin ODE identities](wild140_fixed_origin_cubic_ode_reduction.md) likewise depend only on F's pole7, reduced fiber and Cartier exactness. They force the normalized family
\[
\Phi=(w+1)(w^4+L),\quad F=w^3-L+yw,
\quad N=-w^7+2Lw^3-Lw^2+L^2,\quad L\ne0,-1.
\]
Its explicit primitive G₀ has pole18. Any other primitive with pole at most18 differs by a fifth power whose root lies in L(3P), hence by K₀+K₅w⁵. Therefore the completion packet has EXACT coefficient d=3, rather than the ordinary open condition d≠3.

The seven wild completions still identify over the SAME fixed coordinate β. Use the original congruence and rescalings of the [ordinary cubic proof](wild140_ordinary_cubic_even_part_exclusion.md): a=L²u,b=Lv,λ=M/L with L,M≠0. Let r₀,…,r₆ denote its seven exact rescaled remainder rows. The following direct identities give a contradiction, without any Gröbner calculation:
\[
r_3+r_4=v^2+(2d-1)(u-1).
\]
At d=3 this forces v=0 at a geometric solution. Then r₁+r₂+r₄=L+2+2u forces u=2L+4. The identity r₅+r₆=2L−3M then forces M=4L. Substitution into r₄ gives L(L−1)=0. Since L≠0, one has L=1,u=1,M=4. But the ORIGINAL remaining row r₀ equals1 at these forced values, a contradiction. The [direct source](../../scripts/genus_two/oct03_wild140_tame_cone_completion_identities.py) reconstructs all seven rows from the original norm congruence, checks every displayed identity and the final1=0, and saves its [receipt](../../../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier/tame_cone_identity_receipt.json). The new exact check took3.0 seconds on one core and did not calculate a Gröbner basis. This excludes the fixed cubic cone universally, without an endpoint parameter bound.

Finally, for A of degree at most one the reduced-fiber E argument is unchanged by the G pole. The [whole-origin lower-degree proof](wild140_ordinary_four_pair_reduction.md) uses only F,σ and its reduced fiber: at fixed origins it forces A=0, already excluded above; at the moving origin it forces F=w(y+v),v≠0. The accepted arbitrary-q,s [conic completion identities](wild140_exceptional_common_completion_refinement.md) then force v²=2s and K₁₀=C−3c/q with C²=c²q³/s. Pole18 now forces K₁₀=0, hence C=3c/q and q⁵=4s. The [accepted moving-family pole test](../quotient_geometry/wild140_moving_coarse_map_family.md) proves this parameter value absent on BOTH selected endpoints. Thus the moving lower-degree case is also excluded.

All six origins and all even-part degrees are covered for the distinguished tame-order-seven cone. No ordinary pole-twenty open condition was used to remove d=3; that boundary was treated separately by exact original equations.
