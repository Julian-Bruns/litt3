import Solutions.CartierAndSpin.RestrictedCartierCoefficient
import Solutions.CartierAndSpin.PBasisDerivationKernel
import Mathlib.LinearAlgebra.FiniteDimensional.Basic

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors
open scoped Classical

variable {K : Type*} [Field K] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- Every genuine nonzero solution spans the ENTIRE original connection
kernel over the literal subfield of pth powers. No solution-space
dimension or finite-dimensionality premise is supplied. -/
theorem actual_normalized_connection_kernel_eq_span
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f u : K) (hu : u ≠ 0) (hDu : D u = f * u) :
    LinearMap.ker (scalarDerivationConnection D f) =
      Submodule.span (frobeniusSubfield K p) {u} := by
  ext x
  rw [LinearMap.mem_ker, Submodule.mem_span_singleton]
  constructor
  · intro hx
    have hDx : D x = f * x := sub_eq_zero.mp hx
    have hratio : D (x / u) = 0 := by
      rw [D.leibniz_div, hDx, hDu]
      simp only [smul_eq_mul]
      field_simp
      ring
    obtain ⟨r, hr⟩ :=
      (normalized_p_basis_derivation_zero_iff_pth_power b D hDt (x / u)).mp hratio
    refine ⟨frobeniusImageEquiv K p r, ?_⟩
    change (frobeniusImageEquiv K p r : K) * u = x
    rw [frobeniusImageEquiv_coe, hr]
    exact div_mul_cancel₀ x hu
  · rintro ⟨c, rfl⟩
    rw [map_smul]
    change c • (D u - f * u) = 0
    rw [hDu, sub_self, smul_zero]

/-- The zero-curvature connection has exactly ONE dimension over the
actual pth-power subfield. Its nonzero solution is constructed by the
restricted formula and the original field, not assumed. -/
theorem actual_normalized_connection_kernel_finrank_one
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K)
    (hcurv : D^[p - 1] f + f ^ p = 0) :
    Module.finrank (frobeniusSubfield K p)
      (LinearMap.ker (scalarDerivationConnection D f)) = 1 := by
  obtain ⟨u, hu, hDu⟩ := (actual_normalized_connection_kernel_iff b D hDt f).mpr hcurv
  rw [actual_normalized_connection_kernel_eq_span b D hDt f u hu hDu]
  exact finrank_span_singleton hu

/-- Nonzero actual curvature forces the entire original connection
kernel to be zero, rather than merely excluding selected solutions. -/
theorem actual_normalized_connection_kernel_eq_bot_of_curvature_ne_zero
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K)
    (hcurv : D^[p - 1] f + f ^ p ≠ 0) :
    LinearMap.ker (scalarDerivationConnection D f) = ⊥ := by
  apply eq_bot_iff.mpr
  intro x hx
  rw [Submodule.mem_bot]
  by_contra hne
  exact hcurv ((actual_normalized_connection_kernel_iff b D hDt f).mp
    ⟨x, hne, sub_eq_zero.mp hx⟩)

/-- The exact original kernel dimension is one for actual Cartier-fixed
coefficients and zero otherwise. The field may be imperfect. -/
theorem actual_normalized_connection_kernel_finrank
    (b : PowerPBasis K p) (D : Derivation (frobeniusSubfield K p) K K)
    (hDt : D b.parameter = 1) (f : K) :
    Module.finrank (frobeniusSubfield K p)
      (LinearMap.ker (scalarDerivationConnection D f)) =
      if rationalCartierCoefficient K p b f = f then 1 else 0 := by
  classical
  by_cases hfixed : rationalCartierCoefficient K p b f = f
  · rw [if_pos hfixed]
    exact actual_normalized_connection_kernel_finrank_one b D hDt f
      ((actual_cartier_coefficient_fixed_iff_curvature_zero b D hDt f).mp hfixed)
  · rw [if_neg hfixed]
    have hcurv : D^[p - 1] f + f ^ p ≠ 0 :=
      mt (actual_cartier_coefficient_fixed_iff_curvature_zero b D hDt f).mpr hfixed
    rw [actual_normalized_connection_kernel_eq_bot_of_curvature_ne_zero b D hDt f hcurv]
    exact finrank_bot (frobeniusSubfield K p) K

end Litt3.CartierAndSpin
