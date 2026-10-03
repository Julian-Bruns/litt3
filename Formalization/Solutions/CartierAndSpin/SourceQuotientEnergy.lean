import Definitions.CartierAndSpin.SourceQuotientEnergy
import Solutions.CartierAndSpin.SourceTraceDescent
import Solutions.CartierAndSpin.SourceDerivation
import Solutions.CartierAndSpin.DerivationTrace

namespace Litt3.CartierAndSpin

open Polynomial Module

variable {R K A : Type*} [CommRing R] [Field K] [Algebra R K]
  [CommRing A] [Algebra K A] [Algebra R A]

/-- Leibniz inversion for an actual unit, without assuming the algebra
is a field or even a domain. -/
theorem derivation_unit_inverse (E : Derivation R A A) (unit : Aˣ) :
    E (↑unit⁻¹ : A) = -(↑unit⁻¹ : A) ^ 2 * E (unit : A) := by
  simpa only [smul_eq_mul] using E.leibniz_of_mul_eq_one unit.inv_mul

omit [Algebra R K] in
theorem derivation_characteristic_power (E : Derivation R A A)
    (p : ℕ) [CharP K p] (x : A) : E (x ^ p) = 0 := by
  have hcast : (p : A) = 0 := by
    rw [← map_natCast (algebraMap K A), CharP.cast_eq_zero, map_zero]
  rw [E.leibniz_pow, nsmul_eq_mul, smul_eq_mul, hcast, zero_mul]

theorem source_quotient_factor_derivation (D : Derivation R K K)
    (F : K[X]) (E : Derivation R (AdjoinRoot F) (AdjoinRoot F))
    (compatible : ∀ c : K, E (algebraMap K (AdjoinRoot F) c) =
      algebraMap K (AdjoinRoot F) (D c))
    (p : ℕ) [CharP K p] (q : K) (unit : (AdjoinRoot F)ˣ)
    (hunit : (unit : AdjoinRoot F) = AdjoinRoot.mk F (X ^ p + C q)) :
    E (unit : AdjoinRoot F) = algebraMap K (AdjoinRoot F) (D q) := by
  rw [hunit]
  change E ((AdjoinRoot.root F) ^ p + algebraMap K (AdjoinRoot F) q) = _
  rw [map_add, derivation_characteristic_power (K := K) E p, compatible, zero_add]

omit [Algebra R K] in
theorem characteristic_unit_twisted_power_derivative (E : Derivation R A A)
    (p : ℕ) [CharP K p] (w : A) (unit : Aˣ) (q' : K) (hp : 3 ≤ p)
    (hunit : E (unit : A) = algebraMap K A q') :
    E (w * (unit : A) ^ (p - 2)) = (unit : A) ^ (p - 2) *
      (E w - 2 * w * algebraMap K A q' * (↑unit⁻¹ : A)) := by
  have hcastp : (p : A) = 0 := by
    rw [← map_natCast (algebraMap K A), CharP.cast_eq_zero, map_zero]
  have hcast : ((p - 2 : ℕ) : A) = -(2 : A) := by
    rw [Nat.cast_sub (by omega), hcastp, Nat.cast_two, zero_sub]
  have hexponent : p - 2 - 1 = p - 3 := by omega
  have hcross : (unit : A) ^ (p - 2) * (↑unit⁻¹ : A) = (unit : A) ^ (p - 3) := by
    rw [show p - 2 = (p - 3) + 1 by omega, pow_succ, mul_assoc, unit.mul_inv, mul_one]
  calc
    _ = (unit : A) ^ (p - 2) * E w -
        2 * w * algebraMap K A q' * (unit : A) ^ (p - 3) := by
      rw [E.leibniz, E.leibniz_pow, hunit]
      simp only [nsmul_eq_mul, smul_eq_mul, hcast, hexponent]
      ring
    _ = _ := by
      rw [mul_sub, show (unit : A) ^ (p - 2) *
        (2 * w * algebraMap K A q' * (↑unit⁻¹ : A)) =
        2 * w * algebraMap K A q' *
          ((unit : A) ^ (p - 2) * (↑unit⁻¹ : A)) by ring, hcross]

omit [Algebra R K] in
theorem characteristic_unit_twisted_power_square (E : Derivation R A A)
    (p : ℕ) [CharP K p] (w : A) (unit : Aˣ) (q' : K) (hp : 3 ≤ p)
    (hunit : E (unit : A) = algebraMap K A q') :
    (E (w * (unit : A) ^ (p - 2))) ^ 2 * (↑unit⁻¹ : A) ^ (2 * p - 3) =
      (E w - 2 * w * algebraMap K A q' * (↑unit⁻¹ : A)) ^ 2 * (↑unit⁻¹ : A) := by
  have hpower : (↑unit⁻¹ : A) ^ (2 * p - 3) =
      ((↑unit⁻¹ : A) ^ (p - 2)) ^ 2 * (↑unit⁻¹ : A) := by
    rw [show 2 * p - 3 = (p - 2) * 2 + 1 by omega, pow_add, pow_mul, pow_one]
  rw [characteristic_unit_twisted_power_derivative E p w unit q' hp hunit]
  calc
    _ = (((unit : A) ^ (p - 2) * (↑unit⁻¹ : A) ^ (p - 2)) ^ 2) *
        ((E w - 2 * w * algebraMap K A q' * (↑unit⁻¹ : A)) ^ 2 * (↑unit⁻¹ : A)) := by
      rw [hpower]
      ring
    _ = _ := by rw [← mul_pow, unit.mul_inv, one_pow, one_pow, one_mul]

end Litt3.CartierAndSpin
