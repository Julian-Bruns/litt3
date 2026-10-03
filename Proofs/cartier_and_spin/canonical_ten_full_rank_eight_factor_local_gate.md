# Proof: the simple wild defect contradicts a constant source module

Version2,3 October2026. Whole independent review [PASS](../../Research/audits/RANK_THREE_SOCLE_AND_ORTHOGONAL_ROW_AUDIT_2026_10_03.md); see the [exact statement](../../Theorems/cartier_and_spin/canonical_ten_full_rank_eight_factor_local_gate.md). No computation is used.

The accepted [pushforward theorem, Version2](canonical_ten_orthogonal_pushforward_row_quotient.md) gives determinant c t₂ for any specified actual full-rank constant EIGHT-factor map. Its divisor is exactly the wild orbit with multiplicityONE. At a wild point the original map φ is étale and the actual target F=M²𝔅₈ has special fiber J₅⊕J₃. The shared projective lifts restrict to this cyclic C₅ with a common honest normalization: the scalar cocycle has prime-to-FIVE order, so restriction splits, and the normalized fiber scalars on both sides are ONE. The source is the CONSTANT module W with this action.

The [simple determinant obstruction](../quotient_geometry/local_actions/wild_constant_module_simple_determinant_obstruction.md) applies to the completed local map. The wild tangent character is ONE, and neither target block has sizeONE. Thus a determinant of orderONE is impossible. This is the claimed contradiction; irreducibility is needed for the accepted factor determinant input, not for the local obstruction itself.

The rankEIGHT,k=TWO case of the accepted quadratic gate gives an ACTUAL constant EIGHT-dimensional quotient W and an ACTUAL full-rank map. Its composition factors all have dimension at leastEIGHT, so W is irreducible. The contradiction therefore deletes that case. Nothing in this proof supplies such a factor map in the other cases.

## Version1 first-jet evidence retained for provenance

The following earlier conditional fiber calculation is no longer needed by Version2. It correctly gives a necessary special-fiber type, but did not use the stronger invariant-section lifting obstruction.

The [pushforward theorem, Version2](canonical_ten_orthogonal_pushforward_row_quotient.md) gives determinant c t₂ for this ACTUAL full-rank factor. Hence its image I in F is locally free and has colengthONE at each wild point and no other defect. At such a point its fiber image is an invariant hyperplane J in F₀=J₅⊕J₃. The map identifies W⊗O with I; no arbitrary factor map is introduced.

## The moving trace hyperplane to first order

Complete at a wild point of Γ and choose a uniformizer t. The original degreeTEN map φ is étale here. Thus its algebra has a frame of ten point idempotents, and the inertia generator acts by a constant permutation matrix P with two free FIVE-cycles, together with the base automorphism σ(t)=t+O(t²). Write Δ=P−ONE and let u be the constant vector with all entriesONE.

In a local frame of ω⁻¹ the relative pairing has diagonal weights ONE/a_j(t), up to a common invertible factor. Its pairing with u is a row functional
\[
\ell(t)=\ell_0+t\ell_1+O(t^2),\qquad \ell(t)u=0.
\]
The last equality is the integral weighted trace of ONE, already ZERO in the pushforward theorem. Equivariance of the value-line pairing and σ(t)=t+O(t²) implies
\[
\ell_0P=\ell_0,\qquad \ell_1P-\ell_1=c\ell_0
\]
for some scalar c. Choosing the inverse convention for the group action changes c or its sign and has no effect below. Indeed the first-order scalar of the value line contributes only a multiple of ℓ₀. Put H₀=kerℓ₀. Since ℓ₁u=ZERO, the functional ψ=ℓ₁|H₀ descends to H₀/ku; the displayed equality says that ψ is P-invariant. Consequently
\[
\psi\Delta(H_0/ku)=0.
\]

Choose w with ℓ₀(w)=ONE. A first-order lift of x∈H₀ to the moving hyperplane kerℓ(t) is x−tψ(x)w. Applying P and comparing with the lift of Px gives the difference tψ(x)(w−Pw). The vector w−Pw belongs to H₀, and its class v belongs to H₀/ku. After quotienting by the CONSTANT line ku, this proves that the first-order action on the quotient is
\[
A(t)=A_0+tA_1+O(t^2),\qquad A_1=c' A_0+v\otimes\psi.
\]
The scalar term includes the local root-line action in F=M⁶(H/ku). No root-line scalar is dropped, and no flat connection is assumed. Its only relevance is that a scalar multiple of A₀ preserves every invariant hyperplane. The accepted fiber calculation identifies H₀/ku, with this action, with F₀=J₅⊕J₃.

## Every possible hyperplane modification splits

Any invariant hyperplane J in J₅⊕J₃ is the kernel of a functional annihilating ΔF₀. If that functional is nonzero on the top of the shorter block, J has type J₅⊕J₂; otherwise it has type J₄⊕J₃. This follows by replacing the longer cyclic generator by a suitable multiple of the shorter one when the shorter top coefficient is nonzero. In both cases
\[
\ker(\Delta|J)\subset\Delta F_0.
\]
Indeed every block of J has length at leastTWO, and its fixed vector is a bottom vector of an original block of length at leastTHREE.

Let h be the invariant functional cutting out J. The modification has fiber sequence
\[
0\longrightarrow k\longrightarrow I_0\longrightarrow J\longrightarrow0.
\]
The kernel is generated by t times a complementary direction. It is trivial under C₅ because the tangent action and the ONE-dimensional quotient F₀/J both have scalarONE. In a chosen splitting as vector spaces, its extension row functional is hA₁|J. The scalar term in A₁ contributes ZERO, and the remaining term is h(v)ψ|J. This vanishes on ker(Δ|J), since ψ annihilates ΔF₀.

A row functional on J which vanishes on kerΔ factors through Δ: it equals bΔ for some linear functional b. Changing the vector-space splitting by b removes the extension row. Thus the sequence splits as a C₅-module. Consequently I₀, and hence W, has type J₅⊕J₂⊕J₁ or J₄⊕J₃⊕J₁. This splitting uses the first-order trace-hyperplane deformation, not merely the abstract target fiber type.

## The actual opposite tuple deletes the second type

The [accepted higher-module theorem](../../Theorems/cartier_and_spin/canonical_ten_higher_trace_section_module.md) gives balanced tame multiplicities FOUR-plus-FOUR. Its prescribed weak-C₅ lift gives a product-ONE generating tuple a,b,c in the SAME original G with b conjugate to a⁻¹, as in the [reviewed opposite-branch construction](../quotient_geometry/local_actions/weak_cyclic_reflection_representation_obstruction.md). Unique unipotent lifts in W therefore give A and B with identical Jordan type and identical centralizer dimension.

For J₄⊕J₃⊕J₁ the centralizer dimension is EIGHTEEN: the column lengths are THREE,TWO,TWO,ONE. The tame centralizer dimension is THIRTY TWO. Scott on End(W), using irreducibility and the trace pairing, requires their sum to be at most EIGHT²+TWO=SIXTY SIX. But TWO timesEIGHTEEN plusTHIRTY TWO is SIXTY EIGHT. Contradiction. Therefore only J₅⊕J₂⊕J₁ survives; its centralizer dimension is SIXTEEN and there is no corresponding Scott contradiction.

The Version1 first-jet calculation alone leaves J₅⊕J₂⊕J₁. Version2's preceding constant-section argument excludes the actual map even with that fiber type. No map is supplied merely by a composition factor.
