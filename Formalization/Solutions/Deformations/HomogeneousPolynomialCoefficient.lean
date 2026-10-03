import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.Algebra.Polynomial.Degree.Lemmas
import Mathlib.Algebra.Polynomial.Coeff

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [IsDomain R]

/-- A polynomial whose nonzero parameter coefficients all have the
same positive weighted degree is a single monomial; evaluation at a
nonzero parameter is therefore injective on that exact component. -/
theorem homogeneous_parameter_evaluation_zero (p : Polynomial R) (w offset d : ℕ)
    (positive : 0 < w)
    (homogeneous : ∀ j, p.coeff j ≠ 0 → w * j + offset = d)
    (c : R) (nonzero : c ≠ 0) (vanish : p.eval c = 0) : p = 0 := by
  classical
  by_contra polynomialNonzero
  have top : p.coeff p.natDegree ≠ 0 := by
    rw [Polynomial.coeff_natDegree]
    exact Polynomial.leadingCoeff_ne_zero.mpr polynomialNonzero
  have monomial : p = Polynomial.monomial p.natDegree (p.coeff p.natDegree) := by
    apply Polynomial.ext
    intro j
    by_cases same : j = p.natDegree
    · simp [same]
    · have zero : p.coeff j = 0 := by
        by_contra nonzeroCoefficient
        have degree := (homogeneous j nonzeroCoefficient).trans (homogeneous p.natDegree top).symm
        have product : w * j = w * p.natDegree := Nat.add_right_cancel degree
        exact same (Nat.eq_of_mul_eq_mul_left positive product)
      have reverse : p.natDegree ≠ j := by intro h; exact same h.symm
      simp only [Polynomial.coeff_monomial, if_neg reverse, zero]
  rw [monomial, Polynomial.eval_monomial] at vanish
  exact (mul_ne_zero top (pow_ne_zero p.natDegree nonzero)) vanish

end Litt3.Deformations
