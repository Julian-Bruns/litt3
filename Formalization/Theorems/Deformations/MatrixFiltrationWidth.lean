import Definitions.Deformations.MatrixFiltrationWidth

namespace Litt3.Deformations.Specifications

variable {k A ι : Type*} [Field k] [Ring A] [Algebra k A] [Fintype ι]

def MatrixFiltrationWidth (F : ℕ → Submodule k A) (lag : ℕ) (M : Matrix ι ι A) : Prop :=
  ∀ i, Fintype.card ι * (∑ j ∈ Finset.range lag, Module.finrank k (FiltrationLayer F (i + j))) ≤
    Module.finrank k (EndomorphismCokernel (rightMatrixOperator (k := k) M))

end Litt3.Deformations.Specifications
