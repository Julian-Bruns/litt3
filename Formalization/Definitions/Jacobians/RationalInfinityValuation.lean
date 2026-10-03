import Definitions.Jacobians.DedekindDivisors
import Mathlib.FieldTheory.RatFunc.Degree
import Mathlib.Tactic

namespace Litt3.Jacobians

open scoped WithZero Classical

/-- The actual valuation at infinity of the rational function field:
its multiplicative exponent is numerator degree minus denominator degree.
Thus the local parameter 1/t has multiplicative value exp(-1). -/
noncomputable def rationalInfinityValuation (K : Type*) [Field K] :
    Valuation (RatFunc K) ℤᵐ⁰ where
  toFun r := if r = 0 then 0 else WithZero.exp r.intDegree
  map_zero' := by simp
  map_one' := by simp
  map_mul' r s := by
    by_cases hr : r = 0
    · simp [hr]
    by_cases hs : s = 0
    · simp [hs]
    simp only [if_neg hr, if_neg hs, if_neg (mul_ne_zero hr hs), RatFunc.intDegree_mul hr hs,
      WithZero.exp_add]
  map_add_le_max' r s := by
    by_cases hsum : r + s = 0
    · simp only [if_pos hsum]
      exact bot_le
    by_cases hr : r = 0
    · simp [hr]
    by_cases hs : s = 0
    · simp [hs]
    simp only [if_neg hsum, if_neg hr, if_neg hs]
    have hmonotone : Monotone (fun z : ℤ => (WithZero.exp z : ℤᵐ⁰)) := by
      intro a b hab
      exact WithZero.coe_le_coe.mpr hab
    rcases le_max_iff.mp (RatFunc.intDegree_add_le hs hsum) with h | h
    · exact (hmonotone h).trans (le_max_left _ _)
    · exact (hmonotone h).trans (le_max_right _ _)

theorem rational_infinity_value_of_nonzero
    {K : Type*} [Field K] (r : RatFunc K) (hr : r ≠ 0) :
    rationalInfinityValuation K r = WithZero.exp r.intDegree := by
  change (if r = 0 then 0 else WithZero.exp r.intDegree) = _
  exact if_neg hr

theorem rational_infinity_order
    {K : Type*} [Field K] (r : (RatFunc K)ˣ) :
    valuationOrder (rationalInfinityValuation K) (Additive.ofMul r) =
      -r.val.intDegree :=
  valuation_order_of_value_exp _ _ _ (rational_infinity_value_of_nonzero r.val r.ne_zero)

/-- The full valuation-place model for K(t), including the place at
infinity and every height-one prime of K[t]. Its interpretation as points
of the scheme projective line is a separate bridge. -/
abbrev RationalProjectivePlaces (K : Type*) [Field K] :=
  Option (IsDedekindDomain.HeightOneSpectrum (Polynomial K))

noncomputable def rationalProjectiveValuationDivisorSystem
    (K : Type*) [Field K] : ValuationDivisorSystem (RatFunc K) (RationalProjectivePlaces K) where
  valuation
    | none => rationalInfinityValuation K
    | some v => v.valuation (RatFunc K)
  finite_support f := by
    have haffine := (dedekindValuationDivisorSystem (Polynomial K) (RatFunc K)).finite_support f
    apply ((Set.finite_singleton none).union (haffine.image some)).subset
    intro point hpoint
    cases point with
    | none => exact Or.inl rfl
    | some v => exact Or.inr ⟨v, hpoint, rfl⟩

end Litt3.Jacobians
