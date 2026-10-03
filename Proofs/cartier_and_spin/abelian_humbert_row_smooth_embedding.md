# Proof: characteristic-free genus and the free row orbit

Version2,3 October2026. [Root whole-proof review PASS](../../Research/audits/ABELIAN_HUMBERT_ROW_SMOOTH_HILBERT_BURCH_AUDIT_2026_10_03.md); Version2 adds the arithmetic Cohen–Macaulay and exact Hilbert–Burch conclusions. [Statement](../../Theorems/cartier_and_spin/abelian_humbert_row_smooth_embedding.md). The actual X-map remains upstairs. Use the reviewed [complete birational row](abelian_humbert_positive_coefficient_image.md) on the actual free A=C4×C4 cover C→Y, with genusSEVENTEEN and row degreeTWELVE.

## The arithmetic genus bound in characteristic five

Let Z⊂P³ be the integral row image and Σ its generic plane section. The characteristic-free result of [Bonacini, On the plane section of an integral curve in positive characteristic, Corollary4.3](https://arxiv.org/pdf/1009.4021) says its plane Hilbert h-vector is of decreasing type. This means it starts1,2,…,s, may have a plateau at its maximums, and after the first drop it strictly decreases untilZERO. The sum of its entries isTWELVE. The section is noncollinear, so s≥TWO; the sum1+2+3+4+5 already exceedsTWELVE, so s≤FOUR.

For s=TWO the only degreeTWELVE sequence is (1,2,2,2,2,2,1). For s=THREE the largest weighted sum is realized by (1,2,3,3,2,1); the other longest plateau possibility (1,2,3,3,3) has smaller weighted sum. For s=FOUR the remaining mass after (1,2,3,4) isTWO and the maximum is (1,2,3,4,2). Therefore the usual Hilbert-function inequality gives respectively
\[
 p_a(Z)\le\sum_{i\ge0}i h_i-12+1\le25,19,17.
\]
This inequality and its equality implication have an elementary coordinate-ring proof. A generic plane equation is a nonzerodivisor on the integral homogeneous coordinate ring. The quotient's Hilbert function dominates that of the saturated plane section. Summing these differences subtracts a nonnegative finite length from the displayed upper bound. Equality requires that quotient already be saturated; equivalently the coordinate ring is arithmetically Cohen–Macaulay.

In particular p_a(Z)=TWENTY FIVE forces s=TWO, the displayed conic sequence, and arithmetic Cohen–Macaulayness. The plane conic then lifts to a quadric containing Z: H¹(I_Z(1))=ZERO and the hyperplane restriction exact sequence makes H⁰(I_Z(2))→H⁰(I_Σ(2)) surjective.

## The actual projective multiplier forbids that quadric

Two linearly independent quadrics cannot contain an integral degreeTWELVE nondegenerate curve: their complete intersection has degreeFOUR unless they share a surface component; such a common component would be a plane, also impossible for Z. Thus any containing quadric is UNIQUE. It would be A-invariant since the row image is A-invariant.

But the actual four-dimensional coefficient representation has an orderFOUR multiplier. The induced projective action on quadratic equations has multiplier twice that class, of nonzero orderTWO (dualizing changes only its sign). A one-dimensional invariant subspace would trivialize this multiplier, which is impossible. Hence Z lies on no quadric, and the equality case is excluded:
\[
p_a(Z)\le24.
\]

## Every singular orbit costs at least eight

C is the normalization of Z. For an image pointz, let its stabilizer inA have orders and let b be the number of normalization branches. This stabilizer acts freely on the normalization fiber, because A acts freely on the ACTUAL smooth curve C. Thus b≥s and s dividesb. The local normalization defect satisfies δ_z≥b−ONE; ifs=ONE and z is singular, it satisfies δ_z≥ONE.

The whole image orbit has size16/s. Therefore a singular orbit contributes at leastSIXTEEN when s=ONE, at leastEIGHT when s=TWO, and at leastTWELVE, FOURTEEN orFIFTEEN when s=FOUR,EIGHT,SIXTEEN. These exhaust the stabilizer possibilities. Every singularity therefore contributes at leastEIGHT globally.

On the other hand the arithmetic genus bound gives
\[
\sum_z\delta_z=p_a(Z)-g(C)\le24-17=SEVEN.
\]
There can be NO singular point. The finite birational normalization map C→Z is thus an isomorphism, so the complete row is a smooth embedding. This argument treats multibranch collisions and cusps alike.

## Exact first-jet consequence

On C the actual pulled trace is P⊗V4, degP=FOUR, with constant coefficient frame. Its adjunction row consists of FOUR sections of Arow=ω_C⊗F*P^{-1}, of degreeTWELVE. In this horizontal frame the canonical map Φ₁ is the first-jet row map tensored with F*P. Fifth-power frame changes have derivativeZERO, so this is the ACTUAL O-linear horizontal Cartier jet map, not jets of variable-coefficient arbitrary sections.

A basepoint-free embedded linear series separates every tangent vector. Thus its FOUR first jets generate J¹Arow at every point; Φ₁ upstairs has no torsion cokernel. Faithfully flat étale descent gives the integral surjectivity on Y. The determinant of J¹ω_Y is ω_Y³, of degreeSIX; F*J_Y has degreeFIVE. Hence the kernel has rankTWO and degreeFIVE−SIX=MINUS ONE.

The accepted [contact-eight noncyclic jet flag](contact_eight_cartier_third_jet_flag.md) has first-jet defectTWO at its actual all-branch pointQ. It is incompatible with this additional abelian-Humbert positive-image hypothesis. That specialized implication cannot be transferred to arbitrary surviving degreeTEN traces without the exact contact/Smith hypotheses.

## Cubics and the missing plane-section bridge

Write Arow for the degreeTWELVE embedding line, and α for its orderFOUR projective deck multiplier (changing its sign does not affect the argument). A containing cubic is unique if it exists. Indeed two independent cubic surfaces meet in degreeNINE when they have no common surface component. If they have such a component, its degree is at mostTWO; C cannot lie in that component by nondegeneracy and the absence of quadrics, and would have to lie in both residual surfaces of degree at mostTWO, again impossible. The unique cubic would give a one-dimensional invariant subspace of the cubic equation representation, whose multiplier is 3α, still of orderFOUR. Consequently there is NO cubic equation.

It remains necessary to show that the generic plane section has no cubic equation: absence of a cubic on C alone would not establish that. Put M_n=H¹(P³,I_C(n)). Riemann–Roch gives h⁰(Arow³)=TWENTY, since deg(Arow³)=THIRTY SIX exceeds degω_C=THIRTY TWO. The ambient cubic space also has dimensionTWENTY and injects, so M_3=ZERO.

For the square, Riemann–Roch and Clifford give
\[
h^0(Arow^2)=8+h^0(\omega_C\otimes Arow^{-2}),\qquad
2\le h^0(\omega_C\otimes Arow^{-2})\le5.
\]
Here the lower bound follows from the injection of the TEN ambient quadrics, and the upper bound from the complementary degreeEIGHT line. The projective action on the square has multiplier 2α. Taking determinants shows that every invariant finite-dimensional space with this multiplier has EVEN dimension. In particular h⁰(Arow²), and hence dimM_2=h⁰(Arow²)−TEN, are EVEN. Thus dimM_2 is ZERO orTWO.

The hyperplane restriction sequence, together with H⁰(I_C(2))=H⁰(I_C(3))=M_3=ZERO, now identifies H⁰(I_Σ(3)) with M_2. The decreasing-type possibilities already listed give dimensions THREE, ONE and ZERO for this plane cubic space when s is respectively TWO, THREE and FOUR. Only ZERO is compatible with dimM_2∈{ZERO,TWO}. Therefore s=FOUR, and the plane h-vector is exactly
\[
(1,2,3,4,2).
\]
Its arithmetic genus bound isSEVENTEEN. Since C is already smooth of genusSEVENTEEN, equality holds; the coordinate-ring argument above proves that C is arithmetically Cohen–Macaulay. This step uses only the characteristic-free plane-section result, Riemann–Roch, Clifford and the actual orderFOUR multiplier.

## The two quadratic syzygies and exact resolution

Let R=k[X_0,X_1,X_2,X_3]/I_C. Arithmetic Cohen–Macaulayness and the plane h-vector give
\[
H_R(t)=\frac{1+2t+3t^2+4t^3+2t^4}{(1-t)^2},\qquad
(1-t)^4H_R(t)=1-3t^4+2t^6.
\]
In degreeFOUR the ideal has dimensionTHREE. Choose a basis Q_1,Q_2,Q_3 of quartics. They have no nonconstant common factor. A common factor of degree at mostTHREE would either contain C, contrary to the absence of equations in those degrees, or leave residual equations of degree at mostTHREE containing C. A factor of degreeFOUR would make the Q_i dependent.

There is at mostONE independent linear syzygy among the Q_i. Two syzygies independent over the rational function field would express the quartic vector as a multiple of their quadratic cross-product, forcing a common factor of degree at leastTWO. Two linearly independent syzygies dependent over that field are also impossible: their primitive common direction either is constant, giving a scalar relation among the Q_i, or is linear, in which case all linear syzygies in that direction are constant multiples of it.

On the other hand the linear-syzygy space is invariant under the actual deck action and has the degreeFIVE multiplier 5α=α, of orderFOUR. The determinant of its projective action forces its dimension to be divisible byFOUR. The preceding bound therefore makes that space ZERO. This explains the absence of linear syzygies without assuming a generic matrix.

The ideal dimensions in degreesFIVE andSIX are respectivelyTWELVE andTWENTY EIGHT. Thus the THREE quartics generate all degreeFIVE equations. Their THIRTY quadratic multiples have at leastTWO independent quadratic syzygies. Choose two. They are independent over the rational function field: otherwise their primitive common direction has degreeZERO, ONE orTWO, yielding respectively a scalar relation, a forbidden linear syzygy, or a one-dimensional space of quadratic syzygies in that direction.

Their cross-product consists of quartics and is proportional to (Q_1,Q_2,Q_3). Since that quartic vector has greatest common divisorONE, the proportionality factor is polynomial; equality of degrees makes it a nonzero constant. Therefore the Q_i are the maximal minors of the resulting TWO-by-THREE quadratic matrix. The minors have heightTWO. Hilbert–Burch gives its ideal I′ the resolution
\[
0\longrightarrow\mathcal O(-6)^2\longrightarrow\mathcal O(-4)^3
\longrightarrow\widetilde I'\longrightarrow0.
\]
Its homogeneous coordinate ring has numerator 1−3t⁴+2t⁶, exactly the numerator already computed for R. Since I′⊂I_C and their Hilbert series coincide in every degree, they are equal. This proves the asserted exact resolution and all generating degrees. The induced deck actions on generators and syzygies are inherited from the actual ideal; the proof makes no assertion that the row line extends to a surface or that C carries an actual X-map.
