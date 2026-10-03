import Definitions.Deformations.FiltrationWidth

namespace Litt3.Deformations.Specifications

variable {k V : Type*} [DivisionRing k] [AddCommGroup V] [Module k V]
variable [FiniteDimensional k V]

/-- Two-step filtration loss gives a uniform lower bound on the
actual kernel and cokernel dimensions. -/
def AdjacentFiltrationWidth (T : V →ₗ[k] V)
    (F : ℕ → Submodule k V) : Prop :=
  ∀ i,
    Module.finrank k (FiltrationLayer F i) +
      Module.finrank k (FiltrationLayer F (i + 1)) ≤
        Module.finrank k (EndomorphismCokernel T)

end Litt3.Deformations.Specifications
