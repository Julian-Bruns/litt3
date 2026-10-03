import Solutions.QuotientGeometry.PowerSeriesAdic
import Mathlib.RingTheory.PowerSeries.Inverse
import Mathlib.FieldTheory.IsAlgClosed.Basic
import Mathlib.Algebra.CharP.Lemmas
import Mathlib.Tactic

namespace Litt3.QuotientGeometry

theorem power_series_simple_root_lift
    {k : Type*} [Field k] (f : Polynomial (PowerSeries k)) (hf : f.Monic)
    (a₀ : k)
    (hroot : f.eval₂ PowerSeries.constantCoeff a₀ = 0)
    (hsimple : f.derivative.eval₂ PowerSeries.constantCoeff a₀ ≠ 0) :
    ∃ a : PowerSeries k, f.IsRoot a ∧ PowerSeries.constantCoeff a = a₀ := by
  haveI := power_series_parameter_henselian k
  have hmem : f.eval (PowerSeries.C a₀) ∈ powerSeriesParameterIdeal k := by
    rw [powerSeriesParameterIdeal, Ideal.mem_span_singleton, PowerSeries.X_dvd_iff]
    simpa only [← Polynomial.eval₂_at_apply, PowerSeries.constantCoeff_C] using hroot
  have hunit : IsUnit (f.derivative.eval (PowerSeries.C a₀)) := by
    apply PowerSeries.isUnit_iff_constantCoeff.mpr
    apply isUnit_iff_ne_zero.mpr
    simpa only [← Polynomial.eval₂_at_apply, PowerSeries.constantCoeff_C] using hsimple
  obtain ⟨a, ha, hmod⟩ := HenselianRing.is_henselian f hf (PowerSeries.C a₀)
    hmem (hunit.map (Ideal.Quotient.mk (powerSeriesParameterIdeal k)))
  refine ⟨a, ha, ?_⟩
  rw [powerSeriesParameterIdeal, Ideal.mem_span_singleton, PowerSeries.X_dvd_iff,
    map_sub, PowerSeries.constantCoeff_C, sub_eq_zero] at hmod
  exact hmod

theorem linearized_polynomial_monic
    {R : Type*} [CommRing R] (p : ℕ) (hp : 1 < p) (b c : R) :
    (Polynomial.X ^ p + (Polynomial.C b * Polynomial.X + Polynomial.C c)).Monic := by
  apply Polynomial.monic_X_pow_add
  exact Polynomial.degree_linear_le.trans_lt (WithBot.coe_lt_coe.mpr hp)

theorem power_series_linearized_equation
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [CharP k p] (hp : 1 < p)
    (b : k) (hb : b ≠ 0) (r : PowerSeries k) :
    ∃ w : PowerSeries k, w ^ p + PowerSeries.C b * w = r := by
  let q : Polynomial k := Polynomial.X ^ p +
    (Polynomial.C b * Polynomial.X + Polynomial.C (-PowerSeries.constantCoeff r))
  have hq : q.degree = p := by
    change (Polynomial.X ^ p +
      (Polynomial.C b * Polynomial.X + Polynomial.C (-PowerSeries.constantCoeff r))).degree = (p : WithBot ℕ)
    rw [Polynomial.degree_add_eq_left_of_degree_lt, Polynomial.degree_X_pow]
    rw [Polynomial.degree_X_pow]
    exact Polynomial.degree_linear_le.trans_lt (WithBot.coe_lt_coe.mpr hp)
  obtain ⟨a₀, ha₀⟩ := IsAlgClosed.exists_root q (by rw [hq]; exact_mod_cast (by omega : p ≠ 0))
  let f : Polynomial (PowerSeries k) := Polynomial.X ^ p +
    (Polynomial.C (PowerSeries.C b) * Polynomial.X + Polynomial.C (-r))
  have hf : f.Monic := linearized_polynomial_monic p hp _ _
  have hroot : f.eval₂ PowerSeries.constantCoeff a₀ = 0 := by
    simpa [f, q, Polynomial.IsRoot] using ha₀
  have hderivative : f.derivative = Polynomial.C (PowerSeries.C b) := by
    have hcast : (p : PowerSeries k) = 0 := by
      rw [← map_natCast (PowerSeries.C : k →+* PowerSeries k), CharP.cast_eq_zero k p, map_zero]
    simp [f, Polynomial.derivative_X_pow, hcast]
  have hsimple : f.derivative.eval₂ PowerSeries.constantCoeff a₀ ≠ 0 := by
    simpa [hderivative] using hb
  obtain ⟨w, hw, -⟩ := power_series_simple_root_lift f hf a₀ hroot hsimple
  refine ⟨w, ?_⟩
  have h : w ^ p + (PowerSeries.C b * w - r) = 0 := by
    simpa [f, Polynomial.IsRoot, sub_eq_add_neg] using hw
  exact sub_eq_zero.mp (by simpa only [add_sub_assoc] using h)

theorem power_series_two_coefficient_linearized_equation
    {k : Type*} [Field k] [IsAlgClosed k] (p : ℕ) [CharP k p] (hp : 1 < p)
    (α γ : k) (hα : α ≠ 0) (hγ : γ ≠ 0) (r : PowerSeries k) :
    ∃ w : PowerSeries k, PowerSeries.C α * w ^ p + PowerSeries.C γ * w = r := by
  obtain ⟨w, hw⟩ := power_series_linearized_equation p hp (γ / α)
    (div_ne_zero hγ hα) (PowerSeries.C α⁻¹ * r)
  refine ⟨w, ?_⟩
  have hαγ : (PowerSeries.C α : PowerSeries k) * PowerSeries.C (γ / α) =
      PowerSeries.C γ := by
    rw [← map_mul]
    congr 1
    field_simp
  have hαinv : (PowerSeries.C α : PowerSeries k) * PowerSeries.C α⁻¹ = 1 := by
    rw [← map_mul, mul_inv_cancel₀ hα, map_one]
  have h := congrArg (fun v : PowerSeries k => PowerSeries.C α * v) hw
  simpa only [mul_add, ← mul_assoc, hαγ, hαinv, one_mul] using h

end Litt3.QuotientGeometry
