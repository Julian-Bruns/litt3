import Solutions.Deformations.FiniteFieldMoments

namespace Litt3.Deformations

open scoped BigOperators

variable (F : Type*) [Field F] [Fintype F]
variable {I K : Type*} [Fintype I] [DecidableEq I] [CommRing K]

/-- Multiplying a normal monomial by one original coordinate extracts
exactly exponent card(F)-2 there and card(F)-1 elsewhere. -/
theorem finite_field_coordinate_monomial_sum (φ : F →+* K)
    (large : 2 < Fintype.card F) (i : I) (alpha : I → ℕ)
    (bound : ∀ j, alpha j ≤ Fintype.card F - 1) :
    ∑ a : I → F, φ (a i) * (∏ j, φ (a j) ^ alpha j) =
      if alpha i = Fintype.card F - 2 ∧
          ∀ j, j ≠ i → alpha j = Fintype.card F - 1
      then (-1 : K) ^ Fintype.card I else 0 := by
  classical
  let beta := fun j => alpha j + if j = i then 1 else 0
  have bounds : ∀ j, beta j ≤ Fintype.card F := by
    intro j
    have := bound j
    dsimp only [beta]
    split_ifs <;> omega
  have terms (a : I → F) : φ (a i) * (∏ j, φ (a j) ^ alpha j) =
      ∏ j, φ (a j) ^ beta j := by
    simp only [beta, pow_add, Finset.prod_mul_distrib]
    have final : (∏ j, φ (a j) ^ (if j = i then 1 else 0)) = φ (a i) := by
      simp
    rw [final, mul_comm]
  simp_rw [terms]
  rw [finite_field_monomial_sum_map F φ large beta bounds]
  have equivalent : (∀ j, beta j = Fintype.card F - 1) ↔
      alpha i = Fintype.card F - 2 ∧
        ∀ j, j ≠ i → alpha j = Fintype.card F - 1 := by
    constructor
    · intro all
      constructor
      · have : alpha i + 1 = Fintype.card F - 1 := by simpa [beta] using all i
        omega
      · intro j different
        simpa [beta, different] using all j
    · rintro ⟨special, other⟩ j
      by_cases same : j = i
      · subst j
        change alpha i + (if i = i then 1 else 0) = Fintype.card F - 1
        simp only [ite_true, special]
        omega
      · simp [beta, same, other j same]
  simp only [equivalent]

/-- The distinguished original exponent for the i-th coefficient
detector, with one coordinate lowered and all others maximal. -/
def finiteFieldDetectorExponent (large : 2 < Fintype.card F) (i : I) :
    I → Fin (Fintype.card F) :=
  fun j => if j = i then ⟨Fintype.card F - 2, by omega⟩
    else ⟨Fintype.card F - 1, by omega⟩

/-- Full original finite-field moment extracts the actual coefficient
of the distinguished normal monomial, uniformly in every rank and
every finite field of cardinality greater than two. -/
theorem finite_field_normal_coefficient_extraction (φ : F →+* K)
    (large : 2 < Fintype.card F) (i : I)
    (c : (I → Fin (Fintype.card F)) → K) :
    ∑ a : I → F, φ (a i) *
        (∑ alpha : I → Fin (Fintype.card F), c alpha * (∏ j, φ (a j) ^ (alpha j).val)) =
      (-1 : K) ^ Fintype.card I * c (finiteFieldDetectorExponent F large i) := by
  classical
  have condition (alpha : I → Fin (Fintype.card F)) :
      ((alpha i).val = Fintype.card F - 2 ∧
        ∀ j, j ≠ i → (alpha j).val = Fintype.card F - 1) ↔
      alpha = finiteFieldDetectorExponent F large i := by
    constructor
    · rintro ⟨special, other⟩
      ext j
      by_cases same : j = i
      · subst j; simpa [finiteFieldDetectorExponent] using special
      · simpa [finiteFieldDetectorExponent, same] using other j same
    · intro same
      subst alpha
      constructor
      · simp [finiteFieldDetectorExponent]
      · intro j different
        simp [finiteFieldDetectorExponent, different]
  have moment (alpha : I → Fin (Fintype.card F)) :
      ∑ a : I → F, φ (a i) * (∏ j, φ (a j) ^ (alpha j).val) =
        if alpha = finiteFieldDetectorExponent F large i
          then (-1 : K) ^ Fintype.card I else 0 := by
    rw [finite_field_coordinate_monomial_sum F φ large i (fun j => (alpha j).val)
      (fun j => Nat.le_pred_of_lt (alpha j).isLt)]
    simp only [condition]
  calc
    _ = ∑ alpha : I → Fin (Fintype.card F), c alpha *
        (∑ a : I → F, φ (a i) * (∏ j, φ (a j) ^ (alpha j).val)) := by
      simp_rw [Finset.mul_sum]
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro alpha _
      apply Finset.sum_congr rfl
      intro a _
      ring
    _ = _ := by simp [moment, mul_comm]

end Litt3.Deformations
