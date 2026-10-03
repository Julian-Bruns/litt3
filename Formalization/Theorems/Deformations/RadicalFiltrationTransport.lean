import Definitions.Deformations.RadicalPowerFiltration
import Definitions.Deformations.FilteredQuotients

namespace Litt3.Deformations.Specifications

variable {k A B : Type*} [Field k] [Ring A] [Ring B] [Algebra k A] [Algebra k B]

def RadicalLayerTransport (_e : A ≃ₐ[k] B) : Prop :=
  ∀ i, Module.finrank k (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := A)) i) =
    Module.finrank k (FiltrationLayer (jacobsonRadicalFiltration (k := k) (A := B)) i)

end Litt3.Deformations.Specifications
