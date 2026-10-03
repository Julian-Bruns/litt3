import Solutions.QuotientGeometry.WeakTameDerivativeOrders

namespace Litt3.QuotientGeometry

/-- The logarithmic differential of an actual power root, for every
field derivation. This uses an actual root identity and unit exponent. -/
theorem field_derivation_power_root_identity
    {R K : Type*} [CommRing R] [Field K] [Algebra R K]
    (D : Derivation R K K) (u g : K) (h m : ℕ)
    (hh : 0 < h) (hm : 0 < m) (hg : g ≠ 0)
    (hchar : (h : K) ≠ 0) (hroot : u ^ h = g ^ m) :
    D u = ((m : K) / (h : K)) * u * g⁻¹ * D g := by
  have huPower : u ^ h = u ^ (h - 1) * u := by
    rw [← pow_succ]
    congr 1
    omega
  have hgPower : g ^ m = g ^ (m - 1) * g := by
    rw [← pow_succ]
    congr 1
    omega
  have hd := congrArg D hroot
  rw [field_derivation_nat_power_formula, field_derivation_nat_power_formula] at hd
  have hdu : (h : K) * u ^ h * D u = (m : K) * g ^ (m - 1) * u * D g := by
    rw [huPower]
    linear_combination u * hd
  have hlog : (h : K) * g * D u = (m : K) * u * D g := by
    apply mul_left_cancel₀ (pow_ne_zero (m - 1) hg)
    calc
      g ^ (m - 1) * ((h : K) * g * D u) = (h : K) * g ^ m * D u := by
        rw [hgPower]
        ring
      _ = (m : K) * g ^ (m - 1) * u * D g := by rw [← hroot]; exact hdu
      _ = g ^ (m - 1) * ((m : K) * u * D g) := by ring
  field_simp [hchar, hg]
  linear_combination hlog

end Litt3.QuotientGeometry
