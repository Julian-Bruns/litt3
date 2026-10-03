import Definitions.SharedTensors.DivisorRelations

namespace Litt3.SharedTensors

/-- Saturation is an integral assertion, not only a rational rank calculation. -/
def DivisorRelationsSaturated {X Y Z : Type*} (f : Z → X) (g : Z → Y)
    (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite)
    (hg : ∀ s : Set Y, s.Finite → (g ⁻¹' s).Finite) : Prop :=
  ∀ (n : ℤ), n ≠ 0 → ∀ D : Litt3.Jacobians.Divisor Z,
    n • D ∈ (divisorRelationMap f g hf hg).range →
      D ∈ (divisorRelationMap f g hf hg).range

end Litt3.SharedTensors
