import Solutions.Deformations.ElementaryWeightCoordinates
import Solutions.Deformations.GroupNormalCoordinates

namespace Litt3.Deformations

open scoped BigOperators

variable {R S : Type*} [CommRing R] [Nontrivial R] [CommRing S] [Nontrivial S]

/-- Every actual coefficient ring map preserves the complete original
normal weight filtration. No field, residue model or injectivity is needed. -/
theorem group_coefficient_original_weight_preserves (phi : R →+* S)
    (q : ℕ) (positive : 0 < q) (nontrivial : 1 < q) (r d : ℕ)
    (x : AddMonoidAlgebra R (Fin r → ZMod q))
    (member : x ∈ elementaryNormalWeightFiltration R q positive r d) :
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod q) phi x ∈
      elementaryNormalWeightFiltration S q positive r d := by
  apply (elementary_normal_weight_coordinate_iff q positive nontrivial r d _).mpr
  intro alpha
  rw [group_coefficient_map_normal_coordinate]
  obtain ⟨c, equation⟩ :=
    (elementary_normal_weight_coordinate_iff q positive nontrivial r d x).mp member alpha
  refine ⟨phi c, ?_⟩
  rw [equation, map_mul, map_pow, map_natCast]

end Litt3.Deformations
