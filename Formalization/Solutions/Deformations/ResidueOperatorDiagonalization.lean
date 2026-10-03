import Solutions.Deformations.IntegerInjectiveLift
import Solutions.Deformations.InjectivePIDDiagonalization
import Solutions.Deformations.PiEquivScalarExtension
import Mathlib.Algebra.EuclideanDomain.Int

namespace Litt3.Deformations

/-- Every finite free residue-ring operator has an actual two-basis
diagonalization. It is obtained from an injective integral lift and
the checked PID Smith theorem, then reduced through literal matrices.
No conclusion about the original operator is assumed. -/
theorem residue_operator_diagonalization (n d : ℕ) [NeZero n]
    (A : Module.End (ZMod n) (Fin d → ZMod n)) :
    ∃ (source target : (Fin d → ZMod n) ≃ₗ[ZMod n] (Fin d → ZMod n))
      (diagonal : Fin d → ZMod n),
      ∀ v, target (A (source.symm v)) = fun i => diagonal i * v i := by
  classical
  obtain ⟨B, reduction, injective⟩ :=
    zmod_matrix_injective_integer_lift n (LinearMap.toMatrix' A)
  obtain ⟨source, target, diagonal, equation⟩ :=
    injective_pid_operator_diagonalization (Pi.basisFun ℤ (Fin d)) B.mulVecLin injective
  let φ := Int.castRingHom (ZMod n)
  refine ⟨piEquivScalarExtension φ source, piEquivScalarExtension φ target,
    fun i => φ (diagonal i), ?_⟩
  intro v
  have forward : ∀ w, target (B.mulVecLin w) = fun i => diagonal i * source w i := by
    intro w
    simpa using equation (source w)
  have extended := pi_equiv_scalar_extension_diagonal_identity φ B.mulVecLin source target
    diagonal forward ((piEquivScalarExtension φ source).symm v)
  have matrixB : LinearMap.toMatrix' B.mulVecLin = B := LinearMap.toMatrix'_toLin' B
  have reduction' : B.map φ = LinearMap.toMatrix' A := reduction
  simpa only [matrixB, reduction', ← Matrix.toLin'_apply, Matrix.toLin'_toMatrix',
    LinearEquiv.apply_symm_apply] using extended

end Litt3.Deformations
