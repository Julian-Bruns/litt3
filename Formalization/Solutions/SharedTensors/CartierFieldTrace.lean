import Solutions.SharedTensors.FrobeniusFieldTrace

namespace Litt3.SharedTensors

variable {K L : Type*} [Field K] [Field L] [Algebra K L]
  [FiniteDimensional K L] [Algebra.IsSeparable K L]
variable {p : ℕ} [Fact p.Prime] [CharP K p] [CharP L p]

/-- Every literal p-basis root coefficient commutes with the actual
finite separable field trace; the entire field expansions are used. -/
theorem pRootCoefficient_finite_separable_trace
    (bK : PowerPBasis K p) (bL : PowerPBasis L p)
    (hparameter : bL.parameter = algebraMap K L bK.parameter)
    (a : L) (i : Fin p) :
    pRootCoefficient K p bK (Algebra.trace K L a) i =
      Algebra.trace K L (pRootCoefficient L p bL a i) := by
  have hsum : (∑ j : Fin p,
      (Algebra.trace K L (pRootCoefficient L p bL a j)) ^ p * bK.parameter ^ j.val) =
      Algebra.trace K L a := by
    calc
      _ = Algebra.trace K L
          (∑ j : Fin p, pRootCoefficient L p bL a j ^ p * bL.parameter ^ j.val) := by
        rw [map_sum]
        apply Finset.sum_congr rfl
        intro j _
        rw [hparameter, ← map_pow (algebraMap K L), mul_comm
          (pRootCoefficient L p bL a j ^ p), ← Algebra.smul_def,
          map_smul, smul_eq_mul, finite_separable_trace_pth_power]
        exact mul_comm _ _
      _ = _ := by rw [p_basis_actual_expansion]
  exact (p_basis_actual_expansion_unique bK (Algebra.trace K L a)
    (fun j => Algebra.trace K L (pRootCoefficient L p bL a j)) hsum i).symm

theorem rationalCartierCoefficient_finite_separable_trace
    (bK : PowerPBasis K p) (bL : PowerPBasis L p)
    (hparameter : bL.parameter = algebraMap K L bK.parameter) (a : L) :
    rationalCartierCoefficient K p bK (Algebra.trace K L a) =
      Algebra.trace K L (rationalCartierCoefficient L p bL a) :=
  pRootCoefficient_finite_separable_trace bK bL hparameter a _

end Litt3.SharedTensors
