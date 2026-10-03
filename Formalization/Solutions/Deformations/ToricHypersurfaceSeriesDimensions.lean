import Definitions.Deformations.ToricHypersurfaceSeriesAlgebra
import Solutions.Deformations.ToricHypersurfaceDimensions
import Solutions.Deformations.SeriesTruncatedAdditionalRelations
import Solutions.Deformations.TruncatedMonomialResidue

namespace Litt3.Deformations

variable (K : Type*) [CommRing K]

theorem toric_hypersurface_polynomial_truncation_le (Q R s : ℕ) :
    truncatedMonomialIdeal K (Fin 3) (toricHypersurfacePowers Q R) ≤
      toricHypersurfaceIdeal K Q R s := by
  rw [truncated_monomial_original_variable_generators]
  apply Ideal.span_le.mpr
  rintro _ ⟨i,rfl⟩
  fin_cases i <;> apply Ideal.subset_span <;> simp [toricHypersurfacePowers]

theorem toric_hypersurface_series_truncation_le (Q R s : ℕ) :
    seriesVariablePowerIdeal K 3 (toricHypersurfacePowers Q R) ≤
      toricHypersurfaceSeriesIdeal K Q R s := by
  apply Ideal.span_le.mpr
  rintro _ ⟨i,rfl⟩
  fin_cases i <;> apply Ideal.subset_span <;> simp [toricHypersurfacePowers]

theorem toric_hypersurface_original_series_map (Q R s : ℕ) :
    (toricHypersurfaceIdeal K Q R s).map MvPolynomial.coeToMvPowerSeries.ringHom =
      toricHypersurfaceSeriesIdeal K Q R s := by
  rw [toricHypersurfaceIdeal,Ideal.map_span]
  simp only [toricHypersurfaceSeriesIdeal,Set.image_insert_eq,Set.image_singleton,
    map_sub,map_pow,map_mul]
  have coordinateImages : ∀ i : Fin 3,
      (MvPolynomial.coeToMvPowerSeries.ringHom : MvPolynomial (Fin 3) K →+*
        MvPowerSeries (Fin 3) K) (MvPolynomial.X i) = MvPowerSeries.X i :=
    fun i => MvPolynomial.coe_X i
  simp only [coordinateImages]

/-- Genuine algebra equivalence retaining the original toric series
and every displayed power relation. -/
noncomputable def toricHypersurfaceSeriesPolynomialEquiv (Q R s : ℕ)
    (positiveQ : 0<Q) (positiveR : 0<R) :
    ToricHypersurfaceSeriesAlgebra K Q R s ≃ₐ[K] ToricHypersurfaceAlgebra K Q R s := by
  have source : seriesVariablePowerIdeal K 3 (toricHypersurfacePowers Q R) ⊔
      (toricHypersurfaceIdeal K Q R s).map MvPolynomial.coeToMvPowerSeries.ringHom =
      toricHypersurfaceSeriesIdeal K Q R s := by
    rw [toric_hypersurface_original_series_map,
      sup_eq_right.mpr (toric_hypersurface_series_truncation_le K Q R s)]
  have target : truncatedMonomialIdeal K (Fin 3) (toricHypersurfacePowers Q R) ⊔
      toricHypersurfaceIdeal K Q R s = toricHypersurfaceIdeal K Q R s :=
    sup_eq_right.mpr (toric_hypersurface_polynomial_truncation_le K Q R s)
  have positive : ∀ i, 0<toricHypersurfacePowers Q R i := by
    intro i; unfold toricHypersurfacePowers; split_ifs <;> assumption
  exact (Ideal.quotientEquivAlgOfEq K source).symm.trans
    ((seriesTruncatedAdditionalRelationEquiv K 3 (toricHypersurfacePowers Q R)
      positive (toricHypersurfaceIdeal K Q R s)).trans (Ideal.quotientEquivAlgOfEq K target))

variable [Nontrivial K]

/-- The exact length of the ACTUAL original formal-series quotient. -/
theorem toric_hypersurface_series_finrank (Q R s : ℕ)
    (positiveQ : 0<Q) (positiveR : 0<R) (below : R≤Q) (positiveS : 0<s) :
    Module.finrank K (ToricHypersurfaceSeriesAlgebra K Q R s) =
      R+2*∑ i : Fin (Q-1), min R (s*(i.val+1)) := by
  rw [(toricHypersurfaceSeriesPolynomialEquiv K Q R s positiveQ positiveR).toLinearEquiv.finrank_eq]
  exact toric_hypersurface_polynomial_finrank K Q R s positiveQ below positiveS

end Litt3.Deformations
