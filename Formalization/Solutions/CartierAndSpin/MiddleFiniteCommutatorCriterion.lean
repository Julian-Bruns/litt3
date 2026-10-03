import Theorems.CartierAndSpin.MiddleFiniteCommutatorCriterion

namespace Litt3.CartierAndSpin

universe u v

open Matrix Specifications

theorem finite_commutator_eigen_criteria_clause : FiniteCommutatorEigenCriteriaClause.{u} := by
  intro k _ _ n hn U V
  letI : Nonempty (Fin n) := ⟨⟨0, hn⟩⟩
  refine ⟨matrix_bounded_power_kernel_criterion U V, ?_, ?_⟩
  · have h := matrix_ordered_commutator_rank_criterion U V
    rw [Fintype.card_fin] at h
    exact h
  · simpa only [Fintype.card_fin] using matrix_power_commutator_rank_criterion U V

theorem commutator_row_compression_clause : CommutatorRowCompressionClause.{u} := by
  intro R _ n d U V
  exact commutator_word_rows_eq_ordered U V d

theorem one_dimensional_power_intersection_clause : OneDimensionalPowerIntersectionClause.{u} := by
  intro R _ U V
  exact one_dimensional_bounded_power_kernel U V

theorem middle_pencil_fiber_clause : MiddlePencilFiberClause.{u} := by
  intro k _ _ coeffU coeffV z _
  simpa only [Fintype.card_fin] using shifted_pencil_exists_iff_ordered_rank
    (linearMatrixFiber coeffU z) (linearMatrixFiber coeffV z)

theorem middle_alternative_power_fiber_clause : MiddleAlternativePowerFiberClause.{u} := by
  intro k _ _ coeffU coeffV z _
  rw [shifted_pencil_kernel_iff_common_eigenvector]
  have h := matrix_power_commutator_rank_criterion
    (linearMatrixFiber coeffU z) (linearMatrixFiber coeffV z)
  rw [Fintype.card_fin] at h
  exact h.symm

theorem middle_zero_fiber_clause : MiddleZeroFiberClause.{u} := by
  intro k _ coeffU coeffV a b
  rw [linear_matrix_fiber_zero, linear_matrix_fiber_zero]
  exact zero_shifted_pencil_kernel_iff a b

theorem middle_polynomial_degree_clause : MiddlePolynomialDegreeClause.{u} := by
  intro k _ coeffU coeffV
  constructor
  · exact linear_polynomial_ordered_stack_degree_bound coeffU coeffV 14
  · simpa only [Fintype.card_fin] using linear_polynomial_power_stack_degree_bound coeffU coeffV

theorem middle_stack_counts_clause : MiddleStackCountsClause := by
  refine ⟨ordered_middle_stack_block_count, ordered_middle_stack_row_count, ?_, ?_⟩
  · exact power_middle_stack_block_count
  · exact power_middle_stack_row_count

theorem commutator_stack_specialization_clause : CommutatorStackSpecializationClause.{u,v} := by
  intro R S _ _ f n d U V
  exact ⟨ordered_commutator_stack_map f U V d, power_commutator_stack_map f U V⟩

theorem linear_matrix_scaling_clause : LinearMatrixScalingClause.{u} := by
  intro R _ n coeff z a
  exact linear_matrix_fiber_smul coeff z a

theorem middle_finite_commutator_criterion : MiddleFiniteCommutatorCriterion.{u,v} :=
  ⟨finite_commutator_eigen_criteria_clause, commutator_row_compression_clause,
    one_dimensional_power_intersection_clause, middle_pencil_fiber_clause,
    middle_alternative_power_fiber_clause, middle_zero_fiber_clause,
    middle_polynomial_degree_clause, middle_stack_counts_clause,
    commutator_stack_specialization_clause, linear_matrix_scaling_clause⟩

end Litt3.CartierAndSpin
