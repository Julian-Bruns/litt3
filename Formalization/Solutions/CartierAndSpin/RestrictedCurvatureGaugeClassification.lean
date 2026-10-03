import Solutions.CartierAndSpin.RestrictedCurvatureScalars
import Solutions.CartierAndSpin.RestrictedConnectionDichotomy

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Literal restricted curvature is additive for EVERY actual
derivation, without any normalization or full-basis premise. -/
theorem original_restricted_curvature_add
    (D : Derivation R K K) (f g : K) :
    D^[p - 1] (f + g) + (f + g) ^ p =
      (D^[p - 1] f + f ^ p) + (D^[p - 1] g + g ^ p) := by
  have hiter : D^[p - 1] (f + g) = D^[p - 1] f + D^[p - 1] g := by
    simpa only [Module.End.pow_apply] using (D.toLinearMap ^ (p - 1)).map_add f g
  rw [hiter, add_pow_char]
  ring

/-- The exact difference law, uniformly including characteristic two. -/
theorem original_restricted_curvature_sub
    (D : Derivation R K K) (f g : K) :
    D^[p - 1] (f - g) + (f - g) ^ p =
      (D^[p - 1] f + f ^ p) - (D^[p - 1] g + g ^ p) := by
  have hiter : D^[p - 1] (f - g) = D^[p - 1] f - D^[p - 1] g := by
    simpa only [Module.End.pow_apply] using (D.toLinearMap ^ (p - 1)).map_sub f g
  rw [hiter, sub_pow_char]
  ring

/-- Equal literal curvatures are EXACTLY genuine original unit-gauge
equivalence. The unit is constructed in the ORIGINAL field; no scalar
extension solution, matrix conjugacy or logarithmic converse is assumed. -/
theorem actual_normalized_curvature_eq_iff_unit_gauge
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f g : K) :
    D^[p - 1] f + f ^ p = D^[p - 1] g + g ^ p ↔
      ∃ u : Kˣ, D (u : K) = (f - g) * (u : K) := by
  constructor
  · intro hcurvature
    have hzero : D^[p - 1] (f - g) + (f - g) ^ p = 0 := by
      rw [original_restricted_curvature_sub, hcurvature, sub_self]
    obtain ⟨u, hune, hu⟩ := (actual_normalized_connection_kernel_iff b D hDt (f - g)).mpr hzero
    exact ⟨Units.mk0 u hune, hu⟩
  · rintro ⟨u, hu⟩
    exact actual_normalized_curvature_unit_gauge_invariant b D hDt f g u hu

/-- Equal curvature is also exactly multiplication by an ORIGINAL unit
intertwining the two ENTIRE connections, with the unit constructed. -/
theorem actual_normalized_curvature_eq_iff_connection_unit_intertwiner
    (b : PowerPBasis K p) (D : Derivation R K K)
    (hDt : D b.parameter = 1) (f g : K) :
    D^[p - 1] f + f ^ p = D^[p - 1] g + g ^ p ↔
      ∃ u : Kˣ, ∀ a : K,
        scalarDerivationConnection D f ((u : K) * a) =
          (u : K) * scalarDerivationConnection D g a := by
  constructor
  · intro hcurvature
    obtain ⟨u, hu⟩ := (actual_normalized_curvature_eq_iff_unit_gauge b D hDt f g).mp hcurvature
    exact ⟨u, scalar_connection_unit_gauge D f g u hu⟩
  · rintro ⟨u, hu⟩
    apply actual_normalized_curvature_unit_gauge_invariant b D hDt f g u
    have h := hu 1
    change D ((u : K) * 1) - f * ((u : K) * 1) = (u : K) * (D 1 - g * 1) at h
    rw [mul_one, mul_one, D.map_one_eq_zero, zero_sub] at h
    calc
      D (u : K) = (u : K) * (-g) + f * (u : K) := sub_eq_iff_eq_add.mp h
      _ = (f - g) * (u : K) := by ring

end Litt3.CartierAndSpin
