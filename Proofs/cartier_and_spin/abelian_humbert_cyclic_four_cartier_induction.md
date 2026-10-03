# Proof: actual cyclic-four induction and translated Cartier divisors

Version1,3 October2026. [Root whole-proof review PASS](../../Research/audits/ABELIAN_HUMBERT_POSITIVE_IMAGE_AND_INDUCTION_AUDIT_2026_10_03.md). [Statement](../../Theorems/cartier_and_spin/abelian_humbert_cyclic_four_cartier_induction.md). Use the actual [coefficient-image theorem](abelian_humbert_positive_coefficient_image.md). No computation or new nonexistence claim. Both original finite étale maps remain on T′.

Suppose the actual positive trace J_Y has rankFOUR, degreeONE, and is an integral subbundle of B_Y. In the genuine abelian-kernel Humbert situation the coefficient image is A=C4×C4 with its perfect order-FOUR alternating pairing, and C=T′/Hc→Y is its actual degreeSIXTEEN étale torsor. Choose a maximal isotropic I=C4 in A and let D=C/I. Then f:D→Y and π:C→D are connected cyclic degreeFOUR étale maps, and g(D)=FIVE.

There is an actual degreeONE line N on D with
\[
J_Y\simeq f_*N,
\qquad N\hookrightarrow B_D.
\]
Moreover, for a primitive order-FOUR character line η defining π, the four f-deck conjugates of N are exactly N⊗η^i, i=0,1,2,3, up to permuting the primitive generator. Consequently ALL FOUR spaces
\[
H^0\bigl(D,\omega_D\otimes F^*(N\otimes\eta^i)^{-1}\bigr)
\]
are nonzero; their lines have degreeTHREE. In relative Frobenius notation N and its Cartier bundle are on the same Frobenius target, and the displayed F* is the ACTUAL Frobenius pullback. Equivalently, after that conventional identification these are the four translates of ω_D N^{-5} by the exact cyclic-four character subgroup.

## The actual line and its induction

The projective representation restricted to I has FOUR distinct eigenlines. Indeed its perfect commutator pairing identifies A/I with the full character group I*, so the complementary quotient acts simply transitively on these eigenlines. The preimage G_I of I in G′ fixes each eigenline projectively. Its tensor with the ACTUAL line L² is a genuine G_I-linearized line subbundle of q*J_Y. It descends through the free actual G_I action to a line N on D. Since upstairs it has degree2d and |G_I|=2d, degN=ONE.

The natural N→f*J_Y induces f_*N→J_Y by finite étale adjunction, with the trace identifying f! with f*. Upstairs on T′ its FOUR columns are the distinct eigenlines, hence are linearly independent and the map has full rank. Étale Euler characteristic gives deg(f_*N)=degN=ONE. The target also has degreeONE, so its generically nonzero determinant has degreeZERO and no zero: the map is an isomorphism.

The inclusion N→f*J_Y→f*B_Y=B_D is an integral line inclusion. The last equality is functoriality of the exact Cartier bundle under actual étale base change. Adjunction to the original Frobenius map therefore gives a nonzero section of ω_D⊗F*N^{-1}. Since degω_D=EIGHT and degF*N=FIVE, its zero divisor has degreeTHREE.

## Exact order of the four twists

All eigenlines pull back to the SAME underlying line on C. Their I-linearizations differ by each of the FOUR distinct characters of I. Descent along π therefore identifies the corresponding lines on D as N⊗η^i. Since π is connected and I=C4, its primitive character line η has EXACT orderFOUR: otherwise its faithful primitive character would become trivial on a nontrivial connected torsor subgroup. The A/I deck action of f cyclically permutes all four eigenlines, so these four lines are precisely the f-conjugates of N. Their inclusions into B_D and their Frobenius-adjoint sections all survive.

## What this does and does not add

On D this gives a specific four-fold intersection of translates of the degreeTHREE effective locus in Pic³(D). It is not an arbitrary Tango line on an arbitrary large étale cover; D is an ACTUAL cyclic-four cover of the original genus-two endpoint. BACKUP ordinarity of all exponent-four covers does not by itself exclude this incidence: ordinary H⁰(B_D)=0 addresses the trivial line, not these positive degreeONE twists. No such exclusion is claimed.

The actual X maps remain on T′. Neither induction nor the effective-divisor incidence makes them factor through D or C. Also a degreeNINE endomorphism field does not force its deck characters to have dimension at mostNINE: the settled packet inequality permits, for example, dimensionsTEN andSIXTEEN. Thus the earlier odd-character orbit bound alone cannot close this branch.

## The fourth power descends

Since η has orderFOUR, each f-deck generator σ satisfies σ*N⁴≅N⁴. The obstruction to linearizing this invariant line on the cyclic groupC4 lies in H²(C4,k*)=0 over the algebraically closed field; equivalently rescale a lift by a fourth root to make its fourth powerONE. Thus N⁴ has a genuine f-deck linearization and descends along the ACTUAL étale torsor f to a line M on Y. Its degree is degN⁴/4=ONE. This uses no claim that N itself descends.
