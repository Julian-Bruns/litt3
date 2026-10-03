import Mathlib.RingTheory.AdjoinRoot
import Mathlib.RingTheory.Trace.Defs
import Mathlib.FieldTheory.Separable

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

variable {K : Type*} [Field K]

/-- The exact coefficient-moment assertion for the original separable
source quotient. All source equations are actual polynomial equations. -/
def SourceCoefficientMoments (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K) : Prop :=
  2 ≤ p → p ≤ F.natDegree → tau ≠ 0 → F.Separable →
  F = (X ^ p + C q) * H + C tau →
  ∃ unit : (AdjoinRoot F)ˣ,
    (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
    ∀ j < p,
      Algebra.trace K (AdjoinRoot F) ((AdjoinRoot.root F) ^ j * (↑unit⁻¹ : AdjoinRoot F)) = 0 ∧
      Algebra.trace K (AdjoinRoot F) ((AdjoinRoot.root F) ^ j *
        (↑unit⁻¹ : AdjoinRoot F) ^ 2) =
          (j : K) * (H %ₘ (X ^ p + C q)).coeff (p - j) / tau

end Litt3.CartierAndSpin.Specifications
