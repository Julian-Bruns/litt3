import Definitions.Deformations.RadicalComplements

namespace Litt3.Deformations

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V] [FiniteDimensional k V]

/-- A genuine nonzero leading form removes a positive rank
nondegenerate block and retains a strictly smaller full radical. -/
def PositiveRadicalSplit (B : LinearMap.BilinForm k V) : Prop :=
  ∃ U : Submodule k V, IsCompl U (BilinearRadical B) ∧
    (B.restrict U).Nondegenerate ∧ 0 < Module.finrank k U ∧
      Module.finrank k (BilinearRadical B) < Module.finrank k V

end Litt3.Deformations
