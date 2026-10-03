import Mathlib.Algebra.Algebra.Subalgebra.Lattice

namespace Litt3.CartierAndSpin

variable {K A : Type*} [CommSemiring K] [CommSemiring A] [Algebra K A]

/-- Monomials strictly below a specified total degree. -/
def lowerMonomialSpan (x y : A) (m : ℕ) : Submodule K A :=
  Submodule.span K {z : A | ∃ i j : ℕ, i + j < m ∧ z = x ^ i * y ^ j}

/-- The rectangular monomial span with both exponents less than `m`. -/
def rectangularMonomialSpan (x y : A) (m : ℕ) : Submodule K A :=
  Submodule.span K (Set.range (fun ij : Fin m × Fin m => x ^ (ij.1 : ℕ) * y ^ (ij.2 : ℕ)))

/-- Pure-power reductions lower total degree. These are concrete algebraic
relations, not a finite-dimensionality or spanning assumption. -/
structure PurePowerReductions (x y : A) (m : ℕ) : Prop where
  x_reduction : x ^ m ∈ lowerMonomialSpan (K := K) x y m
  y_reduction : y ^ m ∈ lowerMonomialSpan (K := K) x y m

end Litt3.CartierAndSpin
