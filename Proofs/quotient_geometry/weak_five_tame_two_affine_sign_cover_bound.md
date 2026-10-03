# Proof: the unique tame branch would require a full affine cycle

Version1,3 October2026. [Statement](../../Theorems/quotient_geometry/weak_five_tame_two_affine_sign_cover_bound.md). Whole scoped argument passed [root independent review](../../Research/audits/CANONICAL_TEN_AFFINE_AND_NORMAL_ABELLAN_AUDIT_2026_10_03.md). No computation or classification of finite linear groups is used.

Put Σ=ΔG. Normalization and the trivial intersection make this a genuine finite semidirect product Δ⋊G acting on C. Write B=C/G=P1 and B2=C/Σ. The finite map B→B2 is separating, so B2 is rational as well. Its degree is M=|Δ|=2^a. The Σ/G coset set identifies with the affine space Δ: Δ acts by translation, while G acts by its conjugation linear action. Hence every Σ permutation on this coset set belongs to AGL_a(F2).

Choose a point of C with OLD G inertia orderTWO, and let J be its Σ point stabilizer. In the J action on Σ/G, orbits correspond exactly to points of B over its image in B2; an orbit's stabilizer is conjugate to the OLD G inertia at that point of C. The OLD cover has exactly ONE tame branch value, so there is exactly ONE orbit with stabilizer orderTWO. Every other orbit has stabilizer orderONE orFIVE. This is a count of actual points in a finite Galois fiber, not a formal branch-type assumption for B→B2.

First exclude wild J. A Sylow FIVE-subgroup of G is also Sylow in Σ because |Δ| is prime toFIVE. Any nontrivial wild subgroup of J is conjugate into G, and after conjugation still fixes a point of C. The OLD G stabilizers force it to have orderFIVE and lower breakONE. The entire local wild subgroup is therefore C5 of breakONE. In a curve-point stabilizer its tame quotient is cyclic; the breakONE leading term shows it acts faithfully on C5 through F5×. Thus
\[
|J|\in\{5,10,20\}
\]
in the wild case. Concretely, after tame linearization t↦ζt, the wild generator has g(t)=t+αt²+O(t³), α≠0; conjugation scales α by ζ, so the tame quotient embeds in F5×. There is no extra central tame factor.

OrderFIVE cannot contain the chosen OLD inertiaTWO. For |J|=TEN, the sole orbit with stabilizerTWO has sizeFIVE. All other orbits have sizeTWO orTEN, so the total M would be odd; M is a positive TWO-power and is at leastFIVE, impossible. For |J|=TWENTY, that sole orbit has sizeTEN and all other orbits have sizeFOUR orTWENTY. Thus M≡2 modFOUR. Its only TWO-power possibility would be M=TWO, too small for the orbitTEN. This excludes all wild J.

Now J is tame and cyclic, of some even order n. Its orbit stabilizers are only ONE orTWO, since FIVE cannot divide a tame stabilizer. The unique stabilizer-TWO orbit has size n/2 and every remaining orbit size n. For an integer b≥ZERO,
\[
2^a=M=\frac n2+bn=\frac n2(1+2b).
\]
The odd factor1+2b must beONE, and the odd part of n must beONE. Thus b=ZERO and n=2^(a+ONE). A generator of J consequently acts as ONE full cycle of length2^a on the affine space Δ.

Such a cycle cannot occur in AGL_a(F2) for a≥THREE. Embed an affine element into GL_(a+ONE)(F2) by its augmented matrix. A TWO-power-order matrix is unipotent, so its order is at most2^ceil(log2(a+ONE)). For a≥THREE this is at most2^(a−ONE), strictly smaller than the required2^a.

If a=TWO, the conjugation image of G lies in GL2(F2), a group of orderSIX. The prime-to-FIVE quotient hypothesis makes that image trivial. Therefore the affine Σ action consists only of translations, each of order at mostTWO; it cannot contain the required full FOUR-cycle. We obtain a≤ONE.

For Δ=C2, its automorphism group is trivial, so it centralizes G. It induces an injective action on B: an element trivial on B belongs to the full Galois group G, contradicting Δ∩G=ONE. It fixes the TWO branch values individually, since their inertia types differ; its nonidentity element δ is therefore the sign involution of a coordinate fixing those values. A fixed point of δ on C must lie over one of them. Over the tame value, the G inertiaTWO and δ would give a commuting V4 inside a tame cyclic point stabilizer, impossible. Over the weak wild value, linearize δ as t↦−t. Commutation with g(t)=t+αt²+O(t³) would force α=−α, again impossible. Thus δ is free. The actual quotient C→C/Δ is étale. The trivial group case is immediate.

This proves the entire sign-degree bound while retaining the possible free target double. It supplies no lift of that target involution through any additional source map.
