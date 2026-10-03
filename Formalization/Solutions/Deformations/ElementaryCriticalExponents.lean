import Solutions.Deformations.ElementaryCoefficientExtraction
import Mathlib.Algebra.BigOperators.Finsupp.Basic

namespace Litt3.Deformations

open scoped BigOperators

variable [Fact (Nat.Prime 5)]

/-- The critical original exponent patterns are exactly one lowered
coordinate and all other coordinates maximal, uniformly in the rank. -/
theorem elementary_critical_exponent_classification (r : ℕ) (positive : 0 < r)
    (alpha : Fin r → Fin 5) (degree : (∑ i, (alpha i).val) = 4 * r - 1) :
    ∃ i : Fin r, alpha = finiteFieldDetectorExponent (ZMod 5) (by norm_num) i := by
  classical
  let deficits : Fin r →₀ ℕ := Finsupp.equivFunOnFinite.symm (fun i => 4 - (alpha i).val)
  have sumDeficits : deficits.sum (fun _ n => n) = 1 := by
    rw [Finsupp.sum_fintype _ _ (fun _ => rfl)]
    change (∑ i, (4 - (alpha i).val)) = 1
    rw [Finset.sum_tsub_distrib _ (fun i _ => by have := (alpha i).isLt; omega)]
    simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul, degree]
    omega
  obtain ⟨i, single⟩ := Finsupp.sum_eq_one_iff deficits |>.mp sumDeficits
  refine ⟨i, ?_⟩
  funext j
  apply Fin.ext
  have coefficient := congrArg (fun d : Fin r →₀ ℕ => d j) single
  change 4 - (alpha j).val = Finsupp.single i 1 j at coefficient
  have upper := (alpha j).isLt
  by_cases same : j = i
  · subst j
    simp only [Finsupp.single_eq_same] at coefficient
    simp only [finiteFieldDetectorExponent, if_pos rfl, Fin.val_mk]
    norm_num
    omega
  · simp only [Finsupp.single_eq_of_ne same] at coefficient
    simp only [finiteFieldDetectorExponent, if_neg same, Fin.val_mk]
    norm_num
    omega

theorem elementary_detector_exponent_degree (r : ℕ) (i : Fin r) :
    (∑ j, (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i j).val) = 4 * r - 1 := by
  classical
  have deficits : ∀ j : Fin r,
      4 - (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i j).val =
        if j = i then 1 else 0 := by
    intro j
    by_cases same : j = i <;> simp [finiteFieldDetectorExponent, same]
  have sumDeficits : (∑ j, (4 - (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i j).val)) = 1 := by
    simp only [deficits]
    simp
  rw [Finset.sum_tsub_distrib _ (fun j _ => by
    have := (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i j).isLt
    have cardinal := ZMod.card 5
    omega)] at sumDeficits
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul] at sumDeficits
  have bound : (∑ j, (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i j).val) ≤ 4 * r := by
    calc
      _ ≤ ∑ _ : Fin r, 4 := Finset.sum_le_sum (fun j _ => by
        have := (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i j).isLt
        have cardinal := ZMod.card 5
        omega)
      _ = _ := by simp [Nat.mul_comm]
  omega

end Litt3.Deformations
