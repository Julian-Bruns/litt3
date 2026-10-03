import Definitions.Deformations.SocleCupForms

namespace Litt3.Deformations.Specifications

variable {k V ι : Type*} [Field k] [AddCommGroup V] [Module k V] [Fintype ι]

def FirstSocleSectionCount (B : ι → LinearMap.BilinForm k V) (W : Type*)
    [AddCommGroup W] [Module k W] : Prop :=
  Module.finrank k W = Fintype.card ι * Module.finrank k V +
    Module.finrank k (commonCupRadical B)

end Litt3.Deformations.Specifications
