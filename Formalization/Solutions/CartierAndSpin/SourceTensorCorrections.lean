import Definitions.CartierAndSpin.SourceTensorCorrections
import Solutions.CartierAndSpin.SourceTensorConsequences
import Definitions.CartierAndSpin.ClearedEnergy

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

theorem source_universal_centered_energy_coordinate
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ a : K, E (algebraMap K (AdjoinRoot F) a) =
      algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e a)) (center : K) :
    rationalSymmetricSquareCoordinate e (sourceUniversalCenteredEnergy F hs e unit center) =
      Algebra.trace K (AdjoinRoot F)
        (E (AdjoinRoot.root F - algebraMap K (AdjoinRoot F) center) ^ 2 *
          (↑unit⁻¹ : AdjoinRoot F)) := by
  letI := separable_polynomial_quotient_etale F hs
  unfold sourceUniversalCenteredEnergy
  rw [actual_source_weighted_symmetric_trace F hs e E compatible]
  congr 1
  ring

theorem source_universal_cleared_energy_coordinate
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ a : K, E (algebraMap K (AdjoinRoot F) a) =
      algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e a)) (q tau s c : K) :
    rationalSymmetricSquareCoordinate e (sourceUniversalClearedEnergy F hs e unit q tau s c) =
      clearedDifferentialExpression (universalCoordinateDerivation e)
        (sourceQuotientDifferentialEnergy F E unit) q tau s c := by
  unfold sourceUniversalClearedEnergy clearedDifferentialExpression
  rw [map_sub, map_smul, source_universal_symmetric_energy_coordinate F hs e unit E compatible,
    map_smul, rationalSymmetricSquareCoordinate_product, map_sub, map_smul, map_smul]
  simp only [smul_eq_mul, universalCoordinateDerivation_apply, div_eq_mul_inv]
  ring

theorem source_universal_affine_energy_coordinate
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ a : K, E (algebraMap K (AdjoinRoot F) a) =
      algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e a)) (q tau c : K) :
    rationalSymmetricSquareCoordinate e (sourceUniversalAffineEnergy F hs e unit q tau c) =
      sourceQuotientDifferentialEnergy F E unit -
        universalCoordinateDerivation e q * universalCoordinateDerivation e c / tau := by
  unfold sourceUniversalAffineEnergy
  rw [map_sub, source_universal_symmetric_energy_coordinate F hs e unit E compatible,
    map_smul, rationalSymmetricSquareCoordinate_product]
  simp only [smul_eq_mul, universalCoordinateDerivation_apply, div_eq_mul_inv]
  ring

theorem source_universal_corrected_energy_coordinate
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (E : Derivation k (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ a : K, E (algebraMap K (AdjoinRoot F) a) =
      algebraMap K (AdjoinRoot F) (universalCoordinateDerivation e a)) (q tau c : K) :
    rationalSymmetricSquareCoordinate e (sourceUniversalCorrectedEnergy F hs e unit q tau c) =
      sourceQuotientDifferentialEnergy F E unit -
        universalCoordinateDerivation e q * universalCoordinateDerivation e c / tau -
        c * universalCoordinateDerivation e q * universalCoordinateDerivation e tau / tau ^ 2 := by
  unfold sourceUniversalCorrectedEnergy
  rw [map_sub, source_universal_affine_energy_coordinate F hs e unit E compatible,
    map_smul, rationalSymmetricSquareCoordinate_product]
  simp only [smul_eq_mul, universalCoordinateDerivation_apply, div_eq_mul_inv]
  ring

end Litt3.CartierAndSpin
