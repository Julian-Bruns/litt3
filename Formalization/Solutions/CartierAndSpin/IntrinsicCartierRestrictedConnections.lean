import Solutions.CartierAndSpin.RestrictedCartierCoefficient
import Solutions.CartierAndSpin.RestrictedConnectionBijections
import Solutions.SharedTensors.RationalCartierFormula
import Solutions.SharedTensors.EtaleSymmetricTrace

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]
  {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The restricted coefficient criterion on the ORIGINAL universal
differential module with the actual intrinsic Cartier operator. -/
theorem p_basis_intrinsic_cartier_fixed_iff_restricted_curvature_zero
    (C : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1)
    (omega : KaehlerDifferential k K) :
    C.toAddHom omega = omega ↔
      (universalCoordinateDerivation e)^[p - 1] (e omega) + (e omega) ^ p = 0 := by
  rw [← e.injective.eq_iff, C.coordinate_formula b e he]
  exact actual_cartier_coefficient_fixed_iff_curvature_zero b
    (universalCoordinateDerivation e) he (e omega)

/-- Fixedness of the original rational form is equivalent to zero
pth iterate of the ENTIRE genuine original-field connection. -/
theorem p_basis_intrinsic_cartier_fixed_iff_connection_nilpotent
    (C : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1)
    (omega : KaehlerDifferential k K) :
    C.toAddHom omega = omega ↔
      ∀ a : K, (scalarDerivationConnection
        (universalCoordinateDerivation e) (e omega))^[p] a = 0 := by
  rw [← e.injective.eq_iff, C.coordinate_formula b e he]
  exact (actual_normalized_connection_prime_iterate_zero_iff_cartier_fixed b
    (universalCoordinateDerivation e) he (e omega)).symm

/-- A nonzero solution is constructed in the ORIGINAL field precisely
for Cartier-fixed universal forms. No scalar extension solution is
supplied, and no logarithmic converse is imported by this proof. -/
theorem p_basis_intrinsic_cartier_fixed_iff_connection_solution
    (C : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1)
    (omega : KaehlerDifferential k K) :
    C.toAddHom omega = omega ↔
      ∃ u : K, u ≠ 0 ∧ universalCoordinateDerivation e u = e omega * u := by
  rw [← e.injective.eq_iff, C.coordinate_formula b e he]
  exact (actual_normalized_connection_kernel_iff_cartier_fixed b
    (universalCoordinateDerivation e) he (e omega)).symm

/-- The complementary ORIGINAL connection is bijective exactly when
the actual universal form is not fixed by intrinsic Cartier. -/
theorem p_basis_intrinsic_cartier_connection_bijective_iff
    (C : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1)
    (omega : KaehlerDifferential k K) :
    Function.Bijective (scalarDerivationConnection
      (universalCoordinateDerivation e) (e omega)) ↔ C.toAddHom omega ≠ omega := by
  rw [actual_normalized_connection_bijective_iff b
    (universalCoordinateDerivation e) he]
  exact (not_congr
    (p_basis_intrinsic_cartier_fixed_iff_restricted_curvature_zero C b e he omega)).symm

end Litt3.CartierAndSpin
