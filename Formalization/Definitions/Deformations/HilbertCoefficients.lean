import Mathlib.Algebra.Polynomial.BigOperators
import Mathlib.Algebra.Polynomial.Eval.Degree
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace Litt3.Deformations

open Polynomial Finset

/-- The actual interval Hilbert polynomial with m consecutive
coefficients equal to one. -/
noncomputable def intervalPolynomial (m : ℕ) : Polynomial ℕ :=
  ∑ j ∈ range m, X ^ j

/-- Weight-two interval factor, with no assumed group basis. -/
noncomputable def weightedIntervalPolynomial (m : ℕ) : Polynomial ℕ :=
  ∑ j ∈ range m, X ^ (2 * j)

noncomputable def heisenbergHilbertPolynomial (p : ℕ) : Polynomial ℕ :=
  intervalPolynomial p ^ 2 * weightedIntervalPolynomial p

def heisenbergMonomialWeight (p : ℕ) (j : Fin p × Fin p × Fin p) : ℕ :=
  j.1.val + j.2.1.val + 2 * j.2.2.val

/-- The adjacent-coefficient Hilbert polynomial for the usual
weight-one, weight-one, weight-two Heisenberg monomial basis. Its
identification with an actual group filtration is a separate fact. -/
noncomputable def heisenbergWidthPolynomial (p : ℕ) : Polynomial ℕ :=
  intervalPolynomial p ^ 2 * intervalPolynomial (2 * p)

end Litt3.Deformations
