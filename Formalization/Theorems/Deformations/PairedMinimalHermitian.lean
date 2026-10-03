import Definitions.Deformations.PairedMinimalHermitian

namespace Litt3.Deformations.Specifications

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

def PairedMinimalHermitianModel (N : ℕ)
    (A : Matrix ι ι (TruncatedCoefficientRing k N)) : Prop :=
  ∃ B : Matrix ι ι (TruncatedCoefficientRing k N),
    truncatedHermitianTranspose k N B = B ∧
      Nonempty (LinearMap.ker (Matrix.toLin' A) ≃ₗ[TruncatedCoefficientRing k N]
        LinearMap.ker (Matrix.toLin' B))

end Litt3.Deformations.Specifications
