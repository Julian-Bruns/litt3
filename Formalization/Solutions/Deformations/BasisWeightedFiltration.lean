import Solutions.Deformations.BasisWeightedPowers

namespace Litt3.Deformations

variable {R M I : Type*} [CommRing R] [AddCommGroup M] [Module R M]

theorem basis_weighted_power_filtration_antitone
    (B : Module.Basis I R M) (a : R) (w : ℕ) (degree : I → ℕ) :
    Antitone (basisWeightedPowerFiltration B a w degree) := by
  intro d e bound
  apply Submodule.span_mono
  rintro x ⟨j, i, weight, rfl⟩
  exact ⟨j, i, bound.trans weight, rfl⟩

theorem basis_weighted_power_filtration_initial
    (B : Module.Basis I R M) (a : R) (w : ℕ) (degree : I → ℕ) :
    basisWeightedPowerFiltration B a w degree 0 = ⊤ := by
  apply top_unique
  rw [← B.span_eq]
  apply Submodule.span_le.mpr
  rintro x ⟨i, rfl⟩
  have member : a ^ 0 • B i ∈ basisWeightedPowerFiltration B a w degree 0 :=
    Submodule.subset_span ⟨0, i, by omega, rfl⟩
  simpa only [pow_zero, one_smul] using member

end Litt3.Deformations
