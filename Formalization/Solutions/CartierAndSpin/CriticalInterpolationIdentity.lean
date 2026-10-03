import Solutions.CartierAndSpin.ReducedSourcePolynomials

namespace Litt3.CartierAndSpin

open Polynomial

variable {K : Type*} [Field K]

/-- The genuine reduced quadratic interpolator and exact quotient
identity in the actual source algebra. Arbitrary source characteristic,
nonmonic F and nonreduced source algebras are retained. -/
theorem actual_source_quadratic_interpolator (F D U : K[X]) (hF : F ≠ 0)
    (u : AdjoinRoot F) (hequation : AdjoinRoot.mk F U = u * AdjoinRoot.mk F D) :
    ∃ V2 Q : K[X], V2.degree < F.degree ∧
      AdjoinRoot.mk F V2 = u ^ 2 * AdjoinRoot.mk F D ∧
      U ^ 2 - F * Q = D * V2 := by
  obtain ⟨V2, hV2, _hunique⟩ :=
    source_quotient_reduced_polynomial F hF (u ^ 2 * AdjoinRoot.mk F D)
  have hdvd : F ∣ U ^ 2 - D * V2 := by
    apply AdjoinRoot.mk_eq_zero.mp
    rw [map_sub, map_pow, map_mul, hequation, hV2.2]
    ring
  obtain ⟨Q, hQ⟩ := hdvd
  refine ⟨V2, Q, hV2.1, hV2.2, ?_⟩
  rw [← hQ]
  ring

/-- The exact quotient identity gives the general canonical critical
degree bound without a leading coefficient of D being inverted. -/
theorem critical_interpolation_quotient_degree_bound (F D U V2 Q : K[X])
    (hF : F ≠ 0) (hpositive : 0 < F.natDegree)
    (hV2 : V2.degree < F.degree) (hidentity : U ^ 2 - F * Q = D * V2) :
    Q.natDegree ≤ max (2 * U.natDegree - F.natDegree) (D.natDegree - 1) := by
  by_cases hQ : Q = 0
  · rw [hQ, natDegree_zero]
    exact Nat.zero_le _
  have hVnat : V2.natDegree ≤ F.natDegree - 1 := by
    by_cases hVzero : V2 = 0
    · rw [hVzero, natDegree_zero]
      exact Nat.zero_le _
    · have hlt := natDegree_lt_natDegree hVzero hV2
      omega
  have hproduct : F * Q = U ^ 2 - D * V2 := by
    linear_combination -hidentity
  have hbound : F.natDegree + Q.natDegree ≤
      max (2 * U.natDegree) (D.natDegree + V2.natDegree) := by
    rw [← natDegree_mul hF hQ, hproduct]
    exact (natDegree_sub_le _ _).trans (max_le_max
      (by simp [natDegree_pow, Nat.mul_comm])
      (natDegree_mul_le (p := D) (q := V2)))
  omega

end Litt3.CartierAndSpin
