import Solutions.CartierAndSpin.SourceTensorCorrections
import Solutions.CartierAndSpin.AffineSourceSeparability
import Solutions.CartierAndSpin.DegreeTenCorrectedAffineEnergy

namespace Litt3.CartierAndSpin

open Polynomial Litt3.SharedTensors

variable {k K : Type*} [Field k] [Field K] [Algebra k K]

/-- The degree-2p Qaff law is a literal universal symmetric tensor law,
including c=0 and arbitrary meromorphic affine changes. -/
theorem source_universal_affine_correction_weight
    (F S : K[X]) (p : ℕ) [CharP K p] (q tau kappa : K)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (hp : 3 ≤ p) (htau : tau ≠ 0) (hkappa : kappa ≠ 0) (hsep : F.Separable)
    (hS : S.natDegree ≤ p - 2)
    (hsource : F = C kappa * (X ^ p + C q) ^ 2 + (X ^ p + C q) * S + C tau) :
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      ∀ (a b : K) (ha : a ≠ 0),
        let quotientEquiv := affineSourceQuotientEquiv F a b (2 * p) ha
        let F' := affineSourceFramePolynomial F a b (2 * p)
        let S' := C (a ^ p) * S.comp (C a⁻¹ * (X - C b))
        let unit' := Units.map quotientEquiv.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)
        sourceUniversalAffineEnergy F' (affine_source_frame_separable F hsep a b (2 * p) ha)
          e unit' (a ^ p * q - b ^ p) (a ^ (2 * p) * tau) (S'.coeff (p - 2)) =
          a ^ ((2 : ℤ) - (p : ℤ)) •
            sourceUniversalAffineEnergy F hsep e unit q tau (S.coeff (p - 2)) := by
  obtain ⟨unit, E, hunit, compatible, hcovariance⟩ := degree_two_p_source_affine_energy
    (universalCoordinateDerivation e) F S p q tau kappa hp htau hkappa hsep hS hsource
  refine ⟨unit, hunit, ?_⟩
  intro a b ha
  dsimp only
  obtain ⟨hpresentation, hunit', compatible', hscalar⟩ := hcovariance a b ha
  apply (rationalSymmetricSquareCoordinate e).injective
  rw [source_universal_affine_energy_coordinate _ _ e _ _ compatible', map_smul,
    source_universal_affine_energy_coordinate F hsep e unit E compatible, smul_eq_mul]
  exact hscalar

/-- In characteristic five, the degree-ten corrected source energy
has exact weight a^-3 as a literal universal symmetric tensor. -/
theorem source_universal_degree_ten_corrected_weight [CharP K 5]
    (F S : K[X]) (q tau kappa : K) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (htau : tau ≠ 0) (hkappa : kappa ≠ 0) (hsep : F.Separable)
    (hS : S.natDegree ≤ 3)
    (hsource : F = C kappa * (X ^ 5 + C q) ^ 2 + (X ^ 5 + C q) * S + C tau) :
    ∃ unit : (AdjoinRoot F)ˣ,
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q) ∧
      ∀ (a b : K) (ha : a ≠ 0),
        let quotientEquiv := affineSourceQuotientEquiv F a b 10 ha
        let F' := affineSourceFramePolynomial F a b 10
        let S' := C (a ^ 5) * S.comp (C a⁻¹ * (X - C b))
        let unit' := Units.map quotientEquiv.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ 5) (pow_ne_zero _ ha) unit)
        sourceUniversalCorrectedEnergy F' (affine_source_frame_separable F hsep a b 10 ha)
          e unit' (a ^ 5 * q - b ^ 5) (a ^ 10 * tau) (S'.coeff 3) =
          a ^ (-3 : ℤ) • sourceUniversalCorrectedEnergy F hsep e unit q tau (S.coeff 3) := by
  obtain ⟨unit, E, hunit, compatible, hcovariance⟩ := degree_ten_source_corrected_affine_energy
    (universalCoordinateDerivation e) F S q tau kappa htau hkappa hsep hS hsource
  refine ⟨unit, hunit, ?_⟩
  intro a b ha
  dsimp only
  obtain ⟨hpresentation, hunit', compatible', hscalar⟩ := hcovariance a b ha
  apply (rationalSymmetricSquareCoordinate e).injective
  rw [source_universal_corrected_energy_coordinate _ _ e _ _ compatible', map_smul,
    source_universal_corrected_energy_coordinate F hsep e unit E compatible, smul_eq_mul]
  exact hscalar

end Litt3.CartierAndSpin
