import Mathlib.RingTheory.AdjoinRoot

namespace Litt3.CartierAndSpin

open Polynomial

/-- The actual polynomial after W'=aW+b with retained equation scale.
The exponent need not equal the actual degree for the quotient bridge. -/
noncomputable def affineSourceFramePolynomial {K : Type*} [Field K]
    (F : K[X]) (a b : K) (N : ℕ) : K[X] :=
  C (a ^ N) * F.comp (C a⁻¹ * (X - C b))

end Litt3.CartierAndSpin
