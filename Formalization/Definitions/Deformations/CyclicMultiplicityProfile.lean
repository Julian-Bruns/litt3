import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Litt3.Deformations

variable {ι : Type*} [Fintype ι]

/-- The power-kernel dimension profile of a finite family
of cyclic lengths with their actual multiplicities. -/
def cyclicDimensionProfile (degree multiplicity : ι → ℕ) (a : ℕ) : ℕ :=
  ∑ i, multiplicity i * min a (degree i)

def cyclicMultiplicityAt (degree multiplicity : ι → ℕ) (a : ℕ) : ℕ :=
  ∑ i, if degree i = a then multiplicity i else 0

end Litt3.Deformations
