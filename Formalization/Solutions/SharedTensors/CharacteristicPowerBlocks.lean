import Definitions.SharedTensors.CharacteristicPowerBlocks
import Solutions.SharedTensors.CharacterBlocks
import Mathlib.Tactic

namespace Litt3.SharedTensors

open Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

theorem characteristic_power_block_coeff (p j : ℕ) (F : K[X]) (i : ℕ) :
    (characteristicPowerBlock p j F).coeff i =
      if i < p then F.coeff (p * j + i) else 0 := by
  classical
  simp [characteristicPowerBlock, finset_sum_coeff, coeff_monomial,
    Finset.sum_ite_eq']

theorem characteristic_power_block_degree_lt (p j : ℕ) (F : K[X])
    (hp : 0 < p) : (characteristicPowerBlock p j F).natDegree < p := by
  by_cases hz : characteristicPowerBlock p j F = 0
  · simpa only [hz, natDegree_zero] using hp
  · apply (natDegree_lt_iff_degree_lt hz).mpr
    apply (degree_lt_iff_coeff_zero _ _).mpr
    intro i hi
    rw [characteristic_power_block_coeff, if_neg (not_lt.mpr hi)]

theorem characteristic_power_block_coefficients (p j : ℕ) (F : K[X])
    (V : Submodule k K) (hF : CoefficientsIn V F) :
    CoefficientsIn V (characteristicPowerBlock p j F) := by
  intro i
  rw [characteristic_power_block_coeff]
  split_ifs
  · exact hF _
  · exact V.zero_mem

/-- The original coefficient equation is restricted to each actual block.
The upper block boundary disappears because p is the characteristic. -/
theorem characteristic_power_block_equation
    (p s j : ℕ) [CharP K p] (D : K →ₗ[k] K) (eta beta : K)
    (F : K[X]) (hF : IsCharacterBlock D eta beta s F) :
    IsCharacterBlock D eta beta s (characteristicPowerBlock p j F) := by
  intro i
  rw [characteristic_power_block_coeff, characteristic_power_block_coeff]
  by_cases hi : i < p
  · rw [if_pos hi]
    by_cases hinext : i + 1 < p
    · rw [if_pos hinext]
      have h := hF (p * j + i)
      have hindex : p * j + i + 1 = p * j + (i + 1) := by omega
      simpa only [hindex, Nat.cast_add, Nat.cast_mul, CharP.cast_eq_zero,
        zero_mul, zero_add] using h
    · rw [if_neg hinext]
      have hip : i + 1 = p := by omega
      have h := hF (p * j + i)
      have hcast : ((p * j + i + 1 : ℕ) : K) = 0 := by
        rw [show p * j + i + 1 = p * (j + 1) by rw [Nat.mul_add]; omega]
        simp only [Nat.cast_mul, CharP.cast_eq_zero, zero_mul]
      simpa only [hcast, neg_zero, zero_mul, zero_add,
        Nat.cast_add, Nat.cast_mul, CharP.cast_eq_zero, zero_mul, zero_add, mul_zero,
        add_zero] using h
  · have hinext : ¬ i + 1 < p := by omega
    rw [if_neg hi, if_neg hinext, map_zero]
    ring

/-- Finite block reconstruction of the actual polynomial. -/
theorem characteristic_power_blocks_reconstruct (p : ℕ) (hp : 0 < p)
    (F : K[X]) :
    F = ∑ j ∈ Finset.range (F.natDegree + 1),
      X ^ (p * j) * characteristicPowerBlock p j F := by
  classical
  ext n
  rw [finset_sum_coeff]
  have hterm (j : ℕ) :
      (X ^ (p * j) * characteristicPowerBlock p j F).coeff n =
        if j = n / p then F.coeff n else 0 := by
    rw [coeff_X_pow_mul', characteristic_power_block_coeff]
    by_cases hj : j = n / p
    · subst j
      have hle : p * (n / p) ≤ n := Nat.mul_div_le n p
      have hmod : n - p * (n / p) = n % p := by
        have hquot := Nat.mod_add_div n p
        omega
      rw [if_pos hle, hmod, if_pos (Nat.mod_lt n hp), if_pos rfl]
      congr 1
      omega
    · rw [if_neg hj]
      split_ifs with hle hsmall
      · exfalso
        apply hj
        symm
        apply Nat.div_eq_of_lt_le
        · simpa only [Nat.mul_comm] using hle
        · have : n < p * j + p := by omega
          simpa only [Nat.add_mul, Nat.one_mul, Nat.mul_comm] using this
      · rfl
      · rfl
  simp_rw [hterm]
  rw [Finset.sum_ite_eq']
  by_cases hn : n / p < F.natDegree + 1
  · simp only [Finset.mem_range, hn, if_pos]
  · simp only [Finset.mem_range, hn, if_false]
    apply coeff_eq_zero_of_natDegree_lt
    have hdiv := Nat.div_le_self n p
    omega

end Litt3.SharedTensors
