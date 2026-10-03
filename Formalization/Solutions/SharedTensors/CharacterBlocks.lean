import Theorems.SharedTensors.CharacterBlocks
import Mathlib.Tactic.Ring

namespace Litt3.SharedTensors

open Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

theorem character_block_leading_equation (D : K →ₗ[k] K) (eta beta : K) (s : ℕ)
    (r : K[X]) (hr : IsCharacterBlock D eta beta s r) :
    D (r.coeff r.natDegree) =
      ((s : K) - (r.natDegree : K)) * beta * r.coeff r.natDegree := by
  have hz : r.coeff (r.natDegree + 1) = 0 :=
    coeff_eq_zero_of_natDegree_lt (Nat.lt_succ_self _)
  simpa only [hz, mul_zero, zero_add] using hr r.natDegree

/-- Every nonzero block has precisely the resonant degree; no generic
nonvanishing chart or numerical degree sampling is used. -/
theorem character_block_degree_eq (D : K →ₗ[k] K) (eta beta : K)
    (V : Submodule k K) (p s : ℕ) (no_characters : NoBlockCharacters D beta V p s)
    (r : K[X]) (degree_bound : r.natDegree < p)
    (coefficients : CoefficientsIn V r) (equation : IsCharacterBlock D eta beta s r)
    (nonzero : r ≠ 0) : r.natDegree = s := by
  by_contra hne
  have hzero := no_characters r.natDegree degree_bound hne (r.coeff r.natDegree)
    (coefficients _) (character_block_leading_equation D eta beta s r equation)
  exact (leadingCoeff_ne_zero.mpr nonzero) (coeff_natDegree.symm.trans hzero)

theorem character_block_zero_of_resonant_zero (D : K →ₗ[k] K) (eta beta : K)
    (V : Submodule k K) (p s : ℕ) (no_characters : NoBlockCharacters D beta V p s)
    (r : K[X]) (degree_bound : r.natDegree < p)
    (coefficients : CoefficientsIn V r) (equation : IsCharacterBlock D eta beta s r)
    (resonant_zero : r.coeff s = 0) : r = 0 := by
  by_contra hne
  have hdegree := character_block_degree_eq D eta beta V p s no_characters
    r degree_bound coefficients equation hne
  apply (leadingCoeff_ne_zero.mpr hne)
  rw [← coeff_natDegree, hdegree]
  exact resonant_zero

theorem character_block_resonant_is_constant (D : K →ₗ[k] K) (eta beta : K)
    (V : Submodule k K) (p s : ℕ) (no_characters : NoBlockCharacters D beta V p s)
    (constants : NoNonconstantDifferentialConstants D V)
    (r : K[X]) (degree_bound : r.natDegree < p)
    (coefficients : CoefficientsIn V r) (equation : IsCharacterBlock D eta beta s r) :
    ∃ c : k, algebraMap k K c = r.coeff s := by
  apply constants _ (coefficients s)
  by_cases hz : r = 0
  · simp only [hz, coeff_zero, map_zero]
  · have hdegree := character_block_degree_eq D eta beta V p s no_characters
      r degree_bound coefficients equation hz
    have hleading := character_block_leading_equation D eta beta s r equation
    simpa only [hdegree, sub_self, zero_mul] using hleading

theorem character_block_sub_smul (D : K →ₗ[k] K) (eta beta : K) (s : ℕ)
    (r R : K[X]) (hr : IsCharacterBlock D eta beta s r)
    (hR : IsCharacterBlock D eta beta s R) (c : k) :
    IsCharacterBlock D eta beta s (r - c • R) := by
  intro i
  simp only [coeff_sub, coeff_smul, map_sub, map_smul, hr i, hR i]
  simp only [Algebra.smul_def]
  ring

/-- Every block is a constant multiple of a normalized actual solution,
under precisely the homogeneous-character and constant-space hypotheses. -/
theorem character_block_proportionality (D : K →ₗ[k] K) (eta beta : K)
    (V : Submodule k K) (p s : ℕ) (no_characters : NoBlockCharacters D beta V p s)
    (constants : NoNonconstantDifferentialConstants D V)
    (R : K[X]) (R_degree : R.natDegree < p) (R_coefficients : CoefficientsIn V R)
    (R_equation : IsCharacterBlock D eta beta s R) (normalized : R.coeff s = 1) :
    CharacterBlockProportionality D eta beta V p s R := by
  intro r r_degree r_coefficients r_equation
  obtain ⟨c, hc⟩ := character_block_resonant_is_constant D eta beta V p s no_characters
    constants r r_degree r_coefficients r_equation
  refine ⟨c, sub_eq_zero.mp ?_⟩
  apply character_block_zero_of_resonant_zero D eta beta V p s no_characters
    (r - c • R)
  · calc
      (r - c • R).natDegree ≤ max r.natDegree (c • R).natDegree := natDegree_sub_le _ _
      _ ≤ max r.natDegree R.natDegree := max_le_max le_rfl (natDegree_smul_le _ _)
      _ < p := max_lt r_degree R_degree
  · intro i
    simpa only [coeff_sub, coeff_smul] using
      V.sub_mem (r_coefficients i) (V.smul_mem c (R_coefficients i))
  · exact character_block_sub_smul D eta beta s r R r_equation R_equation c
  · rw [coeff_sub, coeff_smul, normalized, Algebra.smul_def, mul_one, hc, sub_self]

end Litt3.SharedTensors
