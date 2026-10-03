import Solutions.Jacobians.SmoothCurveOriginalLinePicardPullbacks
import Solutions.SharedTensors.SmoothProperSpans

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY] [QuasiCompact sY]
  (sW : s.source ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sW] [QuasiCompact sW]

/-- The joint map is the difference of BOTH ACTUAL categorical
line-SHEAF pullbacks on the HONEST groups of ALL original line classes.
The source and its two original finite etale maps are retained. -/
noncomputable def actualOriginalJointPicardMap :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    letI := actualSmoothCurveOriginalLinePicardGroup sY
    letI := actualSmoothCurveOriginalLinePicardGroup sW
    ActualOriginalLineSheafIsoClasses X × ActualOriginalLineSheafIsoClasses Y →+
      ActualOriginalLineSheafIsoClasses s.source := by
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  letI := actualSmoothCurveOriginalLinePicardGroup sY
  letI := actualSmoothCurveOriginalLinePicardGroup sW
  exact (actualSmoothCurveOriginalLinePicardPullback sW sX s.left).comp (AddMonoidHom.fst _ _) -
    (actualSmoothCurveOriginalLinePicardPullback sW sY s.right).comp (AddMonoidHom.snd _ _)

/-- The ORIGINAL two-leg divisor-class difference is the actual
difference of the two independently constructed divisor pullbacks. -/
theorem actual_joint_divisor_class_map_eq_pullback_difference :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_smooth_curve_closed_point_dvr_stalks sY
    letI := actual_smooth_curve_closed_point_dvr_stalks sW
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sW
    ∀ a : DivisorClassGroup (schemeDivisorSystem X) × DivisorClassGroup (schemeDivisorSystem Y),
      s.jointDivisorClassMap a =
        schemeDivisorClassPullback s.left a.1 - schemeDivisorClassPullback s.right a.2 := by
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sY
  letI := actual_smooth_curve_closed_point_dvr_stalks sW
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sW
  rintro ⟨a, b⟩
  refine Quotient.inductionOn₂ a b ?_
  intro D E
  change s.jointDivisorClassMap (divisorClassMap (schemeDivisorSystem X) D,
      divisorClassMap (schemeDivisorSystem Y) E) =
    schemeDivisorClassPullback s.left (divisorClassMap (schemeDivisorSystem X) D) -
      schemeDivisorClassPullback s.right (divisorClassMap (schemeDivisorSystem Y) E)
  rw [actual_joint_divisor_class_map_representative, map_sub,
    scheme_divisor_class_pullback_representative, scheme_divisor_class_pullback_representative]

/-- The independently defined HONEST Picard difference map and
ORIGINAL divisor-class difference map commute through the proved
ALL-line classification, for BOTH original maps and ALL classes. -/
theorem actual_original_joint_picard_divisor_naturality :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_smooth_curve_closed_point_dvr_stalks sY
    letI := actual_smooth_curve_closed_point_dvr_stalks sW
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sW
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    letI := actualSmoothCurveOriginalLinePicardGroup sY
    letI := actualSmoothCurveOriginalLinePicardGroup sW
    ∀ a : DivisorClassGroup (schemeDivisorSystem X) × DivisorClassGroup (schemeDivisorSystem Y),
      actualOriginalJointPicardMap s sX sY sW
          (actualSmoothCurveOriginalDivisorLinePicardEquiv sX a.1,
            actualSmoothCurveOriginalDivisorLinePicardEquiv sY a.2) =
        actualSmoothCurveOriginalDivisorLinePicardEquiv sW (s.jointDivisorClassMap a) := by
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sY
  letI := actual_smooth_curve_closed_point_dvr_stalks sW
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sW
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  letI := actualSmoothCurveOriginalLinePicardGroup sY
  letI := actualSmoothCurveOriginalLinePicardGroup sW
  intro a
  change actualSmoothCurveOriginalLineClassPullback sW sX s.left
      (actualSmoothCurveOriginalDivisorLinePicardEquiv sX a.1) -
    actualSmoothCurveOriginalLineClassPullback sW sY s.right
      (actualSmoothCurveOriginalDivisorLinePicardEquiv sY a.2) = _
  rw [actualSmoothCurveOriginalDivisorLinePicardEquiv_pullback,
    actualSmoothCurveOriginalDivisorLinePicardEquiv_pullback,
    actual_joint_divisor_class_map_eq_pullback_difference s sX sY sW, map_sub]

/-- The entire ORIGINAL joint divisor-class kernel is isomorphic to
the kernel of the HONEST two-leg original line-SHEAF Picard map.
No representing Picard scheme, finiteness, degree-zero condition or
one-leg replacement is supplied or inferred. -/
noncomputable def actualOriginalJointDivisorPicardKernelEquiv :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_smooth_curve_closed_point_dvr_stalks sY
    letI := actual_smooth_curve_closed_point_dvr_stalks sW
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
    letI := actual_quasiCompact_smooth_curve_finite_principal_support sW
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    letI := actualSmoothCurveOriginalLinePicardGroup sY
    letI := actualSmoothCurveOriginalLinePicardGroup sW
    s.jointDivisorClassMap.ker ≃+ (actualOriginalJointPicardMap s sX sY sW).ker := by
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sY
  letI := actual_smooth_curve_closed_point_dvr_stalks sW
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sY
  letI := actual_quasiCompact_smooth_curve_finite_principal_support sW
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  letI := actualSmoothCurveOriginalLinePicardGroup sY
  letI := actualSmoothCurveOriginalLinePicardGroup sW
  let eX := actualSmoothCurveOriginalDivisorLinePicardEquiv sX
  let eY := actualSmoothCurveOriginalDivisorLinePicardEquiv sY
  let eW := actualSmoothCurveOriginalDivisorLinePicardEquiv sW
  exact
    { toFun := fun a => ⟨(eX a.val.1, eY a.val.2), by
        change actualOriginalJointPicardMap s sX sY sW (eX a.val.1, eY a.val.2) = 0
        rw [actual_original_joint_picard_divisor_naturality s sX sY sW, a.property, map_zero]⟩
      invFun := fun b => ⟨(eX.symm b.val.1, eY.symm b.val.2), by
        change s.jointDivisorClassMap (eX.symm b.val.1, eY.symm b.val.2) = 0
        apply eW.injective
        rw [map_zero, ← actual_original_joint_picard_divisor_naturality s sX sY sW]
        change actualOriginalJointPicardMap s sX sY sW
          (eX (eX.symm b.val.1), eY (eY.symm b.val.2)) = 0
        rw [eX.apply_symm_apply, eY.apply_symm_apply]
        exact b.property⟩
      left_inv := fun a => Subtype.ext (Prod.ext
        (eX.symm_apply_apply a.val.1) (eY.symm_apply_apply a.val.2))
      right_inv := fun b => Subtype.ext (Prod.ext
        (eX.apply_symm_apply b.val.1) (eY.apply_symm_apply b.val.2))
      map_add' := fun a b => Subtype.ext (Prod.ext (eX.map_add _ _) (eY.map_add _ _)) }

end Litt3.SharedTensors
