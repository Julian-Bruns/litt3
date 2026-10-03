import Mathlib.Algebra.Module.Equiv.Basic
import Mathlib.Algebra.Group.Units.Defs

namespace Litt3.SharedTensors

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- Two ENTIRE original integral coordinates differ by one original
scalar. The assertion does not choose independent pointwise generators. -/
theorem integral_line_coordinate_comparison
    (e e' : M ≃ₗ[R] R) (m : M) :
    e' m = e m * e' (e.symm 1) := by
  have hm : m = e m • e.symm 1 := by
    apply e.injective
    rw [map_smul, e.apply_symm_apply, smul_eq_mul, mul_one]
  calc
    e' m = e' (e m • e.symm 1) := congrArg e' hm
    _ = e m * e' (e.symm 1) := by rw [map_smul, smul_eq_mul]

/-- The coordinate-change coefficient is an ACTUAL unit in the original
ring, derived from both original linear inverses. Arbitrary commutative
rings, including the zero ring and zero divisors, are permitted. -/
noncomputable def integralLineCoordinateChange
    (e e' : M ≃ₗ[R] R) : Rˣ where
  val := e' (e.symm 1)
  inv := e (e'.symm 1)
  val_inv := by
    have h := integral_line_coordinate_comparison e' e (e.symm 1)
    simpa only [e.apply_symm_apply] using h.symm
  inv_val := by
    have h := integral_line_coordinate_comparison e e' (e'.symm 1)
    simpa only [e'.apply_symm_apply] using h.symm

theorem integral_line_coordinate_change_apply
    (e e' : M ≃ₗ[R] R) (m : M) :
    e' m = (integralLineCoordinateChange e e' : R) * e m := by
  rw [integral_line_coordinate_comparison e e' m]
  exact mul_comm _ _

end Litt3.SharedTensors
