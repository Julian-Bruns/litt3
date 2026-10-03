import Theorems.Deformations.FiniteCyclicCohomology
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Deformations.Specifications

universe u

variable {k G V : Type u} [Field k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V]

/-- Genuine cyclic H¹ counts the exact invariant dimension left
outside the actual full group norm image. -/
def FiniteCyclicCohomologyDimension (ρ : Representation k G V) : Prop :=
  Module.finrank k (groupCohomology (Rep.of ρ) 1) +
    Module.finrank k (LinearMap.range ρ.norm) = Module.finrank k ρ.invariants

end Litt3.Deformations.Specifications
