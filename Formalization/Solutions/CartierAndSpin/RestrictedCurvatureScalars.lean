import Solutions.CartierAndSpin.RestrictedNormalizedDerivations
import Solutions.CartierAndSpin.PBasisDerivationKernel
import Solutions.CartierAndSpin.ConnectionUnitGauge

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The literal restricted curvature coefficient lies in the ACTUAL
pth powers, even when the original field is imperfect. -/
theorem actual_normalized_curvature_is_pth_power
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f : K) :
    ∃ c : K, c ^ p = D^[p - 1] f + f ^ p := by
  apply (normalized_p_basis_derivation_zero_iff_pth_power b D hDt _).mp
  rw [map_add, ← Function.iterate_succ_apply' D (p - 1) f]
  have hexp : (p - 1).succ = p := by have := (Fact.out : p.Prime).pos; omega
  rw [hexp,
    actual_normalized_derivation_prime_iterate_zero b D hDt]
  rw [D.leibniz_pow, nsmul_eq_mul, CharP.cast_eq_zero K p, zero_mul, add_zero]

/-- Literal p-curvature is invariant under every genuine unit gauge.
Both connection operators and their pth-power formulas are proved. -/
theorem actual_normalized_curvature_unit_gauge_invariant
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f g : K) (u : Kˣ)
    (hu : D (u : K) = (f - g) * (u : K)) :
    D^[p - 1] f + f ^ p = D^[p - 1] g + g ^ p := by
  have h := scalar_connection_unit_gauge_iterate D f g u hu 1 p
  rw [mul_one, actual_normalized_derivation_restricted_connection_identity b D hDt f,
    actual_normalized_derivation_restricted_connection_identity b D hDt g,
    mul_one, mul_comm] at h
  have hneg := (u.mul_right_inj).mp h
  exact neg_injective hneg

end Litt3.CartierAndSpin
