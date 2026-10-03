import Solutions.Deformations.PolynomialCoefficientQuotients
import Solutions.Deformations.TruncatedMonomialResidue
import Mathlib.Algebra.MvPolynomial.Equiv

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] (d : ℕ)

/-- Regrouping the original selected coordinate retains every unchanged
lower-variable power and the original selected-coordinate power. -/
theorem fin_succ_truncated_ideal_regrouping (Q : ℕ) (q : Fin d → ℕ) :
    (truncatedMonomialIdeal R (Fin (d + 1)) (Fin.cons Q q)).map
      (MvPolynomial.finSuccEquiv R d).toRingHom =
    (truncatedMonomialIdeal R (Fin d) q).map Polynomial.C ⊔
      Ideal.span ({Polynomial.X ^ Q} : Set (Polynomial (MvPolynomial (Fin d) R))) := by
  classical
  rw [truncated_monomial_original_variable_generators, Ideal.map_span, ← Set.range_comp,
    truncated_monomial_original_variable_generators, Ideal.map_span, ← Set.range_comp]
  apply le_antisymm
  · apply Ideal.span_le.mpr
    rintro a ⟨i, rfl⟩
    induction i using Fin.cases with
    | zero =>
      change (MvPolynomial.finSuccEquiv R d) (MvPolynomial.X 0 ^ Q) ∈ _
      rw [map_pow, MvPolynomial.finSuccEquiv_X_zero]
      exact (show Ideal.span ({Polynomial.X ^ Q} : Set (Polynomial (MvPolynomial (Fin d) R))) ≤ _
        from le_sup_right) (Ideal.subset_span (Set.mem_singleton _))
    | succ j =>
      change (MvPolynomial.finSuccEquiv R d) (MvPolynomial.X j.succ ^ q j) ∈ _
      rw [map_pow, MvPolynomial.finSuccEquiv_X_succ, ← map_pow]
      apply (show Ideal.span (Set.range (fun i => Polynomial.C (MvPolynomial.X i ^ q i))) ≤ _
        from le_sup_left)
      apply Ideal.subset_span
      exact Set.mem_range_self j
  · apply sup_le
    · apply Ideal.span_le.mpr
      rintro a ⟨j, rfl⟩
      apply Ideal.subset_span
      refine ⟨j.succ, ?_⟩
      change (MvPolynomial.finSuccEquiv R d) (MvPolynomial.X j.succ ^ q j) =
        Polynomial.C (MvPolynomial.X j ^ q j)
      rw [map_pow, MvPolynomial.finSuccEquiv_X_succ, map_pow]
    · apply Ideal.span_le.mpr
      rintro a rfl
      apply Ideal.subset_span
      refine ⟨0, ?_⟩
      change (MvPolynomial.finSuccEquiv R d) (MvPolynomial.X 0 ^ Q) = Polynomial.X ^ Q
      rw [map_pow, MvPolynomial.finSuccEquiv_X_zero]

end Litt3.Deformations
