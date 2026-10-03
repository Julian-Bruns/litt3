import Solutions.Jacobians.AffineChartValuationComparison

open CategoryTheory AlgebraicGeometry TopologicalSpace
open IsDedekindDomain

namespace Litt3.Jacobians

universe u
variable {X : Scheme.{u}} [JacobsonSpace X] {U : X.Opens}
  (hU : IsAffineOpen U) [IsDedekindDomain Γ(X, U)] (hfield : ¬IsField Γ(X, U))

/-- The literal global divisor restricted to ORIGINAL points in the
chart, then transported through the proved actual point/prime equivalence.
This is a true finite-support integer divisor on the actual coordinate ring. -/
noncomputable def actualAffineChartDivisorRestriction
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) :
    Divisor (HeightOneSpectrum Γ(X, U)) :=
  Finsupp.equivMapDomain (actualAffineChartClosedPointEquiv hU hfield)
    (D.comapDomain Subtype.val Subtype.val_injective.injOn)

/-- At an ORIGINAL closed chart point, the corresponding ORIGINAL
ideal coefficient is exactly the original global divisor coefficient. -/
@[simp] theorem actualAffineChartDivisorRestriction_coefficient
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X)) (x : ChartClosedPoint U) :
    actualAffineChartDivisorRestriction hU hfield D (chartHeightOne hU hfield x) = D x.val := by
  change (D.comapDomain Subtype.val Subtype.val_injective.injOn)
    ((actualAffineChartClosedPointEquiv hU hfield).symm
      ((actualAffineChartClosedPointEquiv hU hfield) x)) = D x.val
  rw [Equiv.symm_apply_apply]
  rfl

end Litt3.Jacobians
