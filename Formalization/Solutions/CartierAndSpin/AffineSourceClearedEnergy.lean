import Solutions.CartierAndSpin.AffineClearedEnergy
import Solutions.CartierAndSpin.AffineSourceCoefficientWeights
import Solutions.CartierAndSpin.AffineSourceObjects
import Solutions.CartierAndSpin.UnsplitSourceEnergy

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

/-- The actual source-frame cleared R law holds on the entire
coefficient space, with the exact integer weight N−3p+3. No center
coefficient is inverted, including the s=0 boundary. -/
theorem source_frame_cleared_energy (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau) :
    let S := H %ₘ (X ^ p + C q)
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ c : K, E (algebraMap K (AdjoinRoot F) c) = algebraMap K (AdjoinRoot F) (D c)) ∧
      ∀ (a b : K) (N : ℕ) (ha : a ≠ 0),
        let e := affineSourceQuotientEquiv F a b N ha
        let F' := affineSourceFramePolynomial F a b N
        let H' := C (a ^ N / a ^ p) * H.comp (C a⁻¹ * (X - C b))
        let S' := H' %ₘ (X ^ p + C (a ^ p * q - b ^ p))
        let E' := transportedDerivation (e.symm.restrictScalars R) E
        let unit' := Units.map e.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)
        (unit' : AdjoinRoot F') = AdjoinRoot.mk F' (X ^ p + C (a ^ p * q - b ^ p)) ∧
        (∀ c : K, E' (algebraMap K (AdjoinRoot F') c) = algebraMap K (AdjoinRoot F') (D c)) ∧
        clearedDifferentialExpression D (sourceQuotientDifferentialEnergy F' E' unit')
          (a ^ p * q - b ^ p) (a ^ N * tau) (S'.coeff (p - 1)) (S'.coeff (p - 2)) =
          a ^ ((N : ℤ) - 3 * (p : ℤ) + 3) *
            clearedDifferentialExpression D (sourceQuotientDifferentialEnergy F E unit)
              q tau (S.coeff (p - 1)) (S.coeff (p - 2)) := by
  obtain ⟨unit, E, hunit, compatible, hdifferential, hsquare, hpower⟩ :=
    sourceQuotientDifferentialCalculus D F H p q tau hp hdegree htau hsep hsource
  obtain ⟨unit0, hunit0, hmoments⟩ := source_coefficient_moments F H p q tau
    (by omega) hdegree htau hsep hsource
  have hunitEq : unit0 = unit := by
    apply Units.ext
    rw [hunit0, hunit]
  subst unit0
  have hzero : Algebra.trace K (AdjoinRoot F) (↑unit⁻¹ : AdjoinRoot F) = 0 := by
    simpa only [pow_zero, one_mul] using (hmoments 0 (by omega)).1
  have hone : Algebra.trace K (AdjoinRoot F)
      (AdjoinRoot.root F * (↑unit⁻¹ : AdjoinRoot F)) = 0 := by
    simpa only [pow_one] using (hmoments 1 (by omega)).1
  have htwo : Algebra.trace K (AdjoinRoot F)
      (AdjoinRoot.root F ^ 2 * (↑unit⁻¹ : AdjoinRoot F)) = 0 := (hmoments 2 (by omega)).1
  have hfirst : Algebra.trace K (AdjoinRoot F)
      (E (AdjoinRoot.root F) * (↑unit⁻¹ : AdjoinRoot F)) =
        (H %ₘ (X ^ p + C q)).coeff (p - 1) * D q / tau := by
    simpa only [Nat.reduceSub, pow_zero, one_mul] using hdifferential 1 (by omega) (by omega)
  have hsecond : Algebra.trace K (AdjoinRoot F)
      (AdjoinRoot.root F * E (AdjoinRoot.root F) * (↑unit⁻¹ : AdjoinRoot F)) =
        (H %ₘ (X ^ p + C q)).coeff (p - 2) * D q / tau := by
    simpa only [Nat.reduceSub, pow_one] using hdifferential 2 (by omega) (by omega)
  refine ⟨unit, E, hunit, compatible, ?_⟩
  intro a b N ha
  dsimp only
  refine ⟨affine_source_transported_unit_value F p (by omega) a b q N ha unit hunit,
    transportedDerivation_compatible_with_base D E compatible _, ?_⟩
  obtain ⟨hsweight, hcweight⟩ := affine_source_remainder_coefficient_weights p (by omega) H a b q N ha
  rw [hsweight, hcweight]
  unfold sourceQuotientDifferentialEnergy
  rw [trace_derivative_energy_equiv_transport E _ unit (a ^ p) (pow_ne_zero _ ha),
    affineSourceQuotientEquiv_root]
  calc
    _ = (a ^ N * a / (a ^ p) ^ 2) * a ^ 2 / a ^ p *
        clearedDifferentialExpression D
          (Algebra.trace K (AdjoinRoot F) (E (AdjoinRoot.root F) ^ 2 * (↑unit⁻¹ : AdjoinRoot F)))
          q tau ((H %ₘ (X ^ p + C q)).coeff (p - 1))
          ((H %ₘ (X ^ p + C q)).coeff (p - 2)) := by
      apply functional_cleared_energy_affine_covariance D E compatible
        (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F) (AdjoinRoot.root F)
        a b q tau _ _ (a ^ N) _ p ha (pow_ne_zero _ ha) htau rfl
        hzero hone htwo hfirst hsecond
    _ = _ := by rw [affine_cleared_energy_zpow_weight a N p ha]

end Litt3.CartierAndSpin
