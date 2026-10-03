import Definitions.Deformations.PairedMinimalHermitian
import Definitions.Deformations.CanonicalCyclicParity

namespace Litt3.Deformations

variable {k : Type*} [Field k]

/-- An actual paired minimal free complex realizing a
specified full section module. The geometric realization
of these data is a separate obligation. -/
structure CyclicPairedSectionModel (N : ℕ) (positive : 0 < N) (V : Type*)
    [AddCommGroup V] [Module k V] [Module (TruncatedCoefficientRing k N) V]
    [IsScalarTower k (TruncatedCoefficientRing k N) V] where
  d : ℕ
  differential : Matrix (Fin d) (Fin d) (TruncatedCoefficientRing k N)
  paired_complex : MinimalSkewPairingData N positive differential
  sections : V ≃ₗ[TruncatedCoefficientRing k N] LinearMap.ker (Matrix.toLin' differential)

end Litt3.Deformations
