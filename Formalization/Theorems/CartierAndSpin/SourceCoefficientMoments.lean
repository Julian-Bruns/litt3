import Definitions.CartierAndSpin.SplitSourceAlgebra
import Mathlib.RingTheory.Trace.Defs

namespace Litt3.CartierAndSpin.Specifications

open Polynomial

variable {K ι : Type*} [Field K] [Fintype ι]

/-- The complete two coefficient-moment families in the actual split
source quotient, including disconnected source algebras. -/
def SplitSourceCoefficientMoments (node : ι → K) (F H : K[X])
    (p : ℕ) [CharP K p] (q tau c : K) : Prop :=
  2 ≤ p → p ≤ F.natDegree → Function.Injective node → tau ≠ 0 → c ≠ 0 →
  F = C c * Lagrange.nodal Finset.univ node →
  F = (X ^ p + C q) * H + C tau →
  ∃ unit : (K[X] ⧸ Ideal.span ({Lagrange.nodal Finset.univ node} : Set K[X]))ˣ,
    (unit : K[X] ⧸ Ideal.span ({Lagrange.nodal Finset.univ node} : Set K[X])) =
      Ideal.Quotient.mk _ (X ^ p + C q) ∧
    ∀ j < p,
      Algebra.trace K _ ((Ideal.Quotient.mk _ X) ^ j * (↑unit⁻¹ :
        K[X] ⧸ Ideal.span ({Lagrange.nodal Finset.univ node} : Set K[X]))) = 0 ∧
      Algebra.trace K _ ((Ideal.Quotient.mk _ X) ^ j * (↑unit⁻¹ :
        K[X] ⧸ Ideal.span ({Lagrange.nodal Finset.univ node} : Set K[X])) ^ 2) =
          (j : K) * (H %ₘ (X ^ p + C q)).coeff (p - j) / tau

end Litt3.CartierAndSpin.Specifications
