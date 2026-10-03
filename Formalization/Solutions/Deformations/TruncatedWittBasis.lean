import Solutions.Deformations.TruncatedWittResidue
import Solutions.Deformations.PrimePowerResidue
import Solutions.Deformations.ResidueLinearCombinations
import Mathlib.LinearAlgebra.Basis.VectorSpace

namespace Litt3.Deformations

/-- Actual zeroth Witt coordinate, viewed as a semilinear residue map
over the literal prime-power integer coefficient ring. -/
noncomputable def truncatedWittResidueLinear (p N : ℕ) [Fact p.Prime]
    (positive : 0 < N) (k : Type*) [CommRing k] [CharP k p]
    [Module (ZMod p) k] :
    TruncatedWittVector p N k →ₛₗ[primePowerResidue p N positive] k where
  __ := (truncatedWittResidue p N positive k).toAddMonoidHom
  map_smul' r x := by
    obtain ⟨m, rfl⟩ := ZMod.natCast_zmod_surjective r
    change truncatedWittResidue p N positive k ((m : ZMod (p ^ N)) • x) =
      primePowerResidue p N positive (m : ZMod (p ^ N)) • truncatedWittResidue p N positive k x
    rw [Nat.cast_smul_eq_nsmul, map_natCast, Nat.cast_smul_eq_nsmul]
    exact (truncatedWittResidue p N positive k).map_nsmul x m

/-- Lifting an arbitrary residue-field basis by literal Teichmüller
representatives produces a basis of the actual truncated Witt ring. -/
noncomputable def truncatedWittBasis (p N : ℕ) [Fact p.Prime]
    (positive : 0 < N) (k : Type*) [Field k] [CharP k p] [PerfectRing k p]
    [Module (ZMod p) k] :
    Module.Basis (Module.Free.ChooseBasisIndex (ZMod p) k)
      (ZMod (p ^ N)) (TruncatedWittVector p N k) := by
  let φ := primePowerResidue p N positive
  let q := truncatedWittResidueLinear p N positive k
  let basis := Module.Free.chooseBasis (ZMod p) k
  let lift := fun i => WittVector.truncate N (WittVector.teichmuller p (basis i))
  have relation : ∀ i, q (lift i) = basis i := by
    intro i
    change truncatedWittResidue p N positive k
      (WittVector.truncate N (WittVector.teichmuller p (basis i))) = basis i
    rw [truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero]
  have nilpotent : (p : ZMod (p ^ N)) ^ N = 0 := by
    rw [← Nat.cast_pow, ZMod.natCast_self]
  exact nilpotentResidueBasis (p : ZMod (p ^ N)) N nilpotent φ
    (prime_power_residue_kernel p N positive) q.toAddMonoidHom
    (truncated_witt_residue_kernel p N positive k)
    (truncated_witt_nonterminal_annihilator p N positive k)
    (Finsupp.linearCombination (ZMod (p ^ N)) lift)
    (lifted_residue_independent φ q basis lift relation)
    (lifted_residue_spanning φ (prime_power_residue_surjective p N positive)
      q basis lift relation)

/-- Actual truncated Witt vectors over any perfect field are free over
the truncated integer residue ring, including arbitrary residue rank. -/
theorem truncated_witt_free (p N : ℕ) [Fact p.Prime]
    (positive : 0 < N) (k : Type*) [Field k] [CharP k p] [PerfectRing k p] :
    Module.Free (ZMod (p ^ N)) (TruncatedWittVector p N k) := by
  letI : Algebra (ZMod p) k := ZMod.algebra k p
  exact Module.Free.of_basis (truncatedWittBasis p N positive k)

end Litt3.Deformations
