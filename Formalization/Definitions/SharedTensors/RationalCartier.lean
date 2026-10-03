import Definitions.SharedTensors.FrobeniusCoordinates
import Mathlib.RingTheory.Kaehler.Basic

namespace Litt3.SharedTensors

variable (k K : Type*) [CommRing k] [Field K] [Algebra k K]
variable (p : ℕ) [Fact p.Prime] [CharP K p]

/-- The standard intrinsic rational Cartier characterization on the
actual universal differential module. The full p-basis construction and
one-variable-field existence are proved in the solution modules. This
definition assumes no endpoint recovery or field-generation conclusion. -/
structure RationalCartierOperator where
  toAddHom : KaehlerDifferential k K →+ KaehlerDifferential k K
  pth_semilinear : ∀ (a : K) (omega : KaehlerDifferential k K),
    toAddHom (a ^ p • omega) = a • toAddHom omega
  kills_exact : ∀ a : K, toAddHom (KaehlerDifferential.D k K a) = 0
  fixes_logarithmic : ∀ a : K,
    toAddHom (a⁻¹ • KaehlerDifferential.D k K a) =
      a⁻¹ • KaehlerDifferential.D k K a

end Litt3.SharedTensors
