# Proof: two exact flag charts and their universal quotient kernel

Version1, 3 October2026. [Independent four-task static review: PASS](../../Research/audits/OCT03_PULLED_SIX_POWER_DUAL_HOM_TWO_CHARTS_STATIC_REVIEW.md), no repair. The reviewed precursor is retained [byte-exact](../../Research/notes/oct03_ten_hour/pulled_six_power_dual_hom_two_charts.md); this proof states the same argument without changing its scope. Inputs are the [exact dual-Hom theorem](oct03_pulled_six_power_dual_hom_exact.md), [actual scalar-class theorem](canonical_ten_pulled_native_scalar_torsor_and_hom.md), and [specified adjacent power tails](canonical_ten_adjacent_native_power_tail_classes.md). Retain their actual pullback and descent, paired action, power endpoints and both original finite étale maps. No computation is used.

Put L=O_Y(−P). Write
\[
0\to L\to V\xrightarrow{q}O\to0,
\qquad 0\to O\to Z\to O\to0.
\]
The accepted nonzero classes satisfy z∈k^×σ_P e, with e∈H¹(L) and z∈H¹(O). Let i:O→Z* and p:Z*→O be the distinguished dual maps. The accepted Hom calculation gives a lift m:V→Z* with p m=q. Put n=i q. Then Hom(V,Z*)=k n⊕k m.

The restriction of m to L has the form aσ_P i with a≠0. Its quotient image is zero, so it factors through i and Hom(L,O)=kσ_P. If a were zero, m would factor through q as a splitting O→Z*, contradicting z≠0. Consequently det(m) is a nonzero multiple ofσ_P. For every t∈k, m+t n retains this restriction and quotient, so it is invertible outsideP and has rankONE atP. The map n has rankONE everywhere.

Tensor-Hom adjunction turns n,m into maps β₀,β₁:V⊗Z→O. Pulling back through B→V⊗Z gives the exact two-dimensional Hom(B,O), by the accepted nonzero higher-boundary theorem. Every map kills V=𝒫(F₂/O). The retained identity F₆/F₂=D⊗Z₂ identifies F₄/F₂ with D tensored with the distinguished subline ofZ₂. Evaluation on this subline is p:Z*→O. Thus
\[
\beta_0|_{\mathcal P(F_4/F_2)}=0,
\qquad \beta_1|_{\mathcal P(F_4/F_2)}=q.
\]
This proves the unique projective F₆-stage direction and the complementary affine F₄-stage chart.

Every nonzero β is an integral quotient. Away fromP its corresponding n or m+t n is nonzero. AtP the maps n,m kill L_P and factor through q_P; their values in Z*_P are linearly independent because p n=0 but p m=q≠0. Consequently every nonzero linear combination remains nonzero atP as well. These same facts prove that (β₀,β₁):V⊗Z→O² has full rankTWO in every fiber.

For the exact quotient kernel, use local regular frames v₀,v₁ ofV and e₀,e₁ ofZ with
\[
v_{0,i}=l_{ij}v_{0,j},\quad v_{1,i}=v_{1,j}+e_{ij}v_{0,j},
\qquad e_{0,i}=e_{0,j},\quad e_{1,i}=e_{1,j}+z_{ij}e_{0,j}.
\]
Write m(v₀)=aσ_P e₁* and m(v₁)=e₀*+b e₁*, where e₁*=i(1) and p(e₀*)=1. Then σ_{P,i}=l_{ij}σ_{P,j}. Compatibility of m gives
\[
b_i-b_j=z_{ij}+a\sigma_{P,j}e_{ij},
\qquad [a\sigma_Pe]=-z.
\]
This is the correct dual-extension sign. Local generators of the combined kernel are
\[
h_0=v_0\otimes e_0,
\qquad h_1=v_0\otimes e_1-a\sigma_Pv_1\otimes e_0.
\]
They form a basis even atP. Their transitions are
\[
h_{0,i}=l_{ij}h_{0,j},
\qquad h_{1,i}=l_{ij}h_{1,j}
+l_{ij}(z_{ij}-a\sigma_{P,j}e_{ij})h_{0,j}.
\]
After removing their common L factor, the self-extension class is z−(−z)=2z≠0 in characteristicFIVE. Nonzero scalar multiples of a unipotent self-extension have the same ordinary middle-bundle isomorphism class. Hence H≅L⊗Z, without a canonical isomorphism.

With the retained original unit/counit splitting U₆=O⊕B, an original nonzero unit-killing β lies in exactly one of these two flag charts. This remains an ordinary classification and an integral quotient condition. It neither makes β native onΓ nor supplies the original finite source or its Frobenius connection; an arbitrary ordinary extension preimage is not substituted for the same-source classξ_j.
