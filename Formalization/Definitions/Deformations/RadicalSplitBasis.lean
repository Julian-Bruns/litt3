import Definitions.Deformations.RadicalComplements
import Mathlib.LinearAlgebra.Basis.Prod
import Mathlib.LinearAlgebra.Projection

namespace Litt3.Deformations

open Module

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V] [FiniteDimensional k V]

/-- A genuine basis of the complete vector space, assembled
from a chosen complement and the complete radical. -/
noncomputable def radicalSplitBasis (B : LinearMap.BilinForm k V)
    (U : Submodule k V) (complement : IsCompl U (BilinearRadical B)) :
    Basis (Fin (Module.finrank k U) ⊕ Fin (Module.finrank k (BilinearRadical B))) k V :=
  ((Module.finBasis k U).prod (Module.finBasis k (BilinearRadical B))).map
    (Submodule.prodEquivOfIsCompl U (BilinearRadical B) complement)

end Litt3.Deformations
