import Solutions.Deformations.CyclicSkewPresentation
import Mathlib.RepresentationTheory.Basic

namespace Litt3.Deformations

variable {k : Type*} [Field k] [Invertible (2 : k)]

/-- The actual cyclic deck representation induced by the
actual skew group-algebra equivalence on any full Q_N module. -/
noncomputable def cyclicSkewDeckRepresentation (p a : ℕ) [Fact p.Prime] [CharP k p]
    (M : Type*) [AddCommGroup M] [Module k M]
    [Module (TruncatedCoefficientRing k (p ^ a)) M]
    [IsScalarTower k (TruncatedCoefficientRing k (p ^ a)) M] :
    Representation k (Multiplicative (ZMod (p ^ a))) M :=
  (Algebra.lsmul k k M).toMonoidHom.comp
    ((cyclicSkewAlgebraEquiv (k := k) p a).symm.toMonoidHom.comp
      (AddMonoidAlgebra.of k (ZMod (p ^ a))))

end Litt3.Deformations
