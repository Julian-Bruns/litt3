import Solutions.SharedTensors.SmoothCurvePrincipalKernel
import Solutions.SharedTensors.SchemeDivisorClassKernel

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]

omit [IsAlgClosed k] [IsIntegral X] [IsIntegral Y] [IsIntegral s.source] in
/-- The same actual source is smooth of relative dimension one through
the actual finite étale left leg. Connectedness/integrality of a source
is never inferred from étaleness. -/
theorem actual_etale_span_source_smooth :
    IsSmoothOfRelativeDimension 1 (s.left ≫ sX) := by
  have h : IsSmoothOfRelativeDimension (0 + 1) (s.left ≫ sX) := inferInstance
  exact h

omit [IsAlgClosed k] [IsIntegral X] [IsIntegral Y] [IsIntegral s.source]
  [IsSmoothOfRelativeDimension 1 sX] in
/-- Properness of one endpoint makes the SAME actual source proper,
through the actual finite left leg. -/
theorem actual_finite_span_source_proper [IsProper sX] :
    IsProper (s.left ≫ sX) := inferInstance

/-- The genuine original quotient-principal kernel is saturated on an
actual smooth proper span. No local DVR or finite-support hypotheses
are supplied. The right endpoint only needs quasi-compactness. -/
theorem actual_smooth_proper_span_unit_quotient_kernel_saturated
    [IsProper sX] [QuasiCompact sY] :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_smooth_curve_closed_point_dvr_stalks sY
    letI := actual_etale_span_source_smooth s sX
    letI := actual_finite_span_source_proper s sX
    letI := actual_smooth_curve_closed_point_dvr_stalks (s.left ≫ sX)
    letI := actual_proper_smooth_curve_finite_principal_support sX
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
    letI := actual_proper_smooth_curve_finite_principal_support (s.left ≫ sX)
    KernelRootsSaturated s.quotientPrincipalDivisorMap := by
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sY
  letI := actual_etale_span_source_smooth s sX
  letI := actual_finite_span_source_proper s sX
  letI := actual_smooth_curve_closed_point_dvr_stalks (s.left ≫ sX)
  letI := actual_proper_smooth_curve_finite_principal_support sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
  letI := actual_proper_smooth_curve_finite_principal_support (s.left ≫ sX)
  exact actual_same_source_unit_quotient_kernel_saturated s

/-- All original divisor gluing classes identify with the original
two-leg divisor-class kernel. Actual smooth proper geometry proves
the constant-unit ambiguity condition; it is not an assumed input.
The right endpoint only needs quasi-compactness. -/
noncomputable def actual_smooth_proper_span_gluing_equiv_joint_class_kernel
    [IsProper sX] [QuasiCompact sY] :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_smooth_curve_closed_point_dvr_stalks sY
    letI := actual_etale_span_source_smooth s sX
    letI := actual_finite_span_source_proper s sX
    letI := actual_smooth_curve_closed_point_dvr_stalks (s.left ≫ sX)
    letI := actual_proper_smooth_curve_finite_principal_support sX
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
    letI := actual_proper_smooth_curve_finite_principal_support (s.left ≫ sX)
    s.divisorGluingSquare.GluingClasses ≃+ s.jointDivisorClassMap.ker := by
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sY
  letI := actual_etale_span_source_smooth s sX
  letI := actual_finite_span_source_proper s sX
  letI := actual_smooth_curve_closed_point_dvr_stalks (s.left ≫ sX)
  letI := actual_proper_smooth_curve_finite_principal_support sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
  letI := actual_proper_smooth_curve_finite_principal_support (s.left ≫ sX)
  exact actual_same_source_gluing_equiv_joint_divisor_class_kernel s sX
    (s.left ≫ sX) rfl
    (actual_proper_smooth_curve_principal_kernel_constants (s.left ≫ sX))

/-- With the actual no-clump hypothesis, the original multiplicative
relation subgroup is the original joint divisor-class kernel. Both
finite étale morphisms from the SAME source are retained throughout.
No principal-kernel-constants or Jacobson-space premise is supplied. -/
noncomputable def actual_smooth_proper_span_no_clump_relations_equiv_joint_class_kernel
    [IsProper sX] [QuasiCompact sY] (hc : IsEmpty s.fiberClump) :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_smooth_curve_closed_point_dvr_stalks sY
    letI := actual_etale_span_source_smooth s sX
    letI := actual_finite_span_source_proper s sX
    letI := actual_smooth_curve_closed_point_dvr_stalks (s.left ≫ sX)
    letI := actual_proper_smooth_curve_finite_principal_support sX
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
    letI := actual_proper_smooth_curve_finite_principal_support (s.left ≫ sX)
    s.quotientPrincipalDivisorMap.ker ≃+ s.jointDivisorClassMap.ker := by
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sY
  letI := actual_etale_span_source_smooth s sX
  letI := actual_finite_span_source_proper s sX
  letI := actual_smooth_curve_closed_point_dvr_stalks (s.left ≫ sX)
  letI := actual_proper_smooth_curve_finite_principal_support sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
  letI := actual_proper_smooth_curve_finite_principal_support (s.left ≫ sX)
  letI : JacobsonSpace s.source := LocallyOfFiniteType.jacobsonSpace (s.left ≫ sX)
  exact actual_same_source_no_clump_relations_equiv_joint_divisor_class_kernel s hc sX
    (s.left ≫ sX) rfl
    (actual_proper_smooth_curve_principal_kernel_constants (s.left ≫ sX))

end Litt3.SharedTensors
