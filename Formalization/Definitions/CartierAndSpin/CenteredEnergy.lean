import Definitions.CartierAndSpin.DifferentialEnergy

namespace Litt3.CartierAndSpin

open Finset

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K]

/-- Energy after subtracting the actual derivative of a base center. -/
noncomputable def splitCenteredDifferentialEnergy (D : Derivation R K K)
    (s : Finset ι) (node phi : ι → K) (center : K) : K :=
  ∑ i ∈ s, (D (node i) - D center) ^ 2 / phi i

/-- The affine-center expression after clearing the center coefficient.
It is defined even when the coefficient s vanishes. -/
noncomputable def splitClearedCenteredEnergy (D : Derivation R K K)
    (indices : Finset ι) (node phi : ι → K) (q tau s c : K) : K :=
  s * splitDifferentialEnergy D indices node phi -
    2 * D q / tau * (s * D c - c * D s)

end Litt3.CartierAndSpin
