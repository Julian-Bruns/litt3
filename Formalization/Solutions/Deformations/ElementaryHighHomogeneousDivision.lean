import Solutions.Deformations.ElementaryCriticalHomogeneousDivision
import Solutions.Deformations.ElementaryHomogeneousRatio

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [Field k] [CharP k 5] [Fact (Nat.Prime 5)]

/-- In high weight every actual homogeneous target with zero
original augmentation value has an actual homogeneous quadratic
preimage. This is proved before parameter truncation. -/
theorem elementary_high_homogeneous_division (r d : ℕ) (large : 4 * r + 2 ≤ d)
    (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k 5 (by omega) r d)
    (origin : weightedRootOrigin 5 (by omega) (Polynomial.X : Polynomial k) r Z = 0) :
    ∃ x : weightedRootProduct (Polynomial k) 5 Polynomial.X r,
      x ∈ weightedRootHomogeneousComponent k 5 (by omega) r (d - 2) ∧
      weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x = Z := by
  classical
  let ψ := ZMod.castHom (dvd_refl 5) k
  let evaluate := weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r
  let coordinates := finiteFieldNormalFunctionCoordinates (I := Fin r) (ZMod 5) k ψ
  let g : (Fin r → ZMod 5) → k := fun a => evaluate Z a / q.eval (fun i => ψ (a i))
  let c := coordinates.symm g
  have reconstruct : coordinates c = g := coordinates.apply_symm_apply g
  have support : ∀ alpha : Fin r → Fin 5, c alpha ≠ 0 →
      (∑ i, (alpha i).val) ≤ d - 2 ∧ (∑ i, (alpha i).val) % 4 = (d - 2) % 4 := by
    intro alpha nonzero
    have congruence : (∑ i, (alpha i).val) % 4 = (d - 2) % 4 := by
      apply elementary_normal_character_support ψ c (d - 2)
      · intro u a
        rw [reconstruct]
        exact elementary_homogeneous_ratio_character k ψ r d (by omega) q quadratic Z homogeneous u a
      · exact nonzero
    have upper : (∑ i, (alpha i).val) ≤ 4 * r := by
      calc
        _ ≤ ∑ _ : Fin r, 4 := Finset.sum_le_sum (fun i _ => by have := (alpha i).isLt; omega)
        _ = _ := by simp [Nat.mul_comm]
    exact ⟨by omega, congruence⟩
  let x := elementaryHomogeneousNormalLift k r (d - 2) c
  have homogeneousX : x ∈ weightedRootHomogeneousComponent k 5 (by omega) r (d - 2) :=
    elementary_homogeneous_normal_lift_member k r (d - 2) c support
  have evaluateX : evaluate x = g := by
    funext a
    exact (elementary_homogeneous_normal_lift_evaluation k ψ r (d - 2) c a).trans
      (congrFun reconstruct a)
  refine ⟨x, homogeneousX, ?_⟩
  apply sub_eq_zero.mp
  have zeroTest (w : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
      (member : w ∈ weightedRootHomogeneousComponent k 5 (by omega) r d)
      (zero : evaluate w = 0) : w = 0 := by
    simpa only [ZMod.card] using weighted_root_homogeneous_function_zero (ZMod 5) k ψ r d w member zero
  apply zeroTest
  · apply Submodule.sub_mem _ _ homogeneous
    have weight : 2 + (d - 2) = d := by omega
    rw [← weight]
    exact weighted_root_homogeneous_mul k 5 (by omega) r 2 (d - 2) _ _
      (weighted_root_polynomial_homogeneous k 5 (by omega) r 2 q quadratic) homogeneousX
  · change evaluate
      (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x - Z) = 0
    rw [map_sub]
    funext a
    change evaluate
        (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x) a -
      evaluate Z a = 0
    rw [map_mul, Pi.mul_apply, evaluateX]
    have qEvaluation : evaluate
        (weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q)) a =
        q.eval (fun i => ψ (a i)) := by
      simpa only [ZMod.card] using weighted_root_polynomial_function_polynomial (ZMod 5) k ψ r q a
    rw [qEvaluation]
    by_cases atOrigin : a = 0
    · subst a
      have zero : evaluate Z 0 = 0 := by
        have compare : evaluate Z 0 =
            (weightedRootOrigin 5 (by omega) (Polynomial.X : Polynomial k) r Z).eval (-1) := by
          simpa only [ZMod.card] using weighted_root_polynomial_function_origin (ZMod 5) k ψ r Z
        rw [compare, origin]
        simp
      simp [g, zero]
    · have nonzero := anisotropic a atOrigin
      dsimp [g]
      rw [mul_div_cancel₀ _ nonzero, sub_self]

end Litt3.Deformations
