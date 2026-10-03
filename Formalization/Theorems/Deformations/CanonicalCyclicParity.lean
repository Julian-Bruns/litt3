import Definitions.Deformations.CanonicalCyclicParity

namespace Litt3.Deformations.Specifications

def CanonicalCyclicParity (N : ℕ) (multiplicity : Fin (N + 1) → ℕ) : Prop :=
  ∀ j, Odd j.val → j.val < N → Even (multiplicity j)

end Litt3.Deformations.Specifications
