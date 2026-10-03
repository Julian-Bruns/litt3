import Definitions.Deformations.TruncatedCoefficientRing

namespace Litt3.Deformations.Specifications

variable {k : Type*} [CommRing k]

/-- Actual units of the truncated quotient are detected exactly
by the actual residue; arbitrary coefficient rings are allowed. -/
def TruncatedUnitCriterion (N : ℕ) (positive : 0 < N) : Prop :=
  ∀ x : TruncatedCoefficientRing k N,
    IsUnit x ↔ IsUnit (truncatedResidue k N positive x)

end Litt3.Deformations.Specifications
