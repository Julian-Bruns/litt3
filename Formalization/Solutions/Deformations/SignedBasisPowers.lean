import Definitions.Deformations.SignedBasisPowers
import Solutions.Deformations.BasisWeightedPowers

namespace Litt3.Deformations

open scoped BigOperators

theorem signed_basis_weight_exponent_le (w : ℕ) (positive : 0 < w)
    (d : ℤ) (degree j : ℕ) :
    signedBasisWeightExponent w d degree ≤ j ↔ (degree : ℤ) ≤ d + (w : ℤ) * j := by
  rw [signedBasisWeightExponent, basis_weight_exponent_le w _ 0 j positive]
  simp only [Nat.add_zero]
  have cast : ((w * j : ℕ) : ℤ) = (w : ℤ) * j := Nat.cast_mul w j
  omega

theorem signed_basis_weight_exponent_reaches (w : ℕ) (positive : 0 < w)
    (d : ℤ) (degree : ℕ) :
    (degree : ℤ) ≤ d + (w : ℤ) * signedBasisWeightExponent w d degree :=
  (signed_basis_weight_exponent_le w positive d degree _).mp le_rfl

variable {R M I : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- Exact coefficient-ideal characterization of literal signed carries
in a free basis. No cancellation, domain or completeness is used. -/
theorem signed_basis_power_mem_iff [Fintype I] (B : Module.Basis I R M)
    (a : R) (w : ℕ) (positive : 0 < w) (degree : I → ℕ) (d : ℤ) (x : M) :
    x ∈ signedBasisPowerFiltration B a w degree d ↔
      ∀ i, a ^ signedBasisWeightExponent w d (degree i) ∣ B.repr x i := by
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
        exact pow_dvd_pow a ((signed_basis_weight_exponent_le w positive d (degree i) j).mpr bound)
      · simp [Finsupp.single_apply, same, Ne.symm same]
    | zero => intro i; simp
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
        (a ^ signedBasisWeightExponent w d (degree i) • B i) := by
      rw [← B.sum_repr x]
      apply Finset.sum_congr rfl
      intro i _
      rw [hc i, smul_smul, mul_comm]
    rw [expansion]
    apply Submodule.sum_mem
    intro i _
    apply Submodule.smul_mem
    exact Submodule.subset_span ⟨_, i,
      signed_basis_weight_exponent_reaches w positive d (degree i), rfl⟩

end Litt3.Deformations
