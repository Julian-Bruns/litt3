# Proof: a fixed constant vector has the wrong leading coefficient

Version1,3 October2026. Whole independent review [PASS](../../../Research/audits/RANK_THREE_SOCLE_AND_ORTHOGONAL_ROW_AUDIT_2026_10_03.md); see the [exact statement](../../../Theorems/quotient_geometry/local_actions/wild_constant_module_simple_determinant_obstruction.md). No computation is used.

Suppose the determinant has orderONE. Its image I is isomorphic equivariantly to W⊗A. Smith normal form gives length(F/I)=ONE, tF⊂I and t²F⊂tI. The special-fiber image J⊂F₀ is an invariant hyperplane, and
\[
0\longrightarrow k\longrightarrow I/tI\longrightarrow J\longrightarrow0.
\]
Its kernel is one-dimensional, hence trivial under C_p. The equivariant identification I/tI≅W therefore supplies a nonzero fixed vector w∈W in this kernel. Because the source action is CONSTANT, w⊗ONE is an actual invariant section, not merely an invariant special-fiber vector.

Let s be its image in F. Since its special-fiber image is ZERO, write s=t z+O(t²). The coefficient z has nonzero image in F₀/J. Otherwise s∈tI: indeed z∈J lifts to an element of I, and subtracting t times this lift leaves an element of t²F⊂tI. This would make w⊗ONE belong to t(W⊗A), contradicting w≠ZERO.

Invariance of s and σ(t)=t+O(t²) force z to be fixed by the action on F₀. Put Δ=σ−ONE on F₀. The hypothesis that all its Jordan blocks have length at leastTWO gives
\[
\ker\Delta\subset\operatorname{im}\Delta.
\]
Every invariant hyperplane J is the kernel of an invariant functional, because its one-dimensional quotient has trivial C_p action. Hence imΔ⊂J. Therefore z∈kerΔ⊂J, contradicting its nonzero image in F₀/J.

No splitting of the special-fiber extension was needed. The essential extra input is the constant source action, which lifts its fixed vector to an invariant section. A general nonconstant semilinear source does not have that property.
