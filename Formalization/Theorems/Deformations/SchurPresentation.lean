import Definitions.Deformations.SchurPresentation

namespace Litt3.Deformations.Specifications

variable {R V W : Type*} [Ring R] [AddCommGroup V] [AddCommGroup W]
variable [Module R V] [Module R W]

/-- Exact complete-operator solvability, over any coefficient ring. -/
def SchurSolvability (A : V ≃ₗ[R] V) (b : W →ₗ[R] V)
    (c : V →ₗ[R] W) (d : W →ₗ[R] W) : Prop :=
  ∀ p, p ∈ LinearMap.range (schurResponse A b c d) ↔
    schurResidual A c p ∈ LinearMap.range (schurEntry A b c d)

end Litt3.Deformations.Specifications
