import Definitions.Deformations.TruncatedTensorBasis
import Definitions.Deformations.RadicalPowerFiltration

namespace Litt3.Deformations

variable {k : Type*} [CommRing k] [Nontrivial k]

noncomputable def truncatedResidueAlgHom (N : ℕ) (positive : 0 < N) :
    TruncatedCoefficientRing k N →ₐ[k] k :=
  { truncatedResidue k N positive with
    commutes' := by intro c; simp [truncatedResidue, AdjoinRoot.algebraMap_eq] }

/-- The genuine residue map of the actual tensor truncation algebra. -/
noncomputable def truncatedTensorResidue (N M : ℕ) (positiveN : 0 < N) (positiveM : 0 < M) :
    TruncatedTensorAlgebra k N M →ₐ[k] k :=
  Algebra.TensorProduct.lift (truncatedResidueAlgHom N positiveN)
    (truncatedResidueAlgHom M positiveM) (fun _ _ => Commute.all _ _)

end Litt3.Deformations
