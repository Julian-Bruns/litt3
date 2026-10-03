import Definitions.CartierAndSpin.CommutatorWordIdeals
import Mathlib.LinearAlgebra.FiniteDimensional.Defs

namespace Litt3.CartierAndSpin

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- The genuine decreasing commutator kernel sequence. Each next
submodule enforces one more literal rightmost word letter. -/
def commutatorKernelSequence (U V : Module.End R M) : ℕ → Submodule R M
  | 0 => LinearMap.ker (U * V - V * U)
  | d + 1 => commutatorKernelSequence U V d ⊓
      (commutatorKernelSequence U V d).comap U ⊓
      (commutatorKernelSequence U V d).comap V

end Litt3.CartierAndSpin
