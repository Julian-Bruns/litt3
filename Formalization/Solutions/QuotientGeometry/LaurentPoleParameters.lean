import Solutions.QuotientGeometry.LaurentUnitOrders
import Solutions.QuotientGeometry.ParameterLaurentImages

namespace Litt3.QuotientGeometry

/-- Every actual positive pole determines an actual completed-ring
embedding and its compatible whole fraction-field map. -/
theorem laurent_pole_parameter_maps
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n)
    (ψ : LaurentSeries k) (horder : ψ.order = -(n : ℤ)) :
    ∃ (φ : PowerSeries k →ₐ[k] PowerSeries k)
      (Ψ : LaurentSeries k →+* LaurentSeries k),
      (∀ r : PowerSeries k, Ψ (r : LaurentSeries k) = (φ r : PowerSeries k)) ∧
      PowerSeries.constantCoeff (φ PowerSeries.X) = 0 ∧
      Ψ (HahnSeries.single (-1) 1) = ψ := by
  have hψ : ψ ≠ 0 := by
    intro h
    simp only [h, HahnSeries.order_zero] at horder
    omega
  have hinvorder : ψ⁻¹.order = (n : ℤ) := by rw [laurent_order_inverse, horder, neg_neg]
  let c : PowerSeries k := ψ⁻¹.powerSeriesPart
  have hc : PowerSeries.constantCoeff c ≠ 0 := by
    simpa only [c, ← PowerSeries.coeff_zero_eq_constantCoeff, LaurentSeries.powerSeriesPart_coeff,
      Nat.cast_zero, add_zero] using HahnSeries.coeff_order_ne_zero (inv_ne_zero hψ)
  let b : PowerSeries k := PowerSeries.X ^ n * c
  have hb : PowerSeries.constantCoeff b = 0 := by simp [b, hn.ne']
  have hbcoe : (b : LaurentSeries k) = ψ⁻¹ :=
    LaurentSeries.X_order_mul_powerSeriesPart hinvorder.symm
  have hinj : Function.Injective (PowerSeries.subst b : PowerSeries k → PowerSeries k) :=
    finite_parameter_substitution_injective n hn b c rfl hc
  let φ : PowerSeries k →ₐ[k] PowerSeries k :=
    PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)
  let Ψ := parameterLaurentMap b hb hinj
  refine ⟨φ, Ψ, ?_, ?_, ?_⟩
  · intro r
    rw [parameter_laurent_map_power_series]
    exact congrArg (fun f : PowerSeries k => (f : LaurentSeries k))
      (congr_fun (PowerSeries.coe_substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)) r).symm
  · change PowerSeries.constantCoeff
      ((PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)) PowerSeries.X) = 0
    rw [PowerSeries.coe_substAlgHom,
      PowerSeries.subst_X (PowerSeries.HasSubst.of_constantCoeff_zero' hb)]
    exact hb
  · rw [parameter_laurent_map_pole, HahnSeries.C_one, one_mul, hbcoe, inv_inv]

end Litt3.QuotientGeometry
