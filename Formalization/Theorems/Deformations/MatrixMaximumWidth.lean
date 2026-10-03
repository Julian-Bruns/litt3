import Theorems.Deformations.MatrixFiltrationWidth
import Definitions.Deformations.BoundedNaturalMaximum

namespace Litt3.Deformations.Specifications

variable {k A ι : Type*} [Field k] [Ring A] [Algebra k A] [Fintype ι]

def MatrixMaximumFiltrationWidth (F : ℕ → Submodule k A) (lag : ℕ)
    (M : Matrix ι ι A) : Prop :=
  ∃ w : ℕ,
    (∀ i, (∑ j ∈ Finset.range lag, Module.finrank k (FiltrationLayer F (i + j))) ≤ w) ∧
    (∃ i, (∑ j ∈ Finset.range lag, Module.finrank k (FiltrationLayer F (i + j))) = w) ∧
    Fintype.card ι * w ≤ Module.finrank k (EndomorphismCokernel (rightMatrixOperator (k := k) M))

end Litt3.Deformations.Specifications
