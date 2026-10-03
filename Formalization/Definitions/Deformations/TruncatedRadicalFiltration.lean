import Definitions.Deformations.TruncatedCoefficientRing
import Definitions.Deformations.RadicalPowerFiltration
import Mathlib.RingTheory.Ideal.Maximal

namespace Litt3.Deformations

variable {k A : Type*} [Field k] [CommRing A] [Algebra k A]

/-- The full coefficient subspace of actual multiples of f,
rather than its one-dimensional coefficient span. -/
noncomputable def principalCoefficientSubspace (f : A) : Submodule k A :=
  LinearMap.range (LinearMap.mulRight k f)

end Litt3.Deformations
