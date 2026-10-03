import Solutions.Deformations.WeightedRootTruncation
import Solutions.Deformations.WeightedRootPolynomialBasis

namespace Litt3.Deformations

open scoped WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

theorem weighted_root_polynomial_basis_truncation_zero (q : ℕ) (large : 1 < q)
    (N : ℕ) (positive : 0 < N) (r j : ℕ) (terminal : N ≤ j) (alpha : Fin r → Fin q) :
    weightedRootTruncation k q N positive r (weightedRootPolynomialBasis k q large r (j, alpha)) = 0 := by
  classical
  rw [weighted_root_truncation_kernel k q large N positive r]
  intro beta
  rw [weighted_root_polynomial_basis_apply, map_smul, Finsupp.smul_apply,
    Module.Basis.repr_self, smul_eq_mul]
  by_cases same : alpha = beta
  · subst beta
    simp only [Finsupp.single_eq_same, mul_one]
    exact pow_dvd_pow Polynomial.X terminal
  · simp [Finsupp.single_apply, same, Ne.symm same]

end Litt3.Deformations
