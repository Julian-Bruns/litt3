import Solutions.CartierAndSpin.SourceTensorCorrections
import Solutions.CartierAndSpin.LaurentCorrectedEndpoint

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K] [CharP K 5]

/-- In characteristic five the coefficient -4 in the actual Qsharp
tensor is exactly one, without changing the source normalization. -/
theorem source_universal_characteristic_five_twisted_formula
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (q tau c : K) :
    sourceUniversalTwistedEnergy F hs e unit q tau c =
      sourceUniversalSymmetricEnergy F hs e unit +
        rationalSymmetricProduct K (KaehlerDifferential k K)
          (KaehlerDifferential.D k K q) (KaehlerDifferential.D k K (c / tau)) := by
  have hminus : -(4 : K) = 1 := by
    have hfive : (5 : K) = 0 := CharP.cast_eq_zero K 5
    linear_combination -hfive
  unfold sourceUniversalTwistedEnergy
  rw [sub_eq_add_neg, ← neg_smul, hminus, one_smul]

/-- The older corrected tensor differs from Qsharp by its stated
literal differential correction, with the unit denominator explicit. -/
theorem source_universal_characteristic_five_corrected_identity
    (F : K[X]) (hs : F.Separable) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (q tau c : K) (htau : tau ≠ 0) :
    sourceUniversalCorrectedEnergy F hs e unit q tau c =
      sourceUniversalTwistedEnergy F hs e unit q tau c - (2 / tau : K) •
        rationalSymmetricProduct K (KaehlerDifferential k K)
          (KaehlerDifferential.D k K q) (KaehlerDifferential.D k K c) := by
  apply (rationalSymmetricSquareCoordinate e).injective
  simp only [sourceUniversalCorrectedEnergy, sourceUniversalAffineEnergy,
    sourceUniversalTwistedEnergy, map_sub, map_smul,
    rationalSymmetricSquareCoordinate_product, smul_eq_mul,
    ← universalCoordinateDerivation_apply]
  convert characteristic_five_corrected_energy_identity (universalCoordinateDerivation e)
    (rationalSymmetricSquareCoordinate e (sourceUniversalSymmetricEnergy F hs e unit))
    q c tau htau using 1 <;> ring

end Litt3.CartierAndSpin
