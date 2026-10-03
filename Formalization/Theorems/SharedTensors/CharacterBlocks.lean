import Definitions.SharedTensors.CharacterBlocks

namespace Litt3.SharedTensors

open Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- The exact proportionality target, with constants in the specified
embedded coefficient field rather than merely in the ambient field. -/
def CharacterBlockProportionality (D : K →ₗ[k] K) (eta beta : K)
    (V : Submodule k K) (p s : ℕ) (R : K[X]) : Prop :=
  ∀ r : K[X], r.natDegree < p → CoefficientsIn V r →
    IsCharacterBlock D eta beta s r → ∃ c : k, r = c • R

end Litt3.SharedTensors
