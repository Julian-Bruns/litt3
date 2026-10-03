import Theorems.Deformations.MixedHermitianModel
import Solutions.Deformations.PairedMinimalHermitian

namespace Litt3.Deformations

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

omit [Fintype ι] [DecidableEq ι] in
theorem truncated_matrix_reflection_adjoint (N : ℕ)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) :
    truncatedMatrixReflection N A.conjTranspose = A.transpose := by
  ext i j
  exact truncated_reflection_involution N (A j i)

/-- The exact mixed chain-pairing relation becomes a
genuine Hermitian differential after the actual reflected
mixed basis change. -/
theorem mixed_relation_hermitian (N : ℕ)
    (A H : Matrix ι ι (TruncatedCoefficientRing k N))
    (compatibility : H * truncatedMatrixReflection N A = A.transpose * H.conjTranspose) :
    (truncatedMatrixReflection N H * A).conjTranspose = truncatedMatrixReflection N H * A := by
  have reflected := congrArg (fun M => (truncatedReflection k N).mapMatrix M) compatibility
  change (truncatedReflection k N).mapMatrix (H * truncatedMatrixReflection N A) =
    (truncatedReflection k N).mapMatrix (A.transpose * H.conjTranspose) at reflected
  rw [map_mul, map_mul] at reflected
  change truncatedMatrixReflection N H *
      truncatedMatrixReflection N (truncatedMatrixReflection N A) =
    truncatedMatrixReflection N A.transpose * truncatedMatrixReflection N H.conjTranspose at reflected
  rw [truncated_matrix_reflection_involution, truncated_matrix_reflection_transpose,
    truncated_matrix_reflection_adjoint] at reflected
  rw [Matrix.conjTranspose_mul, truncated_matrix_reflection_conjTranspose, ← reflected]

noncomputable def leftUnitMatrixKernelEquiv (N : ℕ)
    (A L : Matrix ι ι (TruncatedCoefficientRing k N)) [Invertible L] :
    LinearMap.ker (Matrix.toLin' (L * A)) ≃ₗ[TruncatedCoefficientRing k N]
      LinearMap.ker (Matrix.toLin' A) := by
  let codomain := L.toLinearEquiv' (inferInstance : Invertible L)
  have hmap : Matrix.toLin' (L * A) = transportedLinearMap (Matrix.toLin' A)
      (LinearEquiv.refl (TruncatedCoefficientRing k N) (ι → TruncatedCoefficientRing k N)) codomain := by
    change Matrix.toLin' (L * A) = (L.toLinearEquiv' (inferInstance : Invertible L)).toLinearMap.comp
      ((Matrix.toLin' A).comp (LinearMap.id))
    rw [Matrix.toLinearEquiv'_apply, Matrix.toLin'_mul, LinearMap.comp_id]
  exact (LinearEquiv.ofEq _ _ (congrArg LinearMap.ker hmap)).trans
    (transportedKernelEquiv (Matrix.toLin' A) (LinearEquiv.refl _ _) codomain)

/-- A genuine perfect strict mixed pairing produces a
genuine Hermitian model with the identical full kernel
module. No change of the actual section-module action occurs. -/
theorem mixed_hermitian_model (N : ℕ) (A H : Matrix ι ι (TruncatedCoefficientRing k N)) :
    Specifications.MixedHermitianModel N A H := by
  intro compatibility unitH
  have unitReflected : IsUnit (truncatedMatrixReflection N H) :=
    unitH.map (truncatedReflection k N).mapMatrix
  letI := unitReflected.invertible
  refine ⟨truncatedMatrixReflection N H * A, mixed_relation_hermitian N A H compatibility,
    ⟨(leftUnitMatrixKernelEquiv N A (truncatedMatrixReflection N H)).symm⟩⟩

end Litt3.Deformations
