import Solutions.QuotientGeometry.ConstantPolynomialGenerator

namespace Litt3.QuotientGeometry

theorem power_polynomial_degree {k : Type*} [Field k] (h : ℕ) :
    (Polynomial.X ^ h : Polynomial k).natDegree = h := Polynomial.natDegree_X_pow h

theorem power_polynomial_constant_zero {k : Type*} [Field k] (h : ℕ) (hh : 0 < h) :
    (Polynomial.X ^ h : Polynomial k).coeff 0 = 0 := by simp [hh.ne]

noncomputable def powerLaurentMap {k : Type*} [Field k] (h : ℕ) (hh : 0 < h) :
    LaurentSeries k →+* LaurentSeries k :=
  parameterLaurentMap (constantPolynomialParameter (Polynomial.X ^ h : Polynomial k))
    (constant_polynomial_parameter_zero _ (by rw [power_polynomial_degree]; exact hh))
    (constant_polynomial_parameter_injective _ (by rw [power_polynomial_degree]; exact hh))

theorem power_parameter_pole_image
    {k : Type*} [Field k] (h : ℕ) (hh : 0 < h) :
    powerLaurentMap (k := k) h hh (HahnSeries.single (-1) 1) =
      (HahnSeries.single (-1) 1) ^ h := by
  rw [powerLaurentMap, constant_polynomial_parameter_pole_image _
    (by rw [power_polynomial_degree]; exact hh)]
  simp

/-- Literal power-parameter base agreement and pole-generator
agreement determine arbitrary ring maps on the entire upstairs field. -/
theorem power_parameter_maps_ext
    {k A : Type*} [Field k] [Semiring A] (h : ℕ) (hh : 0 < h)
    (φ χ : LaurentSeries k →+* A)
    (hbase : φ.comp (powerLaurentMap h hh) = χ.comp (powerLaurentMap h hh))
    (hpole : φ (HahnSeries.single (-1) 1) = χ (HahnSeries.single (-1) 1)) : φ = χ :=
  constant_polynomial_parameter_maps_ext (Polynomial.X ^ h) (by rw [power_polynomial_degree]; exact hh)
    (power_polynomial_constant_zero h hh) φ χ hbase hpole

theorem power_parameter_power_series_compatibility
    {k : Type*} [Field k] (h : ℕ) (hh : 0 < h) :
    ∃ φ : PowerSeries k →ₐ[k] PowerSeries k,
      (∀ r : PowerSeries k, powerLaurentMap h hh (r : LaurentSeries k) = (φ r : PowerSeries k)) ∧
      PowerSeries.constantCoeff (φ PowerSeries.X) = 0 := by
  let g := (Polynomial.X : Polynomial k) ^ h
  have hg : 0 < g.natDegree := by rw [power_polynomial_degree]; exact hh
  let b := constantPolynomialParameter g
  have hb := constant_polynomial_parameter_zero g hg
  let φ : PowerSeries k →ₐ[k] PowerSeries k :=
    PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)
  refine ⟨φ, ?_, ?_⟩
  · intro r
    rw [powerLaurentMap, parameter_laurent_map_power_series]
    exact congrArg (fun f : PowerSeries k => (f : LaurentSeries k))
      (congr_fun (PowerSeries.coe_substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)) r).symm
  · change PowerSeries.constantCoeff
      ((PowerSeries.substAlgHom (PowerSeries.HasSubst.of_constantCoeff_zero' hb)) PowerSeries.X) = 0
    rw [PowerSeries.coe_substAlgHom, PowerSeries.subst_X (PowerSeries.HasSubst.of_constantCoeff_zero' hb)]
    exact hb

end Litt3.QuotientGeometry
