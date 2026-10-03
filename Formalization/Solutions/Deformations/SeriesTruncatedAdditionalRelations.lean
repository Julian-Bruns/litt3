import Solutions.Deformations.SeriesTruncatedPolynomialEquivalence

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] (d : ℕ)

/-- The genuine formal-series equivalence carries every unchanged
polynomial class to that polynomial's unchanged quotient class. -/
theorem series_truncated_equiv_original_polynomial (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (f : MvPolynomial (Fin d) R) :
    seriesTruncatedPolynomialEquiv R d q positive
      (Ideal.Quotient.mk (seriesVariablePowerIdeal R d q) (f : MvPowerSeries (Fin d) R)) =
      Ideal.Quotient.mk (truncatedMonomialIdeal R (Fin d) q) f := by
  simp only [seriesTruncatedPolynomialEquiv, AlgEquiv.trans_apply,
    Ideal.quotientEquivAlgOfEq_mk]
  exact truncated_monomial_series_projection_polynomial R d q positive f

/-- Arbitrary genuine original polynomial relations survive passage
between the actual finite formal-series and polynomial quotients.
No normal form or length assertion is part of the input. -/
noncomputable def seriesTruncatedAdditionalRelationEquiv (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (J : Ideal (MvPolynomial (Fin d) R)) :
    (MvPowerSeries (Fin d) R ⧸ (seriesVariablePowerIdeal R d q ⊔
      J.map MvPolynomial.coeToMvPowerSeries.ringHom)) ≃ₐ[R]
      (MvPolynomial (Fin d) R ⧸ (truncatedMonomialIdeal R (Fin d) q ⊔ J)) := by
  let e := seriesTruncatedPolynomialEquiv R d q positive
  have original : e.toRingHom.comp ((Ideal.Quotient.mk (seriesVariablePowerIdeal R d q)).comp
      MvPolynomial.coeToMvPowerSeries.ringHom) =
      Ideal.Quotient.mk (truncatedMonomialIdeal R (Fin d) q) := by
    apply RingHom.ext
    intro f
    exact series_truncated_equiv_original_polynomial R d q positive f
  have image : J.map (Ideal.Quotient.mk (truncatedMonomialIdeal R (Fin d) q)) =
      ((J.map MvPolynomial.coeToMvPowerSeries.ringHom).map
        (Ideal.Quotient.mk (seriesVariablePowerIdeal R d q))).map e.toRingHom := by
    rw [Ideal.map_map, Ideal.map_map, RingHom.comp_assoc, original]
  let middle := Ideal.quotientEquivAlg
    ((J.map MvPolynomial.coeToMvPowerSeries.ringHom).map
      (Ideal.Quotient.mk (seriesVariablePowerIdeal R d q)))
    (J.map (Ideal.Quotient.mk (truncatedMonomialIdeal R (Fin d) q))) e image
  exact (DoubleQuot.quotQuotEquivQuotSupₐ R (seriesVariablePowerIdeal R d q)
    (J.map MvPolynomial.coeToMvPowerSeries.ringHom)).symm.trans
      (middle.trans (DoubleQuot.quotQuotEquivQuotSupₐ R (truncatedMonomialIdeal R (Fin d) q) J))

end Litt3.Deformations
