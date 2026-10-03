import Mathlib.Algebra.Algebra.Basic
import Mathlib.Algebra.Module.LinearMap.Basic

namespace Litt3.CartierAndSpin

variable {K A : Type*} [CommRing K] [CommRing A] [Algebra K A]

/-- A moment of a genuine linear functional on an algebra. Algebra trace
is one instance; no splitting into scalar-valued point weights is presumed. -/
def functionalMoment (linear : A →ₗ[K] K) (weight value : A) (n : ℕ) : K :=
  linear (value ^ n * weight)

def functionalMomentDiscriminant (linear : A →ₗ[K] K) (weight value : A) : K :=
  3 * functionalMoment linear weight value 2 * functionalMoment linear weight value 4 -
    2 * functionalMoment linear weight value 3 ^ 2

end Litt3.CartierAndSpin
