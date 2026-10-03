import Definitions.CartierAndSpin.SourceQuotientEnergy
import Mathlib.FieldTheory.Separable

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

/-- Differential coefficient moments and the two twisted-square
presentations in the original actual source quotient. -/
def SourceQuotientDifferentialCalculus (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K) : Prop :=
  3 ≤ p → p ≤ F.natDegree → tau ≠ 0 → F.Separable →
  F = (X ^ p + C q) * H + C tau →
  ∃ unit : (AdjoinRoot F)ˣ,
    ∃ E : Derivation R (AdjoinRoot F) (AdjoinRoot F),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ a : K, E (algebraMap K (AdjoinRoot F) a) =
        algebraMap K (AdjoinRoot F) (D a)) ∧
      (∀ j : ℕ, 0 < j → j < p →
        Algebra.trace K (AdjoinRoot F) ((AdjoinRoot.root F) ^ (j - 1) *
          E (AdjoinRoot.root F) * (↑unit⁻¹ : AdjoinRoot F)) =
            (H %ₘ (X ^ p + C q)).coeff (p - j) * D q / tau) ∧
      sourceQuotientDifferentialEnergy F E unit -
        4 * D q * D ((H %ₘ (X ^ p + C q)).coeff (p - 2) / tau) =
          sourceQuotientTwistedDifferentialEnergy D F E unit q ∧
      sourceQuotientDifferentialEnergy F E unit -
        4 * D q * D ((H %ₘ (X ^ p + C q)).coeff (p - 2) / tau) =
          Algebra.trace K (AdjoinRoot F)
            ((E (AdjoinRoot.root F * (unit : AdjoinRoot F) ^ (p - 2))) ^ 2 *
              (↑unit⁻¹ : AdjoinRoot F) ^ (2 * p - 3))

end Litt3.CartierAndSpin.Specifications
