import Solutions.Deformations.SeriesTruncatedAdditionalRelations

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] (d : ℕ)

/-- An ARBITRARY original formal hypersurface retains precisely its
original surviving coefficients when passing to the unchanged finite
polynomial quotient. The equation need not be a polynomial or normal form. -/
noncomputable def seriesTruncatedHypersurfaceEquiv (q : Fin d → ℕ)
    (positive : ∀ i, 0 < q i) (f : MvPowerSeries (Fin d) R) :
    (MvPowerSeries (Fin d) R ⧸ (seriesVariablePowerIdeal R d q ⊔
      Ideal.span ({f} : Set (MvPowerSeries (Fin d) R)))) ≃ₐ[R]
      (MvPolynomial (Fin d) R ⧸ (truncatedMonomialIdeal R (Fin d) q ⊔
        Ideal.span ({MvPowerSeries.trunc' R (originalTruncationRectangle (Fin d) q) f} :
          Set (MvPolynomial (Fin d) R)))) := by
  let P := MvPowerSeries.trunc' R (originalTruncationRectangle (Fin d) q) f
  have difference : f - (P : MvPowerSeries (Fin d) R) ∈ seriesVariablePowerIdeal R d q := by
    rw [series_variable_power_ideal_kernel R d q positive, RingHom.mem_ker]
    apply (truncated_monomial_series_projection_zero_iff R (Fin d) q positive _).mpr
    intro a survives
    rw [map_sub, MvPolynomial.coeff_coe]
    change MvPowerSeries.coeff a f -
      MvPolynomial.coeff a (MvPowerSeries.trunc' R (originalTruncationRectangle (Fin d) q) f) = 0
    rw [MvPowerSeries.coeff_trunc', if_pos
      ((original_truncation_rectangle_bound (Fin d) q positive a).mpr survives), sub_self]
  have equations : seriesVariablePowerIdeal R d q ⊔ Ideal.span ({f} : Set _) =
      seriesVariablePowerIdeal R d q ⊔ Ideal.span ({(P : MvPowerSeries (Fin d) R)} : Set _) := by
    apply le_antisymm
    · apply sup_le le_sup_left
      apply Ideal.span_le.mpr
      intro a ha
      have ha : a = f := Set.mem_singleton_iff.mp ha
      subst a
      have add := (seriesVariablePowerIdeal R d q ⊔
        Ideal.span ({(P : MvPowerSeries (Fin d) R)} : Set _)).add_mem
          (show f - (P : MvPowerSeries (Fin d) R) ∈ _ from
            (show seriesVariablePowerIdeal R d q ≤ _ from le_sup_left) difference)
          (show (P : MvPowerSeries (Fin d) R) ∈ _ from
            (show Ideal.span ({(P : MvPowerSeries (Fin d) R)} : Set _) ≤ _ from le_sup_right)
              (Ideal.subset_span (Set.mem_singleton _)))
      simpa only [sub_add_cancel] using add
    · apply sup_le le_sup_left
      apply Ideal.span_le.mpr
      intro a ha
      have ha : a = (P : MvPowerSeries (Fin d) R) := Set.mem_singleton_iff.mp ha
      subst a
      have sub := (seriesVariablePowerIdeal R d q ⊔ Ideal.span ({f} : Set _)).sub_mem
        (show f ∈ _ from (show Ideal.span ({f} : Set _) ≤ _ from le_sup_right)
          (Ideal.subset_span (Set.mem_singleton _)))
        (show f - (P : MvPowerSeries (Fin d) R) ∈ _ from
          (show seriesVariablePowerIdeal R d q ≤ _ from le_sup_left) difference)
      simpa only [sub_sub_cancel] using sub
  have source : seriesVariablePowerIdeal R d q ⊔ Ideal.span ({f} : Set _) =
      seriesVariablePowerIdeal R d q ⊔
        (Ideal.span ({P} : Set (MvPolynomial (Fin d) R))).map MvPolynomial.coeToMvPowerSeries.ringHom := by
    rw [Ideal.map_span, Set.image_singleton]
    exact equations
  exact (Ideal.quotientEquivAlgOfEq R source).trans
    (seriesTruncatedAdditionalRelationEquiv R d q positive (Ideal.span ({P} : Set _)))

end Litt3.Deformations
