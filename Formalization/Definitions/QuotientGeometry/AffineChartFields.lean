import Mathlib.AlgebraicGeometry.FunctionField
import Mathlib.RingTheory.Localization.FractionRing

open AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- A genuine isomorphism of actual affine chart rings induces an
isomorphism of the actual generic-stalk function fields. -/
noncomputable def affineChartFunctionFieldEquiv
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    {U : X.Opens} {V : Y.Opens} (hU : IsAffineOpen U) (hV : IsAffineOpen V)
    [Nonempty U] [Nonempty V] (e : Γ(Y, V) ≃+* Γ(X, U)) :
    Y.functionField ≃+* X.functionField := by
  haveI := functionField_isFractionRing_of_isAffineOpen X U hU
  haveI := functionField_isFractionRing_of_isAffineOpen Y V hV
  exact IsFractionRing.ringEquivOfRingEquiv e

end Litt3.QuotientGeometry
