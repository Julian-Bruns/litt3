import Solutions.QuotientGeometry.FiniteParameterFields
import Mathlib.RingTheory.Finiteness.Basic

namespace Litt3.QuotientGeometry

/-- The genuine Laurent field is spanned by `1,t,…,t^(n-1)` over the
embedded parameter field. The scalar structure uses actual substitution. -/
theorem finite_parameter_laurent_span
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hc : PowerSeries.constantCoeff c ≠ 0)
    (hb0 : PowerSeries.constantCoeff b = 0)
    (hinj : Function.Injective (PowerSeries.subst b : PowerSeries k → PowerSeries k)) :
    letI : Algebra (LaurentSeries k) (LaurentSeries k) :=
      (parameterLaurentMap b hb0 hinj).toAlgebra
    letI : SMul (LaurentSeries k) (LaurentSeries k) :=
      (parameterLaurentMap b hb0 hinj).toAlgebra.toSMul
    letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
    Submodule.span (LaurentSeries k)
      (Set.range (fun i : Fin n =>
        ((PowerSeries.X ^ i.val : PowerSeries k) : LaurentSeries k))) = ⊤ := by
  classical
  let φ := parameterLaurentMap b hb0 hinj
  letI : Algebra (LaurentSeries k) (LaurentSeries k) := φ.toAlgebra
  letI : SMul (LaurentSeries k) (LaurentSeries k) := φ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
  let P := Submodule.span (LaurentSeries k)
    (Set.range (fun i : Fin n => ((PowerSeries.X ^ i.val : PowerSeries k) : LaurentSeries k)))
  change P = ⊤
  apply Submodule.eq_top_iff'.mpr
  intro f
  obtain ⟨m, g, hg⟩ := laurent_parameter_denominator_clearing n hn b c hb f
  have hmem (G : PowerSeries k) : (G : LaurentSeries k) ∈ P := by
    have hdecomp := finite_parameter_power_series_decomposition n hn b c G hb hc
    rw [hdecomp, map_sum]
    apply P.sum_mem
    intro i _
    rw [map_mul]
    have hi : ((PowerSeries.X ^ i.val : PowerSeries k) : LaurentSeries k) ∈ P :=
      Submodule.subset_span ⟨i, rfl⟩
    have hm := P.smul_mem ((finiteParameterComponents n b c G i : PowerSeries k) :
      LaurentSeries k) hi
    rw [Algebra.smul_def] at hm
    change φ ((finiteParameterComponents n b c G i : PowerSeries k) : LaurentSeries k) *
      ((PowerSeries.X ^ i.val : PowerSeries k) : LaurentSeries k) ∈ P at hm
    rw [parameter_laurent_map_power_series] at hm
    simpa only [mul_comm] using hm
  have hparam : φ ((PowerSeries.X ^ m : PowerSeries k) : LaurentSeries k) =
      ((b ^ m : PowerSeries k) : LaurentSeries k) := by
    rw [parameter_laurent_map_power_series,
      PowerSeries.subst_pow (PowerSeries.HasSubst.of_constantCoeff_zero' hb0),
      PowerSeries.subst_X (PowerSeries.HasSubst.of_constantCoeff_zero' hb0)]
  have hnonzero : ((b ^ m : PowerSeries k) : LaurentSeries k) ≠ 0 := by
    rw [← hparam]
    rw [← map_zero φ]
    apply φ.injective.ne
    simpa only [map_zero] using (HahnSeries.ofPowerSeries_injective (Γ := ℤ) (R := k)).ne
      (pow_ne_zero m (PowerSeries.X_ne_zero (R := k)))
  have hmul := P.smul_mem (((PowerSeries.X ^ m : PowerSeries k) : LaurentSeries k)⁻¹) (hmem g)
  rw [Algebra.smul_def] at hmul
  change φ (((PowerSeries.X ^ m : PowerSeries k) : LaurentSeries k)⁻¹) *
    (g : LaurentSeries k) ∈ P at hmul
  rw [map_inv₀, hparam, ← hg, ← mul_assoc, inv_mul_cancel₀ hnonzero, one_mul] at hmul
  exact hmul

end Litt3.QuotientGeometry
