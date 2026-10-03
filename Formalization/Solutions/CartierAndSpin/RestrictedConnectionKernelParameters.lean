import Solutions.CartierAndSpin.RestrictedConnectionKernelDimension

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors
open scoped Classical

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Explicit multiplication by a genuine nonzero solution parametrizes
the WHOLE original connection kernel over the actual pth-power field. -/
noncomputable def actualConnectionKernelParameterEquiv
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f u : K) (hu : u ≠ 0) (hDu : D u = f * u) :
    frobeniusSubfield K p ≃ₗ[frobeniusSubfield K p]
      LinearMap.ker (scalarDerivationConnection D f) :=
  (LinearEquiv.toSpanNonzeroSingleton (frobeniusSubfield K p) K u hu).trans
    (LinearEquiv.ofEq _ _
      (actual_normalized_connection_kernel_eq_span b D hDt f u hu hDu).symm)

theorem actual_connection_kernel_parameter_apply
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f u : K) (hu : u ≠ 0) (hDu : D u = f * u)
    (c : frobeniusSubfield K p) :
    (actualConnectionKernelParameterEquiv b D hDt f u hu hDu c : K) = c • u := by
  rfl

/-- Cartier fixedness yields a true linear parametrization without a
supplied nonzero solution or a solution-space dimension premise. -/
theorem actual_cartier_fixed_connection_kernel_parameter_exists
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K)
    (hfixed : rationalCartierCoefficient K p b f = f) :
    Nonempty (frobeniusSubfield K p ≃ₗ[frobeniusSubfield K p]
      LinearMap.ker (scalarDerivationConnection D f)) := by
  obtain ⟨u, hu, hDu⟩ :=
    (actual_normalized_connection_kernel_iff_cartier_fixed b D hDt f).mpr hfixed
  exact ⟨actualConnectionKernelParameterEquiv b D hDt f u hu hDu⟩

/-- The actual full p-basis derives finite degree p over literal pth
powers, even when the original field is imperfect and not finitely
generated over constants. -/
theorem actual_power_p_basis_field_finrank (b : PowerPBasis K p) :
    Module.finrank (frobeniusSubfield K p) K = p := by
  simpa only [Fintype.card_fin] using Module.finrank_eq_card_basis b.basis

/-- Exact rank of the original connection image: p-1 in the
Cartier-fixed case, p otherwise. Ambient finiteness is derived from
the actual basis; no image or kernel rank hypothesis is supplied. -/
theorem actual_normalized_connection_range_finrank
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    Module.finrank (frobeniusSubfield K p)
      (LinearMap.range (scalarDerivationConnection D f)) =
      if rationalCartierCoefficient K p b f = f then p - 1 else p := by
  letI : Module.Finite (frobeniusSubfield K p) K := Module.Finite.of_basis b.basis
  have h := (scalarDerivationConnection D f).finrank_range_add_finrank_ker
  rw [actual_power_p_basis_field_finrank b,
    actual_normalized_connection_kernel_finrank b D hDt f] at h
  by_cases hfixed : rationalCartierCoefficient K p b f = f
  · rw [if_pos hfixed] at h ⊢
    omega
  · rw [if_neg hfixed] at h ⊢
    omega

end Litt3.CartierAndSpin
