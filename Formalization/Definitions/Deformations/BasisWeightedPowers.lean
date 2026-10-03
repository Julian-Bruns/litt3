import Mathlib.LinearAlgebra.Basis.Defs
import Mathlib.RingTheory.Ideal.Span

namespace Litt3.Deformations

/-- Literal coefficient powers in a fixed basis, with coefficient and
basis weights kept separate. -/
noncomputable def basisWeightedPowerFiltration {R M I : Type*}
    [CommRing R] [AddCommGroup M] [Module R M]
    (B : Module.Basis I R M) (a : R) (w : ℕ) (degree : I → ℕ) (d : ℕ) :
    Submodule R M :=
  Submodule.span R {x | ∃ j : ℕ, ∃ i : I,
    d ≤ w * j + degree i ∧ x = a ^ j • B i}

/-- The least coefficient exponent that reaches the selected weight. -/
def basisWeightExponent (w d b : ℕ) : ℕ := (d - b + w - 1) / w

end Litt3.Deformations
