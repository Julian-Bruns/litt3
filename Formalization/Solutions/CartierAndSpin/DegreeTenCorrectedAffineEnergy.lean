import Solutions.CartierAndSpin.DegreeTwoPAffineEnergy

namespace Litt3.CartierAndSpin

open Polynomial

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K] [CharP K 5]

/-- In the exact degree-ten source presentation, the corrected energy
has affine weight a^-3, even for meromorphic a,b and zero c. -/
theorem degree_ten_source_corrected_affine_energy (D : Derivation R K K)
    (F S : K[X]) (q tau kappa : K) (htau : tau ≠ 0) (hkappa : kappa ≠ 0)
    (hsep : F.Separable) (hS : S.natDegree ≤ 3)
    (hsource : F = C kappa * (X ^ 5 + C q) ^ 2 + (X ^ 5 + C q) * S + C tau) :
    ∃ (unit : (AdjoinRoot F)ˣ) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F)),
      (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ 5 + C q) ∧
      (∀ c : K, E (algebraMap K (AdjoinRoot F) c) = algebraMap K (AdjoinRoot F) (D c)) ∧
      ∀ (a b : K) (ha : a ≠ 0),
        let e := affineSourceQuotientEquiv F a b 10 ha
        let F' := affineSourceFramePolynomial F a b 10
        let S' := C (a ^ 5) * S.comp (C a⁻¹ * (X - C b))
        let E' := transportedDerivation (e.symm.restrictScalars R) E
        let unit' := Units.map e.symm.toMonoidHom
          (scaledAlgebraUnit (a ^ 5) (pow_ne_zero _ ha) unit)
        F' = C kappa * (X ^ 5 + C (a ^ 5 * q - b ^ 5)) ^ 2 +
          (X ^ 5 + C (a ^ 5 * q - b ^ 5)) * S' + C (a ^ 10 * tau) ∧
        (unit' : AdjoinRoot F') = AdjoinRoot.mk F' (X ^ 5 + C (a ^ 5 * q - b ^ 5)) ∧
        (∀ c : K, E' (algebraMap K (AdjoinRoot F') c) = algebraMap K (AdjoinRoot F') (D c)) ∧
        sourceQuotientDifferentialEnergy F' E' unit' -
          D (a ^ 5 * q - b ^ 5) * D (S'.coeff 3) / (a ^ 10 * tau) -
          S'.coeff 3 * D (a ^ 5 * q - b ^ 5) * D (a ^ 10 * tau) / (a ^ 10 * tau) ^ 2 =
          a ^ (-3 : ℤ) * (sourceQuotientDifferentialEnergy F E unit -
            D q * D (S.coeff 3) / tau - S.coeff 3 * D q * D tau / tau ^ 2) := by
  obtain ⟨unit, E, hunit, compatible, hcovariance⟩ :=
    degree_two_p_source_affine_energy D F S 5 q tau kappa (by omega) htau hkappa hsep hS hsource
  refine ⟨unit, E, hunit, compatible, ?_⟩
  intro a b ha
  dsimp only
  obtain ⟨hpresentation, hunit', compatible', henergy⟩ := hcovariance a b ha
  refine ⟨hpresentation, hunit', compatible', ?_⟩
  norm_num only at henergy
  rw [henergy, degree_two_p_affine_coefficient S 5 (by omega) a b ha hS]
  have hDpower5 (x : K) : D (x ^ 5) = 0 := by
    simp only [D.leibniz_pow, nsmul_eq_mul, smul_eq_mul, CharP.cast_eq_zero, zero_mul]
  have hDq : D (a ^ 5 * q - b ^ 5) = a ^ 5 * D q := by
    rw [map_sub, D.leibniz, hDpower5, hDpower5]
    simp only [smul_eq_mul, mul_zero, add_zero, sub_zero]
  have hDpower10 : D (a ^ 10) = 0 := by
    rw [show a ^ 10 = (a ^ 5) ^ 2 by rw [← pow_mul], D.leibniz_pow, hDpower5]
    simp
  have hDtau : D (a ^ 10 * tau) = a ^ 10 * D tau := by
    rw [D.leibniz, hDpower10]
    simp only [smul_eq_mul, mul_zero, add_zero]
  have hterm : a ^ 2 * S.coeff 3 * D (a ^ 5 * q - b ^ 5) * D (a ^ 10 * tau) /
      (a ^ 10 * tau) ^ 2 = a ^ (-3 : ℤ) * (S.coeff 3 * D q * D tau / tau ^ 2) := by
    rw [hDq, hDtau, zpow_neg, zpow_ofNat]
    field_simp
  rw [hterm]
  ring

end Litt3.CartierAndSpin
