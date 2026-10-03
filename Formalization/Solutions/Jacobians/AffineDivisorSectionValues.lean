import Solutions.Jacobians.AffineDivisorSectionsFractionalIdeals

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable {X : Scheme.{u}} [IsIntegral X] [JacobsonSpace X] [ClosedPointDVRStalks X]
  {U : X.Opens} (hU : IsAffineOpen U)
  [IsDedekindDomain Γ(X, U)] [Nonempty U] (hfield : ¬IsField Γ(X, U))

/-- The actual section-to-ideal equivalence preserves the ORIGINAL
entire rational function, not merely its ideal class or divisor orders. -/
theorem actualAffineDivisorSectionsFractionalIdealEquiv_value
    (D : Divisor (Litt3.SharedTensors.ClosedPoint X))
    (a : (actualSchemeDivisorSheaf X D).val.obj (op U)) :
    (actualAffineDivisorSectionsFractionalIdealEquiv hU hfield D a).val =
      actualRationalFunctionOpenLinearEquiv X U a.val := rfl

end Litt3.Jacobians
