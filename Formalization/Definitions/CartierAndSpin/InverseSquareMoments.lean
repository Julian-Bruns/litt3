import Definitions.CartierAndSpin.SplitResidues

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- A polynomial residue numerator for the inverse-square source moment.
`J,S` are the quotient and remainder of H by phi; `A,B` divide X^j S'. -/
noncomputable def inverseSquareResidueNumerator (j : ℕ) (tau : K) (J A B H : K[X]) : K[X] :=
  A + X ^ j * J.derivative - C tau⁻¹ * B * H

end Litt3.CartierAndSpin
