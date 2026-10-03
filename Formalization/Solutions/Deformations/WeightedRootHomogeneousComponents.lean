import Solutions.Deformations.WeightedRootPolynomialProduct

namespace Litt3.Deformations

open scoped BigOperators WeightedRootPolynomialScalars

def rootPolynomialWeight (q r : ℕ) (index : ℕ × (Fin r → Fin q)) : ℕ :=
  (q - 1) * index.1 + ∑ i, (index.2 i).val

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- The genuine homogeneous component is the span of the actual
original monomial basis of the specified exact weight. -/
noncomputable def weightedRootHomogeneousComponent (q : ℕ) (large : 1 < q) (r d : ℕ) :
    Submodule k (weightedRootProduct (Polynomial k) q Polynomial.X r) :=
  Submodule.span k ((weightedRootPolynomialBasis k q large r) ''
    {index | rootPolynomialWeight q r index = d})

theorem weighted_root_homogeneous_membership (q : ℕ) (large : 1 < q) (r d : ℕ)
    (x : weightedRootProduct (Polynomial k) q Polynomial.X r) :
    x ∈ weightedRootHomogeneousComponent k q large r d ↔
      ∀ index, (weightedRootPolynomialBasis k q large r).repr x index ≠ 0 →
        rootPolynomialWeight q r index = d := by
  classical
  rw [weightedRootHomogeneousComponent, Module.Basis.mem_span_image]
  simp only [Set.subset_def, Finset.mem_coe, Finsupp.mem_support_iff, Set.mem_setOf_eq]

theorem weighted_root_homogeneous_basis_member (q : ℕ) (large : 1 < q) (r : ℕ)
    (index : ℕ × (Fin r → Fin q)) :
    weightedRootPolynomialBasis k q large r index ∈
      weightedRootHomogeneousComponent k q large r (rootPolynomialWeight q r index) := by
  exact Submodule.subset_span ⟨index, rfl, rfl⟩

/-- Different actual homogeneous components have zero intersection,
proved from the genuine original coordinates. -/
theorem weighted_root_homogeneous_disjoint (q : ℕ) (large : 1 < q) (r m n : ℕ)
    (different : m ≠ n) (x : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (left : x ∈ weightedRootHomogeneousComponent k q large r m)
    (right : x ∈ weightedRootHomogeneousComponent k q large r n) : x = 0 := by
  classical
  apply (weightedRootPolynomialBasis k q large r).repr.injective
  ext index
  rw [map_zero, Finsupp.zero_apply]
  by_contra nonzero
  exact different (((weighted_root_homogeneous_membership k q large r m x).mp left index nonzero).symm.trans
    ((weighted_root_homogeneous_membership k q large r n x).mp right index nonzero))

/-- The actual span components multiply in the sum of their weights;
the grading is established from literal quotient multiplication. -/
theorem weighted_root_homogeneous_mul (q : ℕ) (large : 1 < q) (r m n : ℕ)
    (x y : weightedRootProduct (Polynomial k) q Polynomial.X r)
    (left : x ∈ weightedRootHomogeneousComponent k q large r m)
    (right : y ∈ weightedRootHomogeneousComponent k q large r n) :
    x * y ∈ weightedRootHomogeneousComponent k q large r (m + n) := by
  classical
  refine Submodule.span_induction₂ (p := fun x y _ _ =>
    x * y ∈ weightedRootHomogeneousComponent k q large r (m + n))
    ?_ ?_ ?_ ?_ ?_ ?_ ?_ left right
  · rintro _ _ ⟨⟨j, alpha⟩, degreeLeft, rfl⟩ ⟨⟨l, beta⟩, degreeRight, rfl⟩
    rw [weighted_root_polynomial_basis_product]
    apply Submodule.smul_mem
    have degree : rootPolynomialWeight q r
        (j + l + (∑ i, rootNormalCarry q (alpha i) (beta i)),
          fun i => rootNormalProductExponent q large (alpha i) (beta i)) = m + n := by
      have carry := weighted_root_normal_product_weight q large r alpha beta
      dsimp [rootPolynomialWeight] at degreeLeft degreeRight ⊢
      simp only [Nat.mul_add]
      omega
    exact Submodule.subset_span ⟨_, degree, rfl⟩
  · intro y _; simpa only [zero_mul] using (weightedRootHomogeneousComponent k q large r (m + n)).zero_mem
  · intro x _; simpa only [mul_zero] using (weightedRootHomogeneousComponent k q large r (m + n)).zero_mem
  · intro x y z _ _ _ hx hy
    rw [add_mul]
    exact Submodule.add_mem _ hx hy
  · intro x y z _ _ _ hy hz
    rw [mul_add]
    exact Submodule.add_mem _ hy hz
  · intro a x y _ _ h
    rw [smul_mul_assoc]
    exact Submodule.smul_mem _ a h
  · intro a x y _ _ h
    rw [mul_smul_comm]
    exact Submodule.smul_mem _ a h

end Litt3.Deformations
