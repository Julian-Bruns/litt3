# Proof: diagonal ten-sheet symmetry and wild conductor comparison

Version1, 3 October2026. Independent whole review PASS in Research/audits/CANONICAL_TEN_PRIMITIVE_TWENTY_BRIDGE_AUDIT_2026_10_03.md. This uses only the normal closure of the SINGLE actual bridge E/F, not a simultaneous Galois completion of the endpoint maps. See the [statement](../../Theorems/cartier_and_spin/canonical_ten_primitive_twenty_bridge_exclusion.md).

Let L/F be the single normal closure of E/F. Its transitive group M acts on Ω of sizeTWENTY. Set H=Gal(LA/A), identified with a subgroup of M. The actual component K/A selects a TEN-element H-orbit Δ; the induced action H→Sym(Δ) is S₁₀ by the retained monodromy of T/Γ. Its complement Q has sizeTEN and is H-stable.

The kernel of H's action on Q maps injectively to Sym(Δ) and has normal image in S₁₀. If it is nontrivial, its image contains A₁₀, so M contains a THREE-cycle supported on Δ. If it is trivial, H embeds into Sym(Q). Since |H|≥TEN factorial, H has orderTEN factorial and both actions are isomorphisms to S₁₀. All automorphisms of S₁₀ are inner, so after matching the two TEN-element sets H is a diagonal S₁₀. Its transpositions are double transpositions, each supported on the union of TWO matched pairs.

In this diagonal case, if every element of M sends every union of TWO matched pairs to another such union, it preserves the matched-pair system: a matched pair is the intersection of two such unions meeting in exactly one pair. That would make M imprimitive. Under the stated primitivity, choose a conjugated double transposition whose support S, of sizeFOUR, is not a union of matched pairs. It meets some pair in ONE point. At mostFOUR pairs meet S, so there is also a matched pair disjoint from S. The original diagonal group contains a double transposition supported on the union of these TWO pairs. Their supports meet in exactlyONE point; their commutator is a THREE-cycle. Therefore both cases put a THREE-cycle in M.

A primitive permutation group containing a THREE-cycle contains A(Ω). One direct formulation is to take all supports of conjugate THREE-cycles. Their connected components are M-blocks. Overlapping THREE-cycles generate the alternating group of their joined supports (intersectionONE gives A₅, intersectionTWO gives A₄), and adjoining successive connected supports gives the alternating group of each component. Primitivity gives one component. Thus M=A₂₀ orS₂₀.

Let J⊂M stabilize Q setwise and R=L^J. Since H fixes Q setwise, R⊂A. The field R has degree
\[
D=[R:F]=\binom{20}{10}=184756.
\]
The normal closure of ER/E is L. Indeed Gal(L/E) is A₁₉ orS₁₉, acting faithfully on the orbit of TEN-subsets avoiding the distinguished E-sheet. Since ER⊂AE=K and K/E is étale, ER/E and its normal closure L/E are étale. This actual intermediate-field argument supplies the needed ramification assertion.

Consequently every inertia group I of L/F intersects all conjugate point stabilizers trivially. It acts semiregularly on Ω, as does every subgroup I_i in its lower ramification filtration. Each such group has order dividingTWENTY; every nonidentity element has order dividingTWENTY and consists of equal cycles on Ω.

Consider its action on the set Ψ of TEN-subsets of Ω. A nonidentity element of order d fixes no TEN-subset unless d dividesTEN. For d=TWO,FIVE,TEN the fixed-subset counts are respectively
\[
\binom{10}{5}=252,\qquad \binom{4}{2}=6,\qquad \binom{2}{1}=2.
\]
Thus every nonidentity element fixes at most252 of the D subsets. For any semiregular subgroup B≤I, of order b>ONE, Burnside gives
\[
1-\frac{\#(\Psi/B)}D
\ge \left(1-\frac1b\right)\left(1-\frac{252}{D}\right).
\]
The corresponding normalized orbit-codimension on Ω is exactly ONE−ONE/b. Apply this term by term to the permutation-representation Artin conductor
\[
a_I(V)=\sum_{i\ge0}\frac{|I_i|}{|I|}\operatorname{codim}V^{I_i}.
\]
All weights are nonnegative. The conductor of a permutation representation is the total different contribution of its associated separable cover above this base point. This formula holds in wild characteristic using the usual rational or auxiliary characteristic-ZERO permutation representation; it is not a characteristic-FIVE dimension calculation. We obtain globally, for Δ_E and Δ_R the degrees of the different divisors,
\[
\frac{\Delta_R}{D}\ge\left(1-\frac{252}{D}\right)\frac{\Delta_E}{20}.
\]
Since g(E)=161 and its degree isTWENTY, Δ_E=360. Therefore
\[
\frac{2g(R)-2}{D}
\ge -2+18\left(1-\frac{252}{D}\right)
>8.
\]
But R⊂A, g(Γ)=8m+ONE and deg(t|Γ)=TWO m. Riemann–Hurwitz for Γ→R, followed by its degree equality, gives
\[
\frac{2g(R)-2}{D}
\le\frac{2g(\Gamma)-2}{[A:F]}=8.
\]
This contradiction excludes the primitive sector. No hypotheses about ramification of the two X-map closures were substituted, and no numerical computation is needed.
