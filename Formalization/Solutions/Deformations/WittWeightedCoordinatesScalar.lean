import Solutions.Deformations.WittWeightedCoordinateMap
import Solutions.Deformations.WittWeightedInitialScalar

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]
variable {M I : Type*} [AddCommGroup M] [Module (TruncatedWittVector p N k) M] [Fintype I]

/-- The actual original residue-coordinate map is semilinear through
the literal Witt residue ring homomorphism, with no chosen field section. -/
theorem witt_weighted_coordinates_scalar
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ)
    (t : TruncatedWittVector p N k)
    (x : basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d) :
    wittWeightedCoordinatesAdd p N positive k B w d weightPositive degree (t • x) =
      truncatedWittResidue p N positive k t •
        wittWeightedCoordinatesAdd p N positive k B w d weightPositive degree x := by
  have initial := witt_weighted_coordinates_initial p N positive k B w d weightPositive degree x
  have scalarInitial : WittWeightedBasisInitial p N B w d degree (t • (x : M))
      (truncatedWittResidue p N positive k t •
        wittWeightedCoordinatesAdd p N positive k B w d weightPositive degree x) := by
    rw [witt_weighted_basis_initial_iff p N k B w d weightPositive]
    intro i
    rw [map_smul, Finsupp.smul_apply, smul_eq_mul]
    exact witt_weighted_coefficient_initial_scalar p N positive k w d (degree i) weightPositive
      _ t _ ((witt_weighted_basis_initial_iff p N k B w d weightPositive degree x _).mp initial i)
  exact ((Classical.choose_spec (witt_weighted_basis_initial_exists_unique p N positive k B w d
    weightPositive degree (t • (x : M)) (Submodule.smul_mem _ t x.property))).2 _ scalarInitial).symm

end Litt3.Deformations
