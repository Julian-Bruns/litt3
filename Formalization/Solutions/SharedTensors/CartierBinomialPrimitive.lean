import Solutions.SharedTensors.RationalCartierExactKernel
import Mathlib.Data.Nat.Choose.Sum

namespace Litt3.SharedTensors

open Finset

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
variable {p : ℕ} [CharP K p]

/-- The mixed part of the p-th-power differential has a primitive whose
denominators are only 1,...,p-1. There is no division by p. -/
noncomputable def cartierBinomialPrimitive (a b : K) : K :=
  ∑ i ∈ range (p - 1),
    ((p - 1).choose i : K) * ((i + 1 : ℕ) : K)⁻¹ *
      a ^ (i + 1) * b ^ (p - 1 - i)

theorem binomial_coefficient_successor_cast
    (n i : ℕ) :
    ((n.choose i : ℕ) : K) * ((n - i : ℕ) : K) =
      ((i + 1 : ℕ) : K) * ((n.choose (i + 1) : ℕ) : K) := by
  rw [mul_comm ((i + 1 : ℕ) : K)]
  simpa only [Nat.cast_mul] using
    congrArg (fun m : ℕ => (m : K)) (Nat.choose_succ_right_eq n i).symm

theorem cartier_binomial_primitive_term_derivative
    (D : Derivation k K K) (a b : K) (i : ℕ) (hi : i < p - 1) :
    D (((p - 1).choose i : K) * ((i + 1 : ℕ) : K)⁻¹ *
      a ^ (i + 1) * b ^ (p - 1 - i)) =
      (a ^ i * b ^ (p - 1 - i) * ((p - 1).choose i : K)) * D a +
      (a ^ (i + 1) * b ^ (p - 1 - (i + 1)) *
        ((p - 1).choose (i + 1) : K)) * D b := by
  have hcast : ((i + 1 : ℕ) : K) ≠ 0 :=
    (CharP.cast_eq_zero_iff K p (i + 1)).not.mpr
      (Nat.not_dvd_of_pos_of_lt (by omega) (by omega))
  have hexp : p - 1 - i - 1 = p - 1 - (i + 1) := by omega
  have hc := binomial_coefficient_successor_cast (K := K) (p - 1) i
  simp only [D.leibniz, D.leibniz_pow, D.leibniz_inv,
    D.map_natCast, nsmul_eq_mul, smul_eq_mul, mul_zero, add_zero,
    Nat.add_sub_cancel, hexp]
  field_simp
  linear_combination hc * a ^ (i + 1) * b ^ (p - 1 - (i + 1)) * D b

/-- The full binary additive defect is exact in every prime
characteristic; the displayed primitive uses all mixed digits. -/
theorem cartier_binomial_primitive_derivative
    (D : Derivation k K K) (a b : K) :
    D (cartierBinomialPrimitive (p := p) a b) =
      (a + b) ^ (p - 1) * D (a + b) -
        a ^ (p - 1) * D a - b ^ (p - 1) * D b := by
  have hleft : (∑ i ∈ range (p - 1),
      a ^ i * b ^ (p - 1 - i) * ((p - 1).choose i : K)) =
      (a + b) ^ (p - 1) - a ^ (p - 1) := by
    have h := add_pow a b (p - 1)
    rw [sum_range_succ] at h
    simp only [Nat.sub_self, pow_zero, mul_one, Nat.choose_self, Nat.cast_one] at h
    linear_combination -h
  have hright : (∑ i ∈ range (p - 1),
      a ^ (i + 1) * b ^ (p - 1 - (i + 1)) *
        ((p - 1).choose (i + 1) : K)) =
      (a + b) ^ (p - 1) - b ^ (p - 1) := by
    have h := add_pow a b (p - 1)
    rw [sum_range_succ'] at h
    simp only [pow_zero, one_mul, Nat.sub_zero, Nat.choose_zero_right,
      Nat.cast_one, mul_one] at h
    linear_combination -h
  rw [cartierBinomialPrimitive, map_sum]
  calc
    _ = ∑ i ∈ range (p - 1), (
        (a ^ i * b ^ (p - 1 - i) * ((p - 1).choose i : K)) * D a +
        (a ^ (i + 1) * b ^ (p - 1 - (i + 1)) *
          ((p - 1).choose (i + 1) : K)) * D b) := by
      apply sum_congr rfl
      intro i hi
      exact cartier_binomial_primitive_term_derivative D a b i (mem_range.mp hi)
    _ = _ := by
      rw [sum_add_distrib, ← sum_mul, ← sum_mul, hleft, hright, map_add]
      ring

end Litt3.SharedTensors
