import Mathlib.LinearAlgebra.Matrix.ToLin

namespace Litt3.Deformations

open Matrix

variable {R S I : Type*} [CommRing R] [CommRing S] [Fintype I] [DecidableEq I]

/-- Base extension of a finite coordinate equivalence through its
actual pair of mutually inverse matrices. -/
noncomputable def piEquivScalarExtension (φ : R →+* S)
    (e : (I → R) ≃ₗ[R] (I → R)) : (I → S) ≃ₗ[S] (I → S) := by
  let forward := LinearMap.toMatrix' e.toLinearMap
  let inverse := LinearMap.toMatrix' e.symm.toLinearMap
  have leftInverse : inverse * forward = 1 := by
    rw [← LinearMap.toMatrix'_comp]
    simp
  have rightInverse : forward * inverse = 1 := by
    rw [← LinearMap.toMatrix'_comp]
    simp
  exact Matrix.toLin'OfInv (M := inverse.map φ) (M' := forward.map φ)
    (by rw [← RingHom.mapMatrix_apply φ, ← RingHom.mapMatrix_apply φ,
      ← map_mul, leftInverse, map_one])
    (by rw [← RingHom.mapMatrix_apply φ, ← RingHom.mapMatrix_apply φ,
      ← map_mul, rightInverse, map_one])

@[simp] theorem piEquivScalarExtension_apply (φ : R →+* S)
    (e : (I → R) ≃ₗ[R] (I → R)) (v : I → S) :
    piEquivScalarExtension φ e v = (LinearMap.toMatrix' e.toLinearMap).map φ *ᵥ v := rfl

/-- A whole diagonal operator identity survives scalar extension,
through the actual extended equivalences and original matrix. -/
theorem pi_equiv_scalar_extension_diagonal_identity (φ : R →+* S)
    (A : Module.End R (I → R)) (source target : (I → R) ≃ₗ[R] (I → R))
    (diagonal : I → R)
    (equation : ∀ v, target (A v) = fun i => diagonal i * source v i)
    (v : I → S) :
    piEquivScalarExtension φ target ((LinearMap.toMatrix' A).map φ *ᵥ v) =
      fun i => φ (diagonal i) * piEquivScalarExtension φ source v i := by
  have operator : target.toLinearMap.comp A =
      (Matrix.toLin' (Matrix.diagonal diagonal)).comp source.toLinearMap := by
    apply LinearMap.ext
    intro w
    ext i
    simpa [Matrix.mulVec_diagonal] using congrFun (equation w) i
  have matrix : LinearMap.toMatrix' target.toLinearMap * LinearMap.toMatrix' A =
      Matrix.diagonal diagonal * LinearMap.toMatrix' source.toLinearMap := by
    rw [← LinearMap.toMatrix'_comp, operator, LinearMap.toMatrix'_comp,
      LinearMap.toMatrix'_toLin']
  have extended := congrArg φ.mapMatrix matrix
  simp only [map_mul, RingHom.mapMatrix_apply] at extended
  simp only [piEquivScalarExtension_apply]
  rw [Matrix.mulVec_mulVec, extended, ← Matrix.mulVec_mulVec]
  rw [Matrix.diagonal_map φ.map_zero]
  ext i
  exact Matrix.mulVec_diagonal _ _ i

end Litt3.Deformations
