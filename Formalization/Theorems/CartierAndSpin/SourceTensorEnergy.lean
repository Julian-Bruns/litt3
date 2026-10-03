import Definitions.CartierAndSpin.SourceTensorEnergy

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- The original source moments and both twisted-square presentations,
as literal universal differentials and their actual symmetric products. -/
def SourceUniversalTensorCalculus (F H : K[X]) (p : ℕ) [CharP K p]
    (q tau : K) (e : KaehlerDifferential k K ≃ₗ[K] K) (hs : F.Separable) : Prop :=
  3 ≤ p → p ≤ F.natDegree → tau ≠ 0 → F = (X ^ p + C q) * H + C tau →
  ∃ unit : (AdjoinRoot F)ˣ,
    (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
    (∀ j : ℕ, 0 < j → j < p →
      sourceUniversalDifferentialMoment F hs e unit j =
        ((H %ₘ (X ^ p + C q)).coeff (p - j) / tau) • KaehlerDifferential.D k K q) ∧
    sourceUniversalTwistedEnergy F hs e unit q tau ((H %ₘ (X ^ p + C q)).coeff (p - 2)) =
      sourceUniversalTwistedSquare F hs e unit q ∧
    sourceUniversalTwistedEnergy F hs e unit q tau ((H %ₘ (X ^ p + C q)).coeff (p - 2)) =
      sourceUniversalTwistedPowerSquare F hs e unit p

end Litt3.CartierAndSpin.Specifications
