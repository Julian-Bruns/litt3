import Definitions.Deformations.TraceSectionDescent

namespace Litt3.Deformations.Specifications

open scoped MonoidAlgebra

variable {k G V D : Type*} [Field k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V] [AddCommGroup D] [Module k D]

/-- Freeness of the literal full deck coefficient module is equivalent
to surjectivity of the actual section trace, under full invariant descent
and the literal trace/norm identity. No finite dimension is required. -/
def TraceSectionFreeness (data : TraceSectionDescentData k G V D) : Prop :=
  Module.Free k[G] data.action.asModule ↔ Function.Surjective data.trace

end Litt3.Deformations.Specifications
