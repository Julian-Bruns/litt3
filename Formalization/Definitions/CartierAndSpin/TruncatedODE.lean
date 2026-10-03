import Mathlib.Algebra.Polynomial.Derivative
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The exact coefficient recursion for a formal unit solution with
constant coefficient one. Only the first p coefficients will be used. -/
noncomputable def truncatedODECoefficient (F : K[X]) : ℕ → K
  | 0 => 1
  | n + 1 => (n + 1 : K)⁻¹ * ∑ i : Fin (n + 1),
      F.coeff (n - i.val) * truncatedODECoefficient F i.val
termination_by n => n
decreasing_by omega

/-- The literal polynomial of degree below p obtained from the ODE
recursion; no solution or last coefficient equation is stipulated. -/
noncomputable def truncatedODEPolynomial (F : K[X]) (p : ℕ) : K[X] :=
  ∑ i : Fin p, monomial i.val (truncatedODECoefficient F i.val)

end Litt3.CartierAndSpin
