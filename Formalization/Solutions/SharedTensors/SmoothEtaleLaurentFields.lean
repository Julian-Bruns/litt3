import Solutions.SharedTensors.SmoothEtaleCompletions
import Solutions.QuotientGeometry.DVRFunctionFieldFunctoriality
import Solutions.QuotientGeometry.CompletedAutomorphismOrders

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]

/-- The actual generic field embeds in the ENTIRE Laurent completion at
the original smooth closed point. All DVR and residue-compatible chart
data are derived from the actual curve. -/
noncomputable def actualSmoothCurveFunctionFieldCompletion (x : ClosedPoint X) :
    X.functionField →+* LaurentSeries k := by
  letI := actual_smooth_curve_closed_point_dvr sX x
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  exact dvrFunctionFieldCompletion (K := X.functionField)
    (actualSmoothCurveCompletionParameters sX x)

theorem actualSmoothCurveFunctionFieldCompletion_valuation
    (x : ClosedPoint X) (a : X.functionField) :
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    (discreteValuationPlace (PowerSeries k)).valuation (LaurentSeries k)
      (actualSmoothCurveFunctionFieldCompletion sX x a) = closedPointValuation X x a := by
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  exact dvrFunctionFieldCompletion_valuation (actualSmoothCurveCompletionParameters sX x) a

variable (f : X ⟶ Y) [IsFinite f] [AlgebraicGeometry.FormallyUnramified f]
  (hover : f ≫ sY = sX) (x : ClosedPoint X)

/-- The true finite unramified map induces an equivalence on the ENTIRE
Laurent fields of the original closed points. No Galois, parameter-image,
completion-equivalence or finite-jet hypothesis is supplied. -/
noncomputable def actualSmoothUnramifiedLaurentEquiv :
    LaurentSeries k ≃ₐ[k] LaurentSeries k := by
  letI : SMul k (LaurentSeries k) := (inferInstance : Algebra k (LaurentSeries k)).toSMul
  letI : IsScalarTower k (PowerSeries k) (LaurentSeries k) :=
    IsScalarTower.of_algebraMap_eq' rfl
  exact IsFractionRing.algEquivOfAlgEquiv
    (actualSmoothUnramifiedPowerSeriesEquiv sX sY f hover x)

theorem actualSmoothUnramifiedLaurentEquiv_power_series (a : PowerSeries k) :
    actualSmoothUnramifiedLaurentEquiv sX sY f hover x (a : LaurentSeries k) =
      (actualSmoothUnramifiedPowerSeriesEquiv sX sY f hover x a : PowerSeries k) := by
  letI : SMul k (LaurentSeries k) := (inferInstance : Algebra k (LaurentSeries k)).toSMul
  letI : IsScalarTower k (PowerSeries k) (LaurentSeries k) :=
    IsScalarTower.of_algebraMap_eq' rfl
  change IsFractionRing.algEquivOfAlgEquiv
    (actualSmoothUnramifiedPowerSeriesEquiv sX sY f hover x)
      (algebraMap (PowerSeries k) (LaurentSeries k) a) = _
  rw [IsFractionRing.algEquivOfAlgEquiv_algebraMap]
  rfl

/-- All integer Laurent orders are preserved by the genuine full-field
equivalence; there is no bounded-support or continuity assumption. -/
theorem actualSmoothUnramifiedLaurentEquiv_order (a : LaurentSeries k) :
    (actualSmoothUnramifiedLaurentEquiv sX sY f hover x a).order = a.order :=
  compatible_laurent_equiv_order
    (actualSmoothUnramifiedPowerSeriesEquiv sX sY f hover x).toRingEquiv
    (actualSmoothUnramifiedLaurentEquiv sX sY f hover x).toRingEquiv
    (actualSmoothUnramifiedLaurentEquiv_power_series sX sY f hover x) a

end Litt3.SharedTensors
