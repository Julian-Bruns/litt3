import Definitions.CartierAndSpin.ClearedEnergy
import Solutions.CartierAndSpin.AffineDifferentialEnergy

namespace Litt3.CartierAndSpin

variable {R K A : Type*} [CommRing R] [Field K] [Algebra R K]
  [CommRing A] [Algebra K A] [Algebra R A]

theorem clearedDifferentialExpression_zero (D : Derivation R K K) (energy q tau c : K) :
    clearedDifferentialExpression D energy q tau 0 c = 0 := by
  simp [clearedDifferentialExpression]

theorem affine_coefficient_skew_derivative (D : Derivation R K K) (lambda a b s c : K) :
    (lambda * s) * D (lambda * (a * c + b * s)) -
      (lambda * (a * c + b * s)) * D (lambda * s) =
    lambda ^ 2 * (a * (s * D c - c * D s) + D a * s * c + D b * s ^ 2) := by
  simp only [D.leibniz, map_add, smul_eq_mul]
  ring

/-- Full affine covariance of the cleared source expression follows
from the actual moments, including the zero-center-coefficient boundary.
Scaling and translation coefficients may vary under the derivation. -/
theorem functional_cleared_energy_affine_covariance (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ x : K, E (algebraMap K A x) = algebraMap K A (D x))
    (l : A →ₗ[K] K) (weight w : A) (a b q tau s c scale lambda : K)
    (p : ℕ) [CharP K p] (ha : a ≠ 0) (hscale : scale ≠ 0) (htau : tau ≠ 0)
    (hlambda : lambda = scale * a / (a ^ p) ^ 2)
    (hzero : l weight = 0) (hone : l (w * weight) = 0)
    (htwo : l (w ^ 2 * weight) = 0)
    (hfirst : l (E w * weight) = s * D q / tau)
    (hsecond : l (w * E w * weight) = c * D q / tau) :
    clearedDifferentialExpression D
      (l (E (algebraMap K A a * w + algebraMap K A b) ^ 2 *
        ((a ^ p)⁻¹ • weight)))
      (a ^ p * q - b ^ p) (scale * tau) (lambda * s) (lambda * (a * c + b * s)) =
    lambda * a ^ 2 / a ^ p * clearedDifferentialExpression D
      (l (E w ^ 2 * weight)) q tau s c := by
  have henergy : l (E (algebraMap K A a * w + algebraMap K A b) ^ 2 *
      ((a ^ p)⁻¹ • weight)) =
      (a ^ p)⁻¹ * (a ^ 2 * l (E w ^ 2 * weight) +
        2 * a * D a * (c * D q / tau) + 2 * a * D b * (s * D q / tau)) := by
    rw [mul_smul_comm, l.map_smul, smul_eq_mul,
      functional_affine_derivative_square D E compatible l weight w a b,
      hzero, hone, htwo, hfirst, hsecond]
    ring
  have hDpower (x : K) : D (x ^ p) = 0 := by
    simp only [D.leibniz_pow, nsmul_eq_mul, smul_eq_mul, CharP.cast_eq_zero, zero_mul]
  have hDq : D (a ^ p * q - b ^ p) = a ^ p * D q := by
    rw [map_sub, D.leibniz, hDpower, hDpower]
    simp only [smul_eq_mul, mul_zero, add_zero, sub_zero]
  unfold clearedDifferentialExpression
  rw [henergy, hDq, affine_coefficient_skew_derivative, hlambda]
  field_simp
  ring

end Litt3.CartierAndSpin
