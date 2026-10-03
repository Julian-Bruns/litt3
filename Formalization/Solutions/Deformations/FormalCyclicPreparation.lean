import Definitions.Deformations.FormalCyclicPreparation
import Solutions.Deformations.IntegralCyclicRelation
import Solutions.Deformations.CoefficientSeriesShiftPowers
import Solutions.Deformations.PolynomialSeriesCompletion
import Mathlib.Data.Nat.Choose.Dvd

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem formal_cyclic_relation_full_sum (p a : ℕ) :
    formalCyclicRelation (R := R) (K := K) p a =
      ∑ j ∈ Finset.Icc 1 (p ^ a), (((p ^ a).choose j : ℕ) : R) • coefficientSeriesShift j := by
  rw [formalCyclicRelation, integral_cyclic_relation_norm (R := R)]
  unfold integralCyclicNormValue
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j member
  have positive := (Finset.mem_Icc.mp member).1
  rw [mul_smul_comm, ← pow_succ', Nat.sub_add_cancel positive, coefficient_series_shift_power]

/-- The full original cyclic relation is itself the actual
distinguished degree-q operator plus a p-multiple polynomial
correction, with its literal integral coefficients. -/
theorem formal_cyclic_relation_prepared (p a : ℕ) (prime : p.Prime) :
    formalCyclicRelation (R := R) (K := K) p a =
      preparedSeriesOperator (p ^ a) (p : R) (formalCyclicCorrection (R := R) (K := K) p a) := by
  classical
  have positive := pow_pos prime.pos a
  have successor : p ^ a - 1 + 1 = p ^ a := by omega
  have split := Finset.sum_Icc_succ_top (a := 1) (b := p ^ a - 1) (by omega)
    (fun j => (((p ^ a).choose j : ℕ) : R) • coefficientSeriesShift (R := R) (K := K) j)
  rw [successor] at split
  rw [formal_cyclic_relation_full_sum, split, Nat.choose_self, Nat.cast_one, one_smul]
  unfold preparedSeriesOperator formalCyclicCorrection
  rw [Finset.smul_sum, add_comm]
  congr 1
  apply Finset.sum_congr rfl
  intro j member
  obtain ⟨lower, upper⟩ := Finset.mem_Icc.mp member
  have different : j ≠ p ^ a := by omega
  have divide := Nat.mul_div_cancel' (prime.dvd_choose_pow (by omega : j ≠ 0) different)
  have coefficient := congrArg (fun n : ℕ => (n : R)) divide
  simp only [Nat.cast_mul] at coefficient
  rw [smul_smul, coefficient]

theorem formal_cyclic_correction_commute_shift (p a : ℕ) :
    Commute (formalCyclicCorrection (R := R) (K := K) p a) (coefficientSeriesShift 1) := by
  unfold formalCyclicCorrection
  apply Commute.symm
  apply Commute.sum_right
  intro j member
  have commute : Commute (coefficientSeriesShift (R := R) (K := K) 1) (coefficientSeriesShift j) := by
    rw [← coefficient_series_shift_power (R := R) (K := K) j]
    exact (Commute.refl (coefficientSeriesShift (R := R) (K := K) 1)).pow_right j
  exact commute.smul_right _

theorem formal_cyclic_correction_preserves_polynomial (p a : ℕ)
    (v : polynomialCoefficientSeries (R := R) (K := K)) :
    formalCyclicCorrection (R := R) (K := K) p a (v : CoefficientSeries (K := K)) ∈
      polynomialCoefficientSeries (R := R) (K := K) := by
  rw [formalCyclicCorrection, LinearMap.sum_apply]
  apply Submodule.sum_mem
  intro j member
  exact Submodule.smul_mem _ _ (polynomialSeriesShift (R := R) j v).2

end Litt3.Deformations
