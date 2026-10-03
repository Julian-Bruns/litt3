import Solutions.Jacobians.SchemeRationalSectionPullbacks
import Solutions.Jacobians.SchemeValuationPullbacks

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  [ClosedPointDVRStalks X] [ClosedPointDVRStalks Y]
  (f : X ⟶ Y) [IsFinite f] [Surjective f]
  [AlgebraicGeometry.FormallyUnramified f] [LocallyOfFiniteType f]

/-- Literal ORIGINAL rational-section pullback under an ACTUAL
finite surjective formally unramified scheme map satisfies the literal
ORIGINAL pulled-divisor bounds. Every valuation compatibility is proved
from actual original DVR stalk maps; no completion or class substitute is
assumed. -/
theorem actualSchemeRationalSectionPullback_mem_divisor
    (D : Divisor (Litt3.SharedTensors.ClosedPoint Y))
    (U : Y.Opens) [Nonempty U]
    (a : (actualSchemeRationalFunctionModuleSheaf Y).val.obj (op U))
    (ha : a ∈ actualSchemeDivisorOpenSubmodule Y D (op U)) :
    actualSchemeRationalSectionPullback f U a ∈
      actualSchemeDivisorOpenSubmodule X (Litt3.SharedTensors.schemeDivisorPullback f D)
        (op (f ⁻¹ᵁ U)) := by
  letI := actualSchemeNonemptyPreimageOpen f U
  intro x hx
  change closedPointValuation X x
      (actualRationalFunctionEvaluation X (f ⁻¹ᵁ U) x.val hx
        (actualSchemeRationalSectionPullback f U a)) ≤ _
  rw [actualRationalFunctionEvaluation_eq_open]
  change closedPointValuation X x
      (actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ U)
        (actualSchemeRationalSectionPullback f U a)) ≤ _
  rw [actualSchemeRationalSectionPullback_field_value,
    scheme_closed_point_valuation_pullback f]
  have h := ha (Litt3.SharedTensors.mapClosedPoint f x) hx
  rw [actualRationalFunctionEvaluation_eq_open] at h
  exact h

end Litt3.Jacobians
