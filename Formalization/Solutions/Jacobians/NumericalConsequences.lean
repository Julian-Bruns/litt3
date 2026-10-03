import Theorems.Jacobians.NumericalConsequences
import Mathlib.Tactic

namespace Litt3.Jacobians

variable {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K]

/-- Saturation forces the normalized second projection to have degree one,
once the actual adjunction trace bound has been established. -/
theorem rosati_saturation_numerical
    (a b c genus trace : K) (ha : 0 < a) (hgenus : 1 < genus)
    (hcb : c ≤ b) (htrace : JointImageTraceBound a b c genus trace)
    (hsaturation : trace = 2 * a * b * genus) : c = b := by
  unfold JointImageTraceBound at htrace
  have hgenus' : 0 < genus - 1 := by linarith
  have hpositive : 0 < 2 * a * (genus - 1) := by positivity
  have hmul : b * (2 * a * (genus - 1)) ≤
      c * (2 * a * (genus - 1)) := by nlinarith [htrace]
  exact le_antisymm hcb (le_of_mul_le_mul_right hmul hpositive)

theorem rosati_saturation_target : Targets.RosatiSaturationNumerical := by
  intro K instField instOrder instRing a b c genus trace ha hg hcb ht hs
  exact rosati_saturation_numerical a b c genus trace ha hg hcb ht hs

/-- An explicit adjunction defect identity detects equality with the bound.
Normality and smoothness of the image still require the geometric bridge. -/
theorem trace_bound_equality_iff_defect_zero
    (a b c genus trace defect : K) (hc : c ≠ 0)
    (hidentity : 2 * a * b + 2 * a * c * (genus - 1) - trace =
      2 * c ^ 2 * defect) :
    trace = 2 * a * b + 2 * a * c * (genus - 1) ↔ defect = 0 := by
  constructor
  · intro heq
    rw [heq, sub_self] at hidentity
    have hnonzero : 2 * c ^ 2 ≠ 0 := by positivity
    exact (mul_eq_zero.mp hidentity.symm).resolve_left hnonzero
  · intro heq
    rw [heq, mul_zero] at hidentity
    linarith

/-- The prime-factor gap is a monotone consequence of the same bound. -/
theorem rosati_prime_factor_numerical_gap
    (a b c genus trace prime : K) (ha : 0 ≤ a) (hgenus : 1 ≤ genus)
    (hc : c ≤ b / prime)
    (htrace : JointImageTraceBound a b c genus trace) :
    trace ≤ 2 * a * b * (1 + (genus - 1) / prime) := by
  unfold JointImageTraceBound at htrace
  have hgenus' : 0 ≤ genus - 1 := by linarith
  have hmono := mul_le_mul_of_nonneg_left hc
    (show 0 ≤ 2 * a * (genus - 1) by positivity)
  calc
    trace ≤ 2 * a * b + 2 * a * c * (genus - 1) := htrace
    _ ≤ 2 * a * b + (2 * a * (genus - 1)) * (b / prime) := by nlinarith
    _ = 2 * a * b * (1 + (genus - 1) / prime) := by ring

/-- Codimension one is impossible under the rank-one bound. This is valid
for every positive characteristic, with no ordinariness assumption. -/
theorem abelian_divisor_rank_one_impossible
    (characteristic genus : K) (hg : 1 < genus) :
    ¬ RankOneDimensionBound characteristic genus (genus - 1) := by
  unfold RankOneDimensionBound
  intro hbound
  nlinarith

theorem abelian_divisor_rank_one_target : Targets.AbelianDivisorRankOneImpossible := by
  intro K instField instOrder instRing characteristic genus hg
  exact abelian_divisor_rank_one_impossible characteristic genus hg

/-- Generic defect and component multiplicity force the characteristic to
exceed five if the component's elliptic quotient satisfies the strict
intersection inequality. The geometric inequalities remain separate. -/
theorem abelian_component_characteristic_gt_five
    (multiplicity quotientDegree characteristic : ℕ)
    (hm : 2 ≤ multiplicity) (he : 2 ≤ quotientDegree)
    (hintersection : multiplicity * quotientDegree < characteristic - 1) :
    5 < characteristic := by
  have hproduct : 4 ≤ multiplicity * quotientDegree := by
    simpa using Nat.mul_le_mul hm he
  omega

/-- Specialization of the higher-defect Wronskian coefficient. -/
theorem wronskian_coefficients_characteristic_five :
    (∀ s : ℚ, s = 1 ∨ s = 2 ∨ s = 3 ∨ s = 4 →
      (5 - 1) * (s + 1) / (2 * 5 * s) =
        if s = 1 then 4 / 5 else if s = 2 then 3 / 5 else
        if s = 3 then 8 / 15 else 1 / 2) := by
  intro s hs
  rcases hs with rfl | rfl | rfl | rfl <;> norm_num

/-- A positive integer defect costs at least one unit of every positive
power budget. This yields a bound on the number of bad geometric cosets. -/
theorem cardinal_le_defect_power_budget
    {ι : Type*} (bad : Finset ι) (defect : ι → ℕ) (power budget : ℕ)
    (hdefect : ∀ z ∈ bad, 1 ≤ defect z)
    (hbudget : ∑ z ∈ bad, defect z ^ power ≤ budget) : bad.card ≤ budget := by
  calc
    bad.card = ∑ _z ∈ bad, (1 : ℕ) := by simp
    _ ≤ ∑ z ∈ bad, defect z ^ power :=
      Finset.sum_le_sum fun z hz => one_le_pow₀ (hdefect z hz)
    _ ≤ budget := hbudget

/-- The cyclic-triple budget ten permits at most one six-point free orbit. -/
theorem cyclic_triple_free_orbit_budget (freeOrbitCount : ℕ)
    (hbudget : 6 * freeOrbitCount ≤ 10) : freeOrbitCount ≤ 1 := by omega

end Litt3.Jacobians
