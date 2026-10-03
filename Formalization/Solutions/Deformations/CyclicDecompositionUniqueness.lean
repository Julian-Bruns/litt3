import Theorems.Deformations.CyclicDecompositionUniqueness
import Solutions.Deformations.CyclicBlockProfile

namespace Litt3.Deformations

variable {k : Type*} [Field k]

/-- The full actual Q_N-module determines every positive
cyclic multiplicity uniquely. This is proved from actual
power-kernel dimensions rather than assumed classification. -/
theorem truncated_cyclic_decomposition_unique (N s t : ℕ)
    (degree multiplicity : Fin s → ℕ) (degree' multiplicity' : Fin t → ℕ)
    (bounded : ∀ i, degree i ≤ N) (bounded' : ∀ i, degree' i ≤ N)
    (E : TruncatedCyclicBlocks k N s degree multiplicity ≃ₗ[TruncatedCoefficientRing k N]
      TruncatedCyclicBlocks k N t degree' multiplicity') :
    Specifications.CyclicDecompositionUnique s t degree multiplicity degree' multiplicity' := by
  apply cyclic_multiplicity_profile_unique degree multiplicity degree' multiplicity'
  intro a
  calc
    cyclicDimensionProfile degree multiplicity a =
        Module.finrank k (LinearMap.ker (truncatedModulePowerMap k N a
          (TruncatedCyclicBlocks k N s degree multiplicity))) :=
      (truncated_cyclic_block_profile N s degree multiplicity bounded a).symm
    _ = Module.finrank k (LinearMap.ker (truncatedModulePowerMap k N a
        (TruncatedCyclicBlocks k N t degree' multiplicity'))) :=
      ((truncatedPowerKernelCongr N a E).restrictScalars k).finrank_eq
    _ = cyclicDimensionProfile degree' multiplicity' a :=
      truncated_cyclic_block_profile N t degree' multiplicity' bounded' a

end Litt3.Deformations
