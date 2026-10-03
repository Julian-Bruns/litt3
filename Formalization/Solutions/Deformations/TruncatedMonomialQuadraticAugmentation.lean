import Solutions.Deformations.TruncatedMonomialAugmentation
import Mathlib.Data.Finsupp.Weight

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R]

/-- An original polynomial whose entire support has degree at least two
has its actual quotient class in the SQUARE of the original variable ideal.
Both factors of every original monomial are constructed, over any ring. -/
theorem truncated_monomial_polynomial_quadratic_augmentation (q : I → ℕ)
    (f : MvPolynomial I R) (quadratic : ∀ a ∈ f.support, 2 ≤ a.degree) :
    Ideal.Quotient.mk (truncatedMonomialIdeal R I q) f ∈
      truncatedMonomialAugmentationIdeal R I q ^ 2 := by
  classical
  rw [f.as_sum, map_sum]
  apply Ideal.sum_mem
  intro a ha
  have degree := quadratic a ha
  have nonzero : a ≠ 0 := by
    intro h
    simp only [h, map_zero] at degree
    omega
  obtain ⟨i, hi⟩ : ∃ i, a i ≠ 0 := by
    by_contra h
    push_neg at h
    apply nonzero
    ext i
    simpa using h i
  have lower : Finsupp.single i 1 ≤ a := Finsupp.single_le_iff.mpr (by omega)
  let b := a - Finsupp.single i 1
  have reconstruct : b + Finsupp.single i 1 = a := tsub_add_cancel_of_le lower
  have bne : b ≠ 0 := by
    intro h
    have hsingle : a = Finsupp.single i 1 := by rw [← reconstruct, h, zero_add]
    rw [hsingle, Finsupp.degree_single] at degree
    omega
  have first : Ideal.Quotient.mk (truncatedMonomialIdeal R I q)
      (MvPolynomial.monomial b (f.coeff a)) ∈ truncatedMonomialAugmentationIdeal R I q := by
    apply truncated_monomial_polynomial_augmentation
    simp only [MvPolynomial.coeff_monomial, if_neg bne]
  have second : Ideal.Quotient.mk (truncatedMonomialIdeal R I q) (MvPolynomial.X i) ∈
      truncatedMonomialAugmentationIdeal R I q := Ideal.subset_span (Set.mem_range_self i)
  have identity : MvPolynomial.monomial a (f.coeff a) =
      MvPolynomial.monomial b (f.coeff a) * MvPolynomial.X i := by
    rw [← reconstruct, MvPolynomial.monomial_add_single, pow_one]
  rw [identity, map_mul, pow_two]
  exact Ideal.mul_mem_mul first second

end Litt3.Deformations
