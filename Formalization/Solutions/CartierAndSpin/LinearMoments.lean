import Theorems.CartierAndSpin.LinearMoments
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Finset

variable {K A : Type*} [CommRing K] [CommRing A] [Algebra K A]

/-- The complete binomial moment law for every actual linear functional
on a commutative algebra. No finite-dimensionality or characteristic is used. -/
theorem functionalMoment_translate (linear : A →ₗ[K] K) (weight value : A)
    (b : K) (n : ℕ) :
    functionalMoment linear weight (value + algebraMap K A b) n =
      ∑ j ∈ range (n + 1), (n.choose j : K) * b ^ (n - j) *
        functionalMoment linear weight value j := by
  unfold functionalMoment
  rw [add_pow, sum_mul, map_sum]
  apply sum_congr rfl
  intro j hj
  have heq : (value ^ j * algebraMap K A b ^ (n - j) * (n.choose j : A)) * weight =
      ((n.choose j : K) * b ^ (n - j)) • (value ^ j * weight) := by
    simp only [Algebra.smul_def, map_mul, map_pow, map_natCast]
    ring
  rw [heq, map_smul, smul_eq_mul]

theorem functionalMoment_translate_two (linear : A →ₗ[K] K) (weight value : A) (b : K) :
    functionalMoment linear weight (value + algebraMap K A b) 2 =
      functionalMoment linear weight value 2 +
      2 * b * functionalMoment linear weight value 1 +
      b ^ 2 * functionalMoment linear weight value 0 := by
  rw [functionalMoment_translate]
  simp only [sum_range_succ, sum_range_zero, Nat.choose_zero_right, Nat.choose_one_right,
    Nat.choose_self, Nat.cast_one, Nat.cast_ofNat, Nat.reduceSub, pow_zero, pow_one,
    one_mul, mul_one, zero_add]
  ring

theorem functionalMoment_translate_three (linear : A →ₗ[K] K) (weight value : A) (b : K) :
    functionalMoment linear weight (value + algebraMap K A b) 3 =
      functionalMoment linear weight value 3 +
      3 * b * functionalMoment linear weight value 2 +
      3 * b ^ 2 * functionalMoment linear weight value 1 +
      b ^ 3 * functionalMoment linear weight value 0 := by
  rw [functionalMoment_translate]
  norm_num [sum_range_succ, Nat.choose]
  ring

theorem functionalMoment_translate_four (linear : A →ₗ[K] K) (weight value : A) (b : K) :
    functionalMoment linear weight (value + algebraMap K A b) 4 =
      functionalMoment linear weight value 4 +
      4 * b * functionalMoment linear weight value 3 +
      6 * b ^ 2 * functionalMoment linear weight value 2 +
      4 * b ^ 3 * functionalMoment linear weight value 1 +
      b ^ 4 * functionalMoment linear weight value 0 := by
  rw [functionalMoment_translate]
  norm_num [sum_range_succ, Nat.choose]
  ring

theorem functionalMoment_two_translation_invariant (linear : A →ₗ[K] K)
    (weight value : A) (b : K)
    (hzero : functionalMoment linear weight value 0 = 0)
    (hone : functionalMoment linear weight value 1 = 0) :
    functionalMoment linear weight (value + algebraMap K A b) 2 =
      functionalMoment linear weight value 2 := by
  rw [functionalMoment_translate_two, hzero, hone]
  ring

theorem functionalMomentDiscriminant_translation_invariant (linear : A →ₗ[K] K)
    (weight value : A) (b : K)
    (hzero : functionalMoment linear weight value 0 = 0)
    (hone : functionalMoment linear weight value 1 = 0) :
    functionalMomentDiscriminant linear weight (value + algebraMap K A b) =
      functionalMomentDiscriminant linear weight value := by
  unfold functionalMomentDiscriminant
  rw [functionalMoment_two_translation_invariant linear weight value b hzero hone,
    functionalMoment_translate_three, functionalMoment_translate_four, hzero, hone]
  ring

theorem functionalTraceZeroMomentTranslationInvariant (linear : A →ₗ[K] K)
    (weight value : A) :
    Specifications.FunctionalTraceZeroMomentTranslationInvariant linear weight value := by
  intro hzero hone b
  exact ⟨functionalMoment_two_translation_invariant linear weight value b hzero hone,
    functionalMomentDiscriminant_translation_invariant linear weight value b hzero hone⟩

end Litt3.CartierAndSpin
