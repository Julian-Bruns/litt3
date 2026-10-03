import Solutions.SharedTensors.SmoothEtaleLaurentFields

open CategoryTheory AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (f : X ⟶ Y) [IsFinite f] [AlgebraicGeometry.FormallyUnramified f] [Surjective f]
  (hover : f ≫ sY = sX) (x : ClosedPoint X)

/-- The entire completed-field equivalence commutes with the ORIGINAL
generic-stalk pullback on EVERY actual rational function. All local
and field maps come from the same original scheme morphism. -/
theorem actual_smooth_unramified_completion_square (a : Y.functionField) :
    actualSmoothUnramifiedLaurentEquiv sX sY f hover x
      (actualSmoothCurveFunctionFieldCompletion sY
        (⟨f x.val, (mapClosedPoint f x).property⟩ : ClosedPoint Y) a) =
      actualSmoothCurveFunctionFieldCompletion sX x (schemeFunctionFieldPullback f a) := by
  letI := actual_smooth_curve_closed_point_dvr sX x
  letI : IsDiscreteValuationRing (Y.presheaf.stalk (f x.val)) :=
    actual_smooth_curve_closed_point_dvr sY (mapClosedPoint f x)
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI := (stalkBaseFieldHom sY (f x.val)).toAlgebra
  let dX := actualSmoothCurveCompletionParameters sX x
  let dY := actualSmoothCurveCompletionParameters sY
    (⟨f x.val, (mapClosedPoint f x).property⟩ : ClosedPoint Y)
  let φ := actualSchemeStalkAlgHom f sX sY hover x.val
  let E := actualSmoothUnramifiedLaurentEquiv sX sY f hover x
  let q := schemeFunctionFieldPullback f
  have hstalk : ∀ r : Y.presheaf.stalk (f x.val),
      E (dvrFunctionFieldCompletion (K := Y.functionField) dY
        (algebraMap (Y.presheaf.stalk (f x.val)) Y.functionField r)) =
      dvrFunctionFieldCompletion (K := X.functionField) dX
        (q (algebraMap (Y.presheaf.stalk (f x.val)) Y.functionField r)) := by
    intro r
    rw [scheme_function_field_pullback_stalk f x.val,
      dvrFunctionFieldCompletion_ring, dvrFunctionFieldCompletion_ring]
    rw [actualSmoothUnramifiedLaurentEquiv_power_series]
    have hactual : actualSmoothUnramifiedPowerSeriesEquiv sX sY f hover x
        (completedDVRStalkEmbedding dY r) =
        completedDVRPowerSeriesMap dY dX φ (completedDVRStalkEmbedding dY r) :=
      AlgHom.congr_fun (actualSmoothUnramifiedPowerSeriesEquiv_is_actual_map
        sX sY f hover x) _
    rw [hactual]
    exact congrArg (fun v : PowerSeries k => (v : LaurentSeries k))
      (completed_dvr_stalk_map_functorial dY dX φ r)
  obtain ⟨r, t, _, rfl⟩ := IsFractionRing.div_surjective
    (A := Y.presheaf.stalk (f x.val)) a
  change E (dvrFunctionFieldCompletion dY
    (algebraMap (Y.presheaf.stalk (f x.val)) Y.functionField r /
      algebraMap (Y.presheaf.stalk (f x.val)) Y.functionField t)) =
    dvrFunctionFieldCompletion dX (q
      (algebraMap (Y.presheaf.stalk (f x.val)) Y.functionField r /
        algebraMap (Y.presheaf.stalk (f x.val)) Y.functionField t))
  simp only [map_div₀, hstalk]

end Litt3.SharedTensors
