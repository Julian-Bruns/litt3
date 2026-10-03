import Theorems.CartierAndSpin.SourceQuadraticCalculus

namespace Litt3.CartierAndSpin

universe u v w

/-- Full checked source calculus at all explicit coefficient boundaries
and local hypotheses; no project theorem is assumed as an axiom. -/
theorem source_quadratic_calculus : Specifications.SourceQuadraticCalculus.{u, v, w} := by
  exact ⟨@source_coefficient_moments,
    @sourceQuotientDifferentialCalculus,
    @source_universal_tensor_calculus,
    @source_universal_centered_formula,
    @source_universal_centered_affine_weight,
    @source_universal_cleared_affine_weight,
    @source_universal_cleared_zero,
    @source_quotient_moment_translation,
    @functional_discriminant_eq_three_five_invariant,
    @source_quotient_five_invariant_translation,
    @degree_two_p_source_degree,
    @degree_two_p_source_remainder,
    @affine_source_remainder_center,
    @source_universal_affine_correction_weight,
    @source_universal_characteristic_five_twisted_formula,
    @source_universal_characteristic_five_corrected_identity,
    @source_universal_twisted_normalization_invariant,
    @source_universal_twisted_translation_invariant,
    @actual_source_laurent_endpoint_objects_exist,
    @actual_source_laurent_corrected_endpoint_bound,
    @actual_source_laurent_coefficient_corrected_endpoint_bound,
    @source_universal_degree_ten_corrected_weight,
    @laurent_characteristic_five_endpoint_jets,
    @power_series_constant_translation,
    @laurent_constant_translation,
    @actual_source_subring_integrality,
    @source_boundary_quotient_integrality,
    @actual_source_unit_derivative_moment_mem_subring,
    @source_universal_energy_frame_independent,
    @separating_function_source_universal_calculus,
    @one_variable_source_universal_calculus⟩

end Litt3.CartierAndSpin
