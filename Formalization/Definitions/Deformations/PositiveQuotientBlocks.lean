import Definitions.Deformations.TruncatedCoefficientRing
import Mathlib.LinearAlgebra.Pi

namespace Litt3.Deformations

variable {k ι : Type*} [CommRing k] (length : ι → ℕ)

/-- Discard precisely the zero-length actual quotient blocks. -/
def positiveBlockRestriction : (∀ i, TruncatedCoefficientRing k (length i)) →ₗ[k]
    (∀ i : {i // 0 < length i}, TruncatedCoefficientRing k (length i.1)) where
  toFun v i := v i.1
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

/-- Extend a positive-block tuple by actual zero coordinates. -/
noncomputable def positiveBlockExtension :
    (∀ i : {i // 0 < length i}, TruncatedCoefficientRing k (length i.1)) →ₗ[k]
      (∀ i, TruncatedCoefficientRing k (length i)) where
  toFun v i := if h : 0 < length i then v ⟨i, h⟩ else 0
  map_add' v w := by
    funext i
    by_cases h : 0 < length i <;> simp [h]
  map_smul' c v := by
    funext i
    by_cases h : 0 < length i <;> simp [h]

end Litt3.Deformations
