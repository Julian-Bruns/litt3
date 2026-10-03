import Definitions.Deformations.FiniteShiftCokernel
import Solutions.Deformations.FreeScalarKernel
import Solutions.Deformations.SeriesCoefficientReduction

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

@[simp] theorem finite_coefficient_shift_zero (n : ℕ) (v : Fin (n + 1) → K) :
    finiteCoefficientShift (R := R) (n + 1) v 0 = 0 := by
  simp [finiteCoefficientShift, coefficientSeriesPrefix, coefficientSeriesShift]

@[simp] theorem finite_coefficient_shift_succ (n : ℕ) (v : Fin (n + 1) → K) (j : Fin n) :
    finiteCoefficientShift (R := R) (n + 1) v j.succ = v j.castSucc := by
  have bound : j.val < n + 1 := Nat.lt_succ_of_lt j.isLt
  simp [finiteCoefficientShift, coefficientSeriesPrefix, coefficientSeriesShift,
    coefficientSeriesPrefixSection, bound]
  rfl

/-- The exact scalar kernel of a constant plus truncated shift retains
all original lower coordinates and leaves the final coordinate free. -/
theorem finite_shift_affine_scalar_zero (n : ℕ) (r : R) (eta : K) (v : Fin (n + 1) → K) :
    r • ((Fin.cons eta 0 : Fin (n + 1) → K) + finiteCoefficientShift (R := R) (n + 1) v) = 0 ↔
      r • eta = 0 ∧ ∀ j : Fin n, r • v j.castSucc = 0 := by
  constructor
  · intro zero
    constructor
    · have point := congrFun zero 0
      simpa only [Pi.smul_apply, Pi.add_apply, Fin.cons_zero, finite_coefficient_shift_zero,
        add_zero, Pi.zero_apply] using point
    · intro j
      have point := congrFun zero j.succ
      simpa only [Pi.smul_apply, Pi.add_apply, Fin.cons_succ, Pi.zero_apply,
        finite_coefficient_shift_succ, zero_add] using point
  · rintro ⟨constant, coordinates⟩
    funext j
    refine Fin.cases ?_ (fun i => ?_) j
    · simpa only [Pi.smul_apply, Pi.add_apply, Fin.cons_zero, finite_coefficient_shift_zero,
        add_zero, Pi.zero_apply] using constant
    · simpa only [Pi.smul_apply, Pi.add_apply, Fin.cons_succ, Pi.zero_apply,
        finite_coefficient_shift_succ, zero_add] using coordinates i

theorem free_zmod_last_scalar_reduction_zero (p a : ℕ) (positive : 0 < p)
    (K : Type*) [AddCommGroup K] [Module (ZMod (p ^ (a + 1))) K]
    [Module.Free (ZMod (p ^ (a + 1))) K] (v : K)
    (zero : (p : ZMod (p ^ (a + 1))) ^ a • v = 0) :
    (coefficientScalarRange (K := K) (p : ZMod (p ^ (a + 1)))).mkQ v = 0 := by
  have member : v ∈ LinearMap.ker
      ((p : ZMod (p ^ (a + 1))) ^ a • (LinearMap.id : K →ₗ[ZMod (p ^ (a + 1))] K)) := zero
  rw [free_zmod_last_power_kernel p a positive K] at member
  exact (Submodule.Quotient.mk_eq_zero _).mpr member

end Litt3.Deformations
