import Solutions.SharedTensors.DivisorSections
import Definitions.Jacobians.DedekindDivisors

namespace Litt3.SharedTensors

open Litt3.Jacobians
open scoped WithZero

variable {k K X : Type*} [Field k] [Field K] [Algebra k K]

theorem valuation_value_eq_exp_neg_order (v : Valuation K ℤᵐ⁰)
    (a : Additive Kˣ) : v a.toMul.val = WithZero.exp (-valuationOrder v a) := by
  have hv : v a.toMul.val ≠ 0 := (Valuation.ne_zero_iff v).mpr a.toMul.ne_zero
  have he := WithZero.exp_log hv
  have ho := valuation_order_of_value_exp v a (WithZero.log (v a.toMul.val)) he.symm
  rw [ho, neg_neg]
  exact he.symm

/-- The usual pole-divisor definition of L(D) is exactly the actual
valuation-bounded function space, with the sign convention proved. -/
theorem unit_mem_divisorSectionSpace_iff_effective
    (S : ValuationDivisorSystem K X)
    (constants : ∀ c : k, ∀ x, S.valuation x (algebraMap k K c) ≤ 1)
    (D : Divisor X) (a : Additive Kˣ) :
    a.toMul.val ∈ divisorSectionSpace S constants D ↔
      EffectiveDivisor (principalDivisorMap S a + D) := by
  change (∀ x, S.valuation x a.toMul.val ≤ WithZero.exp (D x)) ↔
    ∀ x, 0 ≤ principalDivisorMap S a x + D x
  apply forall_congr'
  intro x
  rw [valuation_value_eq_exp_neg_order, WithZero.exp_le_exp]
  change -valuationOrder (S.valuation x) a ≤ D x ↔
    0 ≤ valuationOrder (S.valuation x) a + D x
  omega

end Litt3.SharedTensors
