import Definitions.Deformations.BoundedNaturalMaximum

namespace Litt3.Deformations.Specifications

def AttainedNaturalMaximum {ι : Type*} (f : ι → ℕ) (m : ℕ) : Prop :=
  (∀ i, f i ≤ m) ∧ ∃ i, f i = m

end Litt3.Deformations.Specifications
