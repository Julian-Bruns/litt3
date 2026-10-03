import Definitions.CartierAndSpin.NormalizedDVRBoundary
import Mathlib.RingTheory.Valuation.ValuationRing
import Mathlib.RingTheory.LocalRing.ResidueField.Basic
import Mathlib.Algebra.Ring.Int.Parity
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open scoped WithZero
open IsLocalRing

variable {L : Type*} [Field L]

/-- Actual normalized integer orders add on nonzero products. -/
theorem integer_order_mul (v : Valuation L ℤᵐ⁰) (x y : L)
    (hx : x ≠ 0) (hy : y ≠ 0) :
    integerFieldOrder v (x * y) = integerFieldOrder v x + integerFieldOrder v y := by
  simp only [integerFieldOrder, map_mul,
    WithZero.log_mul ((Valuation.ne_zero_iff v).mpr hx)
      ((Valuation.ne_zero_iff v).mpr hy)]
  omega

/-- Integer orders of actual powers, including the harmless convention at zero. -/
theorem integer_order_pow (v : Valuation L ℤᵐ⁰) (x : L) (n : ℕ) :
    integerFieldOrder v (x ^ n) = (n : ℤ) * integerFieldOrder v x := by
  simp only [integerFieldOrder, map_pow, WithZero.log_pow, nsmul_eq_mul]
  ring

/-- Every actual square has even normalized valuation order. The converse
is deliberately absent: unramified square-class twists remain possible. -/
theorem actual_square_integer_order_even (v : Valuation L ℤᵐ⁰) (x : L)
    (hx : IsSquare x) : Even (integerFieldOrder v x) := by
  obtain ⟨y, hy⟩ := hx
  rw [hy, ← pow_two, integer_order_pow]
  exact ⟨integerFieldOrder v y, by ring⟩

/-- Distinct literal residue classes of valuation integers give a unit
difference, hence actual valuation one. -/
theorem distinct_residues_difference_value_one (v : Valuation L ℤᵐ⁰)
    (a r : v.integer) (hresidue : residue v.integer a ≠ residue v.integer r) :
    v (a.val - r.val) = 1 := by
  have hunit : IsUnit (a - r) :=
    (residue_ne_zero_iff_isUnit (a - r)).mp (by
      rw [map_sub, sub_ne_zero]
      exact hresidue)
  exact (Valuation.integer.integers v).one_of_isUnit hunit

/-- At an odd-order point of the weight where the function is integral,
every actual square parameter has exactly the function's residue value.
Both residue classes are in the actual residue field of the valuation ring. -/
theorem weighted_square_odd_point_forces_residue (v : Valuation L ℤᵐ⁰)
    (g : L) (hg : g ≠ 0) (a r : v.integer)
    (hodd : Odd (integerFieldOrder v g))
    (hsquare : IsSquare (g * (a.val - r.val))) :
    residue v.integer a = residue v.integer r := by
  by_contra hresidue
  have hvalue := distinct_residues_difference_value_one v a r hresidue
  have hdiff : a.val - r.val ≠ 0 := by
    intro hzero
    simpa only [hzero, map_zero, zero_ne_one] using hvalue
  have heven := actual_square_integer_order_even v _ hsquare
  rw [integer_order_mul v g _ hg hdiff] at heven
  have horder : integerFieldOrder v (a.val - r.val) = 0 := by
    simp only [integerFieldOrder, hvalue, WithZero.log_one, neg_zero]
  rw [horder, add_zero] at heven
  exact (Int.not_even_iff_odd.mpr hodd) heven

/-- At a pole the scalar parameter cannot alter the valuation of the
function difference. This is a genuine ultrametric valuation identity. -/
theorem integral_parameter_pole_difference_order (v : Valuation L ℤᵐ⁰)
    (a r : L) (ha : v a ≤ 1) (hr : 1 < v r) :
    integerFieldOrder v (a - r) = integerFieldOrder v r := by
  simp only [integerFieldOrder, v.map_sub_eq_of_lt_right (ha.trans_lt hr)]

/-- The fixed pole-parity condition for an odd-power ratio. It is exactly
Even(ord(g)-m) when the primitive function has pole multiplicity m. -/
theorem weighted_odd_power_square_pole_parity (v : Valuation L ℤᵐ⁰)
    (g a r : L) (hg : g ≠ 0) (ha : v a ≤ 1) (hr : 1 < v r)
    (n : ℕ) (hn : Odd n) (hsquare : IsSquare (g * (a - r ^ n))) :
    Even (integerFieldOrder v g + integerFieldOrder v r) := by
  have hnzero : n ≠ 0 := by intro h; simpa only [h, Nat.not_odd_zero] using hn
  have hrpow : 1 < v (r ^ n) := by
    rw [map_pow]
    exact one_lt_pow₀ hr hnzero
  have hdiff : a - r ^ n ≠ 0 := by
    intro h
    have heq := congrArg v (sub_eq_zero.mp h)
    exact hrpow.not_ge (heq ▸ ha)
  have heven := actual_square_integer_order_even v _ hsquare
  rw [integer_order_mul v g _ hg hdiff,
    integral_parameter_pole_difference_order v a (r ^ n) ha hrpow,
    integer_order_pow] at heven
  rw [Int.even_add', Int.odd_mul, Int.odd_coe_nat] at heven
  rw [Int.even_add']
  simpa only [hn, true_and] using heven

/-- Away from odd divisor points of the weight, the actual weighted
divisor is even exactly when the actual function-difference order is even. -/
theorem even_weight_order_square_parity_iff (v : Valuation L ℤᵐ⁰)
    (g f : L) (hg : g ≠ 0) (hf : f ≠ 0)
    (hgeven : Even (integerFieldOrder v g)) :
    Even (integerFieldOrder v (g * f)) ↔ Even (integerFieldOrder v f) := by
  rw [integer_order_mul v g f hg hf, Int.even_add']
  have hnodd : ¬ Odd (integerFieldOrder v g) := Int.not_odd_iff_even.mpr hgeven
  simp only [hnodd, false_iff, Int.not_odd_iff_even]

end Litt3.CartierAndSpin
