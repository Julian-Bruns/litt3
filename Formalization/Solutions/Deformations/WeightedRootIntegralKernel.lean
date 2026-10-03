import Solutions.Deformations.WeightedRootEvaluationAtTau
import Solutions.Deformations.WeightedRootIntegralLine

namespace Litt3.Deformations

open scoped BigOperators

variable {R K : Type*} [CommRing R] [Nontrivial R] [Field K]

@[simp] theorem weighted_root_base_map_norm (φ : R →+* K) (q : ℕ) (tau : R) (r : ℕ) :
    weightedRootProductBaseMap φ q tau r (weightedRootProductNorm q tau r) =
      weightedRootProductNorm q (φ tau) r := by
  simp only [weightedRootProductNorm, map_prod, map_add, map_pow,
    weighted_root_base_map_parameter, weighted_root_base_map_coefficient]

/-- The actual graded quotient has precisely the integral norm line
as multiplication kernel. The scalar found after coefficient extension
descends because the unchanged original top norm coefficient is one. -/
theorem weighted_root_integral_direction_kernel
    (F : Type*) [Field F] [Fintype F] [DecidableEq F]
    (φ : R →+* K) (injective : Function.Injective φ) (ψ : F →+* K)
    (tau : R) (c : K) (root : c ^ (Fintype.card F - 1) = -(φ tau))
    (nonzero : c ≠ 0) (r : ℕ)
    (q x : weightedRootProduct R (Fintype.card F) tau r)
    (origin : weightedRootEvaluationAtTau F K ψ (φ tau) c root r
      (weightedRootProductBaseMap φ (Fintype.card F) tau r q) 0 = 0)
    (directions : ∀ a : Fin r → F, a ≠ 0 →
      weightedRootEvaluationAtTau F K ψ (φ tau) c root r
        (weightedRootProductBaseMap φ (Fintype.card F) tau r q) a ≠ 0) :
    q * x = 0 ↔ ∃ a : R, x = a • weightedRootProductNorm (Fintype.card F) tau r := by
  let extend := weightedRootProductBaseMap φ (Fintype.card F) tau r
  have fieldKernel := weighted_root_direction_kernel_at_tau F K ψ (φ tau) c root nonzero r
    (extend q)
  have extensionInjective := weighted_root_base_map_injective φ injective
    (Fintype.card F) Fintype.one_lt_card tau r
  constructor
  · intro vanish
    have imageVanish : extend q * extend x = 0 := by
      rw [← map_mul, vanish, map_zero]
    obtain ⟨b, line⟩ := (fieldKernel (extend x) origin directions).mp imageVanish
    apply weighted_root_integral_line_descent φ injective (Fintype.card F)
      Fintype.one_lt_card tau r (weightedRootProductNorm (Fintype.card F) tau r) x
      (weightedRootTopExponent (Fintype.card F) Fintype.one_lt_card r)
      (weighted_root_norm_top_coordinate (Fintype.card F) Fintype.one_lt_card tau r)
    exact ⟨b, line.trans (congrArg (fun v => b • v)
      (weighted_root_base_map_norm φ (Fintype.card F) tau r).symm)⟩
  · rintro ⟨a, rfl⟩
    have normVanish : q * weightedRootProductNorm (Fintype.card F) tau r = 0 := by
      apply extensionInjective
      rw [map_mul, weighted_root_base_map_norm, map_zero]
      exact (fieldKernel (weightedRootProductNorm (Fintype.card F) (φ tau) r)
        origin directions).mpr ⟨1, (one_smul K _).symm⟩
    rw [mul_smul_comm, normVanish, smul_zero]

end Litt3.Deformations
