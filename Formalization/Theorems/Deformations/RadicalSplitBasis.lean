import Definitions.Deformations.RadicalSplitBasis

namespace Litt3.Deformations.Specifications

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V] [FiniteDimensional k V]

def ReflexiveRadicalMatrixSplit (B : LinearMap.BilinForm k V) : Prop :=
  ∃ U : Submodule k V, ∃ complement : IsCompl U (BilinearRadical B),
    IsUnit (_root_.BilinForm.toMatrix (Module.finBasis k U) (B.restrict U)) ∧
    _root_.BilinForm.toMatrix (radicalSplitBasis B U complement) B =
      Matrix.fromBlocks (_root_.BilinForm.toMatrix (Module.finBasis k U) (B.restrict U)) 0 0 0

end Litt3.Deformations.Specifications
