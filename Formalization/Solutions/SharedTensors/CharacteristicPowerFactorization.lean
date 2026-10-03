import Theorems.SharedTensors.CharacteristicPowerFactorization
import Solutions.SharedTensors.CharacteristicPowerBlocks
import Mathlib.FieldTheory.Separable

namespace Litt3.SharedTensors

open Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

theorem no_homogeneous_characters_implies_no_block_characters
    (p s : ℕ) [CharP K p] (hs : s < p)
    (D : K →ₗ[k] K) (beta : K) (V : Submodule k K)
    (h : NoHomogeneousCharacters D beta V p) :
    NoBlockCharacters D beta V p s := by
  intro i hi hne a ha hDa
  by_cases his : i ≤ s
  · apply h (s - i) (by omega) (by omega) a ha
    simpa only [Nat.cast_sub his] using hDa
  · apply h (p + s - i) (by omega) (by omega) a ha
    have hle : i ≤ p + s := by omega
    simpa only [Nat.cast_sub hle, Nat.cast_add, CharP.cast_eq_zero,
      zero_add] using hDa

theorem character_equation_mod_characteristic (p N : ℕ) [CharP K p]
    (D : K →ₗ[k] K) (eta beta : K) (F : K[X])
    (h : IsCharacterBlock D eta beta N F) :
    IsCharacterBlock D eta beta (N % p) F := by
  have hcast : (N : K) = ((N % p : ℕ) : K) := by
    have hn := congrArg (fun n : ℕ => (n : K)) (Nat.mod_add_div N p)
    simpa only [Nat.cast_add, Nat.cast_mul, CharP.cast_eq_zero,
      zero_mul, add_zero] using hn.symm
  intro i
  simpa only [hcast] using h i

/-- Full monic factorization from actual block equations. It works for
any constant-linear operator, so no unnecessary function-field geometry
or algebraic-closure assumption is used in this algebraic core. -/
theorem characteristic_power_factorization
    (p : ℕ) [CharP K p] (hp : 0 < p)
    (D : K →ₗ[k] K) (eta beta : K) (V : Submodule k K)
    (characters : NoHomogeneousCharacters D beta V p)
    (constants : NoNonconstantDifferentialConstants D V)
    (F : K[X]) (monic : F.Monic) (coefficients : CoefficientsIn V F)
    (equation : IsCharacterBlock D eta beta F.natDegree F) :
    CharacteristicPowerFactorization (k := k) p F := by
  classical
  let s := F.natDegree % p
  let a := F.natDegree / p
  let R := characteristicPowerBlock p a F
  have hs : s < p := Nat.mod_lt _ hp
  have hchars := no_homogeneous_characters_implies_no_block_characters
    p s hs D beta V characters
  have hequation := character_equation_mod_characteristic p F.natDegree
    D eta beta F equation
  have R_bound : R.natDegree < p := characteristic_power_block_degree_lt p a F hp
  have R_coefficients : CoefficientsIn V R :=
    characteristic_power_block_coefficients p a F V coefficients
  have R_equation : IsCharacterBlock D eta beta s R :=
    characteristic_power_block_equation p s a D eta beta F hequation
  have R_normalized : R.coeff s = 1 := by
    rw [characteristic_power_block_coeff, if_pos hs]
    have hindex : p * a + s = F.natDegree := by
      exact Nat.div_add_mod _ _
    rw [hindex]
    exact monic.coeff_natDegree
  have R_nonzero : R ≠ 0 := by
    intro hz
    have : (0 : K) = 1 := by simpa only [hz, coeff_zero] using R_normalized
    exact zero_ne_one this
  have R_degree : R.natDegree = s :=
    character_block_degree_eq D eta beta V p s hchars R R_bound R_coefficients
      R_equation R_nonzero
  have R_monic : R.Monic := by
    rw [Monic, ← coeff_natDegree, R_degree]
    exact R_normalized
  have proportional (j : ℕ) : ∃ c : k, characteristicPowerBlock p j F = c • R :=
    character_block_proportionality D eta beta V p s hchars constants R R_bound
      R_coefficients R_equation R_normalized (characteristicPowerBlock p j F)
      (characteristic_power_block_degree_lt p j F hp)
      (characteristic_power_block_coefficients p j F V coefficients)
      (characteristic_power_block_equation p s j D eta beta F hequation)
  choose c hc using proportional
  let P : k[X] := ∑ j ∈ Finset.range (F.natDegree + 1), monomial j (c j)
  have factorization : F = R * expand K p (P.map (algebraMap k K)) := by
    rw [characteristic_power_blocks_reconstruct p hp F]
    simp only [P, Polynomial.map_sum, Polynomial.map_monomial, map_sum,
      expand_monomial, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro j hj
    rw [hc j, Algebra.smul_def, ← C_mul_X_pow_eq_monomial,
      Polynomial.algebraMap_apply]
    rw [Nat.mul_comm j p]
    ring
  have mapped_monic : (expand K p (P.map (algebraMap k K))).Monic :=
    R_monic.of_mul_monic_left (factorization ▸ monic)
  have P_monic : P.Monic :=
    Polynomial.monic_of_injective (algebraMap k K).injective
      ((monic_expand_iff hp).mp mapped_monic)
  have hdegrees : F.natDegree = s + P.natDegree * p := by
    rw [factorization, R_monic.natDegree_mul mapped_monic, R_degree,
      natDegree_expand, P_monic.natDegree_map]
  have hPdegree : P.natDegree = a := by
    have hquot : (s + P.natDegree * p) / p = P.natDegree := by
      rw [Nat.add_mul_div_right _ _ hp, Nat.div_eq_of_lt hs, zero_add]
    rw [← hdegrees] at hquot
    exact hquot.symm
  exact ⟨R, P, R_monic, P_monic, R_degree, hPdegree, factorization⟩

/-- Irreducibility and separability rule out every positive
characteristic-power factor; no factor enumeration is used. -/
theorem characteristic_power_factorization_separable_degree_bound
    (p : ℕ) [CharP K p] (hp : 0 < p) (F : K[X])
    (factor : CharacteristicPowerFactorization (k := k) p F)
    (irreducible : Irreducible F) (separable : F.Separable) :
    F.natDegree < p := by
  obtain ⟨R, P, R_monic, P_monic, R_degree, P_degree, hfactor⟩ := factor
  by_contra hdegree
  have P_positive : 0 < P.natDegree := by
    rw [P_degree]
    exact Nat.div_pos (not_lt.mp hdegree) hp
  have expanded_not_unit : ¬ IsUnit (expand K p (P.map (algebraMap k K))) := by
    intro hunit
    have hzero := natDegree_eq_zero_of_isUnit hunit
    rw [natDegree_expand, P_monic.natDegree_map] at hzero
    exact (Nat.mul_pos P_positive hp).ne' hzero
  rcases irreducible.isUnit_or_isUnit hfactor with R_unit | expanded_unit
  · have R_one := R_monic.eq_one_of_isUnit R_unit
    have derivative_zero : derivative F = 0 := by
      rw [hfactor, R_one, one_mul, derivative_expand]
      simp only [CharP.cast_eq_zero, zero_mul, mul_zero]
    exact ((separable_iff_derivative_ne_zero irreducible).mp separable) derivative_zero
  · exact expanded_not_unit expanded_unit

/-- Complete algebraic degree consequence of the original positive
homogeneous-character hypothesis. -/
theorem character_polynomial_separable_degree_bound
    (p : ℕ) [CharP K p] (hp : 0 < p)
    (D : K →ₗ[k] K) (eta beta : K) (V : Submodule k K)
    (characters : NoHomogeneousCharacters D beta V p)
    (constants : NoNonconstantDifferentialConstants D V)
    (F : K[X]) (monic : F.Monic) (coefficients : CoefficientsIn V F)
    (equation : IsCharacterBlock D eta beta F.natDegree F)
    (irreducible : Irreducible F) (separable : F.Separable) :
    F.natDegree < p :=
  characteristic_power_factorization_separable_degree_bound p hp F
    (characteristic_power_factorization p hp D eta beta V characters constants
      F monic coefficients equation) irreducible separable

end Litt3.SharedTensors
