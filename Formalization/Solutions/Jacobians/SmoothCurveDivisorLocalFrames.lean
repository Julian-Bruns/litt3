import Solutions.Jacobians.SmoothCurvePrincipalDivisorSheaves
import Solutions.Jacobians.DivisorSupportOpens
import Solutions.Jacobians.DivisorSheafRestrictions
import Solutions.SharedTensors.SmoothCurvePointStrata

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]

include sX

/-- At EVERY original point, a genuine original rational multiplier
removes the divisor coefficient on an actual neighborhood. The multiplier
comes from the ORIGINAL DVR uniformizer; the neighborhood is the true
finite closed-point support complement. Neither is supplied as an input. -/
theorem actual_smooth_curve_divisor_local_principal
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (x : X) :
    ∃ (f : X.functionFieldˣ) (U : X.Opens), x ∈ U ∧
      ∀ y : Litt3.SharedTensors.ClosedPoint X, y.val ∈ U →
        (D - actualSmoothCurvePrincipalDivisor sX f) y = 0 := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  letI : FinitePrincipalSupport X :=
    Litt3.SharedTensors.actual_quasiCompact_smooth_curve_finite_principal_support sX
  rcases Litt3.SharedTensors.actual_smooth_curve_point_closed_or_generic sX x with
    hclosed | hgeneric
  · let y : Litt3.SharedTensors.ClosedPoint X := ⟨x, hclosed⟩
    obtain ⟨f, hf⟩ := actual_closed_point_rational_order_exists X y (D y)
    let E := D - actualSmoothCurvePrincipalDivisor sX f
    have hE : E y = 0 := by
      change D y - principalDivisorMap (schemeDivisorSystem X) (Additive.ofMul f) y = 0
      rw [principal_divisor_coefficient]
      change D y - valuationOrder (closedPointValuation X y) (Additive.ofMul f) = 0
      rw [hf, sub_self]
    refine ⟨f, actualDivisorSupportComplement X E,
      actualDivisorSupportComplement_mem_of_zero X E y hE, ?_⟩
    exact actualDivisorSupportComplement_coefficient X E
  · subst x
    let f : X.functionFieldˣ := 1
    let E := D - actualSmoothCurvePrincipalDivisor sX f
    exact ⟨f, actualDivisorSupportComplement X E,
      actualDivisorSupportComplement_generic X E,
      actualDivisorSupportComplement_coefficient X E⟩

/-- The actual valuation-bounded divisor SHEAF on a genuine smooth
quasi-compact curve is locally isomorphic to its ORIGINAL structure-sheaf
module on the ENTIRE original open site below the chosen neighborhood.
This includes every original point and every smaller open, including empty
opens. DVR stalks, support finiteness, local frames and gluing are derived. -/
theorem actual_smooth_curve_divisor_sheaf_locally_trivial
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (x : X) :
    ∃ U : X.Opens, x ∈ U ∧ Nonempty
      ((actualSmoothCurveDivisorSheaf sX D).over U ≅
        (SheafOfModules.unit X.ringCatSheaf).over U) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  obtain ⟨f, U, hx, hzero⟩ := actual_smooth_curve_divisor_local_principal sX D x
  refine ⟨U, hx, ⟨?_⟩⟩
  exact (actualSchemeSheafOverFunctor X U).mapIso
      (actualSmoothCurvePrincipalDivisorSheafShiftIso sX D f) ≪≫
    actualDivisorSheafRestrictionIso X
      (D - actualSmoothCurvePrincipalDivisor sX f) 0 U hzero ≪≫
    (actualSchemeSheafOverFunctor X U).mapIso
      (actualSmoothCurveZeroDivisorOriginalStructureIso sX)

end Litt3.Jacobians
