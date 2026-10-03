import Solutions.Deformations.WeightedRootHomogeneousComponents

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

variable (k : Type*) [CommRing k] [Nontrivial k]

theorem weighted_root_homogeneous_one (q : ℕ) (large : 1 < q) (r : ℕ) :
    (1 : weightedRootProduct (Polynomial k) q Polynomial.X r) ∈
      weightedRootHomogeneousComponent k q large r 0 := by
  letI : NeZero q := ⟨by omega⟩
  have basis := weighted_root_homogeneous_basis_member k q large r
    (0, fun _ => (0 : Fin q))
  simpa only [rootPolynomialWeight, Fin.val_zero, Finset.sum_const_zero, mul_zero, add_zero,
    weighted_root_polynomial_basis_apply, weighted_root_product_basis_apply, pow_zero,
    Finset.prod_const_one, one_smul] using basis

theorem weighted_root_homogeneous_parameter (q : ℕ) (large : 1 < q) (r : ℕ) (i : Fin r) :
    weightedRootProductParameter (Polynomial k) q Polynomial.X r i ∈
      weightedRootHomogeneousComponent k q large r 1 := by
  classical
  letI : NeZero q := ⟨by omega⟩
  let alpha : Fin r → Fin q := Pi.single i ⟨1, large⟩
  have basis := weighted_root_homogeneous_basis_member k q large r (0, alpha)
  have exponent (j : Fin r) : (alpha j).val = if j = i then 1 else 0 := by
    dsimp [alpha]
    by_cases same : j = i <;> simp [Pi.single_apply, same, eq_comm]
  simp only [rootPolynomialWeight, mul_zero, zero_add, exponent] at basis
  rw [Finset.sum_ite_eq', if_pos (Finset.mem_univ i)] at basis
  simpa only [weighted_root_polynomial_basis_apply, pow_zero, one_smul,
    weighted_root_product_basis_apply, exponent, pow_ite, pow_one, pow_zero,
    Finset.prod_ite_eq', if_pos (Finset.mem_univ i)] using basis

theorem weighted_root_homogeneous_scalar (q : ℕ) (large : 1 < q) (r : ℕ) (a : k) :
    algebraMap k (weightedRootProduct (Polynomial k) q Polynomial.X r) a ∈
      weightedRootHomogeneousComponent k q large r 0 := by
  rw [Algebra.algebraMap_eq_smul_one]
  exact Submodule.smul_mem _ a (weighted_root_homogeneous_one k q large r)

theorem weighted_root_homogeneous_pow (q : ℕ) (large : 1 < q) (r d : ℕ)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (homogeneous : x ∈ weightedRootHomogeneousComponent k q large r d) (n : ℕ) :
    x ^ n ∈ weightedRootHomogeneousComponent k q large r (d * n) := by
  induction n with
  | zero => simpa only [pow_zero, mul_zero] using weighted_root_homogeneous_one k q large r
  | succ n induction =>
    rw [pow_succ, Nat.mul_succ]
    exact weighted_root_homogeneous_mul k q large r (d * n) d _ _ induction homogeneous

theorem weighted_root_homogeneous_prod {I : Type*} (q : ℕ) (large : 1 < q) (r : ℕ)
    (s : Finset I) (x : I → weightedRootProduct (Polynomial k) q Polynomial.X r) (d : I → ℕ)
    (homogeneous : ∀ i ∈ s, x i ∈ weightedRootHomogeneousComponent k q large r (d i)) :
    (∏ i ∈ s, x i) ∈ weightedRootHomogeneousComponent k q large r (∑ i ∈ s, d i) := by
  classical
  induction s using Finset.induction_on with
  | empty => simpa only [Finset.prod_empty, Finset.sum_empty] using weighted_root_homogeneous_one k q large r
  | @insert i s outside induction =>
    rw [Finset.prod_insert outside, Finset.sum_insert outside]
    exact weighted_root_homogeneous_mul k q large r _ _ _ _
      (homogeneous i (Finset.mem_insert_self _ _))
      (induction (fun j member => homogeneous j (Finset.mem_insert_of_mem member)))

end Litt3.Deformations
