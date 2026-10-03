import Definitions.Deformations.PairedCyclicSections
import Theorems.Deformations.CanonicalCyclicParity

namespace Litt3.Deformations.Specifications

variable {k : Type*} [Field k]

def PairedCyclicSectionConclusions (N : ℕ) (V : Type*) [AddCommGroup V] [Module k V]
    (multiplicity : Fin (N + 1) → ℕ) : Prop :=
  CanonicalCyclicParity N multiplicity ∧ (Odd (Module.finrank k V) → N ≤ Module.finrank k V)

end Litt3.Deformations.Specifications
