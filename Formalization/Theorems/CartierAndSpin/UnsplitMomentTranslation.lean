import Definitions.CartierAndSpin.LinearMoments
import Definitions.CartierAndSpin.SourceQuotientEnergy
import Mathlib.FieldTheory.Separable

namespace Litt3.CartierAndSpin.Specifications

open Polynomial Finset

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

def SourceTraceZeroMomentTranslations (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K) : Prop :=
  2 ≤ p → p ≤ F.natDegree → tau ≠ 0 → F.Separable →
  F = (X ^ p + C q) * H + C tau → (H %ₘ (X ^ p + C q)).coeff (p - 1) = 0 →
  ∃ unit : (AdjoinRoot F)ˣ,
    ∃ E : Derivation R (AdjoinRoot F) (AdjoinRoot F),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ a : K, E (algebraMap K (AdjoinRoot F) a) = algebraMap K (AdjoinRoot F) (D a)) ∧
      functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
        (E (AdjoinRoot.root F)) 0 = 0 ∧
      functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
        (E (AdjoinRoot.root F)) 1 = 0 ∧
      ∀ b : K,
        (AdjoinRoot.root F + algebraMap K (AdjoinRoot F) b) ^ p +
          algebraMap K (AdjoinRoot F) (q - b ^ p) = (unit : AdjoinRoot F) ∧
        (∀ n : ℕ,
          functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
            (E (AdjoinRoot.root F + algebraMap K (AdjoinRoot F) b)) n =
          ∑ j ∈ range (n + 1), (n.choose j : K) * D b ^ (n - j) *
            functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
              (E (AdjoinRoot.root F)) j) ∧
        functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
            (E (AdjoinRoot.root F + algebraMap K (AdjoinRoot F) b)) 2 =
          functionalMoment (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
            (E (AdjoinRoot.root F)) 2 ∧
        functionalMomentDiscriminant (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
            (E (AdjoinRoot.root F + algebraMap K (AdjoinRoot F) b)) =
          functionalMomentDiscriminant (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F)
            (E (AdjoinRoot.root F))

end Litt3.CartierAndSpin.Specifications
