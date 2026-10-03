import Solutions.SharedTensors.RationalCartierExact
import Solutions.SharedTensors.EtaleSymmetricTrace

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k k' K : Type*} [CommRing k] [CommRing k'] [Field K]
  [Algebra k K] [Algebra k' K]
variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Normalized differentiation through a full literal p-basis is
independent of its constant ring. Both derivations are actual maps on
the original field, and no perfectness assumption is needed. -/
theorem normalized_p_basis_derivations_apply_eq
    (b : PowerPBasis K p) (D : Derivation k K K) (D' : Derivation k' K K)
    (hD : D b.parameter = 1) (hD' : D' b.parameter = 1) (a : K) :
    D a = D' a := by
  rw [derivation_p_basis_expansion b D hD a,
    derivation_p_basis_expansion b D' hD' a]

/-- A normalized derivation over the actual pth powers agrees with the
coordinate of the true universal differential over any constant ring
for which that normalized coordinate exists. -/
theorem normalized_p_basis_derivation_is_universal_coordinate
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hD : D b.parameter = 1) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1) (a : K) :
    D a = e (KaehlerDifferential.D k K a) := by
  exact normalized_p_basis_derivations_apply_eq b D
    (universalCoordinateDerivation e) hD he a

end Litt3.CartierAndSpin
