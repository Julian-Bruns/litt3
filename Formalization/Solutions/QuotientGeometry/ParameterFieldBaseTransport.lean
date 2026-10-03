import Solutions.QuotientGeometry.ParameterFieldEquivalenceRelation

namespace Litt3.QuotientGeometry

variable {k : Type*} [Field k]

/-- A full parameter-field intertwiner remains an intertwiner after
any actual change of the common base embedding. -/
theorem ParameterFieldsEquivalent.precomp
    {φ ψ : LaurentSeries k →+* LaurentSeries k}
    (h : ParameterFieldsEquivalent φ ψ) (η : LaurentSeries k →+* LaurentSeries k) :
    ParameterFieldsEquivalent (φ.comp η) (ψ.comp η) := by
  obtain ⟨e, he⟩ := h
  exact ⟨e, fun r => he (η r)⟩

/-- Genuine endpoint coordinate equivalences can be cancelled from
an equivalence over the same entire base embedding. -/
theorem ParameterFieldsEquivalent.of_postcomp_equiv
    {φ ψ : LaurentSeries k →+* LaurentSeries k}
    (e₁ e₂ : LaurentSeries k ≃+* LaurentSeries k)
    (h : ParameterFieldsEquivalent (e₁.toRingHom.comp φ) (e₂.toRingHom.comp ψ)) :
    ParameterFieldsEquivalent φ ψ := by
  obtain ⟨e, he⟩ := h
  refine ⟨e₁.trans (e.trans e₂.symm), ?_⟩
  intro r
  change e₂.symm (e (e₁ (φ r))) = ψ r
  rw [show e (e₁ (φ r)) = e₂ (ψ r) from he r, e₂.symm_apply_apply]

end Litt3.QuotientGeometry
