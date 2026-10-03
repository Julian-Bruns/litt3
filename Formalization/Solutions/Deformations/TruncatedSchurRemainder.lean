import Theorems.Deformations.TruncatedSchurRemainder
import Solutions.Deformations.TruncatedResidueSymmetry

namespace Litt3.Deformations

variable {k m n : Type*} [CommRing k]
variable [Fintype m] [Fintype n] [DecidableEq n]

/-- The actual complete Schur remainder has zero residue when
its actual off-diagonal and remaining leading blocks do, with
both signed remainder formulas proved. -/
theorem truncated_schur_zero_residue (N : ℕ) (positive : 0 < N)
    (G : Matrix m m (TruncatedCoefficientRing k N))
    (D : Matrix m n (TruncatedCoefficientRing k N))
    (F : Matrix n n (TruncatedCoefficientRing k N))
    (zeroD : truncatedResidueMatrix k N positive D = 0)
    (zeroF : truncatedResidueMatrix k N positive F = 0) :
    Specifications.TruncatedSchurZeroResidue N positive G D F := by
  have hD : D.conjTranspose.map (truncatedResidue k N positive) = 0 := by
    ext i j
    change truncatedResidue k N positive (truncatedReflection k N (D j i)) = 0
    rw [truncated_residue_reflection]
    exact congrArg (fun M : Matrix m n k => M j i) zeroD
  have hterm : (D.conjTranspose * G * D).map (truncatedResidue k N positive) = 0 := by
    rw [Matrix.map_mul, Matrix.map_mul, hD, Matrix.zero_mul, Matrix.zero_mul]
  constructor
  · change (truncatedResidue k N positive).mapMatrix (F - D.conjTranspose * G * D) = 0
    rw [map_sub]
    change F.map (truncatedResidue k N positive) -
      (D.conjTranspose * G * D).map (truncatedResidue k N positive) = 0
    rw [show F.map (truncatedResidue k N positive) = 0 from zeroF, hterm, sub_self]
  · change (truncatedResidue k N positive).mapMatrix (F + D.conjTranspose * G * D) = 0
    rw [map_add]
    change F.map (truncatedResidue k N positive) +
      (D.conjTranspose * G * D).map (truncatedResidue k N positive) = 0
    rw [show F.map (truncatedResidue k N positive) = 0 from zeroF, hterm, add_zero]

end Litt3.Deformations
