# Proof: native shear, weak-wild first jets and the two obstruction classes

Version1, 3 October2026. [Independent bounded audit](../../Research/audits/OCT03_ZERO_TOP_NATIVE_SHEAR_NONSPLITTING_AUDIT.md): mathematical PASS allTEN checks, no repair. Use the [canonical zero-top native family](canonical_ten_zero_gram_nonfactor_zero_top_native_family.md) and its [uniform Cartier extension](canonical_ten_zero_gram_zero_top_family_cartier_extension.md). All objects have their genuine native G-action; Cartier is relative and its coefficient transport is the original one. No averaging over the wild group, ordinary connection or independently chosen scalar root is substituted. Both actual endpoint maps remain onT. No computational certificate is needed.

Write ω=ω_Γ, H=F_Γ*ω and H₂=O⊕ω⁻²⊂F₃. The family is A₃(τ)=Sat⟨ONE,s²,s³−τt₂s⟩ and J_τ=ω²A₃(τ). Write T₇=ω_Γ₁²F₆^(1) and L₁₀=F_Γ*(ω²H₂). The established exact sequences are
\[
0\to N_3\to L_{10}\to T_7\to0,\qquad
0\to N_3\to Z_\tau\to H\to0.
\]

## The global native shear

Normalize the canonical quotient q₃:F₃→F₃/F₂=ω⁻¹ so that its value on the raw cubic power is t₂ in the specified native line frame. This normalization exists: the raw cubic power has exactly the reduced wild zero divisor in that quotient, and t₂ is the specified native ω² section with the same divisor. Their ratio is a nonzero constant; there is no native character ambiguity.

Compose q₃ with the actual linear-power subline [s]:ω⁻¹→F₁⊂F₃ to get N. It killsF₂, its image is inF₂, and N(s³)=t₂s. Hence N²=ZERO and U_τ=Id−τN is a genuine native automorphism, with inverseId+τN. It takes A₃(ZERO) toA₃(τ), acts identically onH₂ and on the last quotientω⁻¹, and gives compatible identifications J_τ≅J₀ and their last quotientω.

Under these identifications the evaluated row onJ_τ changes from the τ=ZERO row by minusτ times the natural differential pullback of its last quotientω. The actual different comparison makes this a literal identity of maps, since N is exactly the quotient followed by the natural s-line. Relative Cartier commutes with that pullback and is k-linear, so the full Cartier-output map is
\[
\mathcal C_\tau=\mathcal C_0-\tau\,i C_\Gamma\pi,
\]
where π:F_Γ*J₀→H is the last quotient and i:ω_Γ₁→T₇ is its natural s₁-line. The lower map L₁₀→T₇ is unchanged. All fixed common nonzero comparison constants can be absorbed intoi; this preserves the given τ and makes the variation a nonzero constant multiple of the displayed map.

The elementary kernel-extension construction therefore gives e_τ=e₀+τβ. More explicitly changing the output map by cπ changes the kernel extension by the boundary ofc from0→N₃→L₁₀→T₇→0, up to the fixed sign convention for Baer classes. Defineβ=e₁−e₀; it is the corresponding nonzero scalar multiple of that boundary. We next prove it is nonzero and that no e_τ vanishes.

## Two native first-jet facts

There is no nonzero native invariant regular canonical form. Every invariant rational form isr(f)df. Regularity at ordinary points forbids finite poles ofr; at the tame point a pole ofr has twice its order whiledf has orderONE, so none is allowed there either. Thus r is a polynomial. At wildf=∞, df has orderminusTWO and each positive f-degree adds a pole of orderFIVE. No nonzero polynomial gives a regular form. Therefore H⁰(ω)^G=ZERO.

There is also no genuine native regular connection onω. At a weak wild fixed point take σ(t)=t/(ONE+t). In a regular frame dt write ∇dt=a(t)dt⊗dt. Equivariance of the connection gives
\[
f''(t)+f'(t)a(t)=a(f(t))(f'(t))^2,\qquad f(t)=t/(ONE+t).
\]
At t=ZERO this would require minusTWO+a(ZERO)=a(ZERO), impossible in characteristicFIVE. This is a local equivariance obstruction, independent of whether the ordinary line happens to have a connection by its degree.

The Frobenius diagonal has idealI with I⁵=ZERO. Filtering V=F_Γ^*H=F_Γ^*F_{Γ*}ω by its powers gives genuine native line gradesω,ω²,ω³,ω⁴,ω⁵, with the first-order quotient P¹ω fitting
\[
0\to\omega^2\to P^1\omega\to\omega\to0.
\]
This is the ordinary principal-parts construction on the first infinitesimal diagonal, with its inherited G-action. A native retraction P¹ω→ω² would split it and give a native connection onω. Thus any native map P¹ω→ω² has zero restriction to the kernelω². It then factorsω→ω² and iszero by H⁰(ω)^G=ZERO. Hence Hom_native(P¹ω,ω²)=ZERO.

## The variation class is nonzero

Any map F_Γ^*H→ω² kills the filtration gradesω³,ω⁴,ω⁵ by degree, so factors throughP¹ω and iszero by the preceding fact. By Frobenius adjunction Hom_native(H,F_{Γ*}ω²)=ZERO. Similarly every filtration grade is positive, so Hom(F_Γ^*H,O)=ZERO and Hom_native(H,F_{Γ*}O)=ZERO. Since L₁₀=F_{Γ*}ω²⊕F_{Γ*}O, we have Hom_native(H,L₁₀)=ZERO.

The boundary Hom_native(H,T₇)→Ext¹_native(H,N₃) is therefore injective. The map iC_Γ is nonzero: ordinary Cartier is locally ontoω_Γ₁ andi is an actual nonzero native subline. Its boundary is nonzero, givingβ≠ZERO.

## The quotient by the unit has a nontrivial native wild extension

Let E₂=J_τ/ω², whereω² is the actual primitive unit subline. It fits0→O→E₂→ω→0. This native extension is nonsplit for everyτ, as a direct wild-fiber calculation shows.

At a wild point write a₊,a₋ for the two nonzero different values, A=a₊+a₋, B=a₊a₋ and Δ=a₊−a₋. The supplied local power model gives A²=THREE B, A≠ZERO andΔ≠ZERO. Let Q(X)=X²−A(t)X+B(t), with the two representative series supplying these coefficients. The regular cubic-saturation vector forA₃(ZERO) can be written
\[
t^{-1}Q(s)(s+B(t)/A(t)).
\]
Indeed its numerator is exactly s³−(A−B/A)s²+B²/A, involving only the three allowed powers, andQ(s) vanishes to orderONE on each cluster. Its degree-ONE orbit-polynomial coefficient in the wild fiber has pair
\[
k_+=-TWO\Delta a_+(a_++B/A),\qquad
k_-=TWO\Delta a_-(a_-+B/A).
\]
The group translates the orbit label; its difference sends this vector to the corresponding degree-ZERO pair. This pair is not the unit direction because
\[
k_+-k_-=-TWO\Delta(A^2-B)=B\Delta\ne ZERO.
\]
After quotienting the unit, inertia therefore acts nontrivially on the rankTWO E₂ fiber: its Jordan type isJ₂. The τ shear changes only a degree-ZERO coefficient of this cubic vector, so has no effect on this difference. A native splitting of0→O→E₂→ω→0 would make the wild fiberJ₁⊕J₁ and is impossible.

## No native Frobenius-pushforward map can split a family member

Every map ω²→E₂ iszero by degree, using its extension byO andω. Thus a map P¹ω→E₂ kills its kernelω² and factors throughω. A native map ω→E₂ either has nonzero scalar quotient ontoω, which would split the native extension, or lands inO and iszero by degree. Both possibilities givezero. Hence Hom_native(P¹ω,E₂)=ZERO.

The ordinary maximum slope ofJ_τ is at mostTWO degω, from its extension0→ω²⊕O→J_τ→ω→0. Therefore any map F_Γ^*H→J_τ kills the higher filtration gradesω³,ω⁴,ω⁵ and factors throughP¹ω. Its projection toE₂ iszero, so it lands in the unitω²; that remaining map iszero by the first-jet obstruction. Frobenius adjunction gives
\[
\operatorname{Hom}_{\rm native}(H,F_{\Gamma*}J_\tau)=ZERO.
\]
Since Z_τ⊂F_Γ*J_τ, this implies Hom_native(H,Z_τ)=ZERO. In particular its extension0→N₃→Z_τ→H→0 cannot split, so e_τ≠ZERO for every finiteτ.

We already haveβ≠ZERO. Ife₀ were a scalar multiple ofβ, some finiteτ over the algebraically closed field would give e_τ=ZERO. Thus e₀ andβ are linearly independent.

For the original prescribed nef C′ and top mapu:C′→H, the actual lift obstruction is u*e_τ=u*e₀+τu*β. The negative kernel gives Hom(C′,N₃)=ZERO, so a lift is unique when it exists. Nothing proves that these two pulled classes remain independent or even nonzero. The finite-source compatibility question remains precisely that pullback vanishing problem.
