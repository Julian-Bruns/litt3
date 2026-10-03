import Solutions.Deformations.MixedAdditiveOperators

namespace Litt3.Deformations

variable {M V : Type*} [AddCommGroup M] [AddCommGroup V]
    (N : ℕ) [Module (ZMod N) M] [Module (ZMod N) V]

/-- The actual mixed-comparison solution bijection retains the entire
actual reduction map and its original coefficient automorphism. -/
theorem mixed_additive_solution_reduction_bijection (L : M →+ M)
    (Phi : M ≃ₗ[ZMod N] M) (Psi : V ≃ₗ[ZMod N] V) (reduction : M →ₗ[ZMod N] V)
    (intertwine : ∀ x, reduction (Phi x) = Psi (reduction x)) (target : M) (v : V) :
    (∃ x, L x = target ∧ reduction x = v) ↔
      ∃ y, mixedAdditiveComparison N L Phi y = target ∧ reduction y = Psi v := by
  constructor
  · rintro ⟨x, equation, image⟩
    refine ⟨Phi x, ?_, ?_⟩
    · simpa only [mixed_additive_comparison_apply, LinearEquiv.symm_apply_apply] using equation
    · rw [intertwine, image]
  · rintro ⟨y, equation, image⟩
    refine ⟨Phi.symm y, equation, Psi.injective ?_⟩
    rw [← intertwine, LinearEquiv.apply_symm_apply]
    exact image

end Litt3.Deformations
