import Theorems.Deformations.TruncatedTensorRadical
import Solutions.Deformations.TruncatedTensorBasis
import Solutions.Deformations.AugmentationBasisKernel
import Solutions.Deformations.WeightedAlgebraWidth
import Solutions.Deformations.RadicalPowerFiltration
import Mathlib.RingTheory.Ideal.Maximal

namespace Litt3.Deformations

open scoped TensorProduct

variable {k : Type*} [Field k]

theorem commutative_nilpotent_mem_jacobson {A : Type*} [CommRing A]
    (x : A) (nilpotent : IsNilpotent x) : x ∈ Ring.jacobson A := by
  rw [Ring.jacobson_eq_sInf_isMaximal]
  apply Submodule.mem_sInf.mpr
  intro I hI
  obtain ⟨n, hn⟩ := nilpotent
  apply hI.isPrime.mem_of_pow_mem n
  rw [hn]
  exact I.zero_mem

theorem truncated_tensor_residue_monomial (N M : ℕ) (positiveN : 0 < N) (positiveM : 0 < M)
    (ij : Fin N × Fin M) :
    truncatedTensorResidue (k := k) N M positiveN positiveM (truncatedTensorMonomialBasis k N M ij) =
      if ij = (⟨0, positiveN⟩, ⟨0, positiveM⟩) then 1 else 0 := by
  rw [truncated_tensor_monomial_basis_apply]
  simp only [truncatedTensorResidue, Algebra.TensorProduct.lift_tmul, map_pow]
  change (truncatedResidue k N positiveN (truncatedParameter k N)) ^ ij.1.val *
    (truncatedResidue k M positiveM (truncatedParameter k M)) ^ ij.2.val = _
  rw [truncated_residue_parameter, truncated_residue_parameter]
  by_cases hi : ij.1.val = 0 <;> by_cases hj : ij.2.val = 0
  · have heq : ij = (⟨0, positiveN⟩, ⟨0, positiveM⟩) := Prod.ext (Fin.ext hi) (Fin.ext hj)
    simp [heq]
  · have heq : ij ≠ (⟨0, positiveN⟩, ⟨0, positiveM⟩) := by
      intro h; exact hj (congrArg (fun x : Fin N × Fin M => x.2.val) h)
    simp [hi, hj, heq]
  · have heq : ij ≠ (⟨0, positiveN⟩, ⟨0, positiveM⟩) := by
      intro h; exact hi (congrArg (fun x : Fin N × Fin M => x.1.val) h)
    simp [hi, hj, heq]
  · have heq : ij ≠ (⟨0, positiveN⟩, ⟨0, positiveM⟩) := by
      intro h; exact hi (congrArg (fun x : Fin N × Fin M => x.1.val) h)
    simp [hi, hj, heq]

theorem truncated_tensor_residue_kernel_weighted (N M : ℕ)
    (positiveN : 0 < N) (positiveM : 0 < M) :
    LinearMap.ker (truncatedTensorResidue (k := k) N M positiveN positiveM).toLinearMap =
      weightedBasisFiltration (truncatedTensorMonomialBasis k N M) truncatedTensorMonomialWeight 1 := by
  classical
  have h := augmentation_basis_kernel (truncatedTensorMonomialBasis k N M)
    (⟨0, positiveN⟩, ⟨0, positiveM⟩)
    (truncatedTensorResidue (k := k) N M positiveN positiveM).toLinearMap
    (by simpa using (truncated_tensor_residue_monomial (k := k) N M positiveN positiveM
      (⟨0, positiveN⟩, ⟨0, positiveM⟩)))
    (by intro ij hij; simpa [hij] using
      (truncated_tensor_residue_monomial (k := k) N M positiveN positiveM ij))
  unfold Specifications.AugmentationBasisKernel at h
  rw [h]
  unfold weightedBasisFiltration
  congr 2
  ext ij
  change ij ≠ (⟨0, positiveN⟩, ⟨0, positiveM⟩) ↔ 1 ≤ ij.1.val + ij.2.val
  constructor
  · intro h
    by_contra hn
    apply h
    apply Prod.ext
    · apply Fin.ext
      change ij.1.val = 0
      omega
    · apply Fin.ext
      change ij.2.val = 0
      omega
  · intro h heq
    subst ij
    simp at h

/-- The actual radical is exactly the positive-weight monomial
span, proved from genuine residue and nilpotent tensor parameters. -/
theorem truncated_tensor_radical_weighted_basis (N M : ℕ)
    (positiveN : 0 < N) (positiveM : 0 < M) :
    Specifications.TruncatedTensorRadicalWeightedBasis (k := k) N M := by
  let ε := truncatedTensorResidue (k := k) N M positiveN positiveM
  have εsurjective : Function.Surjective ε := by
    intro c
    exact ⟨algebraMap k (TruncatedTensorAlgebra k N M) c, ε.commutes c⟩
  have below : Ring.jacobson (TruncatedTensorAlgebra k N M) ≤ RingHom.ker ε.toRingHom := by
    rw [Ring.jacobson_eq_sInf_isMaximal]
    exact sInf_le (RingHom.ker_isMaximal_of_surjective _ εsurjective)
  let X := (Algebra.TensorProduct.includeLeft : TruncatedCoefficientRing k N →ₐ[k]
    TruncatedTensorAlgebra k N M) (truncatedParameter k N)
  let Y := (Algebra.TensorProduct.includeRight : TruncatedCoefficientRing k M →ₐ[k]
    TruncatedTensorAlgebra k N M) (truncatedParameter k M)
  have hx : X ∈ Ring.jacobson (TruncatedTensorAlgebra k N M) :=
    commutative_nilpotent_mem_jacobson X
      ((truncated_parameter_nilpotent (k := k) N).map
        (Algebra.TensorProduct.includeLeft : TruncatedCoefficientRing k N →ₐ[k]
          TruncatedTensorAlgebra k N M))
  have hy : Y ∈ Ring.jacobson (TruncatedTensorAlgebra k N M) :=
    commutative_nilpotent_mem_jacobson Y
      ((truncated_parameter_nilpotent (k := k) M).map
        (Algebra.TensorProduct.includeRight : TruncatedCoefficientRing k M →ₐ[k]
          TruncatedTensorAlgebra k N M))
  unfold Specifications.TruncatedTensorRadicalWeightedBasis
  apply le_antisymm
  · intro a ha
    have hker : a ∈ LinearMap.ker ε.toLinearMap := below ha
    rwa [truncated_tensor_residue_kernel_weighted N M positiveN positiveM] at hker
  · apply Submodule.span_le.mpr
    rintro a ⟨ij, hij, rfl⟩
    rw [truncated_tensor_monomial_formula N M ij]
    change X ^ ij.1.val * Y ^ ij.2.val ∈ Ring.jacobson (TruncatedTensorAlgebra k N M)
    have weight : 1 ≤ ij.1.val + ij.2.val := hij
    by_cases hi : 0 < ij.1.val
    · exact Ideal.mul_mem_right _ _ ((Ring.jacobson _).pow_mem_of_mem hx _ hi)
    · have hj : 0 < ij.2.val := by omega
      exact (Ring.jacobson _).mul_mem_left _ ((Ring.jacobson _).pow_mem_of_mem hy _ hj)

/-- Actual monomial multiplication respects total degree, with
every overflow killed by a genuine truncation relation. -/
theorem truncated_tensor_basis_products_respect_weight (N M : ℕ) :
    BasisProductsRespectWeight (truncatedTensorMonomialBasis k N M) truncatedTensorMonomialWeight := by
  intro ij uv
  rw [truncated_tensor_monomial_basis_apply, truncated_tensor_monomial_basis_apply,
    Algebra.TensorProduct.tmul_mul_tmul, ← pow_add, ← pow_add]
  by_cases hi : ij.1.val + uv.1.val < N
  · by_cases hj : ij.2.val + uv.2.val < M
    · let w : Fin N × Fin M := (⟨ij.1.val + uv.1.val, hi⟩, ⟨ij.2.val + uv.2.val, hj⟩)
      rw [← truncated_tensor_monomial_basis_apply N M w]
      apply Submodule.subset_span
      refine ⟨w, ?_, rfl⟩
      change (ij.1.val + ij.2.val) + (uv.1.val + uv.2.val) ≤
        (ij.1.val + uv.1.val) + (ij.2.val + uv.2.val)
      omega
    · rw [pow_eq_zero_of_le (by omega : M ≤ ij.2.val + uv.2.val)
        (truncated_parameter_pow (k := k) M), TensorProduct.tmul_zero]
      exact Submodule.zero_mem _
  · rw [pow_eq_zero_of_le (by omega : N ≤ ij.1.val + uv.1.val)
      (truncated_parameter_pow (k := k) N), TensorProduct.zero_tmul]
    exact Submodule.zero_mem _

/-- Every actual radical power is the genuine monomial span of
the corresponding total degree; no Jennings data is supplied. -/
theorem truncated_tensor_radical_filtration_weighted_basis (N M : ℕ)
    (positiveN : 0 < N) (positiveM : 0 < M) :
    Specifications.TruncatedTensorRadicalFiltrationWeightedBasis (k := k) N M := by
  let b := truncatedTensorMonomialBasis k N M
  let W := weightedBasisFiltration b truncatedTensorMonomialWeight
  let F := jacobsonRadicalFiltration (k := k) (A := TruncatedTensorAlgebra k N M)
  have multiplicativeW := weighted_basis_filtration_multiplicative b _
    (truncated_tensor_basis_products_respect_weight (k := k) N M)
  have base : jacobsonRadicalSubspace (k := k) (A := TruncatedTensorAlgebra k N M) ≤ W 1 :=
    (truncated_tensor_radical_weighted_basis N M positiveN positiveM).le
  let X := (Algebra.TensorProduct.includeLeft : TruncatedCoefficientRing k N →ₐ[k]
    TruncatedTensorAlgebra k N M) (truncatedParameter k N)
  let Y := (Algebra.TensorProduct.includeRight : TruncatedCoefficientRing k M →ₐ[k]
    TruncatedTensorAlgebra k N M) (truncatedParameter k M)
  have hx : X ∈ F 1 := by
    change X ∈ jacobsonRadicalFiltration (k := k) (A := TruncatedTensorAlgebra k N M) 1
    rw [jacobson_radical_filtration_one]
    exact commutative_nilpotent_mem_jacobson X
      ((truncated_parameter_nilpotent (k := k) N).map
        (Algebra.TensorProduct.includeLeft : TruncatedCoefficientRing k N →ₐ[k]
          TruncatedTensorAlgebra k N M))
  have hy : Y ∈ F 1 := by
    change Y ∈ jacobsonRadicalFiltration (k := k) (A := TruncatedTensorAlgebra k N M) 1
    rw [jacobson_radical_filtration_one]
    exact commutative_nilpotent_mem_jacobson Y
      ((truncated_parameter_nilpotent (k := k) M).map
        (Algebra.TensorProduct.includeRight : TruncatedCoefficientRing k M →ₐ[k]
          TruncatedTensorAlgebra k N M))
  intro n
  apply le_antisymm
  · cases n with
    | zero =>
        change ⊤ ≤ Submodule.span k (b '' {ij | 0 ≤ truncatedTensorMonomialWeight ij})
        simp [b.span_eq]
    | succ n =>
        exact positive_subspace_power_le_filtration W multiplicativeW _ base n
  · apply Submodule.span_le.mpr
    rintro a ⟨ij, hij, rfl⟩
    rw [truncated_tensor_monomial_formula N M ij]
    have member : X ^ ij.1.val * Y ^ ij.2.val ∈ F (ij.1.val + ij.2.val) :=
      jacobson_radical_filtration_multiplicative _ _ _ _
        (filtration_power_member F jacobson_radical_filtration_multiplicative
          (Submodule.mem_top : (1 : TruncatedTensorAlgebra k N M) ∈ F 0) X hx _)
        (filtration_power_member F jacobson_radical_filtration_multiplicative
          (Submodule.mem_top : (1 : TruncatedTensorAlgebra k N M) ∈ F 0) Y hy _)
    exact (antitone_nat_of_succ_le jacobson_radical_filtration_descending hij) member

theorem truncated_tensor_monomial_weight_polynomial (N M : ℕ) :
    weightedBasisHilbertPolynomial (truncatedTensorMonomialWeight (N := N) (M := M)) =
      intervalPolynomial N * intervalPolynomial M := by
  have hN : intervalPolynomial N = ∑ i : Fin N, (Polynomial.X : Polynomial ℕ) ^ i.val := by
    unfold intervalPolynomial
    rw [Finset.sum_range]
  have hM : intervalPolynomial M = ∑ i : Fin M, (Polynomial.X : Polynomial ℕ) ^ i.val := by
    unfold intervalPolynomial
    rw [Finset.sum_range]
  rw [hN, hM]
  simp only [weightedBasisHilbertPolynomial, truncatedTensorMonomialWeight,
    Fintype.sum_prod_type, pow_add, ← Finset.mul_sum, ← Finset.sum_mul]

/-- The complete actual radical Hilbert polynomial is the
product of interval factors, uniformly over all coefficient fields. -/
theorem truncated_tensor_radical_hilbert_polynomial (N M : ℕ)
    (positiveN : 0 < N) (positiveM : 0 < M) :
    Specifications.TruncatedTensorRadicalHilbertPolynomial (k := k) N M := by
  have hF : jacobsonRadicalFiltration (k := k) (A := TruncatedTensorAlgebra k N M) =
      weightedBasisFiltration (truncatedTensorMonomialBasis k N M) truncatedTensorMonomialWeight :=
    funext (truncated_tensor_radical_filtration_weighted_basis N M positiveN positiveM)
  intro i
  have hdim := congrArg (fun F : ℕ → Submodule k (TruncatedTensorAlgebra k N M) =>
    Module.finrank k (FiltrationLayer F i)) hF
  exact hdim.trans ((weighted_basis_hilbert_dimensions
    (truncatedTensorMonomialBasis k N M) truncatedTensorMonomialWeight i).trans
      (congrArg (fun P : Polynomial ℕ => P.coeff i) (truncated_tensor_monomial_weight_polynomial N M)))

theorem truncated_tensor_radical_filtration_vanishes (N M : ℕ)
    (positiveN : 0 < N) (positiveM : 0 < M) :
    jacobsonRadicalFiltration (k := k) (A := TruncatedTensorAlgebra k N M) (N + M - 1) = ⊥ := by
  rw [truncated_tensor_radical_filtration_weighted_basis N M positiveN positiveM]
  unfold weightedBasisFiltration
  have hset : {ij : Fin N × Fin M | N + M - 1 ≤ truncatedTensorMonomialWeight ij} = ∅ := by
    ext ij
    have hi := ij.1.isLt
    have hj := ij.2.isLt
    simp only [Set.mem_setOf_eq, Set.mem_empty_iff_false, iff_false, truncatedTensorMonomialWeight]
    omega
  rw [hset, Set.image_empty, Submodule.span_empty]

end Litt3.Deformations
