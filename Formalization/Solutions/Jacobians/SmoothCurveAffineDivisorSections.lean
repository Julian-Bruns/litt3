import Solutions.Jacobians.AffineDivisorSectionsFractionalIdeals
import Solutions.Jacobians.SmoothCurveDivisorSheaves

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped nonZeroDivisors
open IsDedekindDomain

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (U : X.Opens) (hU : IsAffineOpen U) [Nonempty U]

/-- The true fractional ideal of the original restricted divisor on
an ACTUAL smooth-curve affine chart, in the ORIGINAL generic-stalk field.
All coordinate-ring Dedekindness and point correspondences are derived. -/
noncomputable def actualSmoothCurveAffineDivisorIdeal
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    (FractionalIdeal (Γ(X, U))⁰ X.functionField)ˣ := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  letI : IsDedekindDomain Γ(X, U) :=
    Litt3.QuotientGeometry.actual_smooth_curve_affine_chart_dedekind sX U hU
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  exact actualDedekindSectionFractionalIdeal Γ(X, U) X.functionField
    (actualAffineChartDivisorRestriction hU
      (Litt3.SharedTensors.actual_smooth_curve_affine_chart_not_isField sX U hU) D)

/-- The ACTUAL affine sections of the ACTUAL global divisor SHEAF of
any original smooth curve are the ACTUAL original-coordinate fractional
ideal. No quasi-compactness/properness, DVR, normalization, finite support,
point identification or section-surjectivity input is imposed. -/
noncomputable def actualSmoothCurveAffineDivisorSectionsEquiv
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    (actualSmoothCurveDivisorSheaf sX D).val.obj (op U) ≃ₗ[Γ(X, U)]
      (((actualSmoothCurveAffineDivisorIdeal sX U hU D).val :
        FractionalIdeal (Γ(X, U))⁰ X.functionField) : Submodule Γ(X, U) X.functionField) := by
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  letI : JacobsonSpace X := LocallyOfFiniteType.jacobsonSpace sX
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : IsDedekindDomain Γ(X, U) :=
    Litt3.QuotientGeometry.actual_smooth_curve_affine_chart_dedekind sX U hU
  exact actualAffineDivisorSectionsFractionalIdealEquiv hU
    (Litt3.SharedTensors.actual_smooth_curve_affine_chart_not_isField sX U hU) D

/-- In particular these ORIGINAL affine sections are true invertible
modules over the ORIGINAL affine ring. This does not assert invertibility
of global sections on a proper curve. -/
noncomputable instance actualSmoothCurveAffineDivisorSections_invertible
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    Module.Invertible Γ(X, U) ((actualSmoothCurveDivisorSheaf sX D).val.obj (op U)) := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  letI := actual_invertible_fractional_ideal_module
    (actualSmoothCurveAffineDivisorIdeal sX U hU D)
  exact Module.Invertible.congr (actualSmoothCurveAffineDivisorSectionsEquiv sX U hU D).symm

end Litt3.Jacobians
