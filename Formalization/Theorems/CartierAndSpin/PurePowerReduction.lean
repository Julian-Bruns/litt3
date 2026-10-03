import Definitions.CartierAndSpin.PurePowerReduction

namespace Litt3.CartierAndSpin.Specifications

variable {K A : Type*} [CommSemiring K] [CommSemiring A] [Algebra K A]

/-- The total-degree reduction assertion behind `pure_power_pair_finite_algebra`.
It is stated over semirings, because the induction itself uses no subtraction. -/
def PurePowerRectangularSpan (x y : A) (m : ℕ) : Prop :=
  PurePowerReductions (K := K) x y m →
    Algebra.adjoin K ({x, y} : Set A) = ⊤ →
      rectangularMonomialSpan (K := K) x y m = ⊤

end Litt3.CartierAndSpin.Specifications
