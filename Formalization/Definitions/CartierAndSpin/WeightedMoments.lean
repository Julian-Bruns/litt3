import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Litt3.CartierAndSpin

variable {R ι : Type*} [CommRing R]

/-- A finite weighted power moment. No positivity or nonzero-weight assumption
is imposed. -/
def weightedMoment (s : Finset ι) (weight value : ι → R) (n : ℕ) : R :=
  ∑ i ∈ s, weight i * value i ^ n

/-- The quartic discriminant of a weighted moment sequence. -/
def momentDiscriminant (s : Finset ι) (weight value : ι → R) : R :=
  3 * weightedMoment s weight value 2 * weightedMoment s weight value 4 -
    2 * weightedMoment s weight value 3 ^ 2

end Litt3.CartierAndSpin
