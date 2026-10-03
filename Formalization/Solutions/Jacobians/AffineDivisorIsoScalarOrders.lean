import Solutions.Jacobians.AffineDivisorIsoScalarIdeals
import Solutions.Jacobians.DedekindPrincipalIdeals

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace
open scoped nonZeroDivisors

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] [JacobsonSpace X] [ClosedPointDVRStalks X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  {U : X.Opens} (hU : IsAffineOpen U)
  [IsDedekindDomain Γ(X, U)] [Nonempty U] (hfield : ¬IsField Γ(X, U))
  (D E : Divisor (Litt3.SharedTensors.ClosedPoint X))
  (e : actualSchemeDivisorSheaf X D ≅ actualSchemeDivisorSheaf X E)

/-- The ONE original rational multiplier of a TRUE global
divisor-sheaf isomorphism has principal divisor EXACTLY the difference
of the ORIGINAL divisors on every ORIGINAL affine chart. -/
theorem actualAffineDivisorIsoScalar_principal :
    letI := functionField_isFractionRing_of_isAffineOpen X U hU
    principalDivisorMap (dedekindValuationDivisorSystem Γ(X, U) X.functionField)
      (Additive.ofMul (actualDivisorSheafIsoRationalUnit X D E sX e)) =
      actualAffineChartDivisorRestriction hU hfield D -
        actualAffineChartDivisorRestriction hU hfield E := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  let f := actualDivisorSheafIsoRationalUnit X D E sX e
  have hI := actualAffineDivisorIsoIdeal_eq_scalar_mul sX hU hfield D E e
  have hunit :
      (dedekindDivisorIdealMap Γ(X, U) X.functionField
        (-actualAffineChartDivisorRestriction hU hfield E)).toMul =
      toPrincipalIdeal Γ(X, U) X.functionField f *
        (dedekindDivisorIdealMap Γ(X, U) X.functionField
          (-actualAffineChartDivisorRestriction hU hfield D)).toMul := by
    apply Units.ext
    simpa only [actualDedekindSectionFractionalIdeal, Units.val_mul, coe_toPrincipalIdeal]
      using hI
  have hm := congrArg
    (fun I => dedekindIdealDivisorMap Γ(X, U) X.functionField (Additive.ofMul I)) hunit
  change dedekindIdealDivisorMap Γ(X, U) X.functionField
      (dedekindDivisorIdealMap Γ(X, U) X.functionField
        (-actualAffineChartDivisorRestriction hU hfield E)) =
    dedekindIdealDivisorMap Γ(X, U) X.functionField
      (Additive.ofMul (toPrincipalIdeal Γ(X, U) X.functionField f) +
        dedekindDivisorIdealMap Γ(X, U) X.functionField
          (-actualAffineChartDivisorRestriction hU hfield D)) at hm
  have hp : dedekindIdealDivisorMap Γ(X, U) X.functionField
      (Additive.ofMul (toPrincipalIdeal Γ(X, U) X.functionField f)) =
    principalDivisorMap (dedekindValuationDivisorSystem Γ(X, U) X.functionField)
      (Additive.ofMul f) :=
    dedekindIdealDivisorMap_principal Γ(X, U) X.functionField (Additive.ofMul f)
  simp only [map_add, dedekindIdealDivisorMap_divisorIdeal] at hm
  rw [hp] at hm
  change principalDivisorMap (dedekindValuationDivisorSystem Γ(X, U) X.functionField)
    (Additive.ofMul f) = _
  ext v
  have hv := congrArg (fun A => A v) hm
  dsimp only at hv
  simp only [Finsupp.neg_apply, Finsupp.add_apply, Finsupp.sub_apply] at hv ⊢
  omega

include hU hfield in
/-- The true global scalar has order D(x)−E(x) at each ORIGINAL
closed stalk, through the derived literal original chart valuation. -/
theorem actualAffineDivisorIsoScalar_order (x : ChartClosedPoint U) :
    valuationOrder (closedPointValuation X x.val)
      (Additive.ofMul (actualDivisorSheafIsoRationalUnit X D E sX e)) = D x.val - E x.val := by
  letI := functionField_isFractionRing_of_isAffineOpen X U hU
  have h := congrArg (fun A => A (chartHeightOne hU hfield x))
    (actualAffineDivisorIsoScalar_principal sX hU hfield D E e)
  dsimp only at h
  rw [principal_divisor_coefficient, Finsupp.sub_apply,
    actualAffineChartDivisorRestriction_coefficient,
    actualAffineChartDivisorRestriction_coefficient] at h
  rw [actual_affine_chart_closed_point_valuation hU hfield x]
  exact h

end Litt3.Jacobians
