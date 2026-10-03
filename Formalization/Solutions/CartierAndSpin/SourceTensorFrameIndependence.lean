import Definitions.CartierAndSpin.SourceTensorCorrections

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- The actual source energy does not depend on the meromorphic
coordinate used to construct its universal tensor trace. -/
theorem source_universal_energy_frame_independent
    (F : K[X]) (hs : F.Separable) (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) :
    sourceUniversalSymmetricEnergy F hs e unit = sourceUniversalSymmetricEnergy F hs e' unit := by
  letI := separable_polynomial_quotient_etale F hs
  unfold sourceUniversalSymmetricEnergy
  exact etaleSymmetricTrace_independent e e' _

theorem source_universal_centered_frame_independent
    (F : K[X]) (hs : F.Separable) (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (center : K) :
    sourceUniversalCenteredEnergy F hs e unit center =
      sourceUniversalCenteredEnergy F hs e' unit center := by
  letI := separable_polynomial_quotient_etale F hs
  unfold sourceUniversalCenteredEnergy
  exact etaleSymmetricTrace_independent e e' _

theorem source_universal_twisted_frame_independent
    (F : K[X]) (hs : F.Separable) (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (q tau c : K) :
    sourceUniversalTwistedEnergy F hs e unit q tau c =
      sourceUniversalTwistedEnergy F hs e' unit q tau c := by
  unfold sourceUniversalTwistedEnergy
  rw [source_universal_energy_frame_independent F hs e e' unit]

theorem source_universal_cleared_frame_independent
    (F : K[X]) (hs : F.Separable) (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (q tau s c : K) :
    sourceUniversalClearedEnergy F hs e unit q tau s c =
      sourceUniversalClearedEnergy F hs e' unit q tau s c := by
  unfold sourceUniversalClearedEnergy
  rw [source_universal_energy_frame_independent F hs e e' unit]

theorem source_universal_affine_frame_independent
    (F : K[X]) (hs : F.Separable) (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (q tau c : K) :
    sourceUniversalAffineEnergy F hs e unit q tau c =
      sourceUniversalAffineEnergy F hs e' unit q tau c := by
  unfold sourceUniversalAffineEnergy
  rw [source_universal_energy_frame_independent F hs e e' unit]

theorem source_universal_corrected_frame_independent
    (F : K[X]) (hs : F.Separable) (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (q tau c : K) :
    sourceUniversalCorrectedEnergy F hs e unit q tau c =
      sourceUniversalCorrectedEnergy F hs e' unit q tau c := by
  unfold sourceUniversalCorrectedEnergy
  rw [source_universal_affine_frame_independent F hs e e' unit]

theorem source_universal_twisted_square_frame_independent
    (F : K[X]) (hs : F.Separable) (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (q : K) :
    sourceUniversalTwistedSquare F hs e unit q = sourceUniversalTwistedSquare F hs e' unit q := by
  letI := separable_polynomial_quotient_etale F hs
  unfold sourceUniversalTwistedSquare
  exact etaleSymmetricTrace_independent e e' _

theorem source_universal_twisted_power_frame_independent
    (F : K[X]) (hs : F.Separable) (e e' : KaehlerDifferential k K ≃ₗ[K] K)
    (unit : (AdjoinRoot F)ˣ) (p : ℕ) :
    sourceUniversalTwistedPowerSquare F hs e unit p =
      sourceUniversalTwistedPowerSquare F hs e' unit p := by
  letI := separable_polynomial_quotient_etale F hs
  unfold sourceUniversalTwistedPowerSquare
  exact etaleSymmetricTrace_independent e e' _

end Litt3.CartierAndSpin
