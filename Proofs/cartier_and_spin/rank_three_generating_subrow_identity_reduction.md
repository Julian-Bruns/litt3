# Proof: all native scalar and tame inputs survive the smaller generating quotient

Version1,3 October2026. Root whole-scope review **PASS** in the [rankTHREE review](../../Research/audits/RANK_THREE_SOCLE_AND_ORTHOGONAL_ROW_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/rank_three_generating_subrow_identity_reduction.md). No computation is used. Both original endpoint maps remain on T throughout.

By the accepted [subrow theorem](rank_three_generating_subrow_etale_and_primitive_field.md), W generates K integrally, C=C_W→D=D_W is étale, and Γ·D=T on the original source. Write R=R_W, H=H_W, N=|R| and e=deg(C→D). The restricted original scalar cocycle remains of orderFOUR orEIGHT. Every nonzero W has dimension v≥EIGHT because its original composition factors are factors of V and have that bound. We verify each native input instead of presuming that the original complete-row theorem applies unchanged.

## The actual coefficient kernel preserves the canonical degree-ten target

The faithful effective projective row group is R. It is an actual quotient of G. Its multiplier inflates to the original class of orderFOUR orEIGHT, so R cannot have orderONE orFIVE; ordersTWO,THREE,FOUR are already excluded by the absence of prime-to-FIVE quotients of G. Hence |R|>FIVE. The accepted [general noncyclic quotient clause](canonical_degree_ten_no_a5_quotient.md) says that H acts freely on Γ as well as T.

Put Γ_R=Γ/H. The actual quotient square is cartesian and both horizontal H-covers are étale. Consequently C→Γ_R has degreeTEN, different q_C*P₀ and full S10 monodromy: base change gives the original full S10 cover, so its monodromy both contains and is contained in S10. The original Γ·D=T identity descends to Γ_R·D=C by precisely the Galois compositum argument in the [higher-row quotient proof](canonical_ten_higher_trace_row_geometry.md). This is an embedded field equality; it does not descend an X-map.

The row line A_C=ω_C(F*P)⁻¹ pulls back to L⁶ on T. Its specified genuine H-action is induced by the actual row pullback. Compare it to the isomorphisms of M⁶ on Γ, where L=φ*M. Their pullbacks differ by global constants on proper connected T. Rescale the Γ-isomorphisms to agree; the cocycle identity then descends because it holds on T. Thus M⁶ genuinely H-linearizes and descends to a line B on Γ_R, with A_C=φ_C*B. This uses the SAME source and line comparison as the higher-row proof, not membership of original labels in W. Degrees give
\[
g(C)-1=N,\qquad g(\Gamma_R)-1=N/20,
\qquad\deg B=3N/40,\qquad40\mid N.
\tag{1}
\]
No eighth-power calibration of B is asserted; the determinant character discrepancy remains allowed.

## The actual scalar Cartier line and image descend to D

The [Plücker/Wronskian descent](canonical_ten_rank_three_projective_row_descent.md) uses only the integral presentation P⊗W→q_C*K and the actual basepoint-free row. Repeating its exact ratio calculation with W supplies a globally generated rankTHREE quotient E_D, its surjective W⊗O→E_D, an injection W→H0(E_D), and
\[
q_C^*K=P\otimes\rho_1^*E_D,
\qquad F_D^*E_D\twoheadrightarrow M_D=O_D(1).
\tag{2}
\]
This requires no completeness of W as H0(E_D), no label membership and no irreducibility. Étaleness gives n=g(D)−ONE=N/e, degE_D=n/FOUR and degM_D=THREE n/FOUR. In particular FOUR divides n.

Now apply the independently reviewed [prime-to-characteristic Frobenius line descent](etale_frobenius_line_descent_prime_to_characteristic.md), whose general lemma does not require a complete coefficient module. The retained original étale f:T→C has f*P=L² and f*P⁸=L¹⁶=ω_T. Also
\[
F_C^*P=\rho^*(\omega_D\otimes M_D^{-1}),
\qquad\deg(\omega_D\otimes M_D^{-1})=5n/4.
\]
These are exactly its p=FIVE,m=EIGHT hypotheses. It gives an actual Q on D^(1) with ρ_1*Q=P and F_D*Q=ω_D M_D⁻¹. Equations(2) then give the ACTUAL inclusion
\[
K_D=Q\otimes E_D\hookrightarrow B_D,
\qquad\rho_1^*K_D=q_C^*K,
\qquad\deg K_D=n.
\tag{3}
\]
Adjunction is everywhere surjective. Native equivariance follows by pulling equality of subsheaves along the equivariant finite étale ρ; the pullback is the original q_C*K image. Thus the action on K_D is inherited from B_D and detK_D is genuinely linearized. No Q⁴ determinant identity or quotient-level scalar multiplier bound is used.

## The native determinant and birational row supply the numerical tame inputs

Each actual stabilizer on D acts freely on the complete e-point ρ-fiber, so its order divides e. Put ℓ=lcm|R_z|. A genuine invariant rational section of detK_D exists by Hilbert90. Its invariant divisor has degree divisible by N/ℓ. Since degdetK_D=n=N/e, this forces e|ℓ; combined with ℓ|e it yields ℓ=e. This is the native determinant argument, not the rankFOUR determinant character.

The global quotient W⊗O→E_D and injection W→H0(E_D) supply h0(detE_D)≥v−TWO by choosing two everywhere independent sections. Clifford gives v≤n/EIGHT+THREE. D is nonhyperelliptic because its birational row has degreeTHREE n/FOUR<g(D)+ONE; the birational product-image argument in the [native constraints proof](rank_three_etale_row_native_determinant_constraints.md) excludes a hyperelliptic pencil. Equality in Clifford would force hyperellipticity. Therefore
\[
v<n/8+3,\qquad n\ge8(v-3)+4\ge44.
\tag{4}
\]
All these steps use only integral W-generation and its independent sections.

## Wild and tame nonidentity alternatives both disappear

The faithful action and actual étale ρ give C=YD and an actual uniform coarse atlas Y→D/R of degree e, with full uniform completed local types. For example C=YD follows from D∩Y=D^R and the Galois degree [C:Y]=|R|; no presumed simultaneous closure is used.

Equations(3) and the native action are EXACTLY the hypotheses of [proper positive Cartier wild-atlas exclusion](proper_positive_cartier_etale_atlas_wild_exclusion.md). Thus D/R is tame.

The tame proof uses only the actual uniform Y-coarse map, stabilizer orders dividing e, ℓ=e, and selected endpoint inputs. Odd e is deleted by the accepted odd-uniform atlas theorem. If e>ONE the coarse curve is rational: higher genus is ruled out by genusTWO Hurwitz, and in genusONE a nonzero uniform branch has e(ONE−ONE/m)≤TWO, hence e≤FOUR; the selected small elliptic-map exclusions delete those degrees. Tame Hurwitz and ℓ=e now give
\[
\sum_i(1-1/m_i)-2=2/e,\quad m_i\mid e,
\quad\operatorname{lcm}(m_i)=e.
\]
The explicit signature enumeration and endpoint exclusions in the [tame proof](tame_etale_positive_full_spin_signature_reduction.md), FROM this equation onward, depend on no original X-map or rankFOUR trace. They leave only e=TWO with six TWO cones. In particular its degreeSIX sign-double argument uses bounded elliptic maps on Y and its actual double cover, not a map to X.

In that double case the actual fiber product C=YD gives its involution σ commuting with R and inducing the hyperelliptic involution on Y. It preserves q_C*P₀ because P₀ is Weierstrass. The two actual degreeTEN maps φ_C and φ_Cσ consequently have the same N simple indexTWO critical points. Their target fields are distinct by the exact original canonical β normal form: an induced affine β-transform would have slope−ONE, whereas β+ι_Yβ=2+2c₄/z+c₀/z⁵ is nonconstant. No spin section or X-map on C was needed for that field test.

S10 primitivity makes these two fields jointly generate C. The product genus bound gives total delta at mostONE HUNDRED, while their N common critical points contribute at leastN, even if image branches collide. Thus N≤ONE HUNDRED. But e=TWO and (4) give N≥EIGHTY EIGHT; (1) gives FORTY|N, hence N≥ONE HUNDRED TWENTY. This contradiction deletes the double. Therefore e=ONE, so C_W=D_W.

Every application above retained its actual native hypotheses. In particular no original X-field, original infinity section, bounded spin rank or rankFOUR coefficient fiber was inferred on C_W. Taking an irreducible socle W is therefore a legitimate reduction of the remaining identity coefficient sector, with both endpoint maps still on the original T.
