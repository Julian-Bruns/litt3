import Solutions.Deformations.ElementaryPrimeHomogeneousNormalLift
import Solutions.Deformations.PrimeWeightedPolynomialOrigin
import Solutions.Deformations.ElementaryPrimeHomogeneousRatio

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p]

/-- Near the top original normal weight every actual homogeneous target with zero
original augmentation value has an actual homogeneous principal
preimage. This is proved before parameter truncation. -/
theorem elementary_prime_near_top_homogeneous_division (r d a : ℕ) (degreeBound : a ≤ d)
    (sourceBound : (p - 1) * r - 1 ≤ d - a)
    (sourceNonzero : (d - a) % (p - 1) ≠ 0)
    (q : MvPolynomial (Fin r) k) (principal : q.IsHomogeneous a)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0)
    (Z : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d)
    (origin : weightedRootOrigin p (Fact.out : p.Prime).pos (Polynomial.X : Polynomial k) r Z = 0) :
    ∃ x : weightedRootProduct (Polynomial k) p Polynomial.X r,
      x ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r (d - a) ∧
      weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * x = Z := by
  classical
  let ψ := ZMod.castHom (dvd_refl p) k
  let evaluate := primeWeightedPolynomialFunction p k ψ r
  let coordinates := primeNormalFunctionCoordinates (I := Fin r) p k ψ
  let g : (Fin r → ZMod p) → k := fun v => evaluate Z v / q.eval (fun i => ψ (v i))
  let c := coordinates.symm g
  have reconstruct : coordinates c = g := coordinates.apply_symm_apply g
  have support : ∀ alpha : Fin r → Fin p, c alpha ≠ 0 →
      (∑ i, (alpha i).val) ≤ d - a ∧ (∑ i, (alpha i).val) % (p - 1) = (d - a) % (p - 1) := by
    intro alpha nonzero
    have congruence : (∑ i, (alpha i).val) % (p - 1) = (d - a) % (p - 1) := by
      apply prime_normal_character_support p k ψ c (d - a)
      · intro u v
        rw [reconstruct]
        exact elementary_prime_homogeneous_ratio_character p k ψ r d a (by omega) q principal Z homogeneous u v
      · exact nonzero
    have upper : (∑ i, (alpha i).val) ≤ (p - 1) * r := by
      calc
        _ ≤ ∑ _ : Fin r, (p - 1) := Finset.sum_le_sum (fun i _ => by have := (alpha i).isLt; omega)
        _ = _ := by simp [Nat.mul_comm]
    have notTop : (∑ i, (alpha i).val) ≠ (p - 1) * r := by
      intro equality
      apply sourceNonzero
      rw [← congruence, equality, Nat.mul_mod_right]
    exact ⟨by omega, congruence⟩
  let x := elementaryPrimeHomogeneousNormalLift p k r (d - a) c
  have homogeneousX : x ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r (d - a) :=
    elementary_prime_homogeneous_normal_lift_member p k r (d - a) c support
  have evaluateX : evaluate x = g := by
    funext v
    exact (elementary_prime_homogeneous_normal_lift_evaluation p k ψ r (d - a) c v).trans
      (congrFun reconstruct v)
  refine ⟨x, homogeneousX, ?_⟩
  apply sub_eq_zero.mp
  have zeroTest (w : weightedRootProduct (Polynomial k) p Polynomial.X r)
      (member : w ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r d)
      (zero : evaluate w = 0) : w = 0 := by
    exact prime_weighted_homogeneous_function_zero p k ψ r d w member zero
  apply zeroTest
  · apply Submodule.sub_mem _ _ homogeneous
    have weight : a + (d - a) = d := by omega
    rw [← weight]
    exact weighted_root_homogeneous_mul k p (Fact.out : p.Prime).one_lt r a (d - a) _ _
      (weighted_root_polynomial_homogeneous k p (Fact.out : p.Prime).one_lt r a q principal) homogeneousX
  · change evaluate
      (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * x - Z) = 0
    rw [map_sub]
    funext v
    change evaluate
        (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * x) v -
      evaluate Z v = 0
    rw [map_mul, Pi.mul_apply, evaluateX]
    have qEvaluation : evaluate
        (weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q)) v =
        q.eval (fun i => ψ (v i)) := by
      exact prime_weighted_polynomial_function_polynomial p k ψ r q v
    rw [qEvaluation]
    by_cases atOrigin : v = 0
    · subst v
      have zero : evaluate Z 0 = 0 := by
        have compare : evaluate Z 0 =
            (weightedRootOrigin p (Fact.out : p.Prime).pos (Polynomial.X : Polynomial k) r Z).eval (-1) := by
          exact prime_weighted_polynomial_function_origin p k ψ r Z
        rw [compare, origin]
        simp
      simp [g, zero]
    · have nonzero := anisotropic v atOrigin
      dsimp [g]
      rw [mul_div_cancel₀ _ nonzero, sub_self]

end Litt3.Deformations
