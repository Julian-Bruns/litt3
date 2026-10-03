import Mathlib.Tactic

namespace Litt3.QuotientGeometry

/-- The exponent is an integer: the source formula remains valid when
the numerator exponent is negative. -/
theorem weak_pole_scalar_power_identity
    {k : Type*} [Field k] (p e : ℕ) (hp : 0 < p) (u g a : k)
    (hu : u ≠ 0) (hg : g ≠ 0) (ha : a ≠ 0)
    (hpower : u ^ (p - 1) = g ^ e) :
    -u / (a * u / g) ^ p = -g ^ ((p : ℤ) - (e : ℤ)) / a ^ p := by
  have hup : u ^ p = g ^ e * u := by
    rw [← hpower, ← pow_succ]
    congr 1
    omega
  rw [div_pow, mul_pow, hup, zpow_sub₀ hg, zpow_natCast, zpow_natCast]
  field_simp [hu, hg, ha]

theorem root_power_relation_of_divisible_exponent
    {k : Type*} [CommMonoid k] (p h m q : ℕ) (u g : k)
    (hroot : u ^ h = g ^ m) (hquot : p - 1 = h * q) :
    u ^ (p - 1) = g ^ (m * q) := by
  rw [hquot, pow_mul, hroot, ← pow_mul]

end Litt3.QuotientGeometry
