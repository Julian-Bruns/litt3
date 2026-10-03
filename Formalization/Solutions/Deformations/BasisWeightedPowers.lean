import Definitions.Deformations.BasisWeightedPowers
import Mathlib.Tactic

namespace Litt3.Deformations

theorem basis_weight_exponent_le (w d b j : ℕ) (positive : 0 < w) :
    basisWeightExponent w d b ≤ j ↔ d ≤ w * j + b := by
  unfold basisWeightExponent
  rw [Nat.div_le_iff_le_mul positive]
  rw [Nat.mul_comm j w]
  omega

theorem basis_weight_exponent_reaches (w d b : ℕ) (positive : 0 < w) :
    d ≤ w * basisWeightExponent w d b + b :=
  (basis_weight_exponent_le w d b _ positive).mp le_rfl

variable {R M I : Type*} [CommRing R] [AddCommGroup M] [Module R M]

theorem basis_weighted_power_mem_iff [Fintype I]
    (B : Module.Basis I R M) (a : R) (w : ℕ) (positive : 0 < w)
    (degree : I → ℕ) (d : ℕ) (x : M) :
    x ∈ basisWeightedPowerFiltration B a w degree d ↔
      ∀ i, a ^ basisWeightExponent w d (degree i) ∣ B.repr x i := by
  classical
  constructor
  · intro member
    induction member using Submodule.span_induction with
    | mem y member =>
      obtain ⟨j, i, bound, rfl⟩ := member
      intro t
      rw [map_smul, Finsupp.smul_apply, smul_eq_mul, B.repr_self]
      by_cases same : i = t
      · subst t
        simp only [Finsupp.single_eq_same, mul_one]
        exact pow_dvd_pow a ((basis_weight_exponent_le w d (degree i) j positive).mpr bound)
      · simp [Finsupp.single_apply, same, Ne.symm same]
    | zero =>
      intro i
      simp only [map_zero, Finsupp.zero_apply, dvd_zero]
    | add y z _ _ hy hz =>
      intro i
      rw [map_add, Finsupp.add_apply]
      exact dvd_add (hy i) (hz i)
    | smul c y _ hy =>
      intro i
      rw [map_smul, Finsupp.smul_apply, smul_eq_mul]
      exact dvd_mul_of_dvd_right (hy i) c
  · intro coefficients
    choose c hc using coefficients
    have expansion : x = ∑ i, c i •
        (a ^ basisWeightExponent w d (degree i) • B i) := by
      rw [← B.sum_repr x]
      apply Finset.sum_congr rfl
      intro i _
      rw [hc i, smul_smul, mul_comm]
    rw [expansion]
    apply Submodule.sum_mem
    intro i _
    apply Submodule.smul_mem
    exact Submodule.subset_span ⟨_, i,
      basis_weight_exponent_reaches w d (degree i) positive, rfl⟩

end Litt3.Deformations
