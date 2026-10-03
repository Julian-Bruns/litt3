import Solutions.Jacobians.DedekindIdealOrderComparison
import Solutions.Jacobians.FractionalIdealTensorEquivalence
import Solutions.SharedTensors.DivisorSectionOrders

open scoped nonZeroDivisors WithZero
open IsDedekindDomain

namespace Litt3.Jacobians

variable (R K : Type*) [CommRing R] [IsDedekindDomain R]
  [Field K] [Algebra R K] [IsFractionRing R K]

/-- The genuine fractional ideal for O(D), using the negative ideal
exponent convention and ANY actual fraction field of the original ring. -/
noncomputable def actualDedekindSectionFractionalIdeal
    (D : Divisor (HeightOneSpectrum R)) : (FractionalIdeal R⁰ K)ˣ :=
  (dedekindDivisorIdealMap R K (-D)).toMul

/-- Original membership in this actual fractional ideal is EXACTLY
the full collection of original normalized valuation bounds. No pole
test, ideal correspondence or fraction-field model is supplied. -/
theorem actual_dedekind_section_fractional_ideal_mem
    (D : Divisor (HeightOneSpectrum R)) (f : K) :
    f ∈ (actualDedekindSectionFractionalIdeal R K D).val ↔
      ∀ v : HeightOneSpectrum R, v.valuation K f ≤ WithZero.exp (D v) := by
  by_cases hf : f = 0
  · subst f
    constructor
    · intro h v
      simp only [map_zero]
      exact bot_le
    · intro h
      exact FractionalIdeal.zero_mem _
  · let u : Kˣ := Units.mk0 f hf
    change u.val ∈ (dedekindDivisorIdealMap R K (-D)).toMul.val ↔ _
    rw [dedekind_divisor_ideal_mem_iff_orders]
    apply forall_congr'
    intro v
    rw [Finsupp.neg_apply, principal_divisor_coefficient]
    change -D v ≤ valuationOrder (v.valuation K) (Additive.ofMul u) ↔
      v.valuation K u.val ≤ WithZero.exp (D v)
    have hvalue := Litt3.SharedTensors.valuation_value_eq_exp_neg_order
      (v.valuation K) (Additive.ofMul u)
    change v.valuation K u.val =
      WithZero.exp (-valuationOrder (v.valuation K) (Additive.ofMul u)) at hvalue
    rw [hvalue, WithZero.exp_le_exp]
    omega

/-- The actual valuation-bounded fractional ideal is an actual
invertible module over the original coordinate ring. -/
noncomputable instance actualDedekindSectionFractionalIdeal_invertible
    (D : Divisor (HeightOneSpectrum R)) :
    Module.Invertible R (((actualDedekindSectionFractionalIdeal R K D).val :
      FractionalIdeal R⁰ K) : Submodule R K) :=
  actual_invertible_fractional_ideal_module (actualDedekindSectionFractionalIdeal R K D)

end Litt3.Jacobians
