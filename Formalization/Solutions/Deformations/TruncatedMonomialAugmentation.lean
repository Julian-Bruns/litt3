import Solutions.Deformations.TruncatedMonomialSeriesProjection
import Mathlib.RingTheory.Ideal.Maps

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R]

/-- Zero original constant coefficient puts the actual polynomial
class in the genuine original variable ideal. -/
theorem truncated_monomial_polynomial_augmentation (q : I → ℕ) (f : MvPolynomial I R)
    (constant : f.coeff 0 = 0) :
    Ideal.Quotient.mk (truncatedMonomialIdeal R I q) f ∈
      truncatedMonomialAugmentationIdeal R I q := by
  classical
  let phi := Ideal.Quotient.mk (truncatedMonomialIdeal R I q)
  have inclusion : Ideal.span (Set.range (MvPolynomial.X : I → MvPolynomial I R)) ≤
      (truncatedMonomialAugmentationIdeal R I q).comap phi := by
    apply Ideal.span_le.mpr
    rintro x ⟨i, rfl⟩
    exact Ideal.subset_span (Set.mem_range_self i)
  apply inclusion
  rw [show Set.range (MvPolynomial.X : I → MvPolynomial I R) = MvPolynomial.X '' Set.univ by
    simp, MvPolynomial.mem_ideal_span_X_image]
  intro a member
  have nonzero : a ≠ 0 := by
    intro same
    subst a
    exact (MvPolynomial.mem_support_iff.mp member) constant
  have some : ∃ i, a i ≠ 0 := by
    by_contra none
    apply nonzero
    apply Finsupp.ext
    intro i
    simp only [not_exists, not_not] at none
    exact none i
  obtain ⟨i, oversized⟩ := some
  exact ⟨i, Set.mem_univ _, oversized⟩

variable [Fintype I]

/-- A genuinely zero constant term maps into the literal original
augmentation ideal under the constructed formal-series projection. -/
theorem truncated_monomial_series_augmentation (q : I → ℕ) (positive : ∀ i, 0 < q i)
    (f : MvPowerSeries I R) (constant : MvPowerSeries.coeff 0 f = 0) :
    truncatedMonomialSeriesProjection R I q positive f ∈
      truncatedMonomialAugmentationIdeal R I q := by
  classical
  apply truncated_monomial_polynomial_augmentation
  rw [MvPowerSeries.coeff_trunc', if_pos (zero_le _)]
  exact constant

end Litt3.Deformations
