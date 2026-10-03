# Proof: rank-two quadrics and the tame sign give incompatible degrees

Version1,3 October2026. Pending independent review; see the [actual-source statement](../../Theorems/cartier_and_spin/canonical_ten_quadratic_row_covariant_vanishing.md). No computation is used.

Suppose a nonzero equivariant map supplies a quadratic-form row f on V^[5], with coefficients sections of Q². Its base divisor is R-invariant. Every R-orbit on Γ_R has size r,r/5 orr/2, while degQ²=r/20. Any nonzero coefficient has smaller degree than any orbit, so the row has NO base point.

At an actual tame point choose a determinant-ONE coefficient lift A=λs, with s the normalized reflection of eigenvalues−ONE,ONE,ONE,ONE and λ⁴=−ONE. The paired Q lift B has B²=λ⁻²; its fiber b therefore satisfies b²=λ⁻². On the Frobenius-twisted module A^[5]=λ⁵s. The action on Q²⊗Sym²(V^[5])^* has scalar b²λ⁻¹⁰=λ⁻¹²=−ONE. Thus invariance at this fixed point permits only the cross terms between the ONE-dimensional negative eigenspace and the THREE-dimensional positive eigenspace. Since the row is nonzero there, its quadratic form is a product of TWO distinct linear forms and has rankTWO.

There are r/2 actual tame points. Every THREE-by-THREE minor of its symmetric matrix is a section of Q⁶, of degree3r/20, and vanishes at them all. It therefore vanishes identically. The row has rank at mostTWO everywhere. It has rankTWO somewhere, so at least one TWO-by-TWO minor is nonzero. The locus where rank drops toONE is R-invariant. Such a minor has degree degQ⁴=r/10, again smaller than every R-orbit. Hence rank never drops, and the row has rankTWO EVERYWHERE.

Over the algebraically closed characteristic-FIVE field, an everywhere rank-TWO quadratic form has two distinct linear factors. Ordering these factors defines a finite étale double cover π:Γ_hat→Γ_R. Equivariance supplies a CANONICAL honest R-action on this cover: it sends (p,ℓ₁,ℓ₂) to (gp,gℓ₁,gℓ₂), using the actual projective action on the factor space. This does not choose arbitrary lifts in an étale closure.

Every actual inertia group fixes both factor lines. At a tame point this is the cross-factor description above. At a wild point its group C5 cannot act nontrivially on a TWO-element set. Therefore Γ_hat/R→Γ_R/R=P¹ is an étale double cover: the inertia groups at each lifted point equal the original inertia, and there is no new ramification elsewhere. A connected étale double cover of P¹ does not exist. Thus Γ_hat is split. Since R has no C2 quotient, it preserves each of its two components. We obtain TWO R-equivariant factor maps Γ_R→P((V^[5])^*).

Let L₁,L₂ be their pulled O(ONE) lines. Their sections have no common zero, and multiplication identifies
\[
L_1\otimes L_2=Q^2,\qquad
\deg L_1,\deg L_2\ge0,\qquad
\deg L_1+\deg L_2=r/20.
\]
Both lines inherit the SAME projective scalar cocycle from the same factor-space representation. Hence A=L₁⊗L₂⁻¹ has a GENUINE R-linearization. At each tame point the two factors belong to opposite eigenspaces; the fiber character on A is therefore−ONE.

Hilbert90 supplies a nonzero R-invariant rational section of this genuinely linearized line. Its divisor is R-invariant. At a tame point choose a local parameter t with g(t)=−t. If the invariant section has order j there, its fiber relation gives (−ONE)^j=−ONE, so j is ODD. An invariant divisor on Γ_R consists of ordinary orbits of size r, the wild orbit of size r/5, and the tame orbit of size r/2. Consequently
\[
\deg A=r\left(m+\frac{k}{5}+\frac{2l+1}{2}\right)
=\frac r{10}\bigl(10m+2k+10l+5\bigr)
\]
for integers m,k,l. The numerator is ODD and nonzero, so |degA|≥r/10. This argument does NOT assume that trivial wild fiber characters imply coarse descent; the arbitrary wild coefficient k is retained.

But effectiveness of the factor lines and their displayed degree sum give |degA|=|degL₁−degL₂|≤r/20. This contradiction proves the vanishing.

For the stated trace application, the actual degree-TEN map φ_C:C→Γ_R has ω_C=φ_C*Q⁸ and relative canonical line φ_C*Q⁴. Its Frobenius-adjoint positive row consists of sections b_v of φ_C*Q³, indexed linearly by v∈V^[5]. Relative duality and trace map their products to sections of Q²: in a canonical-different rational frame this is Tr(b_v b_w/a). This construction is R-equivariant, so the vanishing applies. It is a weighted trace, not a presumed descended Cartier inclusion or an arbitrary trace without its different factor.
