import Mathlib.RingTheory.LaurentSeries
import Mathlib.Algebra.Polynomial.Eval.Degree

namespace Litt3.CartierAndSpin

open Polynomial

/-- Literal weighted coordinate rescaling by the Laurent parameter:
r^(-a) P(r^weight T). Arbitrary integer weights are allowed. -/
noncomputable def laurentWeightedRescale {k : Type*} [Field k]
    (P : (LaurentSeries k)[X]) (a weight : ℤ) : (LaurentSeries k)[X] :=
  C (HahnSeries.single (-a) 1) *
    P.comp (C (HahnSeries.single weight 1) * X)

end Litt3.CartierAndSpin
