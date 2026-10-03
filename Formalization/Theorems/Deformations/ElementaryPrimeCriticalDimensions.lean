import Solutions.Deformations.ElementaryPrimeWittGradedDimensions

namespace Litt3.Deformations.Specifications

open scoped ElementaryPrimeGradedScalars

/-- Both actual critical quotient spaces have the full original
projective dimension, with their derived residue-field scalar actions. -/
def ElementaryPrimeCriticalDimensions (p r a : ℕ) [Fact p.Prime]
    (k : Type*) [Field k] [CharP k p] [PerfectRing k p] : Prop :=
  letI : Fact (0 < r + 1) := ⟨by omega⟩
  Module.finrank k (ElementaryPrimeWittGradedClass p (r + 1) k r ((p - 1) * r - 1)) =
      (p ^ r - 1) / (p - 1) ∧
    Module.finrank k (ElementaryPrimeWittGradedClass p (r + 1) k r ((p - 1) * r + a - 1)) =
      (p ^ r - 1) / (p - 1)

end Litt3.Deformations.Specifications
