import Solutions.SharedTensors.EtaleDifferentialTrace

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

noncomputable def sourceUniversalDifferentialMoment (F : K[X]) (hs : F.Separable)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (unit : (AdjoinRoot F)ˣ) (j : ℕ) :
    KaehlerDifferential k K := by
  letI := separable_polynomial_quotient_etale F hs
  exact etaleDifferentialTrace e
    ((AdjoinRoot.root F ^ (j - 1) * (↑unit⁻¹ : AdjoinRoot F)) •
      KaehlerDifferential.D k (AdjoinRoot F) (AdjoinRoot.root F))

noncomputable def sourceUniversalSymmetricEnergy (F : K[X]) (hs : F.Separable)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (unit : (AdjoinRoot F)ˣ) :
    RationalSymmetricSquare K (KaehlerDifferential k K) := by
  letI := separable_polynomial_quotient_etale F hs
  exact etaleSymmetricTrace e ((↑unit⁻¹ : AdjoinRoot F) •
    rationalSymmetricProduct (AdjoinRoot F) (KaehlerDifferential k (AdjoinRoot F))
      (KaehlerDifferential.D k (AdjoinRoot F) (AdjoinRoot.root F))
      (KaehlerDifferential.D k (AdjoinRoot F) (AdjoinRoot.root F)))

noncomputable def sourceUniversalTwistedEnergy (F : K[X]) (hs : F.Separable)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (unit : (AdjoinRoot F)ˣ)
    (q tau c : K) : RationalSymmetricSquare K (KaehlerDifferential k K) :=
  sourceUniversalSymmetricEnergy F hs e unit - (4 : K) •
    rationalSymmetricProduct K (KaehlerDifferential k K)
      (KaehlerDifferential.D k K q) (KaehlerDifferential.D k K (c / tau))

noncomputable def sourceUniversalTwistedSquare (F : K[X]) (hs : F.Separable)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (unit : (AdjoinRoot F)ˣ) (q : K) :
    RationalSymmetricSquare K (KaehlerDifferential k K) := by
  letI := separable_polynomial_quotient_etale F hs
  let omega := KaehlerDifferential.D k (AdjoinRoot F) (AdjoinRoot.root F) -
    (2 * AdjoinRoot.root F * (↑unit⁻¹ : AdjoinRoot F)) •
      KaehlerDifferential.map k k K (AdjoinRoot F) (KaehlerDifferential.D k K q)
  exact etaleSymmetricTrace e ((↑unit⁻¹ : AdjoinRoot F) •
    rationalSymmetricProduct (AdjoinRoot F) (KaehlerDifferential k (AdjoinRoot F)) omega omega)

noncomputable def sourceUniversalTwistedPowerSquare (F : K[X]) (hs : F.Separable)
    (e : KaehlerDifferential k K ≃ₗ[K] K) (unit : (AdjoinRoot F)ˣ) (p : ℕ) :
    RationalSymmetricSquare K (KaehlerDifferential k K) := by
  letI := separable_polynomial_quotient_etale F hs
  let omega := KaehlerDifferential.D k (AdjoinRoot F)
    (AdjoinRoot.root F * (unit : AdjoinRoot F) ^ (p - 2))
  exact etaleSymmetricTrace e ((↑unit⁻¹ : AdjoinRoot F) ^ (2 * p - 3) •
    rationalSymmetricProduct (AdjoinRoot F) (KaehlerDifferential k (AdjoinRoot F)) omega omega)

end Litt3.CartierAndSpin
