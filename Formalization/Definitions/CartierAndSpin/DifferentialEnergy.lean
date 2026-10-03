import Mathlib.RingTheory.Derivation.Basic
import Mathlib.Algebra.BigOperators.Field

namespace Litt3.CartierAndSpin

variable {R K ι : Type*} [CommRing R] [Field K] [Algebra R K]

noncomputable def splitDifferentialEnergy (D : Derivation R K K)
    (s : Finset ι) (node phi : ι → K) : K :=
  ∑ i ∈ s, (D (node i)) ^ 2 / phi i

noncomputable def splitTwistedDifferentialEnergy (D : Derivation R K K)
    (s : Finset ι) (node phi : ι → K) (q : K) : K :=
  ∑ i ∈ s, (D (node i) - 2 * node i * D q / phi i) ^ 2 / phi i

end Litt3.CartierAndSpin
