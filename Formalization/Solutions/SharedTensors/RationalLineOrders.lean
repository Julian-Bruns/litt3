import Definitions.SharedTensors.RationalLineOrders
import Solutions.SharedTensors.DivisorSectionOrders
import Mathlib.Tactic

namespace Litt3.SharedTensors

open Litt3.Jacobians
open scoped WithZero

variable {F M : Type*} [Field F] [AddCommGroup M] [Module F M]

theorem rational_line_coordinate_valuation (v : Valuation F ℤᵐ⁰)
    (e : M ≃ₗ[F] F) (omega : M) (h : omega ≠ 0) :
    v (e omega) = WithZero.exp (-rationalLineOrder v e omega h) :=
  valuation_value_eq_exp_neg_order v
    (Additive.ofMul (nonzeroLineCoordinateUnit e omega h))

theorem rational_line_positive_order_iff (v : Valuation F ℤᵐ⁰)
    (e : M ≃ₗ[F] F) (omega : M) (h : omega ≠ 0) :
    0 < rationalLineOrder v e omega h ↔ v (e omega) < 1 := by
  rw [rational_line_coordinate_valuation]
  change 0 < rationalLineOrder v e omega h ↔
    WithZero.exp (-rationalLineOrder v e omega h) < WithZero.exp (0 : ℤ)
  rw [WithZero.exp_lt_exp]
  omega

theorem rational_line_nonnegative_order_iff (v : Valuation F ℤᵐ⁰)
    (e : M ≃ₗ[F] F) (omega : M) (h : omega ≠ 0) :
    0 ≤ rationalLineOrder v e omega h ↔ v (e omega) ≤ 1 := by
  rw [rational_line_coordinate_valuation]
  change 0 ≤ rationalLineOrder v e omega h ↔
    WithZero.exp (-rationalLineOrder v e omega h) ≤ WithZero.exp (0 : ℤ)
  rw [WithZero.exp_le_exp]
  omega

theorem rational_line_negative_order_iff (v : Valuation F ℤᵐ⁰)
    (e : M ≃ₗ[F] F) (omega : M) (h : omega ≠ 0) :
    rationalLineOrder v e omega h < 0 ↔ 1 < v (e omega) := by
  rw [rational_line_coordinate_valuation]
  change rationalLineOrder v e omega h < 0 ↔
    WithZero.exp (0 : ℤ) < WithZero.exp (-rationalLineOrder v e omega h)
  rw [WithZero.exp_lt_exp]
  omega

theorem rational_line_smul_ne_zero (a : Fˣ) (omega : M) (h : omega ≠ 0) :
    (a : F) • omega ≠ 0 := by
  intro hz
  apply h
  have hi := congrArg (fun m : M => ((a⁻¹ : Fˣ) : F) • m) hz
  simpa only [smul_smul, Units.inv_mul, one_smul, smul_zero] using hi

/-- Every pair of nonzero original vectors in a genuine field line differs
by a unit of that SAME field. -/
theorem rational_line_exists_unit_smul_eq (e : M ≃ₗ[F] F)
    (omega eta : M) (h : omega ≠ 0) (hEta : eta ≠ 0) :
    ∃ a : Fˣ, (a : F) • omega = eta := by
  let u := nonzeroLineCoordinateUnit e omega h
  let v := nonzeroLineCoordinateUnit e eta hEta
  refine ⟨v * u⁻¹, ?_⟩
  apply e.injective
  rw [map_smul, smul_eq_mul]
  change (((v * u⁻¹ : Fˣ) : F) * (u : F)) = (v : F)
  simp only [Units.val_mul, mul_assoc, Units.inv_mul, mul_one]

/-- Scalar multiplication changes order by the order of the SAME original
rational scalar, uniformly for every genuine integer-valued valuation. -/
theorem rational_line_order_smul (v : Valuation F ℤᵐ⁰)
    (e : M ≃ₗ[F] F) (a : Fˣ) (omega : M) (h : omega ≠ 0) :
    rationalLineOrder v e ((a : F) • omega) (rational_line_smul_ne_zero a omega h) =
      valuationOrder v (Additive.ofMul a) + rationalLineOrder v e omega h := by
  have hu : nonzeroLineCoordinateUnit e ((a : F) • omega)
      (rational_line_smul_ne_zero a omega h) = a * nonzeroLineCoordinateUnit e omega h := by
    apply Units.ext
    change e ((a : F) • omega) = (a : F) * e omega
    rw [map_smul, smul_eq_mul]
  unfold rationalLineOrder
  rw [hu]
  exact map_add (valuationOrder v) (Additive.ofMul a)
    (Additive.ofMul (nonzeroLineCoordinateUnit e omega h))

end Litt3.SharedTensors
