import Mathlib.FieldTheory.Galois.Basic

namespace Litt3.QuotientGeometry

/-- The genuine field automorphisms fixing the entire image of the
specified original base embedding. Both fields and the actual map are
retained; no simultaneous closure or generator-only condition replaces it. -/
def fixedEmbeddingAutomorphisms
    {K L : Type*} [Field K] [Field L] (Φ : K →+* L) : Subgroup (L ≃+* L) where
  carrier := {σ | ∀ r, σ (Φ r) = Φ r}
  one_mem' := fun _ => rfl
  mul_mem' := by
    intro σ τ hσ hτ r
    change σ (τ (Φ r)) = Φ r
    rw [hτ, hσ]
  inv_mem' := by
    intro σ hσ r
    apply σ.injective
    change σ (σ.symm (Φ r)) = σ (Φ r)
    rw [σ.apply_symm_apply, hσ]

end Litt3.QuotientGeometry
