import Definitions.CartierAndSpin.SourceTensorEnergy

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

noncomputable def sourceUniversalCenteredEnergy (F : K[X]) (hs : F.Separable)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (unit : (AdjoinRoot F)ˣ) (center : K) :
    RationalSymmetricSquare K (KaehlerDifferential k K) := by
  letI := separable_polynomial_quotient_etale F hs
  let omega := KaehlerDifferential.D k (AdjoinRoot F)
    (AdjoinRoot.root F - algebraMap K (AdjoinRoot F) center)
  exact etaleSymmetricTrace e ((↑unit⁻¹ : AdjoinRoot F) •
    rationalSymmetricProduct (AdjoinRoot F) (KaehlerDifferential k (AdjoinRoot F)) omega omega)

noncomputable def sourceUniversalClearedEnergy (F : K[X]) (hs : F.Separable)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (unit : (AdjoinRoot F)ˣ) (q tau s c : K) :
    RationalSymmetricSquare K (KaehlerDifferential k K) :=
  s • sourceUniversalSymmetricEnergy F hs e unit - (2 / tau : K) •
    rationalSymmetricProduct K (KaehlerDifferential k K) (KaehlerDifferential.D k K q)
      (s • KaehlerDifferential.D k K c - c • KaehlerDifferential.D k K s)

noncomputable def sourceUniversalAffineEnergy (F : K[X]) (hs : F.Separable)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (unit : (AdjoinRoot F)ˣ) (q tau c : K) :
    RationalSymmetricSquare K (KaehlerDifferential k K) :=
  sourceUniversalSymmetricEnergy F hs e unit - (tau⁻¹ : K) •
    rationalSymmetricProduct K (KaehlerDifferential k K)
      (KaehlerDifferential.D k K q) (KaehlerDifferential.D k K c)

noncomputable def sourceUniversalCorrectedEnergy (F : K[X]) (hs : F.Separable)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (unit : (AdjoinRoot F)ˣ) (q tau c : K) :
    RationalSymmetricSquare K (KaehlerDifferential k K) :=
  sourceUniversalAffineEnergy F hs e unit q tau c - (c / tau ^ 2 : K) •
    rationalSymmetricProduct K (KaehlerDifferential k K)
      (KaehlerDifferential.D k K q) (KaehlerDifferential.D k K tau)

end Litt3.CartierAndSpin
