import Solutions.CartierAndSpin.PBasisDerivationKernel
import Solutions.SharedTensors.EtaleSymmetricTrace

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]

/-- The literal logarithmic derivative of a quotient is the difference
of the two logarithmic derivatives, for every field derivation. -/
theorem logarithmic_derivative_quotient
    (D : Derivation k K K) {u v : K} (hu : u ≠ 0) (hv : v ≠ 0) :
    (u / v)⁻¹ * D (u / v) = u⁻¹ * D u - v⁻¹ * D v := by
  rw [D.leibniz_div, smul_eq_mul, smul_eq_mul, smul_eq_mul]
  field_simp

/-- Equality of logarithmic derivatives is exactly vanishing of the
actual derivative of their quotient. -/
theorem logarithmic_derivative_eq_iff_quotient_derivative_zero
    (D : Derivation k K K) {u v : K} (hu : u ≠ 0) (hv : v ≠ 0) :
    u⁻¹ * D u = v⁻¹ * D v ↔ D (u / v) = 0 := by
  rw [← sub_eq_zero, ← logarithmic_derivative_quotient D hu hv]
  exact mul_eq_zero.trans (or_iff_right (inv_ne_zero (div_ne_zero hu hv)))

variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Actual logarithmic fibers over a full literal p-basis are exactly
multiplicative pth-power cosets. No Cartier converse is used here. -/
theorem normalized_p_basis_logarithmic_derivative_eq_iff_pth_ratio
    (b : PowerPBasis K p) (D : Derivation k K K) (ht : D b.parameter = 1)
    {u v : K} (hu : u ≠ 0) (hv : v ≠ 0) :
    u⁻¹ * D u = v⁻¹ * D v ↔ ∃ r : K, r ^ p = u / v := by
  rw [logarithmic_derivative_eq_iff_quotient_derivative_zero D hu hv,
    normalized_p_basis_derivation_zero_iff_pth_power b D ht]

/-- The same exact fiber description for the ORIGINAL universal
differentials, rather than a supplied scalar surrogate. -/
theorem universal_logarithmic_eq_iff_pth_ratio
    (b : PowerPBasis K p) (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1)
    {u v : K} (hu : u ≠ 0) (hv : v ≠ 0) :
    u⁻¹ • KaehlerDifferential.D k K u = v⁻¹ • KaehlerDifferential.D k K v ↔
      ∃ r : K, r ^ p = u / v := by
  rw [← e.injective.eq_iff]
  simp only [map_smul, smul_eq_mul]
  exact normalized_p_basis_logarithmic_derivative_eq_iff_pth_ratio
    b (universalCoordinateDerivation e) he hu hv

end Litt3.CartierAndSpin
