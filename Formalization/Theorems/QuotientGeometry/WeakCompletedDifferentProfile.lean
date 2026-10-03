import Solutions.QuotientGeometry.ParameterDifferentValuation

namespace Litt3.QuotientGeometry

attribute [local instance] FractionRing.liftAlgebra FractionRing.isScalarTower_liftAlgebra

/-- A literal original finite separating positive-parameter profile:
the ACTUAL fraction-field extension is separable and its genuine
trace-defined different has the stated original valuation exponent.
This is a concrete mathematical proposition, not a supplied conclusion
about roots, Galoisness, automorphisms or scalar classification. -/
noncomputable def weakCompletedDifferentProfile
    {k : Type*} [Field k] (p h : ℕ)
    (hp : 1 < p) (hh : 0 < h)
    (b c : PowerSeries k) (hb : b = PowerSeries.X ^ (p * h) * c)
    (hc : PowerSeries.constantCoeff c ≠ 0) (hb0 : PowerSeries.constantCoeff b = 0) : Prop := by
  let A := CompletedPowerSeriesBase k
  let B := PowerSeries k
  letI : IsDomain A := completed_power_series_base_isDomain
  let φ := liftedCompletedEmbedding b hb0
  letI : Algebra A B := φ.toAlgebra
  letI : SMul A B := φ.toAlgebra.toSMul
  letI : Module A B := Algebra.toModule
  letI : NoZeroSMulDivisors A B := NoZeroSMulDivisors.iff_algebraMap_injective.mpr
    (lifted_finite_parameter_embedding_injective (p * h) (Nat.mul_pos (by omega) hh) b c hb hc hb0)
  letI : IsIntegrallyClosed A := completed_power_series_base_integrally_closed
  letI : Algebra A (FractionRing B) :=
    (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra
  letI : SMul A (FractionRing B) :=
    (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra.toSMul
  letI : Module A (FractionRing B) := Algebra.toModule
  letI : FaithfulSMul A (FractionRing B) :=
    (faithfulSMul_iff_algebraMap_injective _ _).mpr
      (lifted_finite_parameter_fraction_embedding_injective (p * h) (Nat.mul_pos (by omega) hh) b c hb hc hb0)
  letI : Algebra (FractionRing A) (FractionRing B) := FractionRing.liftAlgebra _ _
  letI : SMul (FractionRing A) (FractionRing B) := (FractionRing.liftAlgebra _ _).toSMul
  letI : Module (FractionRing A) (FractionRing B) := Algebra.toModule
  exact Algebra.IsSeparable (FractionRing A) (FractionRing B) ∧
    differentIdeal A B = Ideal.span {(PowerSeries.X : PowerSeries k) ^ (p * h + p - 2)}

end Litt3.QuotientGeometry
