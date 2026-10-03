import Definitions.Deformations.CyclicGroupAlgebra

namespace Litt3.Deformations

variable (k : Type*) [CommRing k]

/-- The actual group-algebra inversion, induced by negation on
the actual additive cyclic group. -/
noncomputable def cyclicGroupInversion (N : ℕ) :
    CyclicGroupAlgebra k N →+* CyclicGroupAlgebra k N :=
  AddMonoidAlgebra.mapDomainRingHom k (negAddMonoidHom : ZMod N →+ ZMod N)

end Litt3.Deformations
