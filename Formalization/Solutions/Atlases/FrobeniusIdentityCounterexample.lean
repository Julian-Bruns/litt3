import Solutions.Deformations.TruncatedValuation
import Definitions.Atlases.PerfectFrobenius

namespace Litt3.Atlases

open Litt3.Deformations

variable {k : Type*} [Field k]

/-- The actual dual-number algebra has a nonzero nilpotent, so an
identity-map rank plateau cannot be a reducedness certificate. -/
theorem dual_numbers_have_nonzero_nilpotent :
    ∃ x : TruncatedCoefficientRing k 2, x ≠ 0 ∧ IsNilpotent x := by
  refine ⟨truncatedParameter k 2, ?_, 2, ?_⟩
  · simpa only [pow_one] using truncated_parameter_pow_nonzero (k := k) 2 1 (by decide)
  · exact truncated_parameter_pow (k := k) 2

theorem dual_numbers_not_reduced : ¬IsReduced (TruncatedCoefficientRing k 2) := by
  intro h
  letI := h
  obtain ⟨x, hx, hnil⟩ := dual_numbers_have_nonzero_nilpotent (k := k)
  exact hx hnil.eq_zero

theorem dual_numbers_identity_kernel_not_nilradical :
    LinearMap.ker (LinearMap.id : TruncatedCoefficientRing k 2 →ₗ[k] TruncatedCoefficientRing k 2) ≠
      (nilradical (TruncatedCoefficientRing k 2)).restrictScalars k := by
  intro he
  obtain ⟨x, hx, hnil⟩ := dual_numbers_have_nonzero_nilpotent (k := k)
  have hm : x ∈ (nilradical (TruncatedCoefficientRing k 2)).restrictScalars k :=
    mem_nilradical.mpr hnil
  rw [← he] at hm
  exact hx hm

theorem dual_numbers_identity_rank_plateau :
    Module.finrank k (LinearMap.range
      (LinearMap.id : TruncatedCoefficientRing k 2 →ₗ[k] TruncatedCoefficientRing k 2)) =
      Module.finrank k (LinearMap.range
        ((LinearMap.id : TruncatedCoefficientRing k 2 →ₗ[k] TruncatedCoefficientRing k 2).comp
          LinearMap.id)) := by
  rw [LinearMap.id_comp]

end Litt3.Atlases
