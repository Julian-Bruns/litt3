import Solutions.CartierAndSpin.DegreeTwoPSource
import Solutions.CartierAndSpin.AffineCorrectionEnergy
import Solutions.CartierAndSpin.AffineSourceObjects
import Solutions.CartierAndSpin.UnsplitSourceEnergy

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

/-- Literal degree-2p Qaff covariance under the exact meromorphic
source presentation. Its coefficient c may vanish; no ratio c/s appears. -/
theorem degree_two_p_source_affine_energy (D : Derivation R K K)
    (F S : K[X]) (p : ℕ) [CharP K p] (q tau kappa : K)
    (hp : 3 ≤ p) (htau : tau ≠ 0) (hkappa : kappa ≠ 0) (hsep : F.Separable)
    (hS : S.natDegree ≤ p - 2)
    (hsource : F = C kappa * (X ^ p + C q) ^ 2 + (X ^ p + C q) * S + C tau) :
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ c : K, E (algebraMap K (AdjoinRoot F) c) = algebraMap K (AdjoinRoot F) (D c)) ∧
      ∀ (a b : K) (ha : a ≠ 0),
        let e := affineSourceQuotientEquiv F a b (2 * p) ha
        let F' := affineSourceFramePolynomial F a b (2 * p)
        let S' := C (a ^ p) * S.comp (C a⁻¹ * (X - C b))
        let E' := transportedDerivation (e.symm.restrictScalars R) E
        let unit' := Units.map e.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)
        F' = C kappa * (X ^ p + C (a ^ p * q - b ^ p)) ^ 2 +
          (X ^ p + C (a ^ p * q - b ^ p)) * S' + C (a ^ (2 * p) * tau) ∧
        (unit' : AdjoinRoot F') = AdjoinRoot.mk F' (X ^ p + C (a ^ p * q - b ^ p)) ∧
        (∀ c : K, E' (algebraMap K (AdjoinRoot F') c) = algebraMap K (AdjoinRoot F') (D c)) ∧
        sourceQuotientDifferentialEnergy F' E' unit' -
          D (a ^ p * q - b ^ p) * D (S'.coeff (p - 2)) / (a ^ (2 * p) * tau) =
          a ^ ((2 : ℤ) - (p : ℤ)) *
            (sourceQuotientDifferentialEnergy F E unit - D q * D (S.coeff (p - 2)) / tau) := by
  let H := C kappa * (X ^ p + C q) + S
  have hfactor : F = (X ^ p + C q) * H + C tau := by
    dsimp [H]
    rw [hsource]
    ring
  have hdegree : p ≤ F.natDegree := by
    rw [degree_two_p_source_degree F S p (by omega) q tau kappa hkappa hS hsource]
    omega
  have hrem : H %ₘ (X ^ p + C q) = S :=
    degree_two_p_source_remainder S p (by omega) q kappa hS
  obtain ⟨unit, E, hunit, compatible, hdifferential, hsquare, hpower⟩ :=
    sourceQuotientDifferentialCalculus D F H p q tau hp hdegree htau hsep hfactor
  obtain ⟨unit0, hunit0, hmoments⟩ := source_coefficient_moments F H p q tau
    (by omega) hdegree htau hsep hfactor
  have hunitEq : unit0 = unit := by apply Units.ext; rw [hunit0, hunit]
  subst unit0
  have hzero : Algebra.trace K (AdjoinRoot F) (↑unit⁻¹ : AdjoinRoot F) = 0 := by
    simpa only [pow_zero, one_mul] using (hmoments 0 (by omega)).1
  have hone : Algebra.trace K (AdjoinRoot F)
      (AdjoinRoot.root F * (↑unit⁻¹ : AdjoinRoot F)) = 0 := by
    simpa only [pow_one] using (hmoments 1 (by omega)).1
  have htwo : Algebra.trace K (AdjoinRoot F)
      (AdjoinRoot.root F ^ 2 * (↑unit⁻¹ : AdjoinRoot F)) = 0 := (hmoments 2 (by omega)).1
  have hscoeff : S.coeff (p - 1) = 0 := coeff_eq_zero_of_natDegree_lt (by omega)
  have hfirst : Algebra.trace K (AdjoinRoot F)
      (E (AdjoinRoot.root F) * (↑unit⁻¹ : AdjoinRoot F)) = 0 := by
    have h := hdifferential 1 (by omega) (by omega)
    simpa only [Nat.reduceSub, pow_zero, one_mul, hrem, hscoeff, zero_mul, zero_div] using h
  have hsecond : Algebra.trace K (AdjoinRoot F)
      (AdjoinRoot.root F * E (AdjoinRoot.root F) * (↑unit⁻¹ : AdjoinRoot F)) =
        S.coeff (p - 2) * D q / tau := by
    simpa only [Nat.reduceSub, pow_one, hrem] using hdifferential 2 (by omega) (by omega)
  refine ⟨unit, E, hunit, compatible, ?_⟩
  intro a b ha
  dsimp only
  refine ⟨degree_two_p_source_frame_presentation F S p (by omega) a b q tau kappa ha hsource,
    affine_source_transported_unit_value F p (by omega) a b q (2 * p) ha unit hunit,
    transportedDerivation_compatible_with_base D E compatible _, ?_⟩
  rw [degree_two_p_affine_coefficient S p (by omega) a b ha hS]
  unfold sourceQuotientDifferentialEnergy
  rw [trace_derivative_energy_equiv_transport E _ unit (a ^ p) (pow_ne_zero _ ha),
    affineSourceQuotientEquiv_root]
  have hpowers : a ^ (2 * p) = (a ^ p) ^ 2 := by rw [Nat.mul_comm 2 p, pow_mul]
  rw [hpowers, ← affine_energy_integer_weight a p ha]
  exact functional_affine_correction_covariance D E compatible
    (Algebra.trace K (AdjoinRoot F)) (↑unit⁻¹ : AdjoinRoot F) (AdjoinRoot.root F)
    a b q tau (S.coeff (p - 2)) p ha htau hzero hone htwo hfirst hsecond

end Litt3.CartierAndSpin
