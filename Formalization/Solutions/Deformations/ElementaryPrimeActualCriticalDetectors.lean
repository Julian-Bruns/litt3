import Solutions.Deformations.PrimeProjectiveDetectors
import Solutions.Deformations.ElementaryPrimeCriticalExponents
import Solutions.Deformations.PrimeWeightedPolynomialMoments
import Solutions.Deformations.WeightedRootHomogeneousNormalConstants

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization WeightedRootPolynomialScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p]

/-- The literal projective ratio extracts the actual unchanged critical normal
coefficient, with its exact sign, for every original prime. -/
theorem elementary_prime_actual_critical_detector (large : 2 < p)
    (ψ : ZMod p →+* k) (r : ℕ)
    [Fintype (ℙ (ZMod p) (Fin r → ZMod p))] (positive : 0 < r)
    (q : MvPolynomial (Fin r) k)
    (anisotropic : ∀ v : Fin r → ZMod p, v ≠ 0 → q.eval (fun i => ψ (v i)) ≠ 0)
    (x Z : weightedRootProduct (Polynomial k) p Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k p
      (Fact.out : p.Prime).one_lt r ((p - 1) * r - 1))
    (preimage : weightedRootPolynomialEvaluation p Polynomial.X r
      (MvPolynomial.map Polynomial.C q) * x = Z) (i : Fin r) :
    (∑ P : ℙ (ZMod p) (Fin r → ZMod p), ψ (P.rep i) *
      primeWeightedPolynomialFunction p k ψ r Z P.rep / q.eval (fun j => ψ (P.rep j))) =
      (-1 : k) ^ (r + 1) *
        (weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r).repr x
          (0, primeDetectorExponent p large i) := by
  classical
  let evaluate := primeWeightedPolynomialFunction p k ψ r
  let B := weightedRootProductBasis p (Fact.out : p.Prime).one_lt (Polynomial.X : Polynomial k) r
  let c : (Fin r → Fin p) → k := fun alpha => (B.repr x alpha).eval (-1)
  have reconstruction (v : Fin r → ZMod p) :
      (∑ alpha : Fin r → Fin p, c alpha * ∏ j, ψ (v j) ^ (alpha j).val) = evaluate x v := by
    have equality := congrArg (fun z => evaluate z v) (B.sum_repr x)
    dsimp only at equality
    rw [map_sum, Finset.sum_apply] at equality
    simpa only [evaluate, B, c, Algebra.smul_def, map_mul, Pi.mul_apply,
      prime_weighted_polynomial_function_coefficient,
      prime_weighted_polynomial_normal_basis] using equality
  have weightPositive : 0 < p - 1 := by omega
  have topPositive : 0 < (p - 1) * r := Nat.mul_pos weightPositive positive
  have invariant : ∀ (u : (ZMod p)ˣ) (v : Fin r → ZMod p),
      ψ (((u : ZMod p) • v) i) *
        (∑ alpha : Fin r → Fin p, c alpha * ∏ j, ψ (((u : ZMod p) • v) j) ^ (alpha j).val) =
      ψ (v i) * (∑ alpha : Fin r → Fin p, c alpha * ∏ j, ψ (v j) ^ (alpha j).val) := by
    intro u v
    rw [reconstruction, reconstruction]
    have character := prime_weighted_homogeneous_function_character p k ψ r
      ((p - 1) * r - 1) x homogeneous u v
    have order : ψ (u : ZMod p) ^ (p - 1) = 1 := by
      simpa only [map_pow, map_one] using congrArg ψ (ZMod.pow_card_sub_one_eq_one u.ne_zero)
    have power : ψ (u : ZMod p) * ψ u ^ ((p - 1) * r - 1) = 1 := by
      rw [← pow_succ', Nat.sub_add_cancel topPositive, pow_mul, order, one_pow]
    change ψ ((u : ZMod p) * v i) * evaluate x ((u : ZMod p) • v) = _
    rw [map_mul, character]
    calc
      _ = (ψ u * ψ u ^ ((p - 1) * r - 1)) * (ψ (v i) * evaluate x v) := by ring
      _ = _ := by rw [power, one_mul]
  have extraction := prime_projective_normal_coefficient p large ψ i c invariant
  have constant : c (primeDetectorExponent p large i) =
      (weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r).repr x
        (0, primeDetectorExponent p large i) := by
    rw [weighted_root_polynomial_basis_coordinate]
    dsimp [c, B]
    rw [weighted_root_homogeneous_normal_same_weight k p (Fact.out : p.Prime).one_lt r
      ((p - 1) * r - 1) x homogeneous _ (elementary_prime_detector_exponent_degree p large r i)]
    simp
  have quotient (P : ℙ (ZMod p) (Fin r → ZMod p)) :
      evaluate x P.rep = evaluate Z P.rep / q.eval (fun j => ψ (P.rep j)) := by
    apply (eq_div_iff (anisotropic P.rep P.rep_nonzero)).mpr
    have evaluated := congrArg (fun z => evaluate z P.rep) preimage
    dsimp only at evaluated
    rw [map_mul, Pi.mul_apply, prime_weighted_polynomial_function_polynomial] at evaluated
    simpa only [mul_comm] using evaluated
  calc
    _ = ∑ P : ℙ (ZMod p) (Fin r → ZMod p), ψ (P.rep i) * evaluate x P.rep := by
      apply Finset.sum_congr rfl
      intro P _
      rw [quotient, mul_div_assoc]
    _ = ∑ P : ℙ (ZMod p) (Fin r → ZMod p), ψ (P.rep i) *
        (∑ alpha : Fin r → Fin p, c alpha * ∏ j, ψ (P.rep j) ^ (alpha j).val) := by
      simp only [reconstruction]
    _ = _ := by simpa only [Fintype.card_fin, constant] using extraction

end Litt3.Deformations
