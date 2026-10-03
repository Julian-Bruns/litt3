# Proof: the zero-top lower row and its two native dual coefficients

Version1, 3 October2026. [Independent bounded audit](../../Research/audits/OCT03_NONFACTOR_ZERO_TOP_NATIVE_FAMILY_AUDIT.md): mathematical PASS allTEN checks, no repair. All maps are restrictions of the SAME original calibrated source. Both actual endpoint maps remain onT. The standard gates below are invoked as geometric Cartier-kernel calculations, without replacing the nonconstant C′ by an original constant source.

## The positive source's top kernel is ordinarily nef

Put δ=degω_Γ and μ=deg(M^(1))²=δ/FOUR. The original source S_n is an ordinary direct sum of that positive line. Its integral quotient Q has rankTWO and degreeδ. Untwisting the exact top sequence by(M^(1))⁻² gives a kernel of a trivial bundle with degree−δ/TWO. If U is a rank-r locally free quotient of C′, its untwist has kernel a subbundle of the same trivial bundle, hence of degree at mostZERO. Thus
\[
\deg U\ge r\mu-\delta/TWO=(r-TWO)\delta/FOUR.
\]
For a genuine native quotient its determinant degree is an integer multiple ofδ. Every ordinary last Harder–Narasimhan quotient is genuine native by uniqueness. A rankONE last quotient has degree at least−δ/FOUR and therefore at leastZERO; a rankTWO last quotient has degree at leastZERO; every higher-rank one has positive degree. Consequently μ_min(C′)≥ZERO. This does not assert strict positivity or strong semistability.

The SAME Frobenius-pulled top source map vanishes onF_Γ*C′. The top quotient of the original full rowω²F₄ is its last-power quotientω². Its evaluation is the composite throughF_Γ*Q→ω². Therefore the actual adjoint lower row of F_Γ*C′ lies inω²F₃. Its kernel is R′∩F_Γ*C′, which equalskerρ. Ifρ=ZERO, it is the entire R′. The actual lower image I has rankTHREE and determinant
\[
\det I=\det(F_\Gamma^*C')\,\det(R')^{-1}
=\omega^{FIVE m-FIVE}\omega^{-(FIVE m-EIGHT)}=\omega^3.
\]

## The lower image has no defect

The ordinary Harder–Narasimhan slopes ofF₃ are ZERO,minusδ/TWO,minusδ/TWO,minusδ. Indeed its unit quotientF₃/O contains the ordinarily semistable Q₁=F₂/O of rankTWO degree−δ with quotientω⁻¹. These distinct slopes give its two HN pieces; adjoining the unit gives the first slopeZERO. Hence every rankTHREE subbundle ofω²F₃ has degree at mostFIVE δ, and equality forces the top HN stepω²F₂. This step is unique: a rankTHREE subbundle meeting the last quotientω with rankONE has degree at most (TWO+THREE/TWO+ONE)δ<FIVE δ; without that image it is contained in the rankTHREE top step and equality gives the whole step.

Saturate I inω²F₃. Its determinant defect is invariant and has degree at mostTWO δ. The least orbit is the reduced wild orbit of degreeTWO δ. Thus either the defect isZERO, or it is exactly that wild orbit and the saturation has degreeFIVE δ, hence equalsω²F₂.

The latter case is impossible for the actual source. The calibrated adjoint map C′→F_{Γ*}(ω²F₂) then lands in the standard Cartier kernelZ₂: the standard condition is inherited from the SAME original K⊂B_Y and actual étale pullback toT. The [rankTWO gate](canonical_ten_zero_gram_rank_two_standard_cartier_exclusion.md) proves μ_max(Z₂/B_Γ)<ZERO. Since μ_min(C′)≥ZERO, the composition to this negative quotient isZERO. The map factors throughB_Γ, and its Frobenius adjoint factors through the natural lineω_Γ⊂ω²F₂. Its evaluation onT is consequently divisible by the actual different sections: the natural φ*ω_Γ→ω_T has reduced zero divisor q*P₀. On the other hand the integral joint original source A_n→K⊕Q_Y gives C′_Y=ker(A_n→Q_Y)→K surjective; after Frobenius its original evaluation is surjective ontoω_Y and hence ontoω_T after pullback. It cannot vanish atq*P₀. This contradiction excludes the defectTWO δ alternative. Thus I is saturated with determinantω³.

Untwist I byω² and call the resulting saturated rankTHREE A⊂F₃. Its determinant isω⁻³. It contains the actual primitive unit. Otherwise its generic intersection with the unit isZERO, so its projection toF₃/O is a full-rank native injection with determinant defect
\[
\deg(F_3/O)-\deg A=(-TWO+THREE)\delta=\delta.
\]
No nonzero invariant divisor has this degree. Thus that projection is impossible. Once the unit lies generically inA, saturation implies its integral inclusion. The rankONE quotient F₃/A is a genuine native ω line. The remaining task is to classify its surjective quotient map.

## Weighted duality reduces the classification to four coefficients

The actual inverse-different trace pairing E⊗E→ω⁻¹, (b,c)↦Tr(bc/s), is perfect and native. The same Newton vanishing and saturated power ranks give F₃^⊥=F₅. Therefore
\[
F_3^*\omega=(E/F_5)\omega^2.
\]
In the fixed invariant df frame every genuine native rational section has a unique expression
\[
(A_6(f)d_0^6+A_7(f)d_0^7+A_8(f)d_0^8+A_9(f)d_0^9)(df)^2\pmod{F_5\omega^2}.
\]
At finite ordinary values the saturated power basis makes every A_l regular. At tamef=ZERO, putf=t² times a unit anddf=t times a unit timesdt. The l-th coefficient has orderTWO−l+TWO ord_fA_l. Hence A₆,A₇,A₈,A₉ are polynomials divisible respectively by f²,f³,f³,f⁴.

At a weak wild point use the existing regular basis e_(2r+ε)=t^-r Q(a)^r a^ε, where a=s/dt and Q(X)=X²−A(t)X+B(t). Both A(ZERO) and B(ZERO) are nonzero. Write df=t⁻²u dt withu a unit, so d₀=t²(κu)⁻¹a. The highest e_l coefficient of d₀^l(df)² has order TWO l+floor(l/TWO)−FOUR. For l=SIX,SEVEN,EIGHT,NINE these orders are ELEVEN,THIRTEEN,SIXTEEN,EIGHTEEN. A polynomial of f-degreev has order−FIVE v.

The e₉ condition first gives degA₉≤THREE, incompatible with its f⁴ divisibility, so A₉=ZERO. The e₈ condition gives degA₈≤THREE, hence A₈=γf³. In characteristicFIVE the exact top part of the recurrence X²=Q+AX−B is
\[
X^8=Q^4+FOUR A Q^3X+(A^2+B)Q^3+	ext{terms of power degree at mostFIVE}.
\]
Thus f³d₀⁸(df)² has e₈ coefficient of orderONE and e₇,e₆ coefficients of orderZERO. These are the only surviving quotient coordinates moduloF₅, so it is regular. The e₇ condition then forces degA₇≤TWO, incompatible with its f³ divisibility, so A₇=ZERO. Finally the e₆ condition gives degA₆≤TWO, hence A₆=εf². This section is also regular: its sole surviving highest e₆ coefficient has orderONE. We obtain the exact native section space
\[
H^0((E/F_5)\omega^2)^G
=k[f^2d_0^6(df)^2]\oplus k[f^3d_0^8(df)^2].
\]
No coefficient condition from a specified eight-dimensional source is present. The two directions are generically independent. The displayed top recurrence follows directly by multiplying the known X⁷ expression byX and reducing X²; there is no numerical search.

## The integral quotient maps and family

Pairing these sections withF₃ gives a common nonzero factorκ⁻¹ times the mapsμ₆ andμ₈ in the statement. A common factor does not affect either image or kernel. Newton sums give Tr(d₀^j)=ZERO for ZERO≤j≤SEVEN and j=NINE,TEN, and Tr(d₀⁸)=C f⁻⁴ for C∈k×. Henceμ₆ is nonzero only on the raw cubic power, whileμ₈ is nonzero only on the raw linear power. In particular they kill the unit and quadratic power, and
\[
\mu_6(s^3)=\kappa^3C f^{-2}(df)^4,
\qquad\mu_8(s)=\kappa C f^{-1}(df)^2.
\]
The first map is the canonical F₃/F₂=ω⁻¹ quotient followed by multiplication by a nonzero constant times t₂. Its image inω is thereforeω(-W)=ω⁻¹, with precisely the reduced wild zero divisor; its kernel isF₂.

The second map is surjective. Away from the wild orbit its restriction to the native linear-power line is a nonzero constant times t₂, which is a unit there. At a wild point its dual e₇ coefficient is a nonzero constant times FOUR A(ZERO), by the exact X⁸ expansion; perfect integral trace duality therefore makes its fiber map nonzero. Thusμ₈ is a unit quotient at every point. Adding any multiple ofμ₆ does not change its wild fiber, and away from wild its value on the linear-power line is unchanged sinceμ₆ kills that line. Everyμ₈+tμ₆ is integrally surjective.

The quotient map ofA must be a nonzero combination of the two. The μ₈ coefficient cannot vanish, becauseμ₆ alone has kernelF₂ with determinantω⁻¹ rather than the requiredω⁻³ (and the corresponding original saturated image was already excluded). Normalize that coefficient toONE. The displayed two values show that its generic kernel is exactly the span
\[
ONE,\ s^2,\ s^3-t\kappa^2t_2s.
\]
Writing τ=tκ² gives the statement. Taking the actual saturated kernel supplies the integral family, and its determinant follows from the exact quotient ontoω. The parameter is unique because the two quotient maps are independent and their projective ratio is fixed.

No argument here forces the geometric kernelC′ to be an ordinary direct sum of a positive line or a constant coefficient submodule. Its ordinary nef bound was enough for the one negative-target exclusion, but does not kill a zero-slope target. The explicit affine family remains a source-compatible case list pending further Cartier and local source analysis.
