import Theorems.QuotientGeometry.HomogeneousEvaluation
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

theorem homogeneous_evaluation_scaling
    {R S σ : Type*} [CommSemiring R] [CommSemiring S] [Fintype σ]
    (H : MvPolynomial σ R) (n : ℕ) (hH : H.IsHomogeneous n)
    (coefficients : R →+* S) (values : σ → S) (scalar : S) :
    H.eval₂ coefficients (fun i => scalar * values i) =
      scalar ^ n * H.eval₂ coefficients values := by
  classical
  rw [MvPolynomial.eval₂_eq', MvPolynomial.eval₂_eq', Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d hd
  have hdegree : ∑ i, d i = n := by
    rw [← Finsupp.degree_eq_sum, Finsupp.degree_eq_weight_one]
    exact hH (MvPolynomial.mem_support_iff.mp hd)
  simp only [mul_pow, Finset.prod_mul_distrib, Finset.prod_pow_eq_pow_sum, hdegree]
  ac_rfl

theorem homogeneous_evaluation_scaling_target : Targets.HomogeneousEvaluationScaling := by
  intro R S σ instR instS instFintype H n hH coefficients values scalar
  exact homogeneous_evaluation_scaling H n hH coefficients values scalar

end Litt3.QuotientGeometry
