import Solutions.QuotientGeometry.FiniteParameterSpan

namespace Litt3.QuotientGeometry

/-- Positive-order substitution gives a genuine finite extension of
Laurent fields, with degree bounded by its parameter order. -/
theorem finite_parameter_laurent_dimension
    {k : Type*} [Field k] (n : ℕ) (hn : 0 < n) (b c : PowerSeries k)
    (hb : b = PowerSeries.X ^ n * c) (hc : PowerSeries.constantCoeff c ≠ 0)
    (hb0 : PowerSeries.constantCoeff b = 0)
    (hinj : Function.Injective (PowerSeries.subst b : PowerSeries k → PowerSeries k)) :
    letI : Algebra (LaurentSeries k) (LaurentSeries k) :=
      (parameterLaurentMap b hb0 hinj).toAlgebra
    letI : SMul (LaurentSeries k) (LaurentSeries k) :=
      (parameterLaurentMap b hb0 hinj).toAlgebra.toSMul
    letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
    FiniteDimensional (LaurentSeries k) (LaurentSeries k) ∧
      Module.finrank (LaurentSeries k) (LaurentSeries k) ≤ n := by
  let φ := parameterLaurentMap b hb0 hinj
  letI : Algebra (LaurentSeries k) (LaurentSeries k) := φ.toAlgebra
  letI : SMul (LaurentSeries k) (LaurentSeries k) := φ.toAlgebra.toSMul
  letI : Module (LaurentSeries k) (LaurentSeries k) := Algebra.toModule
  have hspan := finite_parameter_laurent_span n hn b c hb hc hb0 hinj
  have hfg : (⊤ : Submodule (LaurentSeries k) (LaurentSeries k)).FG := by
    rw [← hspan]
    exact Submodule.fg_span (Set.finite_range _)
  haveI : FiniteDimensional (LaurentSeries k) (LaurentSeries k) := Module.finite_def.mpr hfg
  refine ⟨inferInstance, ?_⟩
  simpa only [Fintype.card_fin] using finrank_le_of_span_eq_top hspan

end Litt3.QuotientGeometry
