import Solutions.Deformations.CyclicGroupAlgebra
import Definitions.Deformations.TruncatedRestriction
import Mathlib.Algebra.Algebra.Bilinear
import Mathlib.RepresentationTheory.Basic

namespace Litt3.Deformations

universe u

variable {k : Type u} [CommRing k]

def pPowerCyclicGenerator (p a : ℕ) : Multiplicative (ZMod (p ^ a)) :=
  Multiplicative.ofAdd 1

/-- The genuine action of the actual cyclic p-power group on its
actual length-j quotient block: the generator acts by 1+z. -/
noncomputable def truncatedCyclicBlockRepresentation (p a j : ℕ)
    [Fact p.Prime] [CharP k p] (bound : j ≤ p ^ a) :
    Representation k (Multiplicative (ZMod (p ^ a))) (TruncatedCoefficientRing k j) :=
  (Algebra.lmul k (TruncatedCoefficientRing k j)).toMonoidHom.comp
    ((truncatedRestriction k (p ^ a) j bound).toMonoidHom.comp
      (truncatedCyclicGroupHom (k := k) p a))

end Litt3.Deformations
