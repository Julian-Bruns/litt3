# Proof: exact eight-dimensional Cartier kernel has a negative outer quotient

The [actual original-positive scalar construction](actual_positive_source_relative_scalar_calibration.md) supplies the retained calibration for the same source.

Version1, 3 October2026. [Independent bounded audit](../../Research/audits/OCT03_RANK_TWO_STANDARD_CARTIER_EXCLUSION_AUDIT.md): mathematical PASS all EIGHT tasks. All calculations are exact symbolic identities in characteristicFIVE; no numerical search or computational certificate is required. The final actual-source consequence explicitly retains the original positive-inclusion presentation and scalar-line calibration.

## Rational Cartier calculation in the ACTUAL field

Put A=c⁻³, h=c−ONE, D=d⁵, F=f⁵, and K₀=k(Γ)⁵. Separability makes f a p-basis onΓ andT; thus k(Γ)=K₀(f) and k(T)=k(T)⁵(f), each of degreeFIVE over its fifth-power field. The ACTUAL primitive d has degreeTEN over k(Γ), so D has degreeTEN overK₀. In particular
\[
ONE,D,D^2,D^3,D^4,D^5,D^{-1}
\]
are linearly independent overK₀: multiplying a putative relation byD gives a nonzero polynomial of degree at mostSIX, contrary to degreeTEN.

The primitive polynomial gives
\[
d^2=A+Bf^2+Cf^4,
\quad B=TWO b c^2D,
\quad C=-c^7D^2-Ah/F.
\]
Since d⁻¹=(d²)²/D and d=(d²)³/D, expand them in the p-basis ONE,f,…,f⁴, reducing f⁵=F. For m_i,p_i the coefficients of f^i in d⁻¹,d respectively, the exact formulas are
\[
\begin{array}{c|c|c}
i&Dm_i&Dp_i\\
0&A^2&A^3+THREE BC^2F^2\\
1&TWO BCF&ABCF+B^3F\\
2&TWO AB&THREE A^2B+C^3F^2\\
3&C^2F&THREE AC^2F+THREE B^2CF\\
4&TWO AC+B^2&THREE A^2C+THREE AB^2.
\end{array}
\]
The standard Cartier operator on g df vanishes exactly when the f⁴ coefficient ofg in this p-basis vanishes. This checks kernelZERO without identifying Frobenius twists or taking unlabelled fifth roots of coefficients.

In the invariant rational basis ofJ let
\[
v_0=(df)^2\cdot ONE,
\quad v_1=(df)^2d,
\quad v_2=(df)^2d^2.
\]
Here d=s/(κdf) is the normalized primitive in the fixed-endpoint polynomial, with its fixed comparison constantκ∈k× retained. Under the genuine canonical comparison withφ_*ω_T, evaluation sends these to κ⁻¹d⁻¹df, κ⁻¹df,κ⁻¹d df. A common nonzero scalar does not change the standard Cartier kernel. Thus, after retaining this common factor explicitly, a rational section of F_{Γ*}J is represented by
\[
\alpha=\kappa^{-1}(U/d+V+Wd)df,
\qquad U,V,W\in k(\Gamma).
\]
Write U=ΣU_i f^i,V=ΣV_i f^i,W=ΣW_i f^i with K₀ coefficients. Using the displayed coefficient table and b²=THREE, CartierZERO is equivalent to
\[
\begin{gathered}
W_2=W_4=ZERO,\quad
U_1=THREE A W_1,\quad W_0=THREE h W_1,\quad
W_3=TWO c^3 U_3,\\
U_4=TWO h U_0/F-TWO A h^2W_1/F,\quad
V_4=(b/c)U_2+THREE(b/c)hU_3.
\end{gathered}
\]
The free coefficients are U₀,U₂,U₃,W₁ and V₀,V₁,V₂,V₃, proving generic rankEIGHT. For a direct derivation: the D⁵,D⁴ coefficients force W₂,W₄ toZERO; the D³ andD coefficients give U₁,W₀; D² gives W₃; D⁻¹ gives U₄; and the constant term determines V₄. Independence of the SEVEN displayed D-powers makes this both necessary and sufficient.

## The natural rankFOUR kernel and the TWO outer factors

The v₁ direction is the natural differential-pullback subline ω⊂J, because v₁=κ⁻¹df·s and multiplication by the actual different is natural differential pullback. Cartier commutes with the ACTUAL separatingφ. Its kernel on F_{Γ*}ω is exactly B_Γ; this gives a rankFOUR subbundle ofZ. The intersection Z∩F_{Γ*}ω is B_Γ, so Z/B_Γ embeds in F_{Γ*}(J/ω) and is torsion-free.

Modulo B_Γ, the generic kernel has FOUR generators with coordinate pairs(U,W):
\[
\begin{array}{c|c|c}
&U&W\\
z_0&ONE+TWO h/f&ZERO\\
z_2&f^2&ZERO\\
z_3&f^3&TWO c^3f^3\\
z_1&THREE A f-TWO A h^2/f&f+THREE h.
\end{array}
\]
The omitted V-coordinate is respectivelyZERO,(b/c)f⁴,THREE(b/c)h f⁴,ZERO; it is uniquely determined modulo the FOUR natural exact directions. This also directly verifies each generator with the previous linear conditions.

Project J/ω to its last power quotient ω². The raw v₂ has native zero t₂=(df)²/f, so its image is t₂ times the native quotient frame, not(df)². The projected pairs above therefore span
\[
\left\langle f^2(df)^2,
(ONE+THREE h/f)(df)^2\right\rangle_{K_0}.
\]
Their saturated image lies in P₃ as defined in the statement. The kernel of this projection is represented by z₀,z₂ in the genuine unit sublineω² and lies in P₂. Thus there is an exact sequence of rankTWO bundles
\[
ZERO\longrightarrow U_2\longrightarrow Z/B_\Gamma
\longrightarrow U_3\longrightarrow ZERO,
\qquad U_2\subset P_2,\quad U_3\subset P_3,
\]
where integral images may be unsaturated, which only lowers their degree. This does not require choosing a global splitting of J/ω.

## Exact degree of the saturated Pκ

The two rational generators of Pκ are α_κ=(ONE+κh/f)(df)² and β=f²(df)². Work overΓ^(1); a local uniformizer there is t₁=t⁵, and the local pushforward ofω² has basis t^j(dt)², ZERO≤j≤FOUR.

At the tame orbit, ord(f)=TWO and ord(df)=ONE. Since κh≠ZERO, ακ has orderZERO andβ has orderSIX. Their residues moduloFIVE are respectivelyZERO andONE. Thus a saturated local basis is ακ,t₁⁻¹β, and the rational determinant ακ∧β has orderONE at each tame point ofΓ^(1).

At the weak wild orbit choose an Artin–Schreier weak parameter t with
\[
f=\lambda(t^{-5}-t^{-1}),\qquad
df=\lambda t^{-2}dt,\quad\lambda\in k^\times.
\]
This exact local form is available for the fixed f: the breakONE local class is a nonzero multiple of f plus a regular series, and the latter is removable by an Artin–Schreier change over the complete local base. Then ακ has order−FOUR andβ order−FOURTEEN. Replaceβ by
\[
\beta'=\beta-\lambda^2t^{-10}\alpha_\kappa.
\]
The multiplier lies inK₀. Its leading coefficient is −TWO λ⁴t⁻¹⁰(dt)², so β' has order−TEN. The TWO surviving residues areONE andZERO moduloFIVE. Therefore t₁ακ,t₁²β' are a saturated integral basis, and the unchanged rational wedge ακ∧β has order−THREE at each wild point.

At an ordinary finite f-value the quotient is unramified and df is a frame. The ratio f³/(f+κh) of the two coefficients defines a separable rational map of degreeTHREE. Its local contact with a constant is at mostTHREE, less thanFIVE. Thus the two germs remain independent modulo the fifth-power uniformizer after removing their common leading constant, and give a saturated pushforward rankTWO subspace with determinant orderZERO. At f=−κh the orders areONE andZERO directly. No other point contributes.

Hence the native determinant degree is
\[
\deg P_\kappa=ONE\cdot N/TWO-THREE\cdot N/FIVE
=-N/TEN=-\deg\omega.
\]
The native Picard theorem identifies it genuinely withω_Γ^(1)⁻¹. This is a saturation calculation, not a degree estimate from raw powers.

## Ordinary semistability and the negative outer quotient

If Pκ had a strict rankONE HN destabilizer, its uniqueness would make it native, hence ω_Γ^(1)^a for an integera. Slope greater than−degω/TWO forces a≥ZERO. Its inclusion intoF_{Γ*}ω², by Frobenius adjunction, gives a nonzero map ω^(FIVE a)→ω². For a≥ONE this is impossible by negative degree.

For a=ZERO, a native inclusion would give a G-invariant section ofPκ. The exact divisor df=tame−TWO wild shows
\[
H^0(\Gamma,\omega^2)^G=k\,(df)^2/f.
\]
This section does not lie in the generic Pκ span. Indeed an equality
\[
f^{-1}=A_0(F)(ONE+\kappa h/f)+A_2(F)f^2
\]
would give ONE=A₀(F)f+κh A₀(F)+A₂(F)f³, contrary to independence of ONE,f,f³ overK₀. The same contradiction holds with anyK₀ coefficients. There is no native destabilizer. Thus each Pκ is ordinarily semistable of slope−degω/TWO; no ordinary stability is claimed.

Since U₂,U₃ embed into these semistable bundles, their maximum slopes are at most−degω/TWO. The extension above therefore gives μ_max(Z/B_Γ)≤−degω/TWO, including all possible integral image defects.

## The calibrated ACTUAL source cannot enter this power row

Assume the SAME original source uses the canonical positive scalar Λ=L^(1)=φ^(1)*M^(1), with its original endpoint-derived action. Then a nonzero lifted row W O_Γ→M⁶F₂, multiplied byM¹⁰, is an ORIGINAL map
\[
F_\Gamma^*(V O_{\Gamma^{(1)}}\otimes(M^{(1)})^2)
\longrightarrow J=\omega^2F_2.
\]
Its adjoint maps V(M^(1))² intoF_{Γ*}J. Pulling the same map toT and using the original K⊂B_Y makes the original differential evaluation CartierZERO. The scalar-root identification is what lets this be the STANDARD C_T used above; a bare equality F_T*Λ=L⁵ would not suffice. Therefore the adjoint lands inZ.

The source is an ordinary direct sum of the line(M^(1))², of slope degω/FOUR; no irreducibility is needed for this semistability. A nonzero composition toZ/B_Γ would have a positive-slope torsion-free quotient of this source as an image in a bundle of negative maximum slope, impossible. Hence the adjoint factors throughB_Γ. Frobenius adjunction then makes the ORIGINAL multiplied row factor through the natural lineω⊂J.

Untwisting byM¹⁰, the original constant row would lie inω M⁻¹⁰=M⁶ω⁻¹, of degree−degω/FOUR. This line has no nonzero global sections. The actual row isZERO, contradicting the stipulated nonzero original source. This establishes the conditional whole rankTWO exclusion without changing either actual endpoint map.

For the whole projected-rankTWO consequence, retain its nonzero actual projected row and compatible paired-native lift. Semistability of the ambient quotient and global generation give ZERO≤degI≤N/TWENTY. Any raw-image saturation defect is invariant and has length at mostN/TWENTY, strictly smaller than the least orbitN/FIVE, so it vanishes. Untwisting byM⁶ gives a genuine native rankTWO I₀ of degree between−THREE N/TWENTY and−N/TEN. Every native determinant has degree in (N/TEN)Z; hence detI₀=ω⁻¹ and degI₀=−degω. The dimension-independent equality-slope uniqueness argument in the confinement proof identifies I₀=F₂/O. Thus every original lifted column lies in the literal preimageM⁶F₂. This deduction uses neither a dimension bound nor full generation of that preimage; the row exclusion above applies directly.

If the retained source scalar differs fromφ^(1)*M^(1) by a genuine p-torsion line, the STANDARD kernelZ is not automatically its Cartier gate. That alternative is intentionally outside this theorem; no scalar identification is inferred from degree or from Frobenius pullback alone.
