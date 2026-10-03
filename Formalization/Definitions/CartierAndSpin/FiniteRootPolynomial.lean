import Definitions.CartierAndSpin.CohortPowerSums
import Mathlib.RingTheory.Polynomial.Vieta

namespace Litt3.CartierAndSpin

open Polynomial

variable {K ι : Type*} [CommRing K] [Fintype ι]

/-- The monic polynomial of the actual finite family, retaining repeated
values and all multiplicities. -/
noncomputable def finiteRootPolynomial (u : ι → K) : K[X] :=
  ∏ i, (Polynomial.X - Polynomial.C (u i))

end Litt3.CartierAndSpin
