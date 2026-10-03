import Solutions.Deformations.MixedAdditiveOperators

namespace Litt3.Deformations

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

theorem linear_equiv_inverse_commute (Phi : M ≃ₗ[R] M) (E : Module.End R M)
    (commute : Commute Phi.toLinearMap E) : Commute Phi.symm.toLinearMap E := by
  apply LinearMap.ext
  intro v
  apply Phi.injective
  change Phi (Phi.symm (E v)) = Phi (E (Phi.symm v))
  rw [LinearEquiv.apply_symm_apply]
  have point := LinearMap.congr_fun commute.eq (Phi.symm v)
  simpa only [Module.End.mul_apply, LinearEquiv.coe_coe,
    LinearEquiv.apply_symm_apply] using point.symm

variable (N : ℕ) [Module (ZMod N) M]

/-- The original mixed additive comparison commutes with the original
augmentation as a consequence of both original commutation identities. -/
theorem mixed_additive_comparison_commute (L : M →+ M) (Phi : M ≃ₗ[ZMod N] M)
    (E : Module.End (ZMod N) M) (Lcommute : ∀ v, L (E v) = E (L v))
    (PhiCommute : Commute Phi.toLinearMap E) :
    Commute (mixedAdditiveComparison N L Phi) E :=
  (additive_zmod_commute_actual N L E Lcommute).mul_left
    (linear_equiv_inverse_commute Phi E PhiCommute)

/-- The stated original mod-scalar mixed congruence gives the actual
comparison congruence, without assuming a lift or new linearity. -/
theorem mixed_additive_comparison_scalar_range (L : M →+ M) (Phi : M ≃ₗ[ZMod N] M)
    (E : Module.End (ZMod N) M) (h : ℕ) (r : ZMod N)
    (divisible : LinearMap.range (additiveZModOperator N L - (E ^ h).comp Phi.toLinearMap) ≤
      LinearMap.range (r • (LinearMap.id : Module.End (ZMod N) M))) :
    LinearMap.range (mixedAdditiveComparison N L Phi - E ^ h) ≤
      LinearMap.range (r • (LinearMap.id : Module.End (ZMod N) M)) := by
  rintro v ⟨w, rfl⟩
  apply divisible
  refine ⟨Phi.symm w, ?_⟩
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearEquiv.coe_coe,
    LinearEquiv.apply_symm_apply, mixed_additive_comparison_apply, additive_zmod_operator_apply]

end Litt3.Deformations
