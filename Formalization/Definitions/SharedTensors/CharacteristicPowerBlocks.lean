import Definitions.SharedTensors.CharacterBlocks
import Mathlib.Algebra.Polynomial.Expand

namespace Litt3.SharedTensors

open Polynomial

variable {K : Type*} [Field K]

/-- The actual j-th block of a polynomial, retaining the p consecutive
coefficients rather than postulating a decomposition. -/
noncomputable def characteristicPowerBlock (p j : ℕ) (F : K[X]) : K[X] :=
  ∑ i ∈ Finset.range p, monomial i (F.coeff (p * j + i))

end Litt3.SharedTensors
