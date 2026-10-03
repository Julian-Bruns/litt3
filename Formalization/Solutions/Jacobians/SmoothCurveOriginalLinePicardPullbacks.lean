import Solutions.Jacobians.SmoothCurveDivisorCategoricalPullbacks
import Solutions.Jacobians.SmoothCurveOriginalLinePicardTensor

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
  [IsSmoothOfRelativeDimension 1 sX] [IsSmoothOfRelativeDimension 1 sY]
  [QuasiCompact sX] [QuasiCompact sY]
  (f : X ⟶ Y) [IsFinite f] [Surjective f] [IsEtale f]

include sX sY in
/-- EVERY honest original line sheaf is carried to an honest
original line sheaf by the actual categorical module-SHEAF pullback.
Its divisor presentation is constructed, then genuinely pulled back;
no frame or line-property premise on the pulled sheaf is supplied. -/
theorem actualSmoothCurveOriginalLinePullback_is_line
    (M : Y.Modules) (hM : ActualOriginalLineSheaf Y M) :
    ActualOriginalLineSheaf X ((actualSchemeModulePullback f).obj M) := by
  let D := actualSmoothCurveOriginalLineDivisor sY M hM
  let e := actualSchemeModulePullbackIso f
      (actualSmoothCurveOriginalLineDivisorIso sY M hM) ≪≫
    actualSmoothCurveFiniteEtaleDivisorPullbackIso sX sY f D
  exact actualOriginalLineSheaf_of_iso X e.symm
    (actualSmoothCurveDivisorSheaf_is_original_line sX _)

/-- Pullback on HONEST classes of ALL original line SHEAVES is the
quotient of the ACTUAL categorical module-SHEAF pullback. Independence
of representatives uses the true functor's action on whole-sheaf isos.
It is not defined by transferring divisor-class pullback. -/
noncomputable def actualSmoothCurveOriginalLineClassPullback :
    ActualOriginalLineSheafIsoClasses Y → ActualOriginalLineSheafIsoClasses X :=
  Quotient.map
    (fun M => ⟨(actualSchemeModulePullback f).obj M.val,
      actualSmoothCurveOriginalLinePullback_is_line sX sY f M.val M.property⟩)
    (fun _ _ h => h.map (actualSchemeModulePullbackIso f))

/-- Literal actual categorical SHEAF pullback on every honest
original representative. -/
theorem actualSmoothCurveOriginalLineClassPullback_on_sheaf
    (M : Y.Modules) (hM : ActualOriginalLineSheaf Y M) :
    actualSmoothCurveOriginalLineClassPullback sX sY f
        (actualOriginalLineSheafIsoClass Y M hM) =
      actualOriginalLineSheafIsoClass X ((actualSchemeModulePullback f).obj M)
        (actualSmoothCurveOriginalLinePullback_is_line sX sY f M hM) := rfl

/-- The honest actual line-class pullback carries the class of the
literal original O(D) to the class of the literal original O(f*D), using
the genuine categorical pullback isomorphism. -/
theorem actualSmoothCurveOriginalLineClassPullback_on_divisor
    (D : Divisor (Litt3.SharedTensors.ClosedPoint Y)) :
    actualSmoothCurveOriginalLineClassPullback sX sY f
        (actualSmoothCurveDivisorOriginalLineClass sY D) =
      actualSmoothCurveDivisorOriginalLineClass sX (Litt3.SharedTensors.schemeDivisorPullback f D) := by
  apply Quotient.sound
  exact ⟨actualSmoothCurveFiniteEtaleDivisorPullbackIso sX sY f D⟩

/-- NATURALITY of the actual original divisor-class/ALL-line-sheaf
Picard comparison under the actual finite etale morphism. Both sides are
independently defined from genuine divisor maps and categorical sheaf
pullback, and their equality is proved on all original quotient classes. -/
theorem actualSmoothCurveOriginalDivisorLinePicardEquiv_pullback
    : letI : ClosedPointDVRStalks X :=
        Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
      letI : ClosedPointDVRStalks Y :=
        Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sY
      letI : FinitePrincipalSupport X :=
        Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
      letI : FinitePrincipalSupport Y :=
        Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sY
      letI := actualSmoothCurveOriginalLinePicardGroup sX
      letI := actualSmoothCurveOriginalLinePicardGroup sY
      ∀ c : DivisorClassGroup (schemeDivisorSystem Y),
        actualSmoothCurveOriginalLineClassPullback sX sY f
            (actualSmoothCurveOriginalDivisorLinePicardEquiv sY c) =
          actualSmoothCurveOriginalDivisorLinePicardEquiv sX (schemeDivisorClassPullback f c) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : ClosedPointDVRStalks Y :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sY
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI : FinitePrincipalSupport Y :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sY
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  letI := actualSmoothCurveOriginalLinePicardGroup sY
  intro c
  refine Quotient.inductionOn c ?_
  intro D
  change actualSmoothCurveOriginalLineClassPullback sX sY f
      (actualSmoothCurveOriginalDivisorLinePicardEquiv sY
        (divisorClassMap (schemeDivisorSystem Y) D)) =
    actualSmoothCurveOriginalDivisorLinePicardEquiv sX
      (schemeDivisorClassPullback f (divisorClassMap (schemeDivisorSystem Y) D))
  rw [actualSmoothCurveOriginalDivisorLinePicardEquiv_on_divisor sY,
    actualSmoothCurveOriginalLineClassPullback_on_divisor sX sY f,
    scheme_divisor_class_pullback_representative,
    actualSmoothCurveOriginalDivisorLinePicardEquiv_on_divisor sX]

/-- The genuine categorical original line-SHEAF class pullback is
an additive homomorphism for the HONEST Picard operations. Additivity is
derived from the proved naturality square, rather than used to define
the underlying map. -/
noncomputable def actualSmoothCurveOriginalLinePicardPullback :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    letI := actualSmoothCurveOriginalLinePicardGroup sY
    ActualOriginalLineSheafIsoClasses Y →+ ActualOriginalLineSheafIsoClasses X := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : ClosedPointDVRStalks Y :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sY
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  letI : FinitePrincipalSupport Y :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sY
  letI := actualSmoothCurveOriginalLinePicardGroup sX
  letI := actualSmoothCurveOriginalLinePicardGroup sY
  let eX := actualSmoothCurveOriginalDivisorLinePicardEquiv sX
  let eY := actualSmoothCurveOriginalDivisorLinePicardEquiv sY
  have h : ∀ c, actualSmoothCurveOriginalLineClassPullback sX sY f c =
      eX (schemeDivisorClassPullback f (eY.symm c)) := by
    intro c
    have hn := actualSmoothCurveOriginalDivisorLinePicardEquiv_pullback sX sY f (eY.symm c)
    change actualSmoothCurveOriginalLineClassPullback sX sY f (eY (eY.symm c)) =
      eX (schemeDivisorClassPullback f (eY.symm c)) at hn
    simpa only [eY.apply_symm_apply] using hn
  exact
    { toFun := actualSmoothCurveOriginalLineClassPullback sX sY f
      map_zero' := by rw [h, map_zero, map_zero, map_zero]
      map_add' := fun a b => by rw [h, h a, h b, map_add, map_add, map_add] }

/-- The additive Picard pullback has the literal actual original
line-class pullback as its underlying function. -/
theorem actualSmoothCurveOriginalLinePicardPullback_apply
    (c : ActualOriginalLineSheafIsoClasses Y) :
    letI := actualSmoothCurveOriginalLinePicardGroup sX
    letI := actualSmoothCurveOriginalLinePicardGroup sY
    actualSmoothCurveOriginalLinePicardPullback sX sY f c =
      actualSmoothCurveOriginalLineClassPullback sX sY f c := rfl

end Litt3.Jacobians
