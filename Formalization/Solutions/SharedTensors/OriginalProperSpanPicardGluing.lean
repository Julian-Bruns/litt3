import Solutions.SharedTensors.OriginalJointPicardKernels

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [IsProper sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY] [QuasiCompact sY]

/-- The ORIGINAL rational/divisor gluing presentation is the ENTIRE
kernel of BOTH ACTUAL categorical pullbacks on the HONEST original
line-SHEAF Picard groups. Actual source constants absorb the unit ambiguity.
Only the left endpoint needs properness; the same source is derived smooth
and proper. This proves no representing group scheme or kernel finiteness. -/
noncomputable def actual_original_proper_span_gluing_equiv_joint_picard_kernel :
    letI := actual_etale_span_source_smooth s sX
    letI := actual_finite_span_source_proper s sX
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_smooth_curve_closed_point_dvr_stalks sY
    letI := actual_smooth_curve_closed_point_dvr_stalks (s.left ≫ sX)
    letI := actual_proper_smooth_curve_finite_principal_support sX
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
    letI := actual_proper_smooth_curve_finite_principal_support (s.left ≫ sX)
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    letI := actualSmoothCurveOriginalLinePicardGroup sY
    letI := actualSmoothCurveOriginalLinePicardGroup (s.left ≫ sX)
    s.divisorGluingSquare.GluingClasses ≃+
      (actualOriginalJointPicardMap s sX sY (s.left ≫ sX)).ker := by
  letI := actual_etale_span_source_smooth s sX
  letI := actual_finite_span_source_proper s sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sY
  letI := actual_smooth_curve_closed_point_dvr_stalks (s.left ≫ sX)
  letI := actual_proper_smooth_curve_finite_principal_support sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
  letI := actual_proper_smooth_curve_finite_principal_support (s.left ≫ sX)
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  letI := actualSmoothCurveOriginalLinePicardGroup sY
  letI := actualSmoothCurveOriginalLinePicardGroup (s.left ≫ sX)
  exact (actual_smooth_proper_span_gluing_equiv_joint_class_kernel s sX sY).trans
    (actualOriginalJointDivisorPicardKernelEquiv s sX sY (s.left ≫ sX))

/-- With the actual no-clump condition, the ORIGINAL relation subgroup
in the full original rational-unit quotient is the ENTIRE honest two-leg
line-SHEAF Picard kernel. Both original finite etale maps from the SAME
source survive the proved equivalence. Finite Picard-scheme kernel and
degree/genus consequences remain separate. -/
noncomputable def actual_original_proper_span_no_clump_relations_equiv_joint_picard_kernel
    (hc : IsEmpty s.fiberClump) :
    letI := actual_etale_span_source_smooth s sX
    letI := actual_finite_span_source_proper s sX
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_smooth_curve_closed_point_dvr_stalks sY
    letI := actual_smooth_curve_closed_point_dvr_stalks (s.left ≫ sX)
    letI := actual_proper_smooth_curve_finite_principal_support sX
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
    letI := actual_proper_smooth_curve_finite_principal_support (s.left ≫ sX)
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    letI := actualSmoothCurveOriginalLinePicardGroup sY
    letI := actualSmoothCurveOriginalLinePicardGroup (s.left ≫ sX)
    s.quotientPrincipalDivisorMap.ker ≃+
      (actualOriginalJointPicardMap s sX sY (s.left ≫ sX)).ker := by
  letI := actual_etale_span_source_smooth s sX
  letI := actual_finite_span_source_proper s sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sY
  letI := actual_smooth_curve_closed_point_dvr_stalks (s.left ≫ sX)
  letI := actual_proper_smooth_curve_finite_principal_support sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
  letI := actual_proper_smooth_curve_finite_principal_support (s.left ≫ sX)
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  letI := actualSmoothCurveOriginalLinePicardGroup sY
  letI := actualSmoothCurveOriginalLinePicardGroup (s.left ≫ sX)
  exact (actual_smooth_proper_span_no_clump_relations_equiv_joint_class_kernel s sX sY hc).trans
    (actualOriginalJointDivisorPicardKernelEquiv s sX sY (s.left ≫ sX))

end Litt3.SharedTensors
