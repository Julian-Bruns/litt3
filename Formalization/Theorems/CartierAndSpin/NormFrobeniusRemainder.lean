import Mathlib.RingTheory.Norm.Basic
import Mathlib.RingTheory.AdjoinRoot

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

variable {K : Type*} [Field K]

/-- Literal full positive-degree source-algebra conclusion. Uniqueness
includes both quotient polynomial and nonzero constant. -/
def SourceNormFrobeniusRemainder (p : ℕ) (f : K) (F : K[X]) : Prop :=
  ((∃ a : K, a ≠ 0 ∧ Algebra.norm K
      (AdjoinRoot.mk F (X ^ p + C f)) = a ^ p) ↔
    ∃! remainder : K[X] × K, remainder.2 ≠ 0 ∧
      F = (X ^ p + C f) * remainder.1 + C remainder.2) ∧
  ((∃ a : K, a ≠ 0 ∧ Algebra.norm K
      (AdjoinRoot.mk F (X ^ p + C f)) = a ^ p) → p ≤ F.natDegree)

/-- Literal primitive-field conclusion for the actual monic minimal
polynomial, with the actual field norm and no source-quotient substitute. -/
def PrimitiveNormFrobeniusRemainder {L : Type*} [Field L] [Algebra K L]
    (p : ℕ) (f : K) (b : L) : Prop :=
  ((∃ a : K, a ≠ 0 ∧ Algebra.norm K
      (b ^ p + algebraMap K L f) = a ^ p) ↔
    ∃! remainder : K[X] × K, remainder.2 ≠ 0 ∧
      minpoly K b = (X ^ p + C f) * remainder.1 + C remainder.2) ∧
  ((∃ a : K, a ≠ 0 ∧ Algebra.norm K
      (b ^ p + algebraMap K L f) = a ^ p) → p ≤ (minpoly K b).natDegree)

end Litt3.CartierAndSpin.Specifications
