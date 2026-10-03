import Solutions.CartierAndSpin.SourceTensorCorrections
import Solutions.CartierAndSpin.AffineSourceSeparability
import Solutions.CartierAndSpin.AffineSourceClearedEnergy
import Solutions.CartierAndSpin.AffineCorrectionEnergy

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- The centered source-frame law is a literal equality in the genuine
symmetric square of universal differentials. Meromorphic a,b are allowed. -/
theorem source_universal_centered_affine_weight
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) ≠ 0) :
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ (a b : K) (N : ℕ) (ha : a ≠ 0),
        let quotientEquiv := affineSourceQuotientEquiv F a b N ha
        let F' := affineSourceFramePolynomial F a b N
        let H' := C (a ^ N / a ^ p) * H.comp (C a⁻¹ * (X - C b))
        let S' := H' %ₘ (X ^ p + C (a ^ p * q - b ^ p))
        let unit' := Units.map quotientEquiv.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)
        sourceUniversalCenteredEnergy F' (affine_source_frame_separable F hsep a b N ha)
          e unit' (S'.coeff (p - 2) / S'.coeff (p - 1)) =
          a ^ ((2 : ℤ) - (p : ℤ)) • sourceUniversalCenteredEnergy F hsep e unit
            ((H %ₘ (X ^ p + C q)).coeff (p - 2) /
              (H %ₘ (X ^ p + C q)).coeff (p - 1)) := by
  obtain ⟨unit, E, hunit, compatible, hcovariance⟩ := source_frame_centered_energy
    (universalCoordinateDerivation e) F H p q tau hp hdegree htau hsep hsource hs
  refine ⟨unit, hunit, ?_⟩
  intro a b N ha
  dsimp only
  obtain ⟨hunit', compatible', hscalar⟩ := hcovariance a b N ha
  apply (rationalSymmetricSquareCoordinate e).injective
  rw [source_universal_centered_energy_coordinate _ _ e _ _ compatible', map_smul,
    source_universal_centered_energy_coordinate F hsep e unit E compatible,
    smul_eq_mul, ← affine_energy_integer_weight a p ha]
  exact hscalar

/-- The cleared source tensor has the exact source-frame weight
N−3p+3 on the whole coefficient space, including s=0. -/
theorem source_universal_cleared_affine_weight
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau) :
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ (a b : K) (N : ℕ) (ha : a ≠ 0),
        let quotientEquiv := affineSourceQuotientEquiv F a b N ha
        let F' := affineSourceFramePolynomial F a b N
        let H' := C (a ^ N / a ^ p) * H.comp (C a⁻¹ * (X - C b))
        let S' := H' %ₘ (X ^ p + C (a ^ p * q - b ^ p))
        let unit' := Units.map quotientEquiv.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)
        sourceUniversalClearedEnergy F' (affine_source_frame_separable F hsep a b N ha)
          e unit' (a ^ p * q - b ^ p) (a ^ N * tau) (S'.coeff (p - 1)) (S'.coeff (p - 2)) =
          a ^ ((N : ℤ) - 3 * (p : ℤ) + 3) • sourceUniversalClearedEnergy F hsep e unit
            q tau ((H %ₘ (X ^ p + C q)).coeff (p - 1))
              ((H %ₘ (X ^ p + C q)).coeff (p - 2)) := by
  obtain ⟨unit, E, hunit, compatible, hcovariance⟩ := source_frame_cleared_energy
    (universalCoordinateDerivation e) F H p q tau hp hdegree htau hsep hsource
  refine ⟨unit, hunit, ?_⟩
  intro a b N ha
  dsimp only
  obtain ⟨hunit', compatible', hscalar⟩ := hcovariance a b N ha
  apply (rationalSymmetricSquareCoordinate e).injective
  rw [source_universal_cleared_energy_coordinate _ _ e _ _ compatible', map_smul,
    source_universal_cleared_energy_coordinate F hsep e unit E compatible, smul_eq_mul]
  exact hscalar

end Litt3.CartierAndSpin
