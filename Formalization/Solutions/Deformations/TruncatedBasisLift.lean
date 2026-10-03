import Theorems.Deformations.TruncatedBasisLift
import Solutions.Deformations.TruncatedResidueSymmetry
import Solutions.Deformations.RectangularCongruenceKernels

namespace Litt3.Deformations

open Module Polynomial

variable {k V m n : Type*} [CommRing k] [AddCommGroup V] [Module k V]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

/-- Both inverse identities survive the actual coefficient
algebra map, including rectangular transition matrices. -/
theorem truncated_basis_matrices_inverse (N : ℕ) (b : Basis m k V) (c : Basis n k V) :
    Specifications.TruncatedBasisMatricesInverse N b c := by
  constructor
  · change (c.toMatrix b).map (algebraMap k (TruncatedCoefficientRing k N)) *
      (b.toMatrix c).map (algebraMap k (TruncatedCoefficientRing k N)) = 1
    rw [← Matrix.map_mul, Basis.toMatrix_mul_toMatrix_flip]
    exact (algebraMap k (TruncatedCoefficientRing k N)).mapMatrix.map_one
  · change (b.toMatrix c).map (algebraMap k (TruncatedCoefficientRing k N)) *
      (c.toMatrix b).map (algebraMap k (TruncatedCoefficientRing k N)) = 1
    rw [← Matrix.map_mul, Basis.toMatrix_mul_toMatrix_flip]
    exact (algebraMap k (TruncatedCoefficientRing k N)).mapMatrix.map_one

omit [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n] in
theorem truncated_basis_matrix_residue (N : ℕ) (positive : 0 < N)
    (b : Basis m k V) (c : Basis n k V) :
    truncatedResidueMatrix k N positive (truncatedBasisMatrix N b c) = b.toMatrix c := by
  ext i j
  change truncatedResidue k N positive (algebraMap k (TruncatedCoefficientRing k N)
    (b.toMatrix c i j)) = b.toMatrix c i j
  rw [AdjoinRoot.algebraMap_eq, truncated_residue_constant]

omit [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n] in
/-- The same actual constant basis change is retained under
every actual truncation map. -/
theorem truncated_basis_matrix_restriction (N j : ℕ) (bound : j ≤ N)
    (b : Basis m k V) (c : Basis n k V) :
    truncatedMatrixRestriction k N j bound (truncatedBasisMatrix N b c) =
      truncatedBasisMatrix j b c := by
  ext i l
  change truncatedRestriction k N j bound
    (algebraMap k (TruncatedCoefficientRing k N) (b.toMatrix c i l)) =
      algebraMap k (TruncatedCoefficientRing k j) (b.toMatrix c i l)
  exact (truncatedRestriction k N j bound).commutes _

omit [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n] in
theorem truncated_basis_matrix_reflection (N : ℕ) (b : Basis m k V) (c : Basis n k V) :
    truncatedHermitianTranspose k N (truncatedBasisMatrix N b c) =
      (truncatedBasisMatrix N b c).transpose := by
  ext i j
  change truncatedReflection k N (algebraMap k (TruncatedCoefficientRing k N)
    (b.toMatrix c j i)) = algebraMap k (TruncatedCoefficientRing k N) (b.toMatrix c j i)
  rw [AdjoinRoot.algebraMap_eq, truncated_reflection_constant]

omit [DecidableEq m] [Fintype n] [DecidableEq n] in
/-- The residue of the actual full constant-basis congruence
is exactly the actual original residue-basis congruence. -/
theorem truncated_basis_residue_congruence (N : ℕ) (positive : 0 < N)
    (b : Basis m k V) (c : Basis n k V)
    (A : Matrix m m (TruncatedCoefficientRing k N)) :
    truncatedResidueMatrix k N positive
      ((truncatedBasisMatrix N b c).conjTranspose * A * truncatedBasisMatrix N b c) =
        (b.toMatrix c).transpose * truncatedResidueMatrix k N positive A * b.toMatrix c := by
  change ((truncatedBasisMatrix N b c).conjTranspose * A *
    truncatedBasisMatrix N b c).map (truncatedResidue k N positive) = _
  rw [Matrix.map_mul, Matrix.map_mul]
  have hstar : (truncatedBasisMatrix N b c).conjTranspose.map (truncatedResidue k N positive) =
      (b.toMatrix c).transpose := by
    rw [show (truncatedBasisMatrix N b c).conjTranspose =
      (truncatedBasisMatrix N b c).transpose from truncated_basis_matrix_reflection N b c]
    change (truncatedResidueMatrix k N positive (truncatedBasisMatrix N b c)).transpose = _
    rw [truncated_basis_matrix_residue]
  rw [hstar, show (truncatedBasisMatrix N b c).map (truncatedResidue k N positive) =
    b.toMatrix c from truncated_basis_matrix_residue N positive b c]
  rfl

end Litt3.Deformations
