import Theorems.Deformations.PGroupCohomologyFreeness
import Theorems.Deformations.InvariantOrbitEmbedding
import Definitions.Deformations.PGroupNormFreeness

namespace Litt3.Deformations.Specifications

universe u

variable {k G V : Type u} [Field k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V]

/-- The complete genuine coefficient-module criterion used by the BT
descent arguments. Geometric section modules and their invariant descent
must still be identified separately. -/
def FinitePGroupModuleCriteria (ρ : Representation k G V) : Prop :=
  PGroupRepresentationGrowth ρ ∧ PGroupMaximalGrowthFreeness ρ ∧
    PGroupCohomologyFreeness ρ ∧ PGroupNormFreeness ρ

end Litt3.Deformations.Specifications
