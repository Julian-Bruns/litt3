import Definitions.Deformations.RepresentationProducts

namespace Litt3.Deformations.Specifications

universe u

variable {k G ι : Type u} {V : ι → Type u} [Field k] [Group G]
    [Fintype G] [Fintype ι] [∀ i, AddCommGroup (V i)] [∀ i, Module k (V i)]

def FiniteProductCyclicCohomologyDimension (ρ : ∀ i, Representation k G (V i)) : Prop :=
  Module.finrank k (groupCohomology (Rep.of (representationPi ρ)) 1) =
    ∑ i, Module.finrank k (groupCohomology (Rep.of (ρ i)) 1)

end Litt3.Deformations.Specifications
