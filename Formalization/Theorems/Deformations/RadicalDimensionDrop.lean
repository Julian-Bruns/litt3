import Definitions.Deformations.RadicalDimensionDrop

namespace Litt3.Deformations.Specifications

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V] [FiniteDimensional k V]

def NonzeroReflexiveRadicalDimensionDrop (B : LinearMap.BilinForm k V) : Prop :=
  PositiveRadicalSplit B

end Litt3.Deformations.Specifications
