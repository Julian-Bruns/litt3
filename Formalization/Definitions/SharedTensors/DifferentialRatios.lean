import Definitions.SharedTensors.RationalCartier

namespace Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]

/-- Ratio of actual rational differentials. Coordinate independence is
proved using their genuine rank-one module, including zero numerators. -/
def rationalDifferentialRatio (e : KaehlerDifferential k K ≃ₗ[K] K)
    (eta theta : KaehlerDifferential k K) : K := e eta / e theta

variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The actual Cartier ratio of a rational differential. -/
def rationalCartierRatio (e : KaehlerDifferential k K ≃ₗ[K] K)
    (C : RationalCartierOperator k K p) (theta : KaehlerDifferential k K) : K :=
  rationalDifferentialRatio e (C.toAddHom theta) theta

/-- The actual second recovery function, dq/theta, using the universal
derivation of the already actual Cartier ratio. -/
noncomputable def rationalCartierRecoveryDerivative (e : KaehlerDifferential k K ≃ₗ[K] K)
    (C : RationalCartierOperator k K p) (theta : KaehlerDifferential k K) : K :=
  rationalDifferentialRatio e
    (KaehlerDifferential.D k K (rationalCartierRatio e C theta)) theta

end Litt3.SharedTensors
