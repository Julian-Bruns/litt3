# Proof: actual free fibers and the degree of the half-spin

Version1,3 October2026. Root focused review **PASS**; see [audit](../../Research/audits/ETALE_SPIN_STABILIZER_LCM_AUDIT_2026_10_03.md).

## Every actual stabilizer divides the carrier degree

Fix z∈Z. Its stabilizer G_z acts on the complete φ-fiber, consisting of e points because φ is étale. This action is free: an element fixing a source point would lie in a stabilizer of the free original G-action on T. Hence |G_z| divides e, and their least common multiple ℓ divides e.

Étale Hurwitz for q and φ gives
\[
g(Z)-1=|G|/e,\qquad\deg M=|G|/(8e).
\]
The inherited spin class has obstruction order EIGHT or SIXTEEN by the accepted original free-source Schur argument.

## The positive full-trace determinant genuinely descends

Use the first relative Frobenius targets explicitly. Choose determinant-one projective coefficient lifts A_g on V₄, and let B_g be the paired line lifts on L₁² specified by the ORIGINAL genuine action on q₁*J. Their fourth powers give exactly the native q₁*det J action. Since M₁² is an invariant Picard class, any target lift on it pulls to a lift on L₁² differing from B_g by a global constant on the proper connected source. Rescale to match B_g. Faithful pullback preserves the scalar cocycle. Thus B_g⁴ gives a genuine action on M₁⁸, of degree |G|/e. This is the same line descent used in the accepted determinant-character proof; the comparison of its square with canonical ω remains the character χ.

Every genuinely G-linearized line on Z has degree divisible by |G|/ℓ. Indeed multiplicative Hilbert90 gives an invariant rational section over the ACTUAL extension k(Z)/k(Z/G); its divisor is a sum of complete point orbits, whose sizes have greatest common divisor |G|/ℓ. Applying this to M₁⁸ gives
\[
|G|/\ell\mid |G|/e.
\]
Thus e divides ℓ. Together with the actual fiber divisibility, ℓ=e.

## The weak-(FIVE,TWO) signature

For that actual quotient, the wild cyclic FIVE break-ONE different is EIGHT and the tame TWO different is ONE. Hurwitz therefore gives
\[
\frac{2g(Z)-2}{|G|}=-2+\frac85+\frac12=\frac1{10}.
\]
But its left side is 2/e, so e=TWENTY. Its stabilizer lcm is TEN. The preceding positive-full equality is contradictory.

Without the positive trace, the accepted general Schur degree lemma still applies to M. Its degree is |G|/160, whereas every linearized line degree is divisible by |G|/TEN=SIXTEEN deg M. The obstruction order must be divisible by SIXTEEN. Since M¹⁶ is the canonical line, it also divides SIXTEEN, so it equals SIXTEEN. The determinant of any invariant actual spin-section span W annihilates the obstruction to its dim W power, giving SIXTEEN divides dim W. No rank upper bound is supplied.

## Both two-value inertia orders retain the entire even part

In the positive-full branch with e>ONE and coarse quotient P¹, the accepted determinant-character theorem gives |χ₂(G)|=e₂. The actual quotient Z/kerχ₂→P¹ is cyclic and tame of degree e₂. It has no branch values outside the TWO original values. A connected nontrivial cyclic tame cover of P¹ with at most two branch values has exactly two, both totally ramified: its two inertia generators are inverse and generate the whole cyclic group. Therefore each original inertia image under χ₂ has order e₂. The same accepted theorem identifies this image order with the full TWO-part of that original stabilizer. Both original inertia orders consequently have TWO-part e₂.

This retains, rather than deletes, the possible determinant character. Larger or differently ramified étale targets and unbounded spin spans remain unresolved.
