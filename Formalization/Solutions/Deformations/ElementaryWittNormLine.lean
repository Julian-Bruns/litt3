import Solutions.Deformations.ElementaryNormReduction

namespace Litt3.Deformations

/-- Literal Teichmüller lifts prove that the actual zeroth-coordinate
map of a positive-length truncated Witt ring is onto. -/
theorem truncated_witt_residue_surjective (p N : ℕ) [Fact p.Prime]
    (positive : 0 < N) (k : Type*) [CommRing k] :
    Function.Surjective (truncatedWittResidue p N positive k) := by
  intro a
  refine ⟨WittVector.truncate N (WittVector.teichmuller p a), ?_⟩
  rw [truncated_witt_residue_truncate, WittVector.teichmuller_coeff_zero]

/-- The reduction of the actual original Witt weight 4r is precisely
the literal norm line in the actual characteristic-five group algebra. -/
theorem elementary_witt_weighted_norm_line [Fact (Nat.Prime 5)]
    (N r : ℕ) (positive : 0 < N) (k : Type*) [Field k] [CharP k 5]
    (y : AddMonoidAlgebra k (Fin r → ZMod 5)) :
    (∃ x : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5),
      x ∈ weightedGeneratorFiltration (TruncatedWittVector 5 N k)
        (5 : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5)) 4
        (elementaryAugmentationParameter (R := TruncatedWittVector 5 N k) 5 r) (4 * r) ∧
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
        (truncatedWittResidue 5 N positive k) x = y) ↔
    ∃ c : k, y = c • ∑ g : Fin r → ZMod 5, AddMonoidAlgebra.single g (1 : k) := by
  letI : Nontrivial (TruncatedWittVector 5 N k) := truncated_witt_nontrivial 5 N positive k
  exact elementary_weighted_reduction_norm_iff (truncatedWittResidue 5 N positive k)
    (truncated_witt_residue_surjective 5 N positive k) r y

end Litt3.Deformations
