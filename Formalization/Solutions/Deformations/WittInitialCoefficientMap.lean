import Solutions.Deformations.WittWeightedInitial

set_option maxHeartbeats 1000000

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime]
variable {k l : Type*} [CommRing k] [CommRing l]

theorem witt_weighted_initial_coefficient_map (φ : k →+* l) (w d b : ℕ) (c : k) :
    truncatedWittMap p N φ (wittWeightedInitialCoefficient p N w d b c) =
      wittWeightedInitialCoefficient p N w d b (φ c) := by
  classical
  unfold wittWeightedInitialCoefficient
  split_ifs
  · rw [map_mul, map_pow, map_natCast, truncated_witt_map_truncate, WittVector.map_teichmuller]
  · rw [map_zero]

/-- Every actual weighted initial class is functorial under literal
Witt coefficient maps, keeping the original precision and weight. -/
theorem witt_weighted_coefficient_initial_map (φ : k →+* l) (w d b : ℕ)
    (a : TruncatedWittVector p N k) (c : k)
    (initial : WittWeightedCoefficientInitial p N w d b a c) :
    WittWeightedCoefficientInitial p N w d b (truncatedWittMap p N φ a) (φ c) := by
  constructor
  · intro inactive
    rw [initial.1 inactive, map_zero]
  · obtain ⟨z, relation⟩ := initial.2
    refine ⟨truncatedWittMap p N φ z, ?_⟩
    have mapped := congrArg (truncatedWittMap p N φ) relation
    rw [map_sub, witt_weighted_initial_coefficient_map, map_mul, map_pow, map_natCast] at mapped
    exact mapped

end Litt3.Deformations
