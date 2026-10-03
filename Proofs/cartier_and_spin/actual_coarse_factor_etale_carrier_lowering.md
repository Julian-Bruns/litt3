# Proof: lowering along an actual coarse factor

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/actual_coarse_factor_etale_carrier_lowering.md). [Independent whole-implication review PASS](../../Research/audits/ACTUAL_COARSE_FACTOR_LOWERING_AUDIT_2026_10_03.md).

All fields in this proof are actual subfields of k(T). Since G acts faithfully on Γ, the Galois extension k(Γ)/k(B) has group G. The actual G action on ΓY fixes Y and remains faithful, so ΓY/Y has at least |G| automorphisms. On the other hand ΓY⊂T and [T:Y]=|G|. Therefore
\[
k(T)=k(\Gamma)k(Y),\qquad
[k(\Gamma)k(Y):k(Y)]=|G|=[k(T):k(Y)].
\]
Since [ΓY:Y]=[Γ:B], Γ and Y are linearly disjoint over B, and the same is true for Γ and C⊂Y. In particular Γ′=ΓC⊂T is connected and [Γ′:Γ]=[C:B]=e. The tower gives the asserted source degree. This degree argument uses the actual G action, not a general intersection criterion for arbitrary non-Galois fields.

We check that Γ′→Γ is étale at every point. Fix c∈C over b∈B. If c=u(P), the hypothesis says that the completed field C_c equals B_b, because all residue fields are k. Such a factor creates no ramification in its compositum with any Γ completion.

For c≠u(P), choose any y∈Y above c; then y≠P. Choose an actual t∈T above y and let γ=φ(t). Étaleness of q and absence of ramification of φ at t identify completed fields OVER the fixed B_b field:
\[
k((Y_y))=k((T_t))=k((\Gamma_\gamma)).
\]
The completed C_c field is a subfield of this field. Since Γ/B is Galois, its completions above b are mutually isomorphic over B_b. Thus C_c embeds in every completed Γ field above b, after a suitable B_b embedding. The compositum of a Galois completed Γ field with this subfield has no extension of that Γ field. Equivalently, each completed factor of the normalization of Γ×B C is the original completed Γ field. This proves that Γ′→Γ is unramified everywhere. Finite maps between smooth curves are flat, so it is finite étale.

The G action preserves Γ′ because it preserves Γ and fixes C⊂Y pointwise. Its restriction is faithful because it already acts faithfully on Γ. Disjointness gives [Γ′:C]=|G|, so the fixed field is exactly C. The actual map φ factors through Γ′. The different transitivity formula and étaleness of Γ′→Γ show that φ′ has exactly the original different and local indices.

Pull back M and its genuine linearizations to Γ′. Since ωΓ′ is the pullback of ωΓ, all displayed spin and different identifications pull back unchanged. The original infinity sections pull back as sections of M′. Finally Γ⊂Γ′⊂T and Γ(a)=T imply Γ′(a)=T. Thus enlarging the target does not lose the actual primitive different coefficient. Both original étale endpoint maps are the unchanged maps q and h on T.
