import Solutions.Jacobians.AffineDivisorTrivialGenerators
import Solutions.Jacobians.DedekindPrincipalIdeals

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped nonZeroDivisors

namespace Litt3.Jacobians

universe u
variable {X : Scheme.{u}} [IsIntegral X] [JacobsonSpace X] [ClosedPointDVRStalks X]
  {U : X.Opens} (hU : IsAffineOpen U)
  [IsDedekindDomain Γ(X, U)] [Nonempty U] (hfield : ¬IsField Γ(X, U))
  (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
  (e : actualSchemeDivisorSheaf X D ≅ SheafOfModules.unit X.ringCatSheaf)

/-- The actual global generator of a trivial divisor SHEAF has precisely
the NEGATIVE actual divisor on every original affine chart. This uses the
literal prime factorization of the actual fractional ideal, not merely its
abstract ideal class. -/
theorem actualAffineDivisorTrivialGenerator_principal :
    letI := functionField_isFractionRing_of_isAffineOpen X U hU
    principalDivisorMap (dedekindValuationDivisorSystem Γ(X, U) X.functionField)
      (Additive.ofMul (Units.mk0 (actualDivisorSheafGlobalGenerator X D e)
        (actualDivisorSheafGlobalGenerator_ne_zero X D e))) =
      -actualAffineChartDivisorRestriction hU hfield D := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  let f : X.functionFieldˣ := Units.mk0 (actualDivisorSheafGlobalGenerator X D e)
    (actualDivisorSheafGlobalGenerator_ne_zero X D e)
  have hI := actualAffineDivisorIdeal_eq_span_global_generator hU hfield D e
  have hunit :
      (dedekindDivisorIdealMap Γ(X, U) X.functionField
        (-actualAffineChartDivisorRestriction hU hfield D)).toMul =
      toPrincipalIdeal Γ(X, U) X.functionField f := by
    apply Units.ext
    simpa only [actualDedekindSectionFractionalIdeal, coe_toPrincipalIdeal] using hI
  have hmap : dedekindDivisorIdealMap Γ(X, U) X.functionField
      (-actualAffineChartDivisorRestriction hU hfield D) =
      Additive.ofMul (toPrincipalIdeal Γ(X, U) X.functionField f) :=
    Additive.toMul.injective hunit
  have he := congrArg (dedekindIdealDivisorMap Γ(X, U) X.functionField) hmap
  rw [dedekindIdealDivisorMap_divisorIdeal] at he
  exact (he.trans (dedekindIdealDivisorMap_principal Γ(X, U) X.functionField
    (Additive.ofMul f))).symm

include hU hfield in
/-- At every actual original closed point in the chart, the same
derived global rational generator has the exact original DVR order -D(x).
No independent local generator or valuation normalization is supplied. -/
theorem actualAffineDivisorTrivialGenerator_order (x : ChartClosedPoint U) :
    valuationOrder (closedPointValuation X x.val)
      (Additive.ofMul (Units.mk0 (actualDivisorSheafGlobalGenerator X D e)
        (actualDivisorSheafGlobalGenerator_ne_zero X D e))) = -D x.val := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  have h := congrArg (fun E => E (chartHeightOne hU hfield x))
    (actualAffineDivisorTrivialGenerator_principal hU hfield D e)
  dsimp only at h
  rw [principal_divisor_coefficient, Finsupp.neg_apply,
    actualAffineChartDivisorRestriction_coefficient] at h
  rw [actual_affine_chart_closed_point_valuation hU hfield x]
  exact h

end Litt3.Jacobians
