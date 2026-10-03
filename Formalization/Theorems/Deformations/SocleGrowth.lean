import Definitions.Deformations.SocleCupForms

namespace Litt3.Deformations.Specifications

variable {k V ι : Type*} [Field k] [AddCommGroup V] [Module k V] [Fintype ι]

def SocleSectionLowerBound (B : ι → LinearMap.BilinForm k V) (U : Type*)
    [AddCommGroup U] [Module k U] : Prop :=
  Fintype.card ι * Module.finrank k V + Module.finrank k (commonCupRadical B) ≤
    Module.finrank k U

end Litt3.Deformations.Specifications
