import Solutions.CartierAndSpin.QuotientResidueGram
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.ToLin

namespace Litt3.CartierAndSpin

open Polynomial Module

variable {R : Type*} [CommRing R]

/-- The actual residue map has the universal triangular Gram matrix,
when its output is expressed in the dual reversed-power basis. -/
theorem quotient_residue_pairing_matrix {D : R[X]} (hD : D.Monic) :
    LinearMap.toMatrix (AdjoinRoot.powerBasis' hD).basis
      ((AdjoinRoot.powerBasis' hD).basis.reindex Fin.revPerm).dualBasis
      (quotientResiduePairing hD) = quotientResidueReversedMatrix hD := by
  classical
  ext i j
  rw [LinearMap.toMatrix_apply, Basis.dualBasis_repr,
    Basis.reindex_apply, PowerBasis.basis_eq_pow, PowerBasis.basis_eq_pow]
  rfl

/-- Perfect residue duality for every monic polynomial over EVERY
commutative ring, including zero divisors and nonreduced quotients.
The proof constructs a unimodular Gram matrix, without field dimensions. -/
noncomputable def universalQuotientResidueDuality {D : R[X]} (hD : D.Monic) :
    AdjoinRoot D ≃ₗ[R] Module.Dual R (AdjoinRoot D) := by
  classical
  let b := (AdjoinRoot.powerBasis' hD).basis
  let c := (b.reindex Fin.revPerm).dualBasis
  let A := LinearMap.toMatrix b c (quotientResiduePairing hD)
  have hdet : IsUnit A.det := by
    dsimp only [A, b, c]
    rw [quotient_residue_pairing_matrix, quotient_residue_reversed_matrix_det]
    exact isUnit_one
  exact Matrix.toLinOfInv b c (Matrix.mul_nonsing_inv A hdet)
    (Matrix.nonsing_inv_mul A hdet)

/-- The constructed universal equivalence is literally residue against
the multiplier, not merely an unspecified finite-free equivalence. -/
theorem universal_quotient_residue_duality_apply {D : R[X]} (hD : D.Monic)
    (x y : AdjoinRoot D) :
    universalQuotientResidueDuality hD x y = quotientResidueFunctional hD (x * y) := by
  classical
  change Matrix.toLin (AdjoinRoot.powerBasis' hD).basis
    ((AdjoinRoot.powerBasis' hD).basis.reindex Fin.revPerm).dualBasis
    (LinearMap.toMatrix (AdjoinRoot.powerBasis' hD).basis
      ((AdjoinRoot.powerBasis' hD).basis.reindex Fin.revPerm).dualBasis
      (quotientResiduePairing hD)) x y = _
  rw [Matrix.toLin_toMatrix]
  rfl

/-- Every linear functional is uniquely multiplication-residue over the
original coefficient ring, with no coefficient inversions. -/
theorem universal_quotient_residue_multiplier_exists_unique {D : R[X]} (hD : D.Monic)
    (f : Module.Dual R (AdjoinRoot D)) :
    ∃! x : AdjoinRoot D, ∀ y : AdjoinRoot D,
      f y = quotientResidueFunctional hD (x * y) := by
  refine ⟨(universalQuotientResidueDuality hD).symm f, ?_, ?_⟩
  · intro y
    rw [← universal_quotient_residue_duality_apply,
      (universalQuotientResidueDuality hD).apply_symm_apply]
  · intro x hx
    apply (universalQuotientResidueDuality hD).injective
    apply LinearMap.ext
    intro y
    rw [(universalQuotientResidueDuality hD).apply_symm_apply,
      universal_quotient_residue_duality_apply]
    exact (hx y).symm

end Litt3.CartierAndSpin
