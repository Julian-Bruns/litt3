import Definitions.Deformations.FiltrationWidth
import Mathlib.Algebra.Polynomial.BigOperators

namespace Litt3.Deformations

open Module

variable {k V ι : Type*} [DivisionRing k] [AddCommGroup V] [Module k V]

/-- The actual span of basis vectors of weight at least n. -/
def weightedBasisFiltration (basis : Basis ι k V) (weight : ι → ℕ)
    (n : ℕ) : Submodule k V :=
  Submodule.span k (basis '' {j | n ≤ weight j})

/-- The exact generating polynomial of a finite weighted basis. -/
noncomputable def weightedBasisHilbertPolynomial [Fintype ι]
    (weight : ι → ℕ) : Polynomial ℕ :=
  ∑ j : ι, Polynomial.X ^ weight j

end Litt3.Deformations
