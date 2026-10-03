import Definitions.Deformations.FormalCyclicReduction
import Solutions.Deformations.FormalCyclicPreparation
import Solutions.Deformations.SeriesCoefficientReduction

namespace Litt3.Deformations

variable {R K : Type*} [CommRing R] [AddCommGroup K] [Module R K]

theorem scalar_coefficient_reduction_shift (scalar : R) (h : ℕ)
    (v : CoefficientSeries (K := K)) :
    scalarCoefficientReduction scalar (coefficientSeriesShift (R := R) h v) =
      coefficientSeriesShift (R := R) h (scalarCoefficientReduction scalar v) :=
  coefficient_series_lift_shift _ h v

theorem formal_cyclic_norm_full_sum (p a : ℕ) :
    formalCyclicNorm (R := R) (K := K) p a =
      ∑ j ∈ Finset.Icc 1 (p ^ a), (((p ^ a).choose j : ℕ) : R) • coefficientSeriesShift (j - 1) := by
  unfold formalCyclicNorm integralCyclicNormValue
  simp_rw [coefficient_series_shift_power]

/-- The literal full original norm is its highest monomial plus
the literal p-multiple integral lower-binomial correction. -/
theorem formal_cyclic_norm_prepared (p a : ℕ) (prime : p.Prime) :
    formalCyclicNorm (R := R) (K := K) p a =
      coefficientSeriesShift (p ^ a - 1) + (p : R) • formalCyclicNormCorrection p a := by
  classical
  have positive := pow_pos prime.pos a
  have successor : p ^ a - 1 + 1 = p ^ a := by omega
  have split := Finset.sum_Icc_succ_top (a := 1) (b := p ^ a - 1) (by omega)
    (fun j => (((p ^ a).choose j : ℕ) : R) • coefficientSeriesShift (R := R) (K := K) (j - 1))
  rw [successor] at split
  rw [formal_cyclic_norm_full_sum, split, Nat.choose_self, Nat.cast_one, one_smul]
  unfold formalCyclicNormCorrection
  rw [Finset.smul_sum, add_comm]
  congr 1
  apply Finset.sum_congr rfl
  intro j member
  obtain ⟨lower, upper⟩ := Finset.mem_Icc.mp member
  have divide := Nat.mul_div_cancel' (prime.dvd_choose_pow (by omega : j ≠ 0) (by omega : j ≠ p ^ a))
  have coefficient := congrArg (fun n : ℕ => (n : R)) divide
  simp only [Nat.cast_mul] at coefficient
  rw [smul_smul, coefficient]

/-- The full original cyclic relation reduces to e^q on the actual
original coefficient scalar quotient. -/
theorem formal_cyclic_relation_scalar_reduction (p a : ℕ) [Fact p.Prime]
    (v : CoefficientSeries (K := K)) :
    scalarCoefficientReduction (p : R) (formalCyclicRelation (R := R) p a v) =
      coefficientSeriesShift (R := R) (p ^ a) (scalarCoefficientReduction (p : R) v) := by
  rw [formal_cyclic_relation_prepared p a Fact.out, preparedSeriesOperator,
    LinearMap.add_apply, LinearMap.smul_apply, map_add,
    scalar_coefficient_reduction_kills, add_zero, scalar_coefficient_reduction_shift]

/-- The full original norm reduces to e^(q−1), including the whole
unbounded cyclic order and arbitrary coefficient module rank. -/
theorem formal_cyclic_norm_scalar_reduction (p a : ℕ) [Fact p.Prime]
    (v : CoefficientSeries (K := K)) :
    scalarCoefficientReduction (p : R) (formalCyclicNorm (R := R) p a v) =
      coefficientSeriesShift (R := R) (p ^ a - 1) (scalarCoefficientReduction (p : R) v) := by
  rw [formal_cyclic_norm_prepared p a Fact.out, LinearMap.add_apply,
    LinearMap.smul_apply, map_add, scalar_coefficient_reduction_kills, add_zero,
    scalar_coefficient_reduction_shift]

end Litt3.Deformations
