import Solutions.Deformations.ElementaryAugmentationBasis
import Solutions.Deformations.WeightedAdditiveCorrection
import Solutions.Deformations.TruncatedWittResidue

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- The genuine original augmentation monomials generate the entire
actual elementary group algebra, so weight zero is exactly the full ring. -/
theorem elementary_weighted_initial (q : ℕ) (positive : 0 < q) (r : ℕ)
    (p : AddMonoidAlgebra R (Fin r → ZMod q)) (primeWeight : ℕ) :
    weightedGeneratorFiltration R p primeWeight
      (elementaryAugmentationParameter (R := R) q r) 0 = ⊤ := by
  apply top_unique
  rw [← (elementaryAugmentationBasis (R := R) q positive r).span_eq]
  apply Submodule.span_le.mpr
  rintro x ⟨alpha, rfl⟩
  rw [elementary_augmentation_basis_apply]
  simpa only [pow_zero, one_mul, generatorMonomial] using
    weighted_generator_member (R := R) p primeWeight
      (elementaryAugmentationParameter (R := R) q r) 0 0
      (fun i => (alpha i).val) (Nat.zero_le _)

/-- Positive-length actual truncated Witt rings are nontrivial over
every nontrivial coefficient ring, through the actual residue map. -/
theorem truncated_witt_nontrivial (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
    (k : Type*) [CommRing k] [Nontrivial k] :
    Nontrivial (TruncatedWittVector p N k) :=
  (truncatedWittResidue p N positive k).domain_nontrivial

end Litt3.Deformations
