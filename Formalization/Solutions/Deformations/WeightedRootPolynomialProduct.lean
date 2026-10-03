import Solutions.Deformations.WeightedRootPolynomialBasis

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- Exact multiplication in the original coefficient-field basis of
the untruncated graded algebra, including the literal carry sign. -/
theorem weighted_root_polynomial_basis_product (q : ℕ) (large : 1 < q) (r : ℕ)
    (j l : ℕ) (alpha beta : Fin r → Fin q) :
    weightedRootPolynomialBasis k q large r (j, alpha) *
        weightedRootPolynomialBasis k q large r (l, beta) =
      (-1 : k) ^ (∑ i, rootNormalCarry q (alpha i) (beta i)) •
        weightedRootPolynomialBasis k q large r
          (j + l + (∑ i, rootNormalCarry q (alpha i) (beta i)),
            fun i => rootNormalProductExponent q large (alpha i) (beta i)) := by
  let t := ∑ i, rootNormalCarry q (alpha i) (beta i)
  let gamma := fun i => rootNormalProductExponent q large (alpha i) (beta i)
  rw [weighted_root_polynomial_basis_apply, weighted_root_polynomial_basis_apply,
    weighted_root_polynomial_basis_apply, smul_mul_assoc, mul_smul_comm,
    weighted_root_normal_basis_product, smul_smul, smul_smul]
  change ((Polynomial.X : Polynomial k) ^ j *
      (Polynomial.X : Polynomial k) ^ l * (-Polynomial.X) ^ t) •
        weightedRootProductBasis (R := Polynomial k) q large Polynomial.X r gamma =
      (-1 : k) ^ t • ((Polynomial.X : Polynomial k) ^ (j + l + t) •
        weightedRootProductBasis (R := Polynomial k) q large Polynomial.X r gamma)
  have scalar : (Polynomial.X : Polynomial k) ^ j *
      (Polynomial.X : Polynomial k) ^ l * (-Polynomial.X) ^ t =
        Polynomial.C ((-1 : k) ^ t) * Polynomial.X ^ (j + l + t) := by
    rw [map_pow, map_neg, map_one, neg_eq_neg_one_mul, mul_pow, pow_add, pow_add]
    ring
  rw [scalar, ← smul_smul]
  exact IsScalarTower.algebraMap_smul (Polynomial k) _ _

end Litt3.Deformations
