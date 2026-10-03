import Solutions.Jacobians.SmoothCurveDivisorLocalFrames
import Solutions.Jacobians.OriginalLineSheafFrames

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]

/-- The actual full ORIGINAL open frame arising from a genuine
original local principal equation. The frame is literal rational
multiplication followed by the true zero-divisor/structure comparison. -/
noncomputable def actualSmoothCurvePrincipalOpenFrameIso
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (a : X.functionFieldˣ)
    (U : X.Opens)
    (h : ∀ z : Litt3.SharedTensors.ClosedPoint X, z.val ∈ U →
      (D - actualSmoothCurvePrincipalDivisor sX a) z = 0) :
    (actualSmoothCurveDivisorSheaf sX D).over U ≅
      (SheafOfModules.unit X.ringCatSheaf).over U := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  exact (actualSchemeSheafOverFunctor X U).mapIso
      (actualSmoothCurvePrincipalDivisorSheafShiftIso sX D a) ≪≫
    actualDivisorSheafRestrictionIso X
      (D - actualSmoothCurvePrincipalDivisor sX a) 0 U h ≪≫
    (actualSchemeSheafOverFunctor X U).mapIso
      (actualSmoothCurveZeroDivisorOriginalStructureIso sX)

/-- On EVERY original subopen the inverse genuine principal frame
is literal multiplication of an ORIGINAL ring section by the inverse
ORIGINAL rational multiplier. This includes empty opens. -/
theorem actualSmoothCurvePrincipalOpenFrameIso_symm_value
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (a : X.functionFieldˣ)
    (U : X.Opens)
    (h : ∀ z : Litt3.SharedTensors.ClosedPoint X, z.val ∈ U →
      (D - actualSmoothCurvePrincipalDivisor sX a) z = 0)
    (V : X.Opens) (i : V ⟶ U) (r : Γ(X, V)) :
    ((actualOriginalLineFrameSectionEquiv X (actualSmoothCurveDivisorSheaf sX D) U
      (actualSmoothCurvePrincipalOpenFrameIso sX D a U h) V i).symm r).val =
      actualRationalFunctionScalar X a⁻¹.val (op V) *
        (actualSchemeStructureToRationalFunctions X).val.app (op V) r := rfl

end Litt3.Jacobians
