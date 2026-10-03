import Definitions.Deformations.CyclicSkewPresentation

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k] [Invertible (2 : k)]

def CyclicSkewPresentationExists (p a : ℕ) [Fact p.Prime] [CharP k p] : Prop :=
  ∃ e : TruncatedCoefficientRing k (p ^ a) ≃ₐ[k] CyclicGroupAlgebra k (p ^ a),
    e (truncatedParameter k (p ^ a)) =
      cyclicSkewCoordinate (cyclicGroupGenerator k (p ^ a)) ∧
    ∀ x, e (truncatedReflection k (p ^ a) x) =
      cyclicGroupInversion k (p ^ a) (e x)

end Litt3.Deformations.Specifications
