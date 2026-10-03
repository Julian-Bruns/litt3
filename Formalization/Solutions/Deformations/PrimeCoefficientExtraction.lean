import Solutions.Deformations.ElementaryPrimeCriticalExponents

namespace Litt3.Deformations

open scoped BigOperators

variable (p : ℕ) [Fact p.Prime]
variable {I K : Type*} [Fintype I] [DecidableEq I] [CommRing K]

theorem prime_normal_coefficient_extraction (large : 2 < p) (φ : ZMod p →+* K) (i : I)
    (c : (I → Fin p) → K) :
    ∑ a : I → ZMod p, φ (a i) *
        (∑ alpha : I → Fin p, c alpha * (∏ j, φ (a j) ^ (alpha j).val)) =
      (-1 : K) ^ Fintype.card I * c (primeDetectorExponent p large i) := by
  classical
  have condition (alpha : I → Fin p) :
      ((alpha i).val = p - 2 ∧
        ∀ j, j ≠ i → (alpha j).val = p - 1) ↔
      alpha = primeDetectorExponent p large i := by
    constructor
    · rintro ⟨special, other⟩
      ext j
      by_cases same : j = i
      · subst j; simpa [primeDetectorExponent] using special
      · simpa [primeDetectorExponent, same] using other j same
    · intro same
      subst alpha
      constructor
      · simp [primeDetectorExponent]
      · intro j different
        simp [primeDetectorExponent, different]
  have moment (alpha : I → Fin p) :
      ∑ a : I → ZMod p, φ (a i) * (∏ j, φ (a j) ^ (alpha j).val) =
        if alpha = primeDetectorExponent p large i
          then (-1 : K) ^ Fintype.card I else 0 := by
    have moment := finite_field_coordinate_monomial_sum (ZMod p) φ (by simpa using large) i
      (fun j => (alpha j).val) (fun j => by rw [ZMod.card]; exact Nat.le_pred_of_lt (alpha j).isLt)
    rw [show (∑ a : I → ZMod p, φ (a i) * ∏ j, φ (a j) ^ (alpha j).val) = _ by exact moment]
    simp only [ZMod.card]
    simp only [condition]
  calc
    _ = ∑ alpha : I → Fin p, c alpha *
        (∑ a : I → ZMod p, φ (a i) * (∏ j, φ (a j) ^ (alpha j).val)) := by
      simp_rw [Finset.mul_sum]
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro alpha _
      apply Finset.sum_congr rfl
      intro a _
      ring
    _ = _ := by simp [moment, mul_comm]


end Litt3.Deformations
