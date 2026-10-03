import Definitions.Deformations.FilteredQuotients

namespace Litt3.Deformations.Specifications

variable {k V W : Type*} [DivisionRing k]
variable [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]
variable {F : ℕ → Submodule k V} {E : ℕ → Submodule k W}

def FiltrationHilbertMonotone (_f : FilteredLinearMap F E) : Prop :=
  ∀ i, Module.finrank k (FiltrationLayer E i) ≤ Module.finrank k (FiltrationLayer F i)

def FiltrationWindowMonotone (_f : FilteredLinearMap F E) : Prop :=
  ∀ i lag, (∑ j ∈ Finset.range lag, Module.finrank k (FiltrationLayer E (i + j))) ≤
    ∑ j ∈ Finset.range lag, Module.finrank k (FiltrationLayer F (i + j))

end Litt3.Deformations.Specifications
