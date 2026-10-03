import Theorems.CartierAndSpin.SourceTensorEnergy
import Solutions.CartierAndSpin.UnsplitSourceEnergy

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

theorem source_universal_differential_moment_coordinate
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : K, E (algebraMap K (AdjoinRoot F) c) =
      algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e c)) (j : ℕ) :
    e (sourceUniversalDifferentialMoment F hs e unit j) =
      Algebra.trace K (AdjoinRoot F)
        (AdjoinRoot.root F ^ (j - 1) * E (AdjoinRoot.root F) * (↑unit⁻¹ : AdjoinRoot F)) := by
  letI := separable_polynomial_quotient_etale F hs
  have hE := actual_source_derivation_is_universal_coordinate F hs e E compatible
  unfold sourceUniversalDifferentialMoment
  rw [etale_weighted_universal_differential_trace, ← hE]
  congr 1
  ring

theorem source_universal_symmetric_energy_coordinate
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : K, E (algebraMap K (AdjoinRoot F) c) =
      algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e c)) :
    rationalSymmetricSquareCoordinate e (sourceUniversalSymmetricEnergy F hs e unit) =
      sourceQuotientDifferentialEnergy F E unit := by
  letI := separable_polynomial_quotient_etale F hs
  unfold sourceUniversalSymmetricEnergy sourceQuotientDifferentialEnergy
  rw [actual_source_weighted_symmetric_trace F hs e E compatible]
  congr 1
  ring

theorem source_universal_twisted_energy_coordinate
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ a : K, E (algebraMap K (AdjoinRoot F) a) =
      algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e a)) (q tau c : K) :
    rationalSymmetricSquareCoordinate e (sourceUniversalTwistedEnergy F hs e unit q tau c) =
      sourceQuotientDifferentialEnergy F E unit -
        4 * universalCoordinateDerivation e q * universalCoordinateDerivation e (c / tau) := by
  unfold sourceUniversalTwistedEnergy
  rw [map_sub, map_smul, source_universal_symmetric_energy_coordinate F hs e unit E compatible,
    rationalSymmetricSquareCoordinate_product]
  simp only [smul_eq_mul, universalCoordinateDerivation_apply]
  ring

theorem source_universal_twisted_square_coordinate
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ a : K, E (algebraMap K (AdjoinRoot F) a) =
      algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e a)) (q : K) :
    rationalSymmetricSquareCoordinate e (sourceUniversalTwistedSquare F hs e unit q) =
      sourceQuotientTwistedDifferentialEnergy (universalCoordinateDerivation e) F E unit q := by
  letI := separable_polynomial_quotient_etale F hs
  have hE := actual_source_derivation_is_universal_coordinate F hs e E compatible
  have hcoord : etaleDifferentialCoordinate (B := AdjoinRoot F) e
      (KaehlerDifferential.D k (AdjoinRoot F) (AdjoinRoot.root F) -
        (2 * AdjoinRoot.root F * (↑unit⁻¹ : AdjoinRoot F)) •
          KaehlerDifferential.map k k K (AdjoinRoot F) (KaehlerDifferential.D k K q)) =
      E (AdjoinRoot.root F) - 2 * AdjoinRoot.root F *
        algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e q) *
          (↑unit⁻¹ : AdjoinRoot F) := by
    rw [map_sub, map_smul, etaleDifferentialCoordinate_map]
    change universalCoordinateDerivation (etaleDifferentialCoordinate e) (AdjoinRoot.root F) -
      _ = _
    rw [← hE]
    simp only [smul_eq_mul, universalCoordinateDerivation_apply]
    ring
  unfold sourceUniversalTwistedSquare sourceQuotientTwistedDifferentialEnergy
  rw [etaleSymmetricTrace_coordinate, map_smul, rationalSymmetricSquareCoordinate_product, hcoord]
  simp only [smul_eq_mul, pow_two]
  congr 1
  ring

theorem source_universal_twisted_power_coordinate
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ a : K, E (algebraMap K (AdjoinRoot F) a) =
      algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e a)) (p : ℕ) :
    rationalSymmetricSquareCoordinate e (sourceUniversalTwistedPowerSquare F hs e unit p) =
      Algebra.trace K (AdjoinRoot F)
        (E (AdjoinRoot.root F * (unit : AdjoinRoot F) ^ (p - 2)) ^ 2 *
          (↑unit⁻¹ : AdjoinRoot F) ^ (2 * p - 3)) := by
  letI := separable_polynomial_quotient_etale F hs
  unfold sourceUniversalTwistedPowerSquare
  rw [actual_source_weighted_symmetric_trace F hs e E compatible]
  congr 1
  ring

/-- Both literal universal square presentations and the entire linear
differential moment family in the original source, including disconnected
finite etale algebras. -/
theorem source_universal_tensor_calculus
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (hs : F.Separable) :
    Specifications.SourceUniversalTensorCalculus F H p q tau e hs := by
  intro hp hdegree htau hsource
  obtain ⟨unit, E, hunit, compatible, hdifferential, hsquare, hpower⟩ :=
    sourceQuotientDifferentialCalculus (universalCoordinateDerivation e)
      F H p q tau hp hdegree htau hs hsource
  refine ⟨unit, hunit, ?_, ?_, ?_⟩
  · intro j hj0 hj
    apply e.injective
    rw [source_universal_differential_moment_coordinate F hs e unit E compatible j,
      map_smul, smul_eq_mul]
    rw [hdifferential j hj0 hj]
    simp only [universalCoordinateDerivation_apply]
    ring
  · apply (rationalSymmetricSquareCoordinate e).injective
    rw [source_universal_twisted_energy_coordinate F hs e unit E compatible,
      source_universal_twisted_square_coordinate F hs e unit E compatible]
    exact hsquare
  · apply (rationalSymmetricSquareCoordinate e).injective
    rw [source_universal_twisted_energy_coordinate F hs e unit E compatible,
      source_universal_twisted_power_coordinate F hs e unit E compatible]
    exact hpower

end Litt3.CartierAndSpin
