import Theorems.Deformations.TruncatedRestriction
import Solutions.Deformations.TruncatedPowerKernels
import Solutions.Deformations.FiltrationWidth

namespace Litt3.Deformations

open Polynomial

variable {k : Type*} [CommRing k]

@[simp] theorem truncated_restriction_parameter (N j : ℕ) (bound : j ≤ N) :
    truncatedRestriction k N j bound (truncatedParameter k N) =
      truncatedParameter k j := by
  exact AdjoinRoot.algHomOfDvd_root _ _ _

@[simp] theorem truncated_restriction_mk (N j : ℕ) (bound : j ≤ N)
    (P : Polynomial k) :
    truncatedRestriction k N j bound (AdjoinRoot.mk ((X : Polynomial k) ^ N) P) =
      AdjoinRoot.mk ((X : Polynomial k) ^ j) P := by
  unfold truncatedRestriction
  rw [AdjoinRoot.coe_algHomOfDvd, AdjoinRoot.liftAlgHom_mk]
  exact AdjoinRoot.aeval_eq P

theorem truncated_restriction_surjective (N j : ℕ) (bound : j ≤ N) :
    Function.Surjective (truncatedRestriction k N j bound) := by
  intro x
  obtain ⟨P, rfl⟩ := AdjoinRoot.mk_surjective (g := (X : Polynomial k) ^ j) x
  exact ⟨AdjoinRoot.mk ((X : Polynomial k) ^ N) P,
    truncated_restriction_mk N j bound P⟩

/-- The actual reduction kernel is the actual parameter-power
ideal; this requires no field or reduced coefficient hypothesis. -/
theorem truncated_restriction_kernel (N j : ℕ) (bound : j ≤ N) :
    Specifications.TruncatedRestrictionKernel (k := k) N j bound := by
  apply SetLike.ext
  intro x
  rw [LinearMap.mem_ker, LinearMap.mem_range]
  change truncatedRestriction k N j bound x = 0 ↔
    ∃ y, truncatedParameter k N ^ j * y = x
  constructor
  · intro hx
    obtain ⟨P, rfl⟩ := AdjoinRoot.mk_surjective (g := (X : Polynomial k) ^ N) x
    rw [truncated_restriction_mk, AdjoinRoot.mk_eq_zero] at hx
    obtain ⟨Q, hQ⟩ := hx
    refine ⟨AdjoinRoot.mk ((X : Polynomial k) ^ N) Q, ?_⟩
    rw [hQ, map_mul, map_pow, AdjoinRoot.mk_X]
    rfl
  · rintro ⟨y, rfl⟩
    rw [map_mul, map_pow, truncated_restriction_parameter,
      truncated_parameter_pow, zero_mul]

/-- The genuine cokernel of a power multiplication is the genuine
shorter truncated coefficient algebra, as a coefficient module. -/
noncomputable def truncatedPowerCokernelEquiv (N j : ℕ) (bound : j ≤ N) :
    (TruncatedCoefficientRing k N ⧸ LinearMap.range (truncatedPowerCoefficientMap k N j))
      ≃ₗ[k] TruncatedCoefficientRing k j :=
  (Submodule.quotEquivOfEq _ _
    (truncated_restriction_kernel (k := k) N j bound).symm).trans
    ((truncatedRestriction k N j bound).toLinearMap.quotKerEquivOfSurjective
      (truncated_restriction_surjective N j bound))

theorem truncated_power_cokernel_finrank {K : Type*} [Field K]
    (N j : ℕ) (bound : j ≤ N) :
    Module.finrank K (EndomorphismCokernel (truncatedPowerCoefficientMap K N j)) = j := by
  rw [(truncatedPowerCokernelEquiv (k := K) N j bound).finrank_eq]
  exact truncated_coefficient_finrank j

theorem truncated_power_kernel_finrank {K : Type*} [Field K]
    (N j : ℕ) (bound : j ≤ N) :
    Module.finrank K (LinearMap.ker (truncatedPowerCoefficientMap K N j)) = j := by
  rw [kernel_cokernel_finrank_eq]
  exact truncated_power_cokernel_finrank N j bound

end Litt3.Deformations
