import Solutions.Deformations.ElementaryPrimeNormReduction
import Solutions.Deformations.ElementaryWittNormLine

namespace Litt3.Deformations

/-- The literal original Witt norm line at every prime, positive precision
and rank, with all reduced coefficients realized by actual Teichmüller lifts. -/
theorem elementary_prime_witt_weighted_norm_line (p : ℕ) [Fact p.Prime]
    (N r : ℕ) (positive : 0 < N) (k : Type*) [Field k] [CharP k p]
    (y : AddMonoidAlgebra k (Fin r → ZMod p)) :
    (∃ x : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p),
      x ∈ @elementaryNormalWeightFiltration (TruncatedWittVector p N k) _
        (truncated_witt_nontrivial p N positive k) p (Fact.out : p.Prime).pos r ((p - 1) * r) ∧
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
        (truncatedWittResidue p N positive k) x = y) ↔
      ∃ c : k, y = c • ∑ g : Fin r → ZMod p, AddMonoidAlgebra.single g (1 : k) := by
  letI : Nontrivial (TruncatedWittVector p N k) := truncated_witt_nontrivial p N positive k
  simpa only [elementary_prime_normal_weights_eq p (Fact.out : p.Prime)] using
    elementary_prime_weighted_reduction_norm_iff p (truncatedWittResidue p N positive k)
      (truncated_witt_residue_surjective p N positive k) r y

end Litt3.Deformations
