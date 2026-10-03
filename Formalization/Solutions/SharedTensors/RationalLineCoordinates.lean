import Solutions.SharedTensors.RationalLineOrders

namespace Litt3.SharedTensors

variable {F M : Type*} [Field F] [AddCommGroup M] [Module F M]

/-- The coordinate of the SAME original field line normalized by an
actual nonzero original vector. -/
noncomputable def normalizedRationalLineCoordinate (e : M ≃ₗ[F] F)
    (omega : M) (h : omega ≠ 0) : M ≃ₗ[F] F :=
  e.trans (LinearEquiv.smulOfUnit (nonzeroLineCoordinateUnit e omega h)⁻¹)

theorem normalized_rational_line_coordinate_vector (e : M ≃ₗ[F] F)
    (omega : M) (h : omega ≠ 0) :
    normalizedRationalLineCoordinate e omega h omega = 1 := by
  change (((nonzeroLineCoordinateUnit e omega h)⁻¹ : Fˣ) : F) * e omega = 1
  exact (nonzeroLineCoordinateUnit e omega h).inv_mul

/-- The inverse coordinate is literally multiplication by the SAME
original vector, not an abstract field-line identification. -/
theorem normalized_rational_line_coordinate_symm (e : M ≃ₗ[F] F)
    (omega : M) (h : omega ≠ 0) (a : F) :
    (normalizedRationalLineCoordinate e omega h).symm a = a • omega := by
  apply (normalizedRationalLineCoordinate e omega h).injective
  rw [LinearEquiv.apply_symm_apply, map_smul,
    normalized_rational_line_coordinate_vector, smul_eq_mul, mul_one]

theorem normalized_rational_line_coordinate_reconstruction (e : M ≃ₗ[F] F)
    (omega : M) (h : omega ≠ 0) (eta : M) :
    normalizedRationalLineCoordinate e omega h eta • omega = eta := by
  rw [← normalized_rational_line_coordinate_symm]
  exact (normalizedRationalLineCoordinate e omega h).symm_apply_apply eta

end Litt3.SharedTensors
