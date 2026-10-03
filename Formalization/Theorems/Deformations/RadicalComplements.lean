import Definitions.Deformations.RadicalComplements

namespace Litt3.Deformations.Specifications

open LinearMap

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V]

def NondegenerateRadicalComplement (B : LinearMap.BilinForm k V) : Prop :=
  ∃ U : Submodule k V, IsCompl U (BilinearRadical B) ∧ (B.restrict U).Nondegenerate

end Litt3.Deformations.Specifications
