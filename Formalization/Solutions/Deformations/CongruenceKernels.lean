import Theorems.Deformations.CongruenceKernels
import Solutions.Deformations.KernelTransport

namespace Litt3.Deformations

variable {R ι : Type*} [CommRing R] [StarRing R] [Fintype ι] [DecidableEq ι]

/-- An actual invertible Hermitian congruence preserves the
actual complete kernel module, over every commutative star ring. -/
noncomputable def congruenceKernelEquiv (A P : Matrix ι ι R) [Invertible P] :
    LinearMap.ker (Matrix.toLin' (hermitianCongruence A P)) ≃ₗ[R]
      LinearMap.ker (Matrix.toLin' A) := by
  let domain := P.toLinearEquiv' (inferInstance : Invertible P)
  let codomain := P.conjTranspose.toLinearEquiv' (inferInstance : Invertible P.conjTranspose)
  have hmap : Matrix.toLin' (hermitianCongruence A P) =
      transportedLinearMap (Matrix.toLin' A) domain codomain := by
    change Matrix.toLin' (P.conjTranspose * A * P) =
      ((P.conjTranspose.toLinearEquiv' (inferInstance : Invertible P.conjTranspose)) :
        Module.End R (ι → R)).comp
          ((Matrix.toLin' A).comp ((P.toLinearEquiv' (inferInstance : Invertible P)) :
            Module.End R (ι → R)))
    rw [Matrix.toLinearEquiv'_apply, Matrix.toLinearEquiv'_apply,
      Matrix.toLin'_mul, Matrix.toLin'_mul, LinearMap.comp_assoc]
  exact (LinearEquiv.ofEq _ _ (congrArg LinearMap.ker hmap)).trans
    (transportedKernelEquiv (Matrix.toLin' A) domain codomain)

theorem congruence_kernel_equivalent (A P : Matrix ι ι R) [Invertible P] :
    Specifications.CongruenceKernelEquivalent A P :=
  ⟨congruenceKernelEquiv A P⟩

end Litt3.Deformations
