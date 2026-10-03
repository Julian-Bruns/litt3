import Definitions.Deformations.WeightedAlgebraWidth

namespace Litt3.Deformations.Specifications

open Module

variable {k A : Type*} [Field k] [Ring A] [Algebra k A] [FiniteDimensional k A]

def WeightedHeisenbergCokernelBound (p : ℕ) (f : A) : Prop :=
  p ^ 2 ≤ Module.finrank k (A ⧸ LinearMap.range (LinearMap.mulRight k f))

end Litt3.Deformations.Specifications
