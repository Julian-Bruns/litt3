import Definitions.CartierAndSpin.ShiftedMatrixPencils
import Mathlib.Algebra.MvPolynomial.Eval

namespace Litt3.CartierAndSpin

noncomputable section

open scoped BigOperators

variable {R σ n : Type*} [CommRing R] [Fintype σ]

/-- A genuine homogeneous linear polynomial matrix from arbitrary
coefficient matrices; all variables and all coefficients are retained. -/
def linearPolynomialMatrix (coeff : σ → Matrix n n R) : Matrix n n (MvPolynomial σ R) :=
  fun i j => ∑ r : σ, MvPolynomial.C (coeff r i j) * MvPolynomial.X r

/-- Its actual geometric fiber under literal polynomial evaluation. -/
def linearMatrixFiber (coeff : σ → Matrix n n R) (z : σ → R) : Matrix n n R :=
  (linearPolynomialMatrix coeff).map (MvPolynomial.eval z)

end

end Litt3.CartierAndSpin
