# Proof: row parity omits the intrinsic branch direction

Version2,3 October2026. [Root whole-proof review PASS, including the general scope extension](../../Research/audits/ABELIAN_POSITIVE_TRACE_WHOLE_EXCLUSION_AUDIT_2026_10_03.md). [Statement](../../Theorems/cartier_and_spin/abelian_humbert_positive_trace_exclusion.md). Preserve BOTH actual finite étale maps throughout. The main assertion concerns the ENTIRE abelian projective coefficient image; the Humbert abelian-kernel case is its corollary.

## General exact image without a Humbert premise

Let q:T→Y be the actual positive spin refinement in the statement. Its degree is EIGHT d, and q*J_Y=L²⊗V4 with degL²=TWO d. A proper invariant constant subspace of dimension r=ONE,TWO orTHREE would descend to a subbundle of J_Y with degree r/FOUR, impossible for an integral degree. Thus the coefficient representation is irreducible.

Let A be its finite ENTIRE abelian projective image. Its faithful irreducible projective representation has perfect alternating commutator pairing: an element in the radical would commute linearly with every coefficient after a scalar rescaling, hence would be scalar by irreducibility and would be trivial in the faithful projective image. The twisted algebra is Mat₄, so |A|=SIXTEEN. The only paired abelian groups of this order are C₂⁴ and C₄×C₄. The former has multiplier exponentTWO, and inflation cannot increase that exponent. It cannot produce the actual orderFOUR positive coefficient multiplier. Therefore A=C₄×C₄ exactly.

For its kernel Hc the actual quotient C=T/Hc→Y is an étale degreeSIXTEEN torsor. Tensoring the scalar action on L² with the inverse coefficient scalar descends the actual coefficient line P of degreeFOUR, so q_C*J_Y=P⊗V4. The row line is Arow=ω_C F*P⁻¹ of degreeTWELVE. The raw row identities give a basepoint-free row: at a fixed Y-fiber only SIX of EIGHT fractions of the actual raw labels can be q₀-zero labels, because the q₀-zero divisor on X is reduced of degreeSIX and the Y-degree is EIGHT times its X-degree. Irreducibility makes its constant kernelZERO. Its FOUR sections are independent. Its orderFOUR multiplier and Clifford imply h⁰(Arow)=FOUR, so the row is complete.

For completeness, the birational row argument uses only this A, degreeTWELVE, genusSEVENTEEN and the accepted absence of degree-at-mostFOUR elliptic maps from the selected Y. Its separating degree onto the normalized image dividesTWELVE and is at mostFOUR. A acts faithfully on that image, with stabilizer orders dividing that degree. Rational image is impossible for faithful C₄²⊂PGL₂. An elliptic image has only translation action, giving a forbidden low-degree elliptic map from Y. DegreesTHREE orFOUR force image line degree at mostFOUR and genus at mostONE. DegreeTWO forces genus at mostFOUR; the tame A Hurwitz formula makes that genus minusONE divisible byEIGHT, again impossible. Thus the row is birational.

The proofs of the [smooth row and exact ideal](abelian_humbert_row_smooth_embedding.md) and [quadratic model](abelian_humbert_row_quadratic_hyperelliptic_model.md) now apply to these data without any Humbert assumption: they use solely the actual free A=C₄² action, complete birational degreeTWELVE row, genusSEVENTEEN and its primitive multiplier. Explicitly the characteristic-free plane-section bound is at mostTWENTY FIVE; multiplier forbids the unique quadric equality case; a free A singular orbit costs at leastEIGHT versus the remaining genus budgetSEVEN. Thus the row is smooth. Its FOUR invariant quadrics descend to degreeSIX on C/A[2] of genusFIVE; Clifford equality identifies the hyperelliptic H³ series, and finite flat quadratic pullback identifies C with the inverse image of its twisted cubic. These are exactly the geometric inputs used below. No target Humbert curve, normal kernel or presumed extra X endpoint was used.

## Exact dependencies and degrees

The preceding general argument gives an actual étale C₄×C₄ torsor q_C:C→Y of degreeSIXTEEN, genusSEVENTEEN, and a complete smooth degreeTWELVE row embedding Arow. Its image is the inverse image of a twisted cubic under FOUR invariant quadrics. Denote the retained source by T′ below; it is the actual T in the general statement, or the Humbert compositum refinement in that corollary. The actual X-map remains on T′, which is étale over C and both original endpoints.

Write D_Y for the determinant divisor of J_Y⊂B_Y. Since degB_Y=FOUR and degJ_Y=ONE, it has degreeTHREE. Its actual pullback D_C has degreeFORTY EIGHT. The [canonical horizontal Taylor isomorphism](contact_eight_cartier_third_jet_flag.md) F*B_C≅J³ω_C sends the primitive classes [t],[t²],[t³],[t⁴] to the jets of dt,2t dt,3t²dt,4t³dt. In particular the intrinsic primitive-orderFOUR line F₄ maps to the highest jet line, generated at a fiber by (ZERO,ZERO,ZERO,ONE).

Restricting this isomorphism to F*q_C*J_Y identifies its image with the horizontal jets of the actual adjunction row. In a local horizontal frame of F*P, with q_C*J_Y=P⊗V4, this is the ordinary row jet matrix multiplied by that frame. Its determinant divisor is EXACTLY
\[
\operatorname{div}(\mathrm{Wr}_{\psi})=5D_C.
\]
Its total degree is 4degArow+6degω_C=FORTY EIGHT+ONE HUNDRED NINETY TWO=TWO HUNDRED FORTY, consistently with 5degD_C. These are the raw integral jets and actual Smith determinant; saturation is not performed.

The intrinsic source statement used below is proved in the [branch-fiber contact proof, section on the order-four line](branch_fiber_uniform_contact_gap.md): at EVERY actual finite cubic branch of the fixed X, the original three-section image I has primitive orders(ONE,FOUR,SEVEN), so its image in the Cartier fiber contains F₄. This is invariant under arbitrary actual étale parameter changes. Its local source Smith exponents are(0,0,1), while at infinity they are(0,1,2), as in the [generated hyperplane theorem](cartier_kernel_generated_subbundle.md). Away from those source points I=U. By definition of the COMPLETE first trace, every pulled-back original I is integrally contained in q*J_Y.

## Forty-eight ramification points with one odd coordinate

Put Y₀=X₀+X₂,Y₁=X₀−X₂,Y₂=X₁+X₃,Y₃=X₁−X₃ in the row coordinates. The quadratic map becomes the square-coordinate map, up to an invertible change of target coordinates. Its projective sign group B is elementary abelian of orderEIGHT. Restriction gives the actual degreeEIGHT Galois map C→P¹ through the twisted cubic. The quadratic model identifies E=C/A[2] as its hyperelliptic intermediate curve of genusFIVE.

On the twisted-cubic P¹ the four squared coordinates are independent cubic sections F_i. GenusFIVE of the intermediate double cover y²=∏F_i forces TWELVE distinct simple branch values. Each value has inertiaTWO in B and therefore FOUR points above it on C. There are exactlyFORTY EIGHT reduced B-ramification points.

At a root of F_i only Y_i vanishes. Its zero is simple on C. The local inertia fixes the other three coordinates and negates Y_i, projectively. Choose a nonzero other coordinate as row frame and a tame local parameter t with inertia t↦−t. The row functions then consist of THREE even functions and ONE odd function with nonzero linear coefficient. In their zero-through-third jet matrix, rowsONE andTHREE are both supported only in that odd column. Consequently rowTHREE is a scalar multiple of rowONE in the fiber. The matrix has rank at mostTHREE, and its image does NOT contain the highest jet vector (0,0,0,1).

This highest-vector conclusion does not depend on the chosen row frame. A change by any unit acts triangularly on principal parts and preserves the highest jet line. In particular it survives the change to the actual horizontal F*P frame and the differential frame in J³ω_C. It is thus a statement about the ACTUAL fiber image of F*q_C*J_Y inside F*B_C, not just about a projective coordinate matrix.

Every one of the FORTY EIGHT ramification points is therefore in D_C. Since degD_C=FORTY EIGHT, they exhaust it, each with multiplicityONE. Equivalently each Wronskian zero has multiplicityFIVE and there are no others. Thus EVERY actual target Smith defect is simple, and at EVERY point of D_C the image of q_C*J_Y in B_C omits the intrinsic F₄ direction. The same assertions hold after the actual étale pullback to T′.

## No finite cubic branch can occur at a defect

Take the retained actual map h:T′→X. If a point above the target defect were a finite cubic source branch, the pulled-back original image I would contain F₄ in the Cartier fiber. But I⊂q*J_Y, whose image omits F₄ there. This is impossible. Thus no source branch point of h lies over ANY target defect. The same holds for every actual conjugate map, though one retained map suffices for the final contradiction.

Write degh=d, so the retained étale map q:T′→Y has degreeEIGHT d. On this actual source let
\[
L_U=h^*U\cap q^*J_Y,\qquad
t=\operatorname{length}(h^*U/L_U).
\]
The source U has degreeTHIRTEEN, so degh*U=THIRTEEN d. The actual decomposition q*J_Y=L²⊗V4 is a direct sum of FOUR equal lines of degreeTWO d. Its rankTHREE subbundle L_U therefore has degree at mostSIX d. Consequently
\[
t\ge7d.
\]
This also agrees with the independently accepted [first-contact bound](first_section_contact_strictness.md); the direct equal-line argument here needs no additional stability assertion.

At a point away from the target defect q*J_Y=B_{T′}, so there is no contact. At an ordinary finite source sheet I=U, and I⊂q*J_Y again gives no contact. Finite cubic branch sheets over the defects were just excluded. All contact must therefore lie in h⁻¹(O), the reduced actual infinity divisor of degree d.

Every target defect is SIMPLE, so B_{T′}/q*J_Y has lengthONE locally. The contact quotient h*U/L_U injects into this quotient and has length at mostONE, irrespective of the two possible infinity elementary divisors. Summing over the d infinity points gives
\[
t\le d,
\]
contradicting t≥SEVEN d. This excludes the ENTIRE abelian projective coefficient-image positive full-trace branch while retaining both original actual maps, without converting C or E into a presumed X endpoint. The Humbert case with abelian genuine target kernel is a corollary by its accepted exact C₄² coefficient-image theorem; the kernel need not itself be the entire projective image.
