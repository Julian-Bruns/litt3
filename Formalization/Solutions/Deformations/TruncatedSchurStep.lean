import Theorems.Deformations.TruncatedSchurStep
import Solutions.Deformations.TruncatedCongruenceLifting
import Solutions.Deformations.TruncatedMatrixDivisibility
import Solutions.Deformations.HermitianSchur
import Solutions.Deformations.TruncatedSchurRemainder

namespace Litt3.Deformations

variable {k m n : Type*} [CommRing k]
variable [Fintype m] [DecidableEq m] [Fintype n] [DecidableEq n]

/-- A genuine short nonsingular-block split with residue-zero
remainder becomes a genuine full invertible congruence split with
strictly higher parameter valuation in its complete remainder. -/
theorem truncated_block_congruence_higher_step (N e : ℕ) (less : e < N)
    (A : Matrix (m ⊕ n) (m ⊕ n) (TruncatedCoefficientRing k N))
    (S : Matrix (m ⊕ n) (m ⊕ n) (TruncatedCoefficientRing k (N - e))) (hS : IsUnit S)
    (C : Matrix m m (TruncatedCoefficientRing k (N - e))) (hC : IsUnit C)
    (F : Matrix n n (TruncatedCoefficientRing k (N - e)))
    (zeroResidue : truncatedResidueMatrix k (N - e) (Nat.sub_pos_of_lt less) F = 0)
    (shortSplit : truncatedHermitianTranspose k (N - e) S *
      truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) A * S =
        Matrix.fromBlocks C 0 0 F) :
    Specifications.TruncatedSchurHigherValuationStep N e A := by
  have positive : 0 < N := lt_of_le_of_lt (Nat.zero_le e) less
  obtain ⟨Cfull, hCfull, rCfull⟩ := truncated_matrix_unit_lifting N (N - e)
    (Nat.sub_le _ _) (Nat.sub_pos_of_lt less) C hC
  obtain ⟨Ffull, rFfull⟩ := truncated_matrix_restriction_surjective
    (k := k) N (N - e) (Nat.sub_le _ _) F
  have hFfull : truncatedResidueMatrix k N positive Ffull = 0 := by
    rw [← truncated_residue_matrix_restriction N (N - e) (Nat.sub_le _ _) positive
      (Nat.sub_pos_of_lt less), rFfull, zeroResidue]
  obtain ⟨Fnext, factorF⟩ := (truncated_matrix_divisibility N positive Ffull).mp hFfull
  let Dfull := Matrix.fromBlocks Cfull 0 0 Ffull
  have rDfull : truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) Dfull =
      Matrix.fromBlocks C 0 0 F := by
    change (Matrix.fromBlocks Cfull 0 0 Ffull).map
      (truncatedRestriction k N (N - e) (Nat.sub_le _ _)) = _
    rw [Matrix.fromBlocks_map]
    simp only [Matrix.map_zero, map_zero]
    rw [show Cfull.map (truncatedRestriction k N (N - e) (Nat.sub_le _ _)) = C from rCfull,
      show Ffull.map (truncatedRestriction k N (N - e) (Nat.sub_le _ _)) = F from rFfull]
  obtain ⟨P, hP, _, fullSplit⟩ := truncated_congruence_lifting N e less A Dfull S hS
    (shortSplit.trans rDfull.symm)
  refine ⟨P, hP, Cfull, hCfull, Fnext, ?_⟩
  rw [fullSplit]
  change truncatedParameter k N ^ e • Matrix.fromBlocks Cfull 0 0 Ffull = _
  rw [Matrix.fromBlocks_smul, smul_zero, factorF, smul_smul, ← pow_succ]
  simp only [smul_zero]

/-- The actual even-sign Schur elimination produces the full
higher-valuation step, including actual invertible lifts and the
complete residue-zero remainder. -/
theorem hermitian_truncated_schur_step (N e : ℕ) (less : e < N)
    (A : Matrix (m ⊕ n) (m ⊕ n) (TruncatedCoefficientRing k N))
    (C : Matrix m m (TruncatedCoefficientRing k (N - e)))
    (D : Matrix m n (TruncatedCoefficientRing k (N - e)))
    (F : Matrix n n (TruncatedCoefficientRing k (N - e))) [Invertible C]
    (hC : truncatedHermitianTranspose k (N - e) C = C)
    (zeroD : truncatedResidueMatrix k (N - e) (Nat.sub_pos_of_lt less) D = 0)
    (zeroF : truncatedResidueMatrix k (N - e) (Nat.sub_pos_of_lt less) F = 0)
    (reduction : truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) A =
      Matrix.fromBlocks C D (truncatedHermitianTranspose k (N - e) D) F) :
    Specifications.TruncatedSchurHigherValuationStep N e A := by
  letI := hermitianSchurEliminatorInvertible C D
  have hzero := (truncated_schur_zero_residue (N - e) (Nat.sub_pos_of_lt less)
    (⅟C) D F zeroD zeroF).1
  apply truncated_block_congruence_higher_step N e less A (hermitianSchurEliminator C D)
    (isUnit_of_invertible _) C (isUnit_of_invertible _) (F - D.conjTranspose * ⅟C * D) hzero
  change (hermitianSchurEliminator C D).conjTranspose *
    truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) A * hermitianSchurEliminator C D = _
  rw [reduction]
  exact hermitian_schur_congruence C D F hC

/-- The actual odd-sign Schur elimination uses its forced plus
remainder sign, and likewise gives the complete full congruence
and actual higher-valuation remainder. -/
theorem skew_hermitian_truncated_schur_step (N e : ℕ) (less : e < N)
    (A : Matrix (m ⊕ n) (m ⊕ n) (TruncatedCoefficientRing k N))
    (C : Matrix m m (TruncatedCoefficientRing k (N - e)))
    (D : Matrix m n (TruncatedCoefficientRing k (N - e)))
    (F : Matrix n n (TruncatedCoefficientRing k (N - e))) [Invertible C]
    (hC : truncatedHermitianTranspose k (N - e) C = -C)
    (zeroD : truncatedResidueMatrix k (N - e) (Nat.sub_pos_of_lt less) D = 0)
    (zeroF : truncatedResidueMatrix k (N - e) (Nat.sub_pos_of_lt less) F = 0)
    (reduction : truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) A =
      Matrix.fromBlocks C D (-truncatedHermitianTranspose k (N - e) D) F) :
    Specifications.TruncatedSchurHigherValuationStep N e A := by
  letI := hermitianSchurEliminatorInvertible C D
  have hzero := (truncated_schur_zero_residue (N - e) (Nat.sub_pos_of_lt less)
    (⅟C) D F zeroD zeroF).2
  apply truncated_block_congruence_higher_step N e less A (hermitianSchurEliminator C D)
    (isUnit_of_invertible _) C (isUnit_of_invertible _) (F + D.conjTranspose * ⅟C * D) hzero
  change (hermitianSchurEliminator C D).conjTranspose *
    truncatedMatrixRestriction k N (N - e) (Nat.sub_le _ _) A * hermitianSchurEliminator C D = _
  rw [reduction]
  exact skew_hermitian_schur_congruence C D F hC

end Litt3.Deformations
