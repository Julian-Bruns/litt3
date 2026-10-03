import Solutions.Deformations.TruncatedMonomialAugmentation

namespace Litt3.Deformations

variable (R I : Type*) [CommRing R]

theorem truncated_monomial_original_variable_generators (q : I → ℕ) :
    truncatedMonomialIdeal R I q =
      Ideal.span (Set.range (fun i => (MvPolynomial.X i : MvPolynomial I R) ^ q i)) := by
  simp only [truncatedMonomialIdeal, ← Set.range_comp, Function.comp_def,
    MvPolynomial.X_pow_eq_monomial]

theorem truncated_monomial_relations_constant_zero (q : I → ℕ) (positive : ∀ i, 0 < q i) :
    truncatedMonomialIdeal R I q ≤ RingHom.ker MvPolynomial.constantCoeff := by
  rw [truncated_monomial_original_variable_generators]
  apply Ideal.span_le.mpr
  rintro _ ⟨i, rfl⟩
  change MvPolynomial.constantCoeff (MvPolynomial.X i ^ q i : MvPolynomial I R) = 0
  rw [map_pow, MvPolynomial.constantCoeff_X, zero_pow (positive i).ne']

/-- The actual unchanged original constant coefficient descends to
the genuine unequal-power quotient. -/
noncomputable def truncatedMonomialResidue (q : I → ℕ) (positive : ∀ i, 0 < q i) :
    TruncatedMonomialAlgebra R I q →+* R :=
  Ideal.Quotient.lift (truncatedMonomialIdeal R I q) MvPolynomial.constantCoeff
    (truncated_monomial_relations_constant_zero R I q positive)

theorem truncated_monomial_residue_surjective (q : I → ℕ) (positive : ∀ i, 0 < q i) :
    Function.Surjective (truncatedMonomialResidue R I q positive) := by
  intro r
  refine ⟨Ideal.Quotient.mk (truncatedMonomialIdeal R I q) (MvPolynomial.C r), ?_⟩
  simp [truncatedMonomialResidue, Ideal.Quotient.lift_mk]

/-- The complete actual residue kernel is precisely the original
variable augmentation ideal, not a supplied identification. -/
theorem truncated_monomial_residue_kernel (q : I → ℕ) (positive : ∀ i, 0 < q i) :
    RingHom.ker (truncatedMonomialResidue R I q positive) =
      truncatedMonomialAugmentationIdeal R I q := by
  apply le_antisymm
  · intro x member
    obtain ⟨f, rfl⟩ := Ideal.Quotient.mk_surjective x
    apply truncated_monomial_polynomial_augmentation R I q f
    change truncatedMonomialResidue R I q positive (Ideal.Quotient.mk _ f) = 0 at member
    simpa only [truncatedMonomialResidue, Ideal.Quotient.lift_mk,
      MvPolynomial.constantCoeff_eq] using member
  · apply Ideal.span_le.mpr
    rintro _ ⟨i, rfl⟩
    change truncatedMonomialResidue R I q positive
      (Ideal.Quotient.mk _ (MvPolynomial.X i)) = 0
    simp [truncatedMonomialResidue, Ideal.Quotient.lift_mk]

end Litt3.Deformations
