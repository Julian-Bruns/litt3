import Solutions.SharedTensors.EtaleSymmetricTrace
import Solutions.SharedTensors.SeparableQuotientEtale
import Solutions.CartierAndSpin.SourceDerivation

namespace Litt3.SharedTensors

open Litt3.CartierAndSpin Polynomial

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- The constructed source derivation is exactly the coordinate of the
actual universal derivation, even on a disconnected nonmonic quotient. -/
theorem actual_source_derivation_is_universal_coordinate
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : K, E (algebraMap K (AdjoinRoot F) c) =
      algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e c)) :
    letI := separable_polynomial_quotient_etale F hs
    E = universalCoordinateDerivation (etaleDifferentialCoordinate (B := AdjoinRoot F) e) := by
  letI := separable_polynomial_quotient_etale F hs
  exact separable_polynomial_quotient_derivation_unique (universalCoordinateDerivation e)
    F hs E (universalCoordinateDerivation (etaleDifferentialCoordinate e)) compatible
    (etale_universal_derivation_compatibility e)

/-- The actual scalar weighted energy is precisely the coordinate of the
actual universal symmetric-tensor trace on the original source quotient. -/
theorem actual_source_weighted_symmetric_trace
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : K, E (algebraMap K (AdjoinRoot F) c) =
      algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e c))
    (a b weight : AdjoinRoot F) :
    letI := separable_polynomial_quotient_etale F hs
    rationalSymmetricSquareCoordinate e (etaleSymmetricTrace e
      (weight • rationalSymmetricProduct (AdjoinRoot F) (KaehlerDifferential k (AdjoinRoot F))
        (KaehlerDifferential.D k (AdjoinRoot F) a)
        (KaehlerDifferential.D k (AdjoinRoot F) b))) =
      Algebra.trace K (AdjoinRoot F) (weight * E a * E b) := by
  letI := separable_polynomial_quotient_etale F hs
  rw [actual_source_derivation_is_universal_coordinate F hs e E compatible]
  exact etale_universal_weighted_product_trace e a b weight

end Litt3.SharedTensors
