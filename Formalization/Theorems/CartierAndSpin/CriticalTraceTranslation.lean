import Mathlib.RingTheory.AdjoinRoot
import Mathlib.RingTheory.Trace.Basic

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

/-- The five invariants in any actual source algebra, independent of its
chosen primitive-polynomial presentation. -/
def AlgebraCriticalTraceTranslationOutcome {K A : Type*} [Field K]
    [CommRing A] [Algebra K A] (w u : A) (phiUnit : Aˣ) : Prop :=
  ∀ z : K,
    Algebra.trace K A ((u - algebraMap K A z) * w ^ 4 * (↑phiUnit⁻¹ : A)) =
      Algebra.trace K A (u * w ^ 4 * (↑phiUnit⁻¹ : A)) ∧
    Algebra.trace K A (u - algebraMap K A z) = Algebra.trace K A u ∧
    ∀ j < 3,
      Algebra.trace K A ((u - algebraMap K A z) ^ 2 * w ^ j * (↑phiUnit⁻¹ : A)) =
        Algebra.trace K A (u ^ 2 * w ^ j * (↑phiUnit⁻¹ : A))

/-- The five actual traces in the critical translation package. The
denominator units and source quotient are actual algebraic objects. -/
def CriticalTraceTranslationOutcome {K : Type*} [Field K]
    (F U : K[X]) (phiUnit DUnit : (AdjoinRoot F)ˣ) : Prop :=
  let w := AdjoinRoot.root F
  let u := AdjoinRoot.mk F U * (↑DUnit⁻¹ : AdjoinRoot F)
  ∀ z : K,
    Algebra.trace K (AdjoinRoot F)
      ((u - algebraMap K (AdjoinRoot F) z) * w ^ 4 * (↑phiUnit⁻¹ : AdjoinRoot F)) =
        Algebra.trace K (AdjoinRoot F) (u * w ^ 4 * (↑phiUnit⁻¹ : AdjoinRoot F)) ∧
    Algebra.trace K (AdjoinRoot F) (u - algebraMap K (AdjoinRoot F) z) =
      Algebra.trace K (AdjoinRoot F) u ∧
    ∀ j < 3,
      Algebra.trace K (AdjoinRoot F)
        ((u - algebraMap K (AdjoinRoot F) z) ^ 2 * w ^ j *
          (↑phiUnit⁻¹ : AdjoinRoot F)) =
        Algebra.trace K (AdjoinRoot F) (u ^ 2 * w ^ j * (↑phiUnit⁻¹ : AdjoinRoot F))

end Litt3.CartierAndSpin.Specifications
