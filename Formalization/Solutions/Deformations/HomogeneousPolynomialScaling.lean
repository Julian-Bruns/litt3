import Mathlib.RingTheory.MvPolynomial.Homogeneous
import Mathlib.Algebra.MvPolynomial.Eval

namespace Litt3.Deformations

open scoped BigOperators

variable {I R S : Type*} [Fintype I] [CommSemiring R] [CommSemiring S]

/-- Literal evaluation of a homogeneous polynomial commutes with
uniform scaling, over arbitrary commutative coefficient semirings. -/
theorem homogeneous_polynomial_evaluation_scale (φ : R →+* S) (p : MvPolynomial I R)
    (n : ℕ) (homogeneous : p.IsHomogeneous n) (c : S) (a : I → S) :
    p.eval₂ φ (fun i => c * a i) = c ^ n * p.eval₂ φ a := by
  classical
  rw [MvPolynomial.eval₂_eq', MvPolynomial.eval₂_eq', Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro alpha member
  have degree := homogeneous (MvPolynomial.mem_support_iff.mp member)
  change (Finsupp.weight (fun _ : I => (1 : ℕ))) alpha = n at degree
  rw [← Finsupp.degree_eq_weight_one, Finsupp.degree_eq_sum] at degree
  simp only [mul_pow, Finset.prod_mul_distrib]
  rw [Finset.prod_pow_eq_pow_sum]
  rw [degree]
  ac_rfl

theorem homogeneous_positive_polynomial_origin (φ : R →+* S) (p : MvPolynomial I R)
    (n : ℕ) (homogeneous : p.IsHomogeneous n) (positive : 0 < n) :
    p.eval₂ φ (0 : I → S) = 0 := by
  have scaling := homogeneous_polynomial_evaluation_scale φ p n homogeneous (0 : S) (0 : I → S)
  simpa only [zero_mul, Pi.zero_apply, zero_pow (Nat.ne_of_gt positive)] using scaling

end Litt3.Deformations
