import Mathlib.LinearAlgebra.FreeModule.PID
import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.LinearAlgebra.Matrix.ToLin

namespace Litt3.Deformations

open Module

/-- Every injective endomorphism of a finite free module over a PID
admits an actual two-basis diagonal operator identity. This is the
submodule Smith theorem applied to its genuine image. -/
theorem injective_pid_operator_diagonalization {R M I : Type*}
    [CommRing R] [IsDomain R] [IsPrincipalIdealRing R]
    [AddCommGroup M] [Module R M] [Fintype I] [DecidableEq I]
    (basis : Basis I R M) (A : Module.End R M) (injective : Function.Injective A) :
    ∃ (source target : M ≃ₗ[R] (I → R)) (diagonal : I → R),
      ∀ v, target (A (source.symm v)) = fun i => diagonal i * v i := by
  classical
  have rankEquality : Module.finrank R (LinearMap.range A) = Module.finrank R M :=
    LinearMap.finrank_range_of_inj injective
  obtain ⟨targetBasis, diagonal, imageBasis, relation⟩ :=
    (LinearMap.range A).exists_smith_normal_form_of_rank_eq basis rankEquality
  let ontoImage := LinearEquiv.ofInjective A injective
  let source := ontoImage.trans imageBasis.equivFun
  refine ⟨source, targetBasis.equivFun, diagonal, ?_⟩
  intro v
  have image : A (source.symm v) = ((imageBasis.equivFun.symm v : LinearMap.range A) : M) := by
    change (ontoImage (ontoImage.symm (imageBasis.equivFun.symm v)) : M) = _
    rw [LinearEquiv.apply_symm_apply]
  rw [image, Basis.equivFun_symm_apply]
  change targetBasis.equivFun ((LinearMap.range A).subtype (∑ i, v i • imageBasis i)) = _
  simp only [map_sum, map_smul]
  ext j
  simp [relation, Finsupp.single_apply, mul_comm]

end Litt3.Deformations
