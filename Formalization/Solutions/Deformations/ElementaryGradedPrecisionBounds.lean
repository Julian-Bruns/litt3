import Solutions.Deformations.WeightedRootHomogeneousTruncation
import Solutions.Deformations.WeightedRootPolynomialHomogeneous
import Solutions.Deformations.ElementaryGradedLowKernel

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (k : Type*) [Field k] [CharP k 5] [Fact (Nat.Prime 5)]

theorem elementary_graded_quadratic_origin (r : ℕ) (q : MvPolynomial (Fin r) k)
    (quadratic : q.IsHomogeneous 2) :
    weightedRootOrigin 5 (by omega) (Polynomial.X : Polynomial k) r
      (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q)) = 0 := by
  rw [weighted_root_origin_polynomial, MvPolynomial.eval_map]
  have zero : q.eval (0 : Fin r → k) = 0 :=
    homogeneous_positive_polynomial_origin (RingHom.id k) q 2 quadratic (by omega)
  have mapped := MvPolynomial.eval₂_comp (Polynomial.C : k →+* Polynomial k) (0 : Fin r → k) q
  have composed : (Polynomial.C : k →+* Polynomial k) ∘ (0 : Fin r → k) =
      (0 : Fin r → Polynomial k) := by funext i; simp
  rw [composed, zero, map_zero] at mapped
  exact mapped.symm

/-- Exact finite-precision homogeneous injectivity at the source
threshold 4m-1, proved in the actual truncated parameter quotient. -/
theorem elementary_graded_precision_low_kernel (r m d : ℕ) (positive : 0 < m)
    (precisionBound : m ≤ r) (small : d < 4 * m - 1)
    (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (x : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k 5 (by omega) r d)
    (vanish : weightedRootTruncation k 5 m positive r
      (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x) = 0) :
    x = 0 := by
  apply elementary_graded_quadratic_low_kernel k r d (by omega) q quadratic anisotropic x homogeneous
  apply weighted_root_homogeneous_truncation_low_zero k 5 (by omega) r m (2 + d) positive (by norm_num; omega)
  · exact weighted_root_homogeneous_mul k 5 (by omega) r 2 d _ _
      (weighted_root_polynomial_homogeneous k 5 (by omega) r 2 q quadratic) homogeneous
  · exact vanish
  · rw [map_mul, elementary_graded_quadratic_origin k r q quadratic, zero_mul]

/-- The final precision r+1 has the sharper source threshold 4r,
without retaining the weaker 4(r+1)-1 bound. -/
theorem elementary_graded_final_precision_low_kernel (r d : ℕ) (small : d < 4 * r)
    (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (x : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k 5 (by omega) r d)
    (vanish : weightedRootTruncation k 5 (r + 1) (by omega) r
      (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x) = 0) :
    x = 0 := by
  apply elementary_graded_quadratic_low_kernel k r d small q quadratic anisotropic x homogeneous
  apply weighted_root_homogeneous_truncation_low_zero k 5 (by omega) r (r + 1) (2 + d) (by omega) (by norm_num; omega)
  · exact weighted_root_homogeneous_mul k 5 (by omega) r 2 d _ _
      (weighted_root_polynomial_homogeneous k 5 (by omega) r 2 q quadratic) homogeneous
  · exact vanish
  · rw [map_mul, elementary_graded_quadratic_origin k r q quadratic, zero_mul]

end Litt3.Deformations
