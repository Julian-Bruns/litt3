import Solutions.Deformations.PrimeWeightedPolynomialMoments
import Solutions.Deformations.WeightedRootHomogeneousTruncation
import Solutions.Deformations.WeightedRootPolynomialHomogeneous

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p]

theorem elementary_prime_graded_principal_origin (r a : ℕ) (positive : 0 < a)
    (q : MvPolynomial (Fin r) k) (principal : q.IsHomogeneous a) :
    weightedRootOrigin p (Fact.out : p.Prime).pos (Polynomial.X : Polynomial k) r
      (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q)) = 0 := by
  rw [weighted_root_origin_polynomial, MvPolynomial.eval_map]
  have zero : q.eval (0 : Fin r → k) = 0 :=
    homogeneous_positive_polynomial_origin (RingHom.id k) q a principal positive
  have mapped := MvPolynomial.eval₂_comp (Polynomial.C : k →+* Polynomial k) (0 : Fin r → k) q
  have composed : (Polynomial.C : k →+* Polynomial k) ∘ (0 : Fin r → k) =
      (0 : Fin r → Polynomial k) := by funext i; simp
  rw [composed, zero, map_zero] at mapped
  exact mapped.symm

/-- Full original finite-precision homogeneous kernel threshold,
uniformly in the prime and positive principal degree. -/
theorem elementary_prime_graded_precision_low_kernel (large : 2 < p)
    (r m d a : ℕ) (positive : 0 < m) (precisionBound : m ≤ r)
    (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (small : d < (p - 1) * m - a + 1)
    (q : MvPolynomial (Fin r) k) (principal : q.IsHomogeneous a)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (X : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : X ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d)
    (vanish : weightedRootTruncation k p m positive r
      (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * X) = 0) :
    X = 0 := by
  have first : p - 1 ≤ (p - 1) * m := Nat.le_mul_of_pos_right (p - 1) positive
  have top : (p - 1) * m ≤ (p - 1) * r := Nat.mul_le_mul_left (p - 1) precisionBound
  apply elementary_prime_homogeneous_low_kernel p k large r d (by omega) q anisotropic X homogeneous
  apply weighted_root_homogeneous_truncation_low_zero k p (Fact.out : p.Prime).one_lt
    r m (a + d) positive (by omega)
  · exact weighted_root_homogeneous_mul k p (Fact.out : p.Prime).one_lt r a d _ _
      (weighted_root_polynomial_homogeneous k p (Fact.out : p.Prime).one_lt r a q principal) homogeneous
  · exact vanish
  · rw [map_mul, elementary_prime_graded_principal_origin p k r a principalPositive q principal,
      zero_mul]

theorem elementary_prime_graded_final_precision_low_kernel (large : 2 < p)
    (r d a : ℕ) (principalPositive : 0 < a) (degreeBound : a + 1 ≤ p - 1)
    (small : d < (p - 1) * r)
    (q : MvPolynomial (Fin r) k) (principal : q.IsHomogeneous a)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (X : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : X ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d)
    (vanish : weightedRootTruncation k p (r + 1) (by omega) r
      (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * X) = 0) :
    X = 0 := by
  apply elementary_prime_homogeneous_low_kernel p k large r d small q anisotropic X homogeneous
  apply weighted_root_homogeneous_truncation_low_zero k p (Fact.out : p.Prime).one_lt
    r (r + 1) (a + d) (by omega) (by rw [Nat.mul_add, Nat.mul_one]; omega)
  · exact weighted_root_homogeneous_mul k p (Fact.out : p.Prime).one_lt r a d _ _
      (weighted_root_polynomial_homogeneous k p (Fact.out : p.Prime).one_lt r a q principal) homogeneous
  · exact vanish
  · rw [map_mul, elementary_prime_graded_principal_origin p k r a principalPositive q principal,
      zero_mul]

end Litt3.Deformations
