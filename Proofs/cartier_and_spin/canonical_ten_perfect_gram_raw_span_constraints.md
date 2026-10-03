# Proof: the wild orthogonal fiber and a global orbit budget force saturation

Version4,3 October2026. Whole root review, including the final lossONE case, [PASS](../../Research/audits/RANK_THREE_SOCLE_AND_ORTHOGONAL_ROW_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/canonical_ten_perfect_gram_raw_span_constraints.md). No computation is used.

We distinguish three dimensions: dimU, the generic actual row rank r in the rankEIGHT bundle F, and the generic rank q of its induced quadratic form. The accepted normalized quotient Q_q is perfect everywhere for q=FOUR, and for q=SIX with k=ZERO. This says the ORIGINAL Gram matrix has fiber rank q at every point: its factorization PᵗBP has P surjective and B invertible there. It does not say that Q_q itself embeds in F.

For a generic subspace E of a nondegenerate rankEIGHT orthogonal space, let A be the radical of its restricted form. Then dimA=r−q and A⊂E^⊥ of dimensionEIGHT−r. Therefore
\[
r-q\le8-r,\qquad r\le(8+q)/2.
\tag{1}
\]
In the perfect cases, at a wild point the actual fiber image I has dimension d≤r, and its restricted form has rank q. The C₅-action preserves I and its radical.

## An elementary orthogonal C₅ fiber lemma

Let V be an EIGHT-dimensional nondegenerate symmetric space in characteristicFIVE, with an orthogonal orderFIVE operator τ of Jordan type J₅⊕J₃. It has no nondegenerate invariant subspace of dimensionFOUR orSIX. Such a subspace would split V orthogonally as a module direct summand, whose Jordan blocks must be a submultiset of {FIVE,THREE}; the possible dimensions are ZERO,THREE,FIVE,EIGHT.

It also has no invariant FIVE-dimensional subspace on which the restricted symmetric form has rankFOUR. Suppose I were one, with invariant isotropic radical line A. Every invariant line for C₅ is fixed, so A⊂ker(τ−ONE). Use
\[
N=\log\tau=(\tau-1)-(\tau-1)^2/2+(\tau-1)^3/3-(\tau-1)^4/4.
\]
The denominators are invertible. Truncated log-inverse gives N*=-N; N has the same Jordan type FIVE-plus-THREE. The logarithm does not assume a characteristic-ZERO lift.

Split the space orthogonally into its odd Jordan blocks. This can be justified directly: choose a long-chain vector v with ⟨v,N⁴v⟩≠ZERO. Such a vector exists because N⁴ is a nonzero self-adjoint rankONE operator. The FIVE vectors v,Nv,…,N⁴v then have an invertible anti-triangular Gram matrix, so their span is nondegenerate and its orthogonal complement is the remaining J₃.

Write long and short chains as e₄,…,e₀ and f₂,…,f₀, with Ne_i=e_(i−ONE) and Nf_i=f_(i−ONE). The socle is span(e₀,f₀), and both basis vectors are isotropic. Put a=⟨e₄,e₀⟩ and b=⟨f₂,f₀⟩, both nonzero. The two orthogonal-reduction possibilities for A are:

- For A=span(e₀), A^⊥/A has Jordan type J₃⊕J₃: remove the two end terms of the long block.
- For A=span(f₀), A^⊥/A has type J₅⊕J₁.
- For A=span(e₀+c f₀), c≠ZERO, the vector h=bc e₄−a f₂ lies in A^⊥ and N⁴h=bc e₀ has nonzero class modulo A. Thus its SIX-dimensional nondegenerate quotient has type J₅⊕J₁ as well.

These exhaust its socle lines. Since A is the radical of I, I/A is a nondegenerate invariant FOUR-dimensional subspace of A^⊥/A. It would be an orthogonal module direct summand. Neither Jordan multiset {THREE,THREE} nor {FIVE,ONE} has a submultiset of total dimensionFOUR. This contradiction proves the FIVE-dimensional assertion.

No claim is made that every invariant degenerate subspace splits. In particular ΔJ₅⊕ΔJ₃ has dimensionSIX and restricted rankFOUR, consistent with this lemma.

## Quadratic rank FOUR

At a wild point the perfect Gram matrix has rankFOUR, so d≥FOUR. Equation(1) gives r≤SIX, hence d≤SIX. If d=FOUR, its form is nondegenerate and the first fiber lemma excludes it. If d=FIVE, the second fiber lemma excludes it. Therefore d=SIX and r=SIX.

Its radical A has dimensionTWO. Since I⊂A^⊥ and both have dimensionSIX, I=A^⊥. Thus the actual wild image is coisotropic. The same dimension argument over the generic field, with r=SIX,q=FOUR, gives its generic coisotropic radical of rankTWO. This derives the exact raw span; it does not insert Q₄ as a nondegenerate subspace of F.

## Perfect quadratic rank SIX

At a wild point its perfect Gram matrix has rankSIX, so d≥SIX. Equation(1) gives r≤SEVEN. If d=SIX, the restriction is nondegenerate and would split an invariant SIX-dimensional summand of J₅⊕J₃, impossible. Therefore d=SEVEN and r=SEVEN. Its ONE-dimensional radical A again satisfies I=A^⊥, and the generic span is the corresponding coisotropic hyperplane.

When q=SIX,k=ONE, the wild Gram rank is onlyFIVE; the preceding nondegenerate SIX-dimensional argument does not apply. It is handled by determinant parity below. When the quadratic covariant is zero, it supplies no perfect positive-rank quotient. No Γ-linear independence of the constant source, source-field descent, or full common-cover exclusion has been inferred.

## The perfect quotient identifies every possible defect with the radical defect

Put N=|G|. In either perfect case, let A⊂F be the saturation of the generic radical, of rank a=TWO orONE. It is isotropic as a subbundle: its generic pairing is zero, hence its regular pairing is zero everywhere. The saturation of the raw image is A^⊥ because the generic image is coisotropic. The quotient A^⊥/A is a vector bundle of rank q with a perfect S-valued pairing, where S=M¹²ω_Γ⁻¹.

Let K be the saturated generic kernel of the source Gram form, so Q_q=(U⊗O_Γ)/K. Let κ be the kernel of the actual row map, and let I be its integral image. The image A′ of K lies in A. The induced morphism
\[
Q_q\longrightarrow A^\perp/A
\]
is an isometry of the two perfect forms. Its matrix T satisfies Tᵗ B T=C with B,C invertible over every local ring. Consequently detT is a unit, and this morphism is an isomorphism everywhere. No splitting of A^⊥ into a nondegenerate smaller source module is used.

It follows that I/A′≅Q_q and A^⊥/I≅A/A′. Thus every remaining saturation loss is precisely the effective torsion divisor D of A/A′. Also κ⊂K and K/κ≅A′. Since κ is a subbundle of the constant source U⊗O_Γ, its determinant has degree at mostZERO. Therefore
\[
\deg A'=\deg K-\deg\kappa
=-\deg Q_q-\deg\kappa\ge-\deg Q_q,
\qquad
\deg D\le\deg A+\deg Q_q.
\tag{2}
\]
These are degrees of the actual integral images; no semistability of F is presumed.

## An elementary upper bound for the radical degree

The target F is the quotient of the unit-orthogonal subbundle of M⁶φ_*O_T by its primitive unit line M⁶. Let Â be the preimage of A in this unit-orthogonal subbundle. Then
\[
0\longrightarrow M^6\longrightarrow\widehat A\longrightarrow A\longrightarrow0,
\qquad
\operatorname{rk}\widehat A=a+1.
\]
Every rank-s subbundle E′ of φ_*O_T has degree at mostZERO. To see this, use only the actual normal closure Z→Γ of this SINGLE separable leg φ. Each of its TEN conjugate embeddings gives a regular evaluation morphism from the pullback of φ_*O_T to O_Z; integrality and normality guarantee regularity also over ramification points. Together these maps are generically injective into O_Z¹⁰. The pullback of detE′ therefore has a nonzero morphism to a trivial bundle, so its degree is at mostZERO. Dividing by the positive degree of Z→Γ gives degE′≤ZERO. The original source and its two actual maps are not replaced by this auxiliary one-leg degree argument.

Apply this to Â⊗M⁻⁶, a subbundle of φ_*O_T. Since degM⁶=THREE N/FORTY, we obtain
\[
\deg A+\deg M^6=\deg\widehat A
\le(a+1)\deg M^6,
\qquad
\deg A\le\frac{3aN}{40}.
\tag{3}
\]
Combining(2) and(3) with the exact perfect Gram degrees yields
\[
\deg D\le\frac N{10}+\frac{6N}{40}=\frac N4
\quad(q=4),\qquad
\deg D\le\frac{3N}{20}+\frac{3N}{40}=\frac{9N}{40}
\quad(q=6).
\tag{4}
\]

## The remaining orbit budget is too small for any defect

At every actual wild point the row fiber rank already equals its generic rank r, by the earlier local argument. Its local Smith factors are therefore all units, so D has no wild support. D is invariant under the actual G-action; scalar changes in the paired lifts do not alter its support or multiplicities. Every orbit away from the wild orbit has degree N/TWO at a tame point, or N at an ordinary point. Both bounds in(4) are strictly below N/TWO. Hence D=ZERO. Thus A′=A and I=A^⊥ everywhere, giving the stated integral exact sequence.

Perfection of F gives F/I≅A*⊗S. Taking determinants in the two exact sequences gives
\[
\det F=\det Q_q\otimes S^a.
\]
The retained native orientation of 𝔅₈ identifies detF with M¹⁶. Using only the accepted M¹⁶≅ω_Γ², this yields
\[
\det Q_4=M^{16}S^{-2}=M^8,
\qquad
\det Q_6=M^{16}S^{-1}=M^4\omega_\Gamma.
\]
These are compatible identities with the original paired cocycles; they do not independently linearize M⁸ or remove the retained ordinary TWO-torsion line M⁸ω_Γ⁻¹.

## Perfect rank SIX has only two native radical line classes

Here a=ONE. Untwist the actual radical by the SAME M⁶ used in the unit construction:
\[
A_0=A\otimes M^{-6}\subset E^\circ/O_\Gamma.
\]
The scalar ambiguity cancels, so A₀ is a GENUINE native G-line. The global exact sequence and global generation of Q₆ imply degA≥−degQ₆=−THREE N/TWENTY; equation(3) gives degA≤THREE N/FORTY. Subtracting degM⁶=THREE N/FORTY yields
\[
-9N/40\le\deg A_0\le0.
\]
The actual two-point quotient has inertia FIVE andTWO. Its [native orbifold Picard group](../quotient_geometry/local_actions/two_point_wild_orbifold_picard_group.md) has degree lattice (N/TEN)Z and trivial degree-ZERO subgroup, since gcd(FIVE,TWO)=ONE. The native canonical line ω_Γ has degree N/TEN and therefore generates this lattice. Hence A₀ is precisely O_Γ, ω_Γ⁻¹ orω_Γ⁻² as a native equivariant line.

The retained φ is primitive of degreeTEN in characteristicFIVE. The [separable coherent-pullback theorem](../curve_arithmetic/separable_curve_coherent_pullback_and_cyclic_etale_factors.md) therefore gives H⁰(Γ,E°/O_Γ)=ZERO. If A₀=O_Γ its actual inclusion would give a nonzero section of that quotient. This excludes the degree-ZERO choice and leaves the two stated line classes.

This does not classify the morphism of either remaining line into E°/O_Γ. In particular it gives no equality with a particular power of the different generator, no vanishing of a further linear trace and no exclusion of the coisotropic hyperplane.

## The quadratic-rank SIX case with wild loss ONE

The dimension inequality(1) gives SIX≤r≤SEVEN. Suppose r=SEVEN. Its generic radical is an isotropic line, whose saturation A is an isotropic subbundle of F. The saturation of the raw image is A^⊥. Thus the perfect rankSIX bundle A^⊥/A receives a regular generically invertible map from the normalized source Gram quotient Q₆. Regularity follows because the saturated source Gram kernel maps into A, and the row image lies in A^⊥. Its pulled form is precisely the original form on Q₆.

Over every DVR, write its matrix as T and the perfect target-form matrix as B. Then det(TᵗBT)=(detT)²detB. Hence EVERY valuation of the Gram determinant is EVEN. But k=ONE says its valuation at each actual wild point is ONE. This contradiction proves r=SIX.

Now the generic row restriction is nondegenerate, so its generic row kernel equals its generic Gram kernel. Both actual kernels in U⊗O are saturated, hence they are equal. Therefore the integral row factors through a generically invertible map
\[
Q_6\longrightarrow\overline I,
\]
where overlineI is its saturated rankSIX image in F. The restricted symmetric form on overlineI is regular and generically nondegenerate, even if it degenerates at a special point. Its determinant divisor and the map determinant divisor are both effective. The integral determinant identity gives
\[
\operatorname{div}(\det\operatorname{Gram}_{Q_6})
=2\operatorname{div}(\det(Q_6\to\overline I))
+\operatorname{div}(\det\operatorname{Gram}_{\overline I}).
\]
The left side has coefficientONE at each wild point and ZERO everywhere else. No positive integral coefficient can occur in the first divisor on the right. Thus the map determinant has no zero anywhere: Q₆→overlineI is an isomorphism. In particular the ACTUAL raw image is saturated, its degree is the accepted degQ₆=N/TWENTY, and its fiber dimension is SIX even at wild points.

At a wild point this SIX-dimensional invariant image has restricted-form rankFIVE. Its radical is a fixed isotropic line A_f. The nondegenerate FIVE-dimensional quotient I_f/A_f is an orthogonal module direct summand of A_f^⊥/A_f. The earlier fixed-line reduction gives only J₃⊕J₃ orJ₅⊕J₁ for that SIX-dimensional orthogonal quotient. A nondegenerate FIVE-dimensional summand can occur only in the second case and is J₅. Since I_f surjects onto J₅ and the ambient operator has all blocks of length at mostFIVE, I_f itself has Jordan type J₅⊕J₁. An actual source J₄⊕J₄ cannot surject onto a lengthFIVE block. This excludes that specific source type only.

Version1 established the perfect-case local and generic ranks. Version2 added their global saturation and determinant identities. Version3 classified the perfect rankSIX radical line. Version4 adds the complete raw-rank and saturation ledger for quadratic rankSIX with lossONE. None of these assertions settles the remaining image embeddings or the common-cover problem.

Dependencies: [actual orthogonal target and its J₅⊕J₃ fiber](canonical_ten_orthogonal_pushforward_row_quotient.md), [perfect normalized Gram cases](canonical_ten_higher_row_quadratic_rank_gate.md), and, only for the dimensionEIGHT frontier interpretation, [actual full-rank EIGHT-factor exclusion](canonical_ten_full_rank_eight_factor_local_gate.md).
