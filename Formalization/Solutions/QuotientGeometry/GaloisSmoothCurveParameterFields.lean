import Solutions.QuotientGeometry.GaloisSmoothCurveCompletedFields
import Solutions.QuotientGeometry.DVRCompletedParameterIndependence

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- The actual full Galois-fiber completed-field comparison for
smooth curves holds for EVERY original choice of the three
uniformizers, including those prescribed by original functions. -/
theorem actual_galois_smooth_curve_arbitrary_parameters
    {k : Type u} [Field k] [IsAlgClosed k]
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    [IsSmoothOfRelativeDimension 1 sX] [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [IsFinite f] [Surjective f]
    (hover : f ≫ sY = sX)
    (b : Litt3.SharedTensors.ClosedPoint Y)
    (p q : Litt3.SharedTensors.ClosedPoint X)
    (hp : b.val = f p.val) (hq : b.val = f q.val) :
    letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
    FiniteDimensional Y.functionField X.functionField →
    IsGalois Y.functionField X.functionField →
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY b
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sX p
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sX q
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY b.val).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX p.val).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX q.val).toAlgebra
    ∀ (dB : DVRCompletionParameters k (Y.presheaf.stalk b.val))
      (dP : DVRCompletionParameters k (X.presheaf.stalk p.val))
      (dQ : DVRCompletionParameters k (X.presheaf.stalk q.val)),
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dB dP
        (actualSchemeFixedBaseStalkMap f sX sY hover b.val p.val hp)
        (actual_integral_fixed_base_scheme_stalk_injective f sX sY hover b.val p.val hp))
      (completedDVRLaurentMap dB dQ
        (actualSchemeFixedBaseStalkMap f sX sY hover b.val q.val hq)
        (actual_integral_fixed_base_scheme_stalk_injective f sX sY hover b.val q.val hq)) := by
  letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
  intro hfinite hgalois
  letI := hfinite
  letI := hgalois
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY b
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sX p
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sX q
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY b.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX p.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX q.val).toAlgebra
  intro dB dP dQ
  exact actual_dvr_completed_comparison_change_parameters dB
    (Litt3.SharedTensors.actualSmoothCurveCompletionParameters sY b)
    dP (Litt3.SharedTensors.actualSmoothCurveCompletionParameters sX p)
    dQ (Litt3.SharedTensors.actualSmoothCurveCompletionParameters sX q)
    (actualSchemeFixedBaseStalkMap f sX sY hover b.val p.val hp)
    (actualSchemeFixedBaseStalkMap f sX sY hover b.val q.val hq)
    (actual_integral_fixed_base_scheme_stalk_injective f sX sY hover b.val p.val hp)
    (actual_integral_fixed_base_scheme_stalk_injective f sX sY hover b.val q.val hq)
    (actual_galois_smooth_curve_completed_fields_equivalent sX sY f hover b p q hp hq
      hfinite hgalois)

end Litt3.QuotientGeometry
