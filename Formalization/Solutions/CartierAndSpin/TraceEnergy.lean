import Solutions.CartierAndSpin.SourceQuotientEnergy

namespace Litt3.CartierAndSpin

open Module Polynomial

variable {R K A ι : Type*} [CommRing R] [Field K] [Algebra R K]
  [CommRing A] [Algebra K A] [Algebra R A] [Fintype ι]

theorem trace_first_differential_moment_equation (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ a : K, E (algebraMap K A a) = algebraMap K A (D a))
    (basis : Basis ι K A) (w : A) (unit : Aˣ) (q : K)
    (hunit : E (unit : A) = algebraMap K A (D q)) (n : ℕ)
    (hmoment : Algebra.trace K A (w ^ n * (↑unit⁻¹ : A)) = 0) :
    (n : K) * Algebra.trace K A (w ^ (n - 1) * E w * (↑unit⁻¹ : A)) =
      D q * Algebra.trace K A (w ^ n * (↑unit⁻¹ : A) ^ 2) := by
  have hderivative := congrArg D hmoment
  rw [← algebra_trace_derivation D E compatible basis, map_zero] at hderivative
  have hinverse := derivation_unit_inverse E unit
  rw [hunit] at hinverse
  have hexpand : E (w ^ n * (↑unit⁻¹ : A)) =
      (n : K) • (w ^ (n - 1) * E w * (↑unit⁻¹ : A)) -
        D q • (w ^ n * (↑unit⁻¹ : A) ^ 2) := by
    rw [E.leibniz, E.leibniz_pow, hinverse]
    simp only [smul_eq_mul, Algebra.smul_def, map_natCast,
      show algebraMap ℕ A n = (n : A) from map_natCast (algebraMap ℕ A) n]
    ring
  rw [hexpand, map_sub, map_smul, map_smul] at hderivative
  simp only [smul_eq_mul] at hderivative
  exact sub_eq_zero.mp hderivative

/-- Differentiating an actual inverse-square algebra trace computes the
cross term, for every finite free algebra and actual derivation extension. -/
theorem trace_inverseSquare_differential (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ a : K, E (algebraMap K A a) = algebraMap K A (D a))
    (basis : Basis ι K A) (w : A) (unit : Aˣ) (q c tau : K)
    (htwo : (2 : K) ≠ 0) (hunit : E (unit : A) = algebraMap K A (D q))
    (hmoment : Algebra.trace K A (w ^ 2 * (↑unit⁻¹ : A) ^ 2) = 2 * c / tau) :
    D (c / tau) = Algebra.trace K A (w * E w * (↑unit⁻¹ : A) ^ 2) -
      D q * Algebra.trace K A (w ^ 2 * (↑unit⁻¹ : A) ^ 3) := by
  have hderivative := congrArg D hmoment
  rw [← algebra_trace_derivation D E compatible basis] at hderivative
  have hinverse := derivation_unit_inverse E unit
  rw [hunit] at hinverse
  have hexpand : E (w ^ 2 * (↑unit⁻¹ : A) ^ 2) =
      (2 : K) • (w * E w * (↑unit⁻¹ : A) ^ 2) -
        (2 * D q) • (w ^ 2 * (↑unit⁻¹ : A) ^ 3) := by
    rw [E.leibniz, E.leibniz_pow, E.leibniz_pow, hinverse]
    simp only [smul_eq_mul, Nat.reduceSub, pow_one, Algebra.smul_def, map_mul, map_ofNat]
    ring
  rw [hexpand, map_sub, map_smul, map_smul] at hderivative
  have hDtwo : D (2 : K) = 0 := by simpa using D.map_natCast 2
  rw [show 2 * c / tau = 2 * (c / tau) by ring, D.leibniz] at hderivative
  simp only [smul_eq_mul, hDtwo, mul_zero, add_zero] at hderivative
  apply (mul_left_cancel₀ htwo)
  linear_combination -hderivative

/-- The corrected quadratic energy is an actual algebra trace of
twisted squares. This proof retains arbitrary disconnected finite algebras. -/
theorem trace_twisted_differential_square (D : Derivation R K K)
    (E : Derivation R A A)
    (compatible : ∀ a : K, E (algebraMap K A a) = algebraMap K A (D a))
    (basis : Basis ι K A) (w : A) (unit : Aˣ) (q c tau : K)
    (htwo : (2 : K) ≠ 0) (hunit : E (unit : A) = algebraMap K A (D q))
    (hmoment : Algebra.trace K A (w ^ 2 * (↑unit⁻¹ : A) ^ 2) = 2 * c / tau) :
    Algebra.trace K A (E w ^ 2 * (↑unit⁻¹ : A)) - 4 * D q * D (c / tau) =
      Algebra.trace K A ((E w - 2 * w * algebraMap K A (D q) *
        (↑unit⁻¹ : A)) ^ 2 * (↑unit⁻¹ : A)) := by
  rw [trace_inverseSquare_differential D E compatible basis w unit q c tau
    htwo hunit hmoment]
  have hexpand : (E w - 2 * w * algebraMap K A (D q) * (↑unit⁻¹ : A)) ^ 2 *
      (↑unit⁻¹ : A) = E w ^ 2 * (↑unit⁻¹ : A) -
      (4 * D q) • (w * E w * (↑unit⁻¹ : A) ^ 2) +
      (4 * D q ^ 2) • (w ^ 2 * (↑unit⁻¹ : A) ^ 3) := by
    simp only [Algebra.smul_def, map_mul, map_pow, map_ofNat]
    ring
  rw [hexpand, map_add, map_sub, map_smul, map_smul]
  simp only [smul_eq_mul]
  ring

end Litt3.CartierAndSpin
