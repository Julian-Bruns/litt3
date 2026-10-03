import Solutions.Deformations.ElementaryCriticalQuotientCharacter
import Solutions.Deformations.ElementaryHomogeneousNormalLift
import Solutions.Deformations.WeightedRootHomogeneousOrigin
import Solutions.Deformations.WeightedRootPolynomialFunctionOrigin

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [Field k] [CharP k 5] [Fact (Nat.Prime 5)]

/-- Genuine homogeneous division at the critical source weight is
constructed by actual original finite-field interpolation. -/
theorem elementary_critical_homogeneous_division (r : ℕ) (positive : 0 < r)
    (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 →
      q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0)
    (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : Z ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r + 1)) :
    ∃ x : weightedRootProduct (Polynomial k) 5 Polynomial.X r,
      x ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r - 1) ∧
      weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x = Z := by
  classical
  let ψ := ZMod.castHom (dvd_refl 5) k
  let evaluate := weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r
  let coordinates := finiteFieldNormalFunctionCoordinates (I := Fin r) (ZMod 5) k ψ
  let g : (Fin r → ZMod 5) → k := fun a => evaluate Z a / q.eval (fun i => ψ (a i))
  let c := coordinates.symm g
  have reconstruct : coordinates c = g := coordinates.apply_symm_apply g
  have support : ∀ alpha : Fin r → Fin 5, c alpha ≠ 0 →
      (∑ i, (alpha i).val) ≤ 4 * r - 1 ∧
        (∑ i, (alpha i).val) % 4 = (4 * r - 1) % 4 := by
    intro alpha nonzero
    have congruence : (∑ i, (alpha i).val) % 4 = 3 := by
      apply elementary_normal_character_support ψ c 3
      · intro u a
        rw [reconstruct]
        exact elementary_actual_critical_ratio_character k ψ r q quadratic Z homogeneous u a
      · exact nonzero
    have upper : (∑ i, (alpha i).val) ≤ 4 * r := by
      calc
        _ ≤ ∑ _ : Fin r, 4 := Finset.sum_le_sum (fun i _ => by have := (alpha i).isLt; omega)
        _ = _ := by simp [Nat.mul_comm]
    constructor <;> omega
  let x := elementaryHomogeneousNormalLift k r (4 * r - 1) c
  have homogeneousX : x ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r - 1) :=
    elementary_homogeneous_normal_lift_member k r (4 * r - 1) c support
  have evaluateX : evaluate x = g := by
    funext a
    exact (elementary_homogeneous_normal_lift_evaluation k ψ r (4 * r - 1) c a).trans
      (congrFun reconstruct a)
  refine ⟨x, homogeneousX, ?_⟩
  apply sub_eq_zero.mp
  have zeroTest (w : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
      (member : w ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r + 1))
      (zero : evaluate w = 0) : w = 0 := by
    simpa only [ZMod.card] using weighted_root_homogeneous_function_zero (ZMod 5) k ψ r
      (4 * r + 1) w member zero
  apply zeroTest
  · apply Submodule.sub_mem _ _ homogeneous
    have weight : 2 + (4 * r - 1) = 4 * r + 1 := by omega
    rw [← weight]
    exact weighted_root_homogeneous_mul k 5 (by omega) r 2 (4 * r - 1) _ _
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
    by_cases origin : a = 0
    · subst a
      have zero : evaluate Z 0 = 0 := by
        have compare : evaluate Z 0 =
            (weightedRootOrigin 5 (by omega) (Polynomial.X : Polynomial k) r Z).eval (-1) := by
          simpa only [ZMod.card] using weighted_root_polynomial_function_origin (ZMod 5) k ψ r Z
        rw [compare]
        have actualOrigin := weighted_root_homogeneous_origin_zero k 5 (by omega) r
          (4 * r + 1) (by omega) Z homogeneous
        rw [actualOrigin]
        simp
      simp [g, zero]
    · have nonzero := anisotropic a origin
      dsimp [g]
      rw [mul_div_cancel₀ _ nonzero, sub_self]

end Litt3.Deformations
