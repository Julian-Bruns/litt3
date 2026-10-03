import Theorems.QuotientGeometry.RamificationNumerics
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

theorem swan_orbit_exponent_bound
    (rank degreeExponent stabilizerExponent : ℕ)
    (hstabilizer : stabilizerExponent ≤ rank)
    (hend : stabilizerExponent ≤ 2 * degreeExponent) :
    (rank + 1) / 2 ≤ rank - stabilizerExponent + degreeExponent := by omega

theorem swan_orbit_exponent_target : Targets.SwanOrbitExponentBound :=
  swan_orbit_exponent_bound

/-- The integral Swan orbit contribution is divisible by the required
power for every base integer, with no primality hypothesis. -/
theorem swan_orbit_contribution_divisibility
    (base rank degreeExponent stabilizerExponent : ℕ)
    (hstabilizer : stabilizerExponent ≤ rank)
    (hend : stabilizerExponent ≤ 2 * degreeExponent) (contribution : ℤ) :
    (base : ℤ) ^ ((rank + 1) / 2) ∣
      (base : ℤ) ^ (rank - stabilizerExponent + degreeExponent) * contribution := by
  exact dvd_mul_of_dvd_left
    (pow_dvd_pow (base : ℤ) (swan_orbit_exponent_bound rank degreeExponent stabilizerExponent
      hstabilizer hend)) contribution

/-- Summing character-twist orbits preserves first-break divisibility. -/
theorem swan_twist_orbit_sum_divisibility
    {ι : Type*} (orbits : Finset ι) (base rank : ℕ)
    (degreeExponent stabilizerExponent : ι → ℕ) (contribution : ι → ℤ)
    (hstabilizer : ∀ i ∈ orbits, stabilizerExponent i ≤ rank)
    (hend : ∀ i ∈ orbits, stabilizerExponent i ≤ 2 * degreeExponent i) :
    (base : ℤ) ^ ((rank + 1) / 2) ∣
      ∑ i ∈ orbits, (base : ℤ) ^
        (rank - stabilizerExponent i + degreeExponent i) * contribution i := by
  apply Finset.dvd_sum
  intro i hi
  exact swan_orbit_contribution_divisibility base rank (degreeExponent i)
    (stabilizerExponent i) (hstabilizer i hi) (hend i hi) (contribution i)

/-- Tame divisibility of each graded break implies divisibility of the
total Swan excess from the exact break-counting formula. -/
theorem tame_break_sum_divisibility
    {ι : Type*} (breaks : Finset ι) (tameOrder base : ℕ)
    (lowerBreak rank tailRank : ι → ℕ)
    (hgraded : ∀ i ∈ breaks, tameOrder ∣ lowerBreak i * (base ^ rank i - 1)) :
    tameOrder ∣ ∑ i ∈ breaks,
      lowerBreak i * base ^ tailRank i * (base ^ rank i - 1) := by
  apply Finset.dvd_sum
  intro i hi
  have h := dvd_mul_of_dvd_left (hgraded i hi) (base ^ tailRank i)
  convert h using 1 <;> ring

end Litt3.QuotientGeometry
