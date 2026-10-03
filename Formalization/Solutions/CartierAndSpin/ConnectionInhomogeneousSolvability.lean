import Solutions.CartierAndSpin.RestrictedCurvatureGaugeClassification
import Solutions.SharedTensors.RationalCartierExactKernel

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {R K : Type*} [CommRing R] [Field K] [Algebra R K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The ENTIRE inhomogeneous connection equation is solvable precisely
when its genuine unit-gauged right side has zero actual Cartier digit.
This is an ORIGINAL-field primitive criterion, not a supplied cokernel
functional or a solution in a scalar extension. -/
theorem actual_unit_gauged_connection_equation_solvable_iff
    (b : PowerPBasis K p) (D : Derivation R K K) (hDt : D b.parameter = 1)
    (f : K) (u : Kˣ) (hDu : D (u : K) = f * (u : K)) (g : K) :
    (∃ v : K, scalarDerivationConnection D f v = g) ↔
      rationalCartierCoefficient K p b (g / (u : K)) = 0 := by
  have hune : (u : K) ≠ 0 := Units.ne_zero u
  have hGauge (x : K) :
      scalarDerivationConnection D f ((u : K) * x) = (u : K) * D x := by
    have h := scalar_connection_unit_gauge D f 0 u (by simpa only [sub_zero] using hDu) x
    change scalarDerivationConnection D f ((u : K) * x) =
      (u : K) * (D x - 0 * x) at h
    simpa only [zero_mul, sub_zero] using h
  constructor
  · rintro ⟨v, hv⟩
    have hprod : (u : K) * (v / (u : K)) = v := by field_simp
    have h := hGauge (v / (u : K))
    rw [hprod, hv] at h
    have hD : D (v / (u : K)) = g / (u : K) := by
      apply (eq_div_iff hune).mpr
      exact (mul_comm _ _).trans h.symm
    rw [← hD]
    exact rationalCartierCoefficient_exact b D hDt _
  · intro hC
    obtain ⟨w, hw⟩ := rationalCartierCoefficient_zero_has_primitive b D hDt
      (g / (u : K)) hC
    refine ⟨(u : K) * w, ?_⟩
    rw [hGauge, hw]
    field_simp

/-- Zero actual curvature CONSTRUCTS the original unit and the entire
inhomogeneous solvability criterion. No gauge, functional or primitive
existence is assumed. -/
theorem actual_zero_curvature_inhomogeneous_criterion_exists
    (b : PowerPBasis K p) (D : Derivation R K K) (hDt : D b.parameter = 1)
    (f : K) (hzero : D^[p - 1] f + f ^ p = 0) :
    ∃ u : Kˣ, D (u : K) = f * (u : K) ∧ ∀ g : K,
      (∃ v : K, scalarDerivationConnection D f v = g) ↔
        rationalCartierCoefficient K p b (g / (u : K)) = 0 := by
  obtain ⟨u, hune, hDu⟩ := (actual_normalized_connection_kernel_iff b D hDt f).mpr hzero
  refine ⟨Units.mk0 u hune, hDu, ?_⟩
  intro g
  exact actual_unit_gauged_connection_equation_solvable_iff b D hDt f
    (Units.mk0 u hune) hDu g

end Litt3.CartierAndSpin
