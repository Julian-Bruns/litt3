import Definitions.Deformations.QuadraticLinearPolynomial
import Mathlib.Algebra.Polynomial.AlgebraMap
import Mathlib.Tactic

namespace Litt3.Deformations

variable {A : Type*} [CommRing A]

/-- A genuine polynomial coefficient automorphism completes the
square, over every commutative ring whenever a literal half of the
linear coefficient is present. -/
theorem quadratic_polynomial_translation (a b t : A) (half : a = 2 * t) :
    Polynomial.algEquivAevalXAddC (-t) (quadraticLinearPolynomial a b) =
      splitQuadraticPolynomial (b - t ^ 2) := by
  simp only [quadraticLinearPolynomial, map_add, map_mul, map_pow]
  have parameter : Polynomial.algEquivAevalXAddC (-t) Polynomial.X =
      Polynomial.X - Polynomial.C t := by
    simp [Polynomial.algEquivAevalXAddC, Polynomial.algEquivOfCompEqX, sub_eq_add_neg]
  have coefficient : ∀ c : A, Polynomial.algEquivAevalXAddC (-t) (Polynomial.C c) = Polynomial.C c :=
    fun c => (Polynomial.algEquivAevalXAddC (-t)).commutes c
  rw [parameter, coefficient, coefficient, half]
  simp only [splitQuadraticPolynomial, map_mul, map_ofNat, map_sub, map_pow]
  ring

/-- Every actual monic quadratic retains precisely its original
linear and constant coefficients; no presentation is assumed. -/
theorem monic_degree_two_original_polynomial (f : Polynomial A) (monic : f.Monic)
    (degree : f.natDegree = 2) :
    f = quadraticLinearPolynomial (f.coeff 1) (f.coeff 0) := by
  apply Polynomial.ext
  intro i
  rcases i with _ | _ | _ | i
  · simp [quadraticLinearPolynomial]
  · simp [quadraticLinearPolynomial]
  · have leading : f.coeff 2 = 1 := by simpa only [degree] using monic.coeff_natDegree
    simp [quadraticLinearPolynomial, leading]
  · have vanishing : f.coeff (i + 3) = 0 := Polynomial.coeff_eq_zero_of_natDegree_lt (by omega)
    simp [quadraticLinearPolynomial, vanishing]

end Litt3.Deformations
