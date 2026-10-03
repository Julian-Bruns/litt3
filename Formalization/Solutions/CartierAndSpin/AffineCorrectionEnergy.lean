import Solutions.CartierAndSpin.AffineDifferentialEnergy

namespace Litt3.CartierAndSpin

variable {R K A : Type*} [CommRing R] [Field K] [Algebra R K]
  [CommRing A] [Algebra K A] [Algebra R A]

/-- The affine correction cancels the derivative of a meromorphic
scale, including c=0 and arbitrary meromorphic translations. -/
theorem functional_affine_correction_covariance (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ x : K, E (algebraMap K A x) = algebraMap K A (D x))
    (l : A →ₗ[K] K) (weight w : A) (a b q tau c : K) (p : ℕ) [CharP K p]
    (ha : a ≠ 0) (htau : tau ≠ 0)
    (hzero : l weight = 0) (hone : l (w * weight) = 0)
    (htwo : l (w ^ 2 * weight) = 0) (hfirst : l (E w * weight) = 0)
    (hsecond : l (w * E w * weight) = c * D q / tau) :
    l (E (algebraMap K A a * w + algebraMap K A b) ^ 2 * ((a ^ p)⁻¹ • weight)) -
      D (a ^ p * q - b ^ p) * D (a ^ 2 * c) / ((a ^ p) ^ 2 * tau) =
      a ^ 2 / a ^ p * (l (E w ^ 2 * weight) - D q * D c / tau) := by
  have henergy : l (E (algebraMap K A a * w + algebraMap K A b) ^ 2 *
      ((a ^ p)⁻¹ • weight)) =
      (a ^ p)⁻¹ * (a ^ 2 * l (E w ^ 2 * weight) + 2 * a * D a * (c * D q / tau)) := by
    rw [mul_smul_comm, l.map_smul, smul_eq_mul,
      functional_affine_derivative_square D E compatible l weight w a b,
      hzero, hone, htwo, hfirst, hsecond]
    ring
  have hDpower (x : K) : D (x ^ p) = 0 := by
    simp only [D.leibniz_pow, nsmul_eq_mul, smul_eq_mul, CharP.cast_eq_zero, zero_mul]
  have hDq : D (a ^ p * q - b ^ p) = a ^ p * D q := by
    rw [map_sub, D.leibniz, hDpower, hDpower]
    simp only [smul_eq_mul, mul_zero, add_zero, sub_zero]
  rw [henergy, hDq, D.leibniz, D.leibniz_pow]
  simp only [smul_eq_mul, nsmul_eq_mul, Nat.reduceSub, pow_one]
  field_simp
  ring

theorem affine_energy_integer_weight (a : K) (p : ℕ) (ha : a ≠ 0) :
    a ^ 2 / a ^ p = a ^ ((2 : ℤ) - (p : ℤ)) := by
  rw [zpow_sub₀ ha, zpow_ofNat, zpow_natCast]

end Litt3.CartierAndSpin
