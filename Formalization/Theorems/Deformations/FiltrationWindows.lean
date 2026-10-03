import Definitions.Deformations.FiltrationWidth

namespace Litt3.Deformations.Specifications

variable {k V : Type*} [DivisionRing k] [AddCommGroup V] [Module k V]

def WindowFiltrationWidth (T : V →ₗ[k] V) (F : ℕ → Submodule k V) (lag : ℕ) : Prop :=
  ∀ i, (∑ j ∈ Finset.range lag, Module.finrank k (FiltrationLayer F (i + j))) ≤
    Module.finrank k (EndomorphismCokernel T)

end Litt3.Deformations.Specifications
