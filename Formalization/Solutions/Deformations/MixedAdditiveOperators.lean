import Definitions.Deformations.MixedAdditiveOperators

namespace Litt3.Deformations

variable {M : Type*} [AddCommGroup M] (n : ℕ) [Module (ZMod n) M]

@[simp] theorem additive_zmod_operator_apply (L : M →+ M) (v : M) :
    additiveZModOperator n L v = L v := rfl

/-- Additivity alone gives full actual O-linearity for every integer
quotient O; no additional coefficient semilinearity is imposed. -/
theorem additive_zmod_scalar_compatibility (L : M →+ M) (r : ZMod n) (v : M) :
    L (r • v) = r • L v := (additiveZModOperator n L).map_smul r v

theorem additive_zmod_commute_actual (L : M →+ M) (e : Module.End (ZMod n) M)
    (commute : ∀ v, L (e v) = e (L v)) :
    Commute (additiveZModOperator n L) e := by
  apply LinearMap.ext
  exact commute

@[simp] theorem mixed_additive_comparison_apply (L : M →+ M) (Phi : M ≃ₗ[ZMod n] M)
    (v : M) : mixedAdditiveComparison n L Phi v = L (Phi.symm v) := rfl

theorem mixed_additive_original_equation (L : M →+ M) (Phi : M ≃ₗ[ZMod n] M)
    (x target : M) :
    mixedAdditiveComparison n L Phi (Phi x) = target ↔ L x = target := by
  simp

theorem mixed_additive_solution_bijection (L : M →+ M) (Phi : M ≃ₗ[ZMod n] M)
    (target : M) :
    (∃ x, L x = target) ↔ ∃ y, mixedAdditiveComparison n L Phi y = target := by
  constructor
  · rintro ⟨x, same⟩
    exact ⟨Phi x, by simpa using same⟩
  · rintro ⟨y, same⟩
    exact ⟨Phi.symm y, same⟩

end Litt3.Deformations
