import Solutions.Deformations.ElementaryCoefficientExtraction
import Mathlib.Algebra.BigOperators.Finsupp.Basic

namespace Litt3.Deformations

open scoped BigOperators

variable (p : ℕ) [Fact p.Prime]
variable {I : Type*} [DecidableEq I]

/-- The original critical exponent, retaining the unchanged coordinate set. -/
def primeDetectorExponent (large : 2 < p) (i : I) : I → Fin p :=
  fun j => if j = i then ⟨p - 2, by omega⟩ else ⟨p - 1, by omega⟩

theorem elementary_prime_critical_exponent_classification (large : 2 < p)
    (r : ℕ) (positive : 0 < r) (alpha : Fin r → Fin p)
    (degree : (∑ i, (alpha i).val) = (p - 1) * r - 1) :
    ∃ i : Fin r, alpha = primeDetectorExponent p large i := by
  classical
  let deficits : Fin r →₀ ℕ := Finsupp.equivFunOnFinite.symm (fun i => p - 1 - (alpha i).val)
  have sumDeficits : deficits.sum (fun _ n => n) = 1 := by
    rw [Finsupp.sum_fintype _ _ (fun _ => rfl)]
    change (∑ i, (p - 1 - (alpha i).val)) = 1
    rw [Finset.sum_tsub_distrib _ (fun i _ => by have := (alpha i).isLt; omega)]
    simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul, degree]
    have weightPositive : 0 < p - 1 := by omega
    have topPositive : 0 < (p - 1) * r := Nat.mul_pos weightPositive positive
    rw [Nat.mul_comm r (p - 1)]
    omega
  obtain ⟨i, single⟩ := Finsupp.sum_eq_one_iff deficits |>.mp sumDeficits
  refine ⟨i, ?_⟩
  funext j
  apply Fin.ext
  have coefficient := congrArg (fun d : Fin r →₀ ℕ => d j) single
  change p - 1 - (alpha j).val = Finsupp.single i 1 j at coefficient
  have upper := (alpha j).isLt
  by_cases same : j = i
  · subst j
    simp only [Finsupp.single_eq_same] at coefficient
    change (alpha i).val = (primeDetectorExponent p large i i).val
    have value : (primeDetectorExponent p large i i).val = p - 2 := by
      simp [primeDetectorExponent]
    rw [value]
    omega
  · simp only [Finsupp.single_eq_of_ne same] at coefficient
    simp only [primeDetectorExponent, if_neg same, Fin.val_mk]
    omega

theorem elementary_prime_detector_exponent_degree (large : 2 < p) (r : ℕ) (i : Fin r) :
    (∑ j, (primeDetectorExponent p large i j).val) = (p - 1) * r - 1 := by
  classical
  have deficits : ∀ j : Fin r,
      p - 1 - (primeDetectorExponent p large i j).val = if j = i then 1 else 0 := by
    intro j
    by_cases same : j = i <;> simp [primeDetectorExponent, same] <;> omega
  have sumDeficits : (∑ j, (p - 1 - (primeDetectorExponent p large i j).val)) = 1 := by
    simp only [deficits]
    simp
  rw [Finset.sum_tsub_distrib _ (fun j _ => by
    have := (primeDetectorExponent p large i j).isLt; omega)] at sumDeficits
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, smul_eq_mul] at sumDeficits
  rw [Nat.mul_comm r (p - 1)] at sumDeficits
  have bound : (∑ j, (primeDetectorExponent p large i j).val) ≤ (p - 1) * r := by
    calc
      _ ≤ ∑ _ : Fin r, (p - 1) := Finset.sum_le_sum (fun j _ => by
        have := (primeDetectorExponent p large i j).isLt; omega)
      _ = _ := by simp [Nat.mul_comm]
  omega

end Litt3.Deformations
