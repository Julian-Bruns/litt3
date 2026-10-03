import Definitions.Deformations.LeftPrincipalWidth

namespace Litt3.Deformations.Specifications

variable {k A : Type*} [Field k] [Ring A] [Algebra k A]

def LeftPrincipalRadicalMaximumWidth (lag : ℕ) (f : A) : Prop :=
  ∃ w : ℕ,
    (∀ i, (∑ j ∈ Finset.range lag, Module.finrank k
      (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := A)) (i + j))) ≤ w) ∧
    (∃ i, (∑ j ∈ Finset.range lag, Module.finrank k
      (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := A)) (i + j))) = w) ∧
    w ≤ Module.finrank k (LeftPrincipalQuotient f)

end Litt3.Deformations.Specifications
