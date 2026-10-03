import Solutions.CartierAndSpin.SourceTensorConsequences
import Solutions.CartierAndSpin.AffineSourceSeparability
import Solutions.CartierAndSpin.SourceNormalizationEnergy
import Solutions.CartierAndSpin.SourceTranslationTwistedEnergy

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- Literal Qsharp as a genuine symmetric universal-differential
tensor is independent of every nonzero meromorphic equation scale. -/
theorem source_universal_twisted_normalization_invariant
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau) :
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ (t : K) (ht : t ≠ 0),
        let quotientEquiv := sourceNormalizationQuotientEquiv F t ht
        let unit' := Units.map quotientEquiv.symm.toMonoidHom unit
        sourceUniversalTwistedEnergy (C t * F)
          (Polynomial.Separable.unit_mul ((isUnit_iff_ne_zero.mpr ht).map C) hsep)
          e unit' q (t * tau) (((C t * H) %ₘ (X ^ p + C q)).coeff (p - 2)) =
          sourceUniversalTwistedEnergy F hsep e unit q tau
            ((H %ₘ (X ^ p + C q)).coeff (p - 2)) := by
  obtain ⟨unit, E, hunit, compatible, hscale⟩ := source_normalization_twisted_energy
    (universalCoordinateDerivation e) F H p q tau hp hdegree htau hsep hsource
  refine ⟨unit, hunit, ?_⟩
  intro t ht
  dsimp only
  obtain ⟨hunit', compatible', hscalar⟩ := hscale t ht
  apply (rationalSymmetricSquareCoordinate e).injective
  rw [source_universal_twisted_energy_coordinate _ _ e _ _ compatible',
    source_universal_twisted_energy_coordinate F hsep e unit E compatible]
  exact hscalar

/-- On the exact s=0 boundary, every meromorphic source translation
retains the literal universal Qsharp tensor in the actual new quotient. -/
theorem source_universal_twisted_translation_invariant
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) = 0) :
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ b : K,
        let quotientEquiv := affineSourceQuotientEquiv F 1 b F.natDegree one_ne_zero
        let F' := affineSourceFramePolynomial F 1 b F.natDegree
        let H' := H.comp (X - C b)
        let unit' := Units.map quotientEquiv.symm.toMonoidHom unit
        sourceUniversalTwistedEnergy F'
          (affine_source_frame_separable F hsep 1 b F.natDegree one_ne_zero)
          e unit' (q - b ^ p) tau ((H' %ₘ (X ^ p + C (q - b ^ p))).coeff (p - 2)) =
          sourceUniversalTwistedEnergy F hsep e unit q tau
            ((H %ₘ (X ^ p + C q)).coeff (p - 2)) := by
  obtain ⟨unit, E, hunit, compatible, htranslation⟩ := source_translation_twisted_energy
    (universalCoordinateDerivation e) F H p q tau hp hdegree htau hsep hsource hs
  refine ⟨unit, hunit, ?_⟩
  intro b
  dsimp only
  obtain ⟨hpresentation, hunit', compatible', hscalar⟩ := htranslation b
  apply (rationalSymmetricSquareCoordinate e).injective
  rw [source_universal_twisted_energy_coordinate _ _ e _ _ compatible',
    source_universal_twisted_energy_coordinate F hsep e unit E compatible]
  exact hscalar

end Litt3.CartierAndSpin
