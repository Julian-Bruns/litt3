import Definitions.Deformations.FiniteCyclicCohomology

namespace Litt3.Deformations.Specifications

universe u

variable {k G V : Type u} [CommRing k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V]

/-- Genuine degree-one group cohomology agrees with the actual
norm-kernel/generator-difference quotient for the specified generator. -/
def FiniteCyclicCohomologyFormula (ρ : Representation k G V) (g : G) : Prop :=
  Nonempty (groupCohomology (Rep.of ρ) 1 ≃ₗ[k] CyclicOneCohomologyQuotient ρ g)

end Litt3.Deformations.Specifications
