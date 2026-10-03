import Solutions.Deformations.WittWeightedBasisOperations

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] (positive : 0 < N)
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]
variable {M I : Type*} [AddCommGroup M] [Module (TruncatedWittVector p N k) M] [Fintype I]

/-- Actual original initial residue coordinates, constructed uniquely
from actual weighted Witt coefficients. -/
noncomputable def wittWeightedCoordinates
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ)
    (x : basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d) : I → k :=
  Classical.choose (witt_weighted_basis_initial_exists_unique p N positive k B w d weightPositive degree x x.property)

theorem witt_weighted_coordinates_initial
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ)
    (x : basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d) :
    WittWeightedBasisInitial p N B w d degree x
      (wittWeightedCoordinates p N positive k B w d weightPositive degree x) :=
  (Classical.choose_spec (witt_weighted_basis_initial_exists_unique p N positive k B w d weightPositive degree x x.property)).1

/-- The actual initial-coordinate map is additive despite the use of
nonadditive Teichmüller representatives. -/
noncomputable def wittWeightedCoordinatesAdd
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ) :
    basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d →+ (I → k) where
  toFun := wittWeightedCoordinates p N positive k B w d weightPositive degree
  map_zero' := by
    apply (witt_weighted_basis_initial_zero_iff p N positive k B w d weightPositive degree _ _
      (witt_weighted_coordinates_initial p N positive k B w d weightPositive degree 0)).mpr
    exact Submodule.zero_mem _
  map_add' x y := by
    have sumInitial := witt_weighted_basis_initial_add p N positive k B w d weightPositive degree
      x y _ _ (witt_weighted_coordinates_initial p N positive k B w d weightPositive degree x)
      (witt_weighted_coordinates_initial p N positive k B w d weightPositive degree y)
    exact ((Classical.choose_spec (witt_weighted_basis_initial_exists_unique p N positive k B w d
      weightPositive degree (x + y) (x + y).property)).2 _ sumInitial).symm

/-- Its exact kernel is the actual next weighted submodule. -/
theorem witt_weighted_coordinates_kernel
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ)
    (x : basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d) :
    wittWeightedCoordinatesAdd p N positive k B w d weightPositive degree x = 0 ↔
      (x : M) ∈ basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree (d + 1) :=
  witt_weighted_basis_initial_zero_iff p N positive k B w d weightPositive degree x _
    (witt_weighted_coordinates_initial p N positive k B w d weightPositive degree x)

/-- Every surviving original residue coordinate array is realized by
an actual Witt element, giving the full initial-layer range. -/
theorem witt_weighted_coordinates_full_range
    (B : Module.Basis I (TruncatedWittVector p N k) M)
    (w d : ℕ) (weightPositive : 0 < w) (degree : I → ℕ) (c : I → k)
    (supported : ∀ i, ¬ wittWeightActive w d (degree i) N → c i = 0) :
    ∃ x : basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d,
      wittWeightedCoordinatesAdd p N positive k B w d weightPositive degree x = c := by
  let x : basisWeightedPowerFiltration B (p : TruncatedWittVector p N k) w degree d :=
    ⟨wittWeightedBasisRepresentative p N B w d degree c,
      witt_weighted_basis_representative_member p N k B w d weightPositive degree c⟩
  have initial : WittWeightedBasisInitial p N B w d degree x c := by
    refine ⟨supported, ?_⟩
    change wittWeightedBasisRepresentative p N B w d degree c -
      wittWeightedBasisRepresentative p N B w d degree c ∈ _
    rw [sub_self]
    exact Submodule.zero_mem _
  refine ⟨x, ?_⟩
  exact ((Classical.choose_spec (witt_weighted_basis_initial_exists_unique p N positive k B w d
    weightPositive degree x x.property)).2 c initial).symm

end Litt3.Deformations
