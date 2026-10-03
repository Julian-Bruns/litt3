# Proof: positive line generation excludes every proper positive image

Version1,3 October2026. Root whole-scope review **PASS** in the [audit](../../Research/audits/RANK_THREE_SOCLE_AND_ORTHOGONAL_ROW_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/rank_three_positive_trace_socle_generation.md). No computation is used.

Every line subbundle A⊂B_Y has nonzero Frobenius adjunction F_Y*A→ω_Y. Thus FIVE degA≤TWO, so degA≤ZERO. This also bounds lines in K.

Suppose a rankTWO subbundle K′⊂K had degree at leastONE. Saturate it INSIDE K. Its quotient Q is then a line bundle of degree at mostZERO. Each original positive q0 line on T has degreeTWO d, whereas q*Q has nonpositive degree. Its morphism to q*Q must vanish. Consequently all original positive inclusions factor through q*K′. By the definition of the COMPLETE actual trace, K would have rank at mostTWO, a contradiction. Every proper rankTWO subbundle therefore has degree at mostZERO. Together with the line bound this proves stability at slopeONE/THREE. Saturation of K in B_Y was never used.

Let W⊂V be a nonzero projective G-submodule. Its evaluation into q*K is nonzero because the defining inclusion V⊂H0(T,q*K⊗L⁻²) is injective. The paired action on W⊗L² is genuine: its projective scalar defects cancel those of L² exactly, as for the complete presentation. Thus its image is a genuine G-equivariant integral subsheaf of q*K. Finite étale descent supplies an actual image K_W⊂K on Y. On a smooth curve the image is locally free, whether or not its quotient has torsion. Its pulled image is EXACTLY the original image; faithful flatness of q commutes with taking this image.

Write r=rankK_W. Dividing its presentation by L² gives a globally generated rank-r bundle q*K_W⊗L⁻². Its determinant is globally generated, so its degree is nonnegative. Since degq=EIGHT d and degL²=TWO d,
\[
\deg(q^*K_W\otimes L^{-2})
=EIGHT d\deg K_W-TWO d r\ge ZERO.
\]
Therefore degK_W≥r/FOUR. The degree is an integer and r is positive, hence degK_W≥ONE. The proper-subbundle bounds above exclude r=ONE,TWO, also when K_W is not saturated: saturation could only increase its degree. Thus r=THREE. A full-rank image in K has degree at mostONE; the displayed inequality forces equality. Its finite torsion quotient has degreeZERO and hence is zero. Consequently K_W=K integrally.

The assertion on C follows by descent of this same evaluation after absorbing the projective scalar action of H into L². No smaller-row field claim is needed for any step.
