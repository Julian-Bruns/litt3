import Solutions.CartierAndSpin.AffineSourceRemainder
import Solutions.CartierAndSpin.AffineTraceTransport

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]

theorem affine_source_quotient_factor (F : K[X]) (p : ℕ) [CharP K p] (hp : 2 ≤ p)
    (a b q : K) (N : ℕ) (ha : a ≠ 0) :
    affineSourceQuotientEquiv F a b N ha
      (AdjoinRoot.mk (affineSourceFramePolynomial F a b N)
        (X ^ p + C (a ^ p * q - b ^ p))) =
      algebraMap K (AdjoinRoot F) (a ^ p) * AdjoinRoot.mk F (X ^ p + C q) := by
  rw [← AdjoinRoot.aeval_eq, ← aeval_algHom_apply,
    affineSourceQuotientEquiv_root, affine_source_characteristic_factor p hp a b q ha,
    map_mul, aeval_C, aeval_comp]
  have hcoordinate : aeval
      (algebraMap K (AdjoinRoot F) a * AdjoinRoot.root F + algebraMap K (AdjoinRoot F) b)
      (C a⁻¹ * (X - C b)) = AdjoinRoot.root F := by
    rw [map_mul, aeval_C, map_sub, aeval_X, aeval_C, add_sub_cancel_right,
      ← mul_assoc, ← map_mul, inv_mul_cancel₀ ha, map_one, one_mul]
  rw [hcoordinate, AdjoinRoot.aeval_eq]

/-- The full actual source-frame centered-energy law, with the new
source quotient, new remainder center, derivative and denominator unit
all constructed from the exact transformed presentation. -/
theorem source_frame_centered_energy (D : Derivation R K K)
    (F H : K[X]) (p : ℕ) [CharP K p] (q tau : K)
    (hp : 3 ≤ p) (hdegree : p ≤ F.natDegree) (htau : tau ≠ 0)
    (hsep : F.Separable) (hsource : F = (X ^ p + C q) * H + C tau)
    (hs : (H %ₘ (X ^ p + C q)).coeff (p - 1) ≠ 0) :
    let center := (H %ₘ (X ^ p + C q)).coeff (p - 2) /
      (H %ₘ (X ^ p + C q)).coeff (p - 1)
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q) ∧
      (∀ c : K, E (algebraMap K (AdjoinRoot F) c) = algebraMap K (AdjoinRoot F) (D c)) ∧
      ∀ (a b : K) (N : ℕ) (ha : a ≠ 0),
        let e := affineSourceQuotientEquiv F a b N ha
        let F' := affineSourceFramePolynomial F a b N
        let H' := C (a ^ N / a ^ p) * H.comp (C a⁻¹ * (X - C b))
        let center' := (H' %ₘ (X ^ p + C (a ^ p * q - b ^ p))).coeff (p - 2) /
          (H' %ₘ (X ^ p + C (a ^ p * q - b ^ p))).coeff (p - 1)
        let E' := transportedDerivation (e.symm.restrictScalars R) E
        let unit' := Units.map e.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)
        (unit' : AdjoinRoot F') = AdjoinRoot.mk F' (X ^ p + C (a ^ p * q - b ^ p)) ∧
        (∀ c : K, E' (algebraMap K (AdjoinRoot F') c) =
          algebraMap K (AdjoinRoot F') (D c)) ∧
        Algebra.trace K (AdjoinRoot F')
          (E' (AdjoinRoot.root F' - algebraMap K (AdjoinRoot F') center') ^ 2 *
            (↑unit'⁻¹ : AdjoinRoot F')) =
          a ^ 2 / a ^ p * Algebra.trace K (AdjoinRoot F)
            (E (AdjoinRoot.root F - algebraMap K (AdjoinRoot F) center) ^ 2 *
              (↑unit⁻¹ : AdjoinRoot F)) := by
  obtain ⟨unit, E, hunit, compatible, hscaling⟩ :=
    source_quotient_centered_affine_scaling D F H p q tau hp hdegree htau hsep hsource hs
  refine ⟨unit, E, hunit, compatible, ?_⟩
  intro a b N ha
  dsimp only
  let e := affineSourceQuotientEquiv F a b N ha
  have hcenter := affine_source_remainder_center p (by omega) H a b q
    (a ^ N / a ^ p) ha (div_ne_zero (pow_ne_zero _ ha) (pow_ne_zero _ ha)) hs
  constructor
  · apply e.injective
    change e (e.symm (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit : AdjoinRoot F)) = _
    rw [e.apply_symm_apply, scaledAlgebraUnit_value, hunit]
    exact (affine_source_quotient_factor F p (by omega) a b q N ha).symm
  constructor
  · intro c
    change e.symm (E (e (algebraMap K _ c))) = _
    rw [e.commutes, compatible, e.symm.commutes]
  · rw [← Algebra.trace_eq_of_algEquiv e, map_mul, map_pow]
    have hderivative (x : AdjoinRoot (affineSourceFramePolynomial F a b N)) :
        e (transportedDerivation (e.symm.restrictScalars R) E x) = E (e x) := by
      change e (e.symm (E (e x))) = E (e x)
      exact e.apply_symm_apply _
    have hinverse : e (↑(Units.map e.symm.toMonoidHom
        (scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit))⁻¹ :
          AdjoinRoot (affineSourceFramePolynomial F a b N)) =
        (a ^ p)⁻¹ • (↑unit⁻¹ : AdjoinRoot F) := by
      rw [← map_inv]
      change e (e.symm (↑(scaledAlgebraUnit (a ^ p) (pow_ne_zero _ ha) unit)⁻¹ : AdjoinRoot F)) = _
      rw [e.apply_symm_apply, scaledAlgebraUnit_inverse_value]
    rw [hderivative, hinverse, map_sub, e.commutes,
      affineSourceQuotientEquiv_root, hcenter]
    exact hscaling a b

end Litt3.CartierAndSpin
