import Definitions.Deformations.BalancedSeriesNodeAlgebra
import Solutions.Deformations.BalancedNodeBasis
import Solutions.Deformations.SeriesTruncatedAdditionalRelations

namespace Litt3.Deformations

variable (R : Type*) [CommRing R]

theorem balanced_node_polynomial_truncation_le (Q : ℕ) :
    truncatedMonomialIdeal R (Fin 2) (fun _ => Q) ≤ balancedNodeIdeal R Q := by
  classical
  apply Ideal.span_le.mpr
  rintro _ ⟨a, ⟨i, rfl⟩, rfl⟩
  fin_cases i
  · exact Ideal.subset_span ⟨Finsupp.single 0 Q, by simp, rfl⟩
  · exact Ideal.subset_span ⟨Finsupp.single 1 Q, by simp, rfl⟩

theorem balanced_node_series_truncation_le (Q : ℕ) :
    seriesVariablePowerIdeal R 2 (fun _ => Q) ≤ balancedSeriesNodeIdeal R Q := by
  apply Ideal.span_le.mpr
  rintro _ ⟨i, rfl⟩
  fin_cases i
  · exact Ideal.subset_span (by simp)
  · exact Ideal.subset_span (by simp)

/-- The literal polynomial node ideal extends to exactly the original
formal-series node ideal, retaining all three displayed generators. -/
theorem balanced_node_ideal_series_map (Q : ℕ) :
    (balancedNodeIdeal R Q).map MvPolynomial.coeToMvPowerSeries.ringHom =
      balancedSeriesNodeIdeal R Q := by
  rw [balanced_node_ideal_original_generators, Ideal.map_span]
  simp only [balancedSeriesNodeIdeal, Set.image_insert_eq, Set.image_singleton, map_pow, map_mul]
  have coordinateImages : ∀ i : Fin 2,
      (MvPolynomial.coeToMvPowerSeries.ringHom : MvPolynomial (Fin 2) R →+* MvPowerSeries (Fin 2) R)
        (MvPolynomial.X i) = MvPowerSeries.X i := fun i => MvPolynomial.coe_X i
  simp only [coordinateImages]

/-- A genuine coefficient algebra equivalence connects the full
literal balanced formal-series node quotient to its original polynomial
quotient. No completion or basis conclusion is supplied as a premise. -/
noncomputable def balancedSeriesNodePolynomialEquiv (Q : ℕ) (positive : 0 < Q) :
    BalancedSeriesNodeAlgebra R Q ≃ₐ[R] BalancedNodeAlgebra R Q := by
  have source : seriesVariablePowerIdeal R 2 (fun _ => Q) ⊔
      (balancedNodeIdeal R Q).map MvPolynomial.coeToMvPowerSeries.ringHom =
      balancedSeriesNodeIdeal R Q := by
    rw [balanced_node_ideal_series_map, sup_eq_right.mpr (balanced_node_series_truncation_le R Q)]
  have target : truncatedMonomialIdeal R (Fin 2) (fun _ => Q) ⊔ balancedNodeIdeal R Q =
      balancedNodeIdeal R Q := sup_eq_right.mpr (balanced_node_polynomial_truncation_le R Q)
  exact (Ideal.quotientEquivAlgOfEq R source).symm.trans
    ((seriesTruncatedAdditionalRelationEquiv R 2 (fun _ => Q) (fun _ => positive)
      (balancedNodeIdeal R Q)).trans (Ideal.quotientEquivAlgOfEq R target))

end Litt3.Deformations
