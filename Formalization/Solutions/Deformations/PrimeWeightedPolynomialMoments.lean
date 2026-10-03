import Solutions.Deformations.PrimeWeightedPolynomialPolynomials
import Solutions.Deformations.FiniteFieldMoments
import Solutions.Deformations.ElementaryGradedLowKernel

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k]

theorem prime_weighted_polynomial_normal_basis (ψ : ZMod p →+* k) (r : ℕ)
    (alpha : Fin r → Fin p) (a : Fin r → ZMod p) :
    primeWeightedPolynomialFunction p k ψ r
      (weightedRootProductBasis p (Fact.out : p.Prime).one_lt (Polynomial.X : Polynomial k) r alpha) a =
        ∏ i, ψ (a i) ^ (alpha i).val := by
  rw [weighted_root_product_basis_apply, map_prod]
  simp only [map_pow, Finset.prod_apply, Pi.pow_apply, prime_weighted_polynomial_function_parameter]

/-- The whole original finite-field moment detects exactly the top
unchanged normal coefficient, with its literal parameter evaluated at -1. -/
theorem prime_weighted_polynomial_function_sum (large : 2 < p)
    (ψ : ZMod p →+* k) (r : ℕ)
    (X : weightedRootProduct (Polynomial k) p Polynomial.X r) :
    (∑ a : Fin r → ZMod p, primeWeightedPolynomialFunction p k ψ r X a) =
      (-1 : k) ^ r *
        ((weightedRootProductBasis p (Fact.out : p.Prime).one_lt Polynomial.X r).repr X
          (weightedRootTopExponent p (Fact.out : p.Prime).one_lt r)).eval (-1) := by
  classical
  let B := weightedRootProductBasis p (Fact.out : p.Prime).one_lt (Polynomial.X : Polynomial k) r
  let top := weightedRootTopExponent p (Fact.out : p.Prime).one_lt r
  have largeCard : 2 < Fintype.card (ZMod p) := by simpa only [ZMod.card] using large
  have moment (alpha : Fin r → Fin p) :
      (∑ a : Fin r → ZMod p, ∏ i, ψ (a i) ^ (alpha i).val) =
        if alpha = top then (-1 : k) ^ r else 0 := by
    have original := finite_field_monomial_sum_map (ZMod p) ψ largeCard
      (fun i => (alpha i).val) (fun i => by
        rw [ZMod.card]
        exact Nat.le_of_lt (alpha i).isLt)
    have condition : (∀ i, (alpha i).val = p - 1) ↔ alpha = top := by
      constructor
      · intro equal
        ext i
        exact equal i
      · intro equal
        subst alpha
        intro i
        rfl
    simpa only [ZMod.card, condition, Fintype.card_fin] using original
  calc
    _ = ∑ a : Fin r → ZMod p, ∑ alpha : Fin r → Fin p,
        (B.repr X alpha).eval (-1) * ∏ i, ψ (a i) ^ (alpha i).val := by
      apply Finset.sum_congr rfl
      intro a _
      have equality := congrArg (fun z => primeWeightedPolynomialFunction p k ψ r z a) (B.sum_repr X)
      dsimp only at equality
      rw [map_sum, Finset.sum_apply] at equality
      simpa only [B, Algebra.smul_def, map_mul, Pi.mul_apply,
        prime_weighted_polynomial_function_coefficient,
        prime_weighted_polynomial_normal_basis] using equality.symm
    _ = ∑ alpha : Fin r → Fin p, (B.repr X alpha).eval (-1) *
        (∑ a : Fin r → ZMod p, ∏ i, ψ (a i) ^ (alpha i).val) := by
      rw [Finset.sum_comm]
      simp only [Finset.mul_sum]
    _ = _ := by simp [moment, B, top, mul_comm]

/-- Below the actual norm weight, anisotropy gives injectivity directly
from unchanged finite-field moments and genuine homogeneous specialization. -/
theorem elementary_prime_homogeneous_low_kernel (large : 2 < p)
    [CharP k p] (r d : ℕ) (small : d < (p - 1) * r)
    (q : MvPolynomial (Fin r) k)
    (anisotropic : ∀ a : Fin r → ZMod p, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (a i)) ≠ 0)
    (X : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : X ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d)
    (vanish : weightedRootPolynomialEvaluation p Polynomial.X r
      (MvPolynomial.map Polynomial.C q) * X = 0) : X = 0 := by
  classical
  let ψ := ZMod.castHom (dvd_refl p) k
  let evaluate := primeWeightedPolynomialFunction p k ψ r
  have outside : ∀ a : Fin r → ZMod p, a ≠ 0 → evaluate X a = 0 := by
    intro a nonzero
    have image := congrArg (fun z => evaluate z a) vanish
    dsimp only at image
    rw [map_mul, Pi.mul_apply, prime_weighted_polynomial_function_polynomial,
      map_zero, Pi.zero_apply] at image
    exact (mul_eq_zero.mp image).resolve_left (anisotropic a nonzero)
  have moment := prime_weighted_polynomial_function_sum p k large ψ r X
  rw [weighted_root_homogeneous_top_coordinate_zero k p (Fact.out : p.Prime).one_lt
    r d small X homogeneous, Polynomial.eval_zero, mul_zero] at moment
  have atOrigin : evaluate X 0 = 0 := by
    have sum : (∑ a : Fin r → ZMod p, evaluate X a) = evaluate X 0 := by
      apply Finset.sum_eq_single
      · intro a _ nonzero
        exact outside a nonzero
      · simp
    exact sum.symm.trans moment
  apply prime_weighted_homogeneous_function_zero p k ψ r d X homogeneous
  funext a
  by_cases origin : a = 0
  · subst a
    exact atOrigin
  · exact outside a origin

end Litt3.Deformations
