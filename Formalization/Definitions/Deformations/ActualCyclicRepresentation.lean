import Definitions.Deformations.CyclicDeckRepresentation

namespace Litt3.Deformations

variable {k V : Type*} [Field k] [Invertible (2 : k)] [AddCommGroup V] [Module k V]

/-- The actual action algebra of a specified cyclic
representation, expressed in the genuine skew coordinate. -/
noncomputable def cyclicRepresentationTruncatedAction (p a : ℕ) [Fact p.Prime] [CharP k p]
    (ρ : Representation k (Multiplicative (ZMod (p ^ a))) V) :
    TruncatedCoefficientRing k (p ^ a) →ₐ[k] Module.End k V :=
  ρ.asAlgebraHom.comp
    (((cyclicSkewAlgebraEquiv (k := k) p a).trans
      (AddMonoidAlgebra.toMultiplicativeAlgEquiv (R := k) k (ZMod (p ^ a)))).toAlgHom)

noncomputable def cyclicRepresentationTruncatedModule (p a : ℕ) [Fact p.Prime] [CharP k p]
    (ρ : Representation k (Multiplicative (ZMod (p ^ a))) V) :
    Module (TruncatedCoefficientRing k (p ^ a)) V :=
  Module.compHom V (cyclicRepresentationTruncatedAction p a ρ).toRingHom

end Litt3.Deformations
