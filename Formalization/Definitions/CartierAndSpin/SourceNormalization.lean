import Mathlib.RingTheory.AdjoinRoot
import Mathlib.Algebra.Polynomial.AlgebraMap

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- Multiplying the actual source equation by a nonzero base function
retains precisely the same quotient ideal. -/
noncomputable def sourceNormalizationQuotientEquiv (F : K[X]) (t : K) (ht : t ≠ 0) :
    AdjoinRoot (C t * F) ≃ₐ[K] AdjoinRoot F :=
  Ideal.quotientEquivAlgOfEq K
    (Ideal.span_singleton_mul_left_unit ((isUnit_iff_ne_zero.mpr ht).map Polynomial.C) F)

end Litt3.CartierAndSpin
