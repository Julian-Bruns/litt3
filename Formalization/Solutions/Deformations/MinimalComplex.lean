import Theorems.Deformations.MinimalComplex
import Solutions.Deformations.TruncatedCoefficientRing

namespace Litt3.Deformations

variable {k ι : Type*} [CommRing k] [Fintype ι] [DecidableEq ι]

/-- A specified two-sided residue inverse gives an actual unit,
over arbitrary commutative coefficients and every positive length. -/
theorem truncated_matrix_unit_of_residue_inverse (N : ℕ) (positive : 0 < N)
    (F G : Matrix ι ι (TruncatedCoefficientRing k N))
    (left_inverse : (truncatedResidue k N positive).mapMatrix (G * F) = 1)
    (right_inverse : (truncatedResidue k N positive).mapMatrix (F * G) = 1) :
    IsUnit F := by
  apply (truncated_matrix_unit_criterion N positive F).mpr
  exact ⟨{
    val := (truncatedResidue k N positive).mapMatrix F
    inv := (truncatedResidue k N positive).mapMatrix G
    val_inv := by simpa only [map_mul] using right_inverse
    inv_val := by simpa only [map_mul] using left_inverse }, rfl⟩

/-- Genuine homotopy equivalences between minimal two-term
free complexes have genuinely invertible degree components.
Reduction of the actual homotopies proves both residue inverses. -/
theorem minimal_homotopy_equivalence_components_invertible (N : ℕ) (positive : 0 < N)
    (A B : Matrix ι ι (TruncatedCoefficientRing k N)) :
    Specifications.MinimalHomotopyEquivalenceComponentsInvertible N positive A B := by
  intro w
  constructor
  · apply truncated_matrix_unit_of_residue_inverse N positive w.f₀ w.g₀
    · rw [w.source_zero_homotopy, map_add, map_one, map_mul,
        w.source_minimal, mul_zero, add_zero]
    · rw [w.target_zero_homotopy, map_add, map_one, map_mul,
        w.target_minimal, mul_zero, add_zero]
  · apply truncated_matrix_unit_of_residue_inverse N positive w.f₁ w.g₁
    · rw [w.source_one_homotopy, map_add, map_one, map_mul,
        w.source_minimal, zero_mul, add_zero]
    · rw [w.target_one_homotopy, map_add, map_one, map_mul,
        w.target_minimal, zero_mul, add_zero]

end Litt3.Deformations
