import Solutions.Deformations.ElementaryCriticalPreimageEvaluation
import Solutions.Deformations.ElementaryCriticalExponents
import Solutions.Deformations.WeightedRootPolynomialFunctionCoordinates
import Solutions.Deformations.WeightedRootHomogeneousNormalConstants
import Solutions.Deformations.ElementaryProjectiveDetectors

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization WeightedRootPolynomialScalars

variable (k : Type*) [Field k] [Fact (Nat.Prime 5)]

/-- The literal projective ratio detects the actual constant normal
coefficient of every actual critical homogeneous quadratic preimage.
Its original-coordinate sign is retained exactly. -/
theorem elementary_actual_critical_detector (ψ : ZMod 5 →+* k) (r : ℕ)
    [Fintype (ℙ (ZMod 5) (Fin r → ZMod 5))] (positive : 0 < r)
    (q : MvPolynomial (Fin r) k) (quadratic : q.IsHomogeneous 2)
    (anisotropic : ∀ a : Fin r → ZMod 5, a ≠ 0 → q.eval (fun i => ψ (a i)) ≠ 0)
    (x Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r - 1))
    (preimage : weightedRootPolynomialEvaluation 5 Polynomial.X r (MvPolynomial.map Polynomial.C q) * x = Z)
    (i : Fin r) :
    (∑ P : ℙ (ZMod 5) (Fin r → ZMod 5), ψ (P.rep i) *
      weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r Z P.rep /
        q.eval (fun j => ψ (P.rep j))) =
      (-1 : k) ^ (r + 1) * (weightedRootPolynomialBasis k 5 (by omega) r).repr x
        (0, finiteFieldDetectorExponent (ZMod 5) (by norm_num) i) := by
  classical
  let evaluate := weightedRootPolynomialFunctionEvaluation (ZMod 5) k ψ r
  let c : (Fin r → Fin 5) → k := fun alpha =>
    ((weightedRootProductBasis 5 (by omega) Polynomial.X r).repr x alpha).eval (-1)
  have reconstruction (a : Fin r → ZMod 5) :
      (∑ alpha : Fin r → Fin 5, c alpha * ∏ j, ψ (a j) ^ (alpha j).val) = evaluate x a := by
    symm
    simpa only [ZMod.card] using weighted_root_polynomial_function_normal_coordinates (ZMod 5) k ψ r x a
  have invariant : ∀ (u : (ZMod 5)ˣ) (a : Fin r → ZMod 5),
      ψ (((u : ZMod 5) • a) i) *
        (∑ alpha : Fin r → Fin 5, c alpha * ∏ j, ψ (((u : ZMod 5) • a) j) ^ (alpha j).val) =
      ψ (a i) * (∑ alpha : Fin r → Fin 5, c alpha * ∏ j, ψ (a j) ^ (alpha j).val) := by
    intro u a
    rw [reconstruction, reconstruction]
    have character := weighted_root_homogeneous_function_character (ZMod 5) k ψ r
      (4 * r - 1) x homogeneous u a
    have fourth : ψ (u : ZMod 5) ^ 4 = 1 := by
      simpa only [map_pow, map_one] using congrArg ψ (ZMod.pow_card_sub_one_eq_one u.ne_zero)
    have power : ψ (u : ZMod 5) * ψ u ^ (4 * r - 1) = 1 := by
      rw [← pow_succ', show 4 * r - 1 + 1 = 4 * r by omega, pow_mul, fourth, one_pow]
    change ψ ((u : ZMod 5) * a i) * evaluate x ((u : ZMod 5) • a) = _
    rw [map_mul, character]
    calc
      _ = (ψ u * ψ u ^ (4 * r - 1)) * (ψ (a i) * evaluate x a) := by ring
      _ = _ := by rw [power, one_mul]
  have extraction := elementary_projective_normal_coefficient ψ i c invariant
  have constant : c (finiteFieldDetectorExponent (ZMod 5) (by norm_num) i) =
      (weightedRootPolynomialBasis k 5 (by omega) r).repr x
        (0, finiteFieldDetectorExponent (ZMod 5) (by norm_num) i) := by
    rw [weighted_root_polynomial_basis_coordinate]
    dsimp [c]
    rw [weighted_root_homogeneous_normal_same_weight k 5 (by omega) r (4 * r - 1)
      x homogeneous _ (elementary_detector_exponent_degree r i)]
    simp
  calc
    _ = ∑ P : ℙ (ZMod 5) (Fin r → ZMod 5), ψ (P.rep i) * evaluate x P.rep := by
      apply Finset.sum_congr rfl
      intro P _
      rw [elementary_critical_preimage_evaluation k ψ r positive q quadratic anisotropic
        x Z homogeneous preimage, mul_div_assoc]
    _ = ∑ P : ℙ (ZMod 5) (Fin r → ZMod 5), ψ (P.rep i) *
        (∑ alpha : Fin r → Fin 5, c alpha * ∏ j, ψ (P.rep j) ^ (alpha j).val) := by
      simp only [reconstruction]
    _ = _ := by simpa only [Fintype.card_fin, constant] using extraction

end Litt3.Deformations
