import Definitions.Jacobians.ValuationDivisors
import Mathlib.RingTheory.DedekindDomain.FiniteAdeleRing

namespace Litt3.Jacobians

open scoped WithZero
open IsDedekindDomain

theorem valuation_order_of_value_exp
    {K : Type*} [Field K] (v : Valuation K ℤᵐ⁰) (f : Additive Kˣ)
    (n : ℤ) (hvalue : v f.toMul.val = WithZero.exp n) : valuationOrder v f = -n := by
  have hunit : Units.map v.toMonoidWithZeroHom.toMonoidHom f.toMul =
      WithZero.expEquiv n := Units.ext hvalue
  change -Multiplicative.toAdd
    ((WithZero.unitsWithZeroEquiv : (ℤᵐ⁰)ˣ ≃* Multiplicative ℤ)
      (Units.map v.toMonoidWithZeroHom.toMonoidHom f.toMul)) = -n
  rw [hunit]
  rfl

theorem valuation_order_eq_zero_of_value_one
    {K : Type*} [Field K] (v : Valuation K ℤᵐ⁰) (f : Additive Kˣ)
    (hvalue : v f.toMul.val = 1) : valuationOrder v f = 0 := by
  have hunit : Units.map v.toMonoidWithZeroHom.toMonoidHom f.toMul = 1 := Units.ext hvalue
  change -Multiplicative.toAdd
    ((WithZero.unitsWithZeroEquiv : (ℤᵐ⁰)ˣ ≃* Multiplicative ℤ)
      (Units.map v.toMonoidWithZeroHom.toMonoidHom f.toMul)) = 0
  rw [hunit, map_one]
  rfl

/-- The actual height-one adic valuations of a Dedekind fraction field
are one away from a finite set for every nonzero element. -/
theorem dedekind_valuation_ne_one_finite
    (R K : Type*) [CommRing R] [IsDedekindDomain R]
    [Field K] [Algebra R K] [IsFractionRing R K] (x : K) (hx : x ≠ 0) :
    {v : HeightOneSpectrum R | v.valuation K x ≠ 1}.Finite := by
  apply ((HeightOneSpectrum.Support.finite R x).union
    (HeightOneSpectrum.Support.finite R x⁻¹)).subset
  intro v hv
  rcases lt_or_gt_of_ne hv with hlt | hgt
  · right
    change 1 < v.valuation K x⁻¹
    rw [map_inv₀]
    apply (one_lt_inv₀ ?_).mpr hlt
    exact bot_lt_iff_ne_bot.mpr ((Valuation.ne_zero_iff _).mpr hx)
  · exact Or.inl hgt

/-- All finite-support data are proved from the standard height-one adic
valuations. This system applies to a Dedekind affine curve ring and its
actual function field; a proper-curve completion and its product formula
are separate geometric obligations. -/
noncomputable def dedekindValuationDivisorSystem
    (R K : Type*) [CommRing R] [IsDedekindDomain R]
    [Field K] [Algebra R K] [IsFractionRing R K] :
    ValuationDivisorSystem K (HeightOneSpectrum R) where
  valuation v := v.valuation K
  finite_support f := (dedekind_valuation_ne_one_finite R K f.toMul.val
    f.toMul.ne_zero).subset fun v hv => by
      intro hvalue
      apply hv
      exact valuation_order_eq_zero_of_value_one (v.valuation K) f hvalue

end Litt3.Jacobians
