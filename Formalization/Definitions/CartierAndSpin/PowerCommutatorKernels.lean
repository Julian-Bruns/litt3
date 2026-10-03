import Mathlib.LinearAlgebra.FiniteDimensional.Basic

namespace Litt3.CartierAndSpin

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- The literal intersection of the kernels of every power commutator. -/
def powerCommutatorKernel (U V : Module.End R M) : Submodule R M :=
  ⨅ i : ℕ, ⨅ j : ℕ, LinearMap.ker (U ^ i * V ^ j - V ^ j * U ^ i)

end Litt3.CartierAndSpin
