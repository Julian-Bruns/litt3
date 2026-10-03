import Mathlib.RingTheory.Kaehler.Basic
import Mathlib.RingTheory.LocalRing.MaximalIdeal.Basic
import Mathlib.RingTheory.Ideal.Operations

namespace Litt3.CartierAndSpin

variable {k R F : Type*} [CommRing k] [CommRing R] [Field F]
  [IsLocalRing R] [Algebra k R] [Algebra k F] [Algebra R F]
  [IsScalarTower k R F]

/-- The actual rational form is zero in the original local residue
fiber: it has an ORIGINAL universal-module representative in m·Ω.
The definition uses the genuine maximal ideal and entire stalk module,
not a selected frame or an assumed order function. -/
def differentialZeroLattice (omega : KaehlerDifferential k F) : Prop :=
  ∃ omegaR : KaehlerDifferential k R,
    omegaR ∈ (IsLocalRing.maximalIdeal R) • (⊤ : Submodule R (KaehlerDifferential k R)) ∧
      KaehlerDifferential.map k k R F omegaR = omega

end Litt3.CartierAndSpin
