import Theorems.Deformations.RectangularCongruenceKernels
import Solutions.Deformations.KernelTransport

namespace Litt3.Deformations

variable {R m n : Type*} [CommRing R]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

/-- An actual rectangular inverse pair gives a genuine
equivalence between the complete coordinate modules. -/
noncomputable def matrixInversePairEquiv (P : Matrix m n R) (Q : Matrix n m R)
    (inverse_pair : MatrixInversePair P Q) : (n → R) ≃ₗ[R] (m → R) where
  __ := Matrix.toLin' P
  invFun := Matrix.toLin' Q
  left_inv x := by
    change (Matrix.toLin' Q) ((Matrix.toLin' P) x) = x
    rw [← LinearMap.comp_apply, ← Matrix.toLin'_mul, inverse_pair.left_inverse]
    exact Matrix.one_mulVec x
  right_inv x := by
    change (Matrix.toLin' P) ((Matrix.toLin' Q) x) = x
    rw [← LinearMap.comp_apply, ← Matrix.toLin'_mul, inverse_pair.right_inverse]
    exact Matrix.one_mulVec x

variable [StarRing R]

/-- Rectangular basis changes preserve the actual kernel;
different basis index types need not be silently identified. -/
noncomputable def rectangularCongruenceKernelEquiv (A : Matrix m m R)
    (P : Matrix m n R) (Q : Matrix n m R) (inverse_pair : MatrixInversePair P Q) :
    LinearMap.ker (Matrix.toLin' (P.conjTranspose * A * P)) ≃ₗ[R]
      LinearMap.ker (Matrix.toLin' A) := by
  let domain := matrixInversePairEquiv P Q inverse_pair
  have hstar : MatrixInversePair P.conjTranspose Q.conjTranspose := {
    left_inverse := by rw [← Matrix.conjTranspose_mul, inverse_pair.right_inverse, Matrix.conjTranspose_one]
    right_inverse := by rw [← Matrix.conjTranspose_mul, inverse_pair.left_inverse, Matrix.conjTranspose_one] }
  let codomain := matrixInversePairEquiv P.conjTranspose Q.conjTranspose hstar
  have hmap : Matrix.toLin' (P.conjTranspose * A * P) =
      transportedLinearMap (Matrix.toLin' A) domain codomain := by
    change Matrix.toLin' (P.conjTranspose * A * P) =
      (Matrix.toLin' P.conjTranspose).comp ((Matrix.toLin' A).comp (Matrix.toLin' P))
    rw [Matrix.toLin'_mul, Matrix.toLin'_mul, LinearMap.comp_assoc]
  exact (LinearEquiv.ofEq _ _ (congrArg LinearMap.ker hmap)).trans
    (transportedKernelEquiv (Matrix.toLin' A) domain codomain)

theorem rectangular_congruence_kernel_equivalent (A : Matrix m m R)
    (P : Matrix m n R) (Q : Matrix n m R) (inverse_pair : MatrixInversePair P Q) :
    Specifications.RectangularCongruenceKernelEquivalent A P :=
  ⟨rectangularCongruenceKernelEquiv A P Q inverse_pair⟩

end Litt3.Deformations
