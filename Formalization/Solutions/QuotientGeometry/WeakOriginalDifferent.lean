import Solutions.QuotientGeometry.ParameterDifferentValuation
import Solutions.QuotientGeometry.LaurentTameRoots
import Solutions.QuotientGeometry.WeakTameDerivativeOrders
import Solutions.QuotientGeometry.WeakLaurentNormalForm

namespace Litt3.QuotientGeometry

attribute [local instance] FractionRing.liftAlgebra FractionRing.isScalarTower_liftAlgebra

/-- The source different hypothesis forces the actual weak Laurent
expansion in the original coordinate BEFORE any normalization. The
prime-to-characteristic root and its derivative order are conclusions. -/
theorem weak_original_root_normal_form_from_different
    {k : Type*} [Field k] [IsAlgClosed k] (p h : ℕ) [CharP k p]
    (hp : 1 < p) (hh : 0 < h) (hchar : (h : k) ≠ 0)
    (b c : PowerSeries k) (hb : b = PowerSeries.X ^ (p * h) * c)
    (hc : PowerSeries.constantCoeff c ≠ 0) (hb0 : PowerSeries.constantCoeff b = 0) :
    letI : IsDomain (CompletedPowerSeriesBase k) := completed_power_series_base_isDomain
    letI : Algebra (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding b hb0).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (PowerSeries k) :=
      (liftedCompletedEmbedding b hb0).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (PowerSeries k) := Algebra.toModule
    letI : NoZeroSMulDivisors (CompletedPowerSeriesBase k) (PowerSeries k) :=
      NoZeroSMulDivisors.iff_algebraMap_injective.mpr
        (lifted_finite_parameter_embedding_injective (p * h) (Nat.mul_pos (by omega) hh) b c hb hc hb0)
    letI : IsIntegrallyClosed (CompletedPowerSeriesBase k) :=
      completed_power_series_base_integrally_closed
    letI : Algebra (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra
    letI : SMul (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (liftedCompletedFractionCoefficientEmbedding b hb0).toAlgebra.toSMul
    letI : Module (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) := Algebra.toModule
    letI : FaithfulSMul (CompletedPowerSeriesBase k) (FractionRing (PowerSeries k)) :=
      (faithfulSMul_iff_algebraMap_injective _ _).mpr
        (lifted_finite_parameter_fraction_embedding_injective (p * h) (Nat.mul_pos (by omega) hh) b c hb hc hb0)
    letI : Algebra (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      FractionRing.liftAlgebra _ _
    letI : SMul (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      (FractionRing.liftAlgebra _ _).toSMul
    letI : Module (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) :=
      Algebra.toModule
    Algebra.IsSeparable (FractionRing (CompletedPowerSeriesBase k)) (FractionRing (PowerSeries k)) →
      differentIdeal (CompletedPowerSeriesBase k) (PowerSeries k) =
        Ideal.span {(PowerSeries.X : PowerSeries k) ^ (p * h + p - 2)} →
      ∃ (ψ : LaurentSeries k), ψ ^ h = (b : LaurentSeries k)⁻¹ ∧
        ψ.order = -(p : ℤ) ∧ (LaurentSeries.derivative k ψ).order = -2 ∧
        ∃ (α γ : k) (r : PowerSeries k), α ≠ 0 ∧ γ ≠ 0 ∧
          ψ = HahnSeries.single (-(p : ℤ)) α + HahnSeries.single (-1) γ +
            (r : LaurentSeries k) := by
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
  intro hsep hdiff
  have hdegreepos : 0 < p * h := Nat.mul_pos (by omega) hh
  have hparameter := ((finite_parameter_completed_different_and_valuation
    (p * h) hdegreepos b c hb hc hb0 hsep).2.2 (p * h + p - 2)).mp hdiff
  have hcL : (c : LaurentSeries k) ≠ 0 := by
    intro hz
    have hc0 := congrArg (fun f : LaurentSeries k => f.coeff 0) hz
    apply hc
    simpa [PowerSeries.coeff_coe] using hc0
  have hbL : (b : LaurentSeries k) ≠ 0 := by
    rw [hb, PowerSeries.coe_mul, PowerSeries.coe_pow]
    exact mul_ne_zero (pow_ne_zero _ (by simp [PowerSeries.coe_X])) hcL
  have horder : (b : LaurentSeries k).order = (p * h : ℕ) := by
    rw [hb, PowerSeries.coe_mul, PowerSeries.coe_pow,
      HahnSeries.order_mul (pow_ne_zero _ (by simp [PowerSeries.coe_X])) hcL,
      HahnSeries.order_pow, PowerSeries.coe_X, HahnSeries.order_single one_ne_zero,
      power_series_coe_unit_order c hc, add_zero]
    simp
  have hβorder : ((b : LaurentSeries k)⁻¹).order = (h : ℤ) * -(p : ℤ) := by
    rw [laurent_order_inverse, horder]
    push_cast
    ring
  obtain ⟨ψ, hroot, hψorder⟩ := laurent_prime_to_characteristic_root h hh hchar
    (b : LaurentSeries k)⁻¹ (inv_ne_zero hbL) (-(p : ℤ)) hβorder
  have hinverse : (ψ ^ h)⁻¹ = (b : LaurentSeries k) := by rw [hroot, inv_inv]
  have hparameterorder : (LaurentSeries.derivative k (ψ ^ h)⁻¹).order =
      (p * h + p : ℕ) - 2 := by
    rw [hinverse, Litt3.CartierAndSpin.laurent_derivative_powerSeries]
    have hcast : ((p * h + p - 2 : ℕ) : ℤ) = (p * h + p : ℕ) - 2 := by
      omega
    exact hcast ▸ hparameter.2
  have hψderiv := weak_tame_root_derivative_order_from_parameter p h hp hh hchar ψ
    hψorder hparameterorder
  exact ⟨ψ, hroot, hψorder, hψderiv, weak_laurent_normal_form p hp ψ hψorder hψderiv⟩

end Litt3.QuotientGeometry

