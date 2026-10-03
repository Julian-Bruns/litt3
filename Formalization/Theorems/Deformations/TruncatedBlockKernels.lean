import Definitions.Deformations.TruncatedBlockKernels

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

def TruncatedUnitBlockKernel (N j : ℕ)
    (C : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  Nonempty (LinearMap.ker (Matrix.toLin' (truncatedParameter k N ^ j • C))
    ≃ₗ[TruncatedCoefficientRing k N]
      (ι → (TruncatedCoefficientRing k N ⧸
        LinearMap.range (truncatedPowerMultiplication k N j))))

end Litt3.Deformations.Specifications
