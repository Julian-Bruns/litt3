import Definitions.QuotientGeometry.ParameterFieldComparison

namespace Litt3.QuotientGeometry

variable {k : Type*} [Field k]

theorem ParameterFieldsEquivalent.refl (φ : LaurentSeries k →+* LaurentSeries k) :
    ParameterFieldsEquivalent φ φ := ⟨RingEquiv.refl _, fun _ => rfl⟩

theorem ParameterFieldsEquivalent.symm
    {φ ψ : LaurentSeries k →+* LaurentSeries k} (h : ParameterFieldsEquivalent φ ψ) :
    ParameterFieldsEquivalent ψ φ := by
  obtain ⟨e, he⟩ := h
  refine ⟨e.symm, ?_⟩
  intro r
  rw [← he r, e.symm_apply_apply]

theorem ParameterFieldsEquivalent.trans
    {φ ψ χ : LaurentSeries k →+* LaurentSeries k}
    (h₁ : ParameterFieldsEquivalent φ ψ) (h₂ : ParameterFieldsEquivalent ψ χ) :
    ParameterFieldsEquivalent φ χ := by
  obtain ⟨e₁, he₁⟩ := h₁
  obtain ⟨e₂, he₂⟩ := h₂
  exact ⟨e₁.trans e₂, fun r => by change e₂ (e₁ (φ r)) = χ r; rw [he₁, he₂]⟩

end Litt3.QuotientGeometry
