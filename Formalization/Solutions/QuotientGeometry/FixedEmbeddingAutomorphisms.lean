import Definitions.QuotientGeometry.FixedEmbeddingAutomorphisms

namespace Litt3.QuotientGeometry

noncomputable def fixed_embedding_automorphisms_equiv
    {K L : Type*} [Field K] [Field L] (Φ : K →+* L) :
    letI : Algebra K L := Φ.toAlgebra
    letI : SMul K L := Φ.toAlgebra.toSMul
    letI : Module K L := Algebra.toModule
    fixedEmbeddingAutomorphisms Φ ≃* (L ≃ₐ[K] L) := by
  letI : Algebra K L := Φ.toAlgebra
  letI : SMul K L := Φ.toAlgebra.toSMul
  letI : Module K L := Algebra.toModule
  exact
    { toFun := fun σ => { __ := σ.val, commutes' := σ.property }
      invFun := fun σ => ⟨σ.toRingEquiv, σ.commutes⟩
      left_inv := fun σ => Subtype.ext rfl
      right_inv := fun σ => rfl
      map_mul' := fun _ _ => rfl }

theorem fixed_embedding_automorphisms_card
    {K L : Type*} [Field K] [Field L] (Φ : K →+* L) :
    letI : Algebra K L := Φ.toAlgebra
    letI : SMul K L := Φ.toAlgebra.toSMul
    letI : Module K L := Algebra.toModule
    Nat.card (fixedEmbeddingAutomorphisms Φ) = Nat.card (L ≃ₐ[K] L) := by
  exact Nat.card_congr (fixed_embedding_automorphisms_equiv Φ).toEquiv

end Litt3.QuotientGeometry
