import Solutions.Deformations.CommutingRangeQuotient

namespace Litt3.Deformations

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

theorem cyclic_relation_commute (A T : Module.End R M) (commute : Commute A T) (n : ℕ) :
    Commute A ((1 + T) ^ n - 1) :=
  ((Commute.one_right A).add_right commute).pow_right n |>.sub_right (Commute.one_right A)

theorem commuting_range_quotient_one_add (A T : Module.End R M) (commute : Commute A T) :
    commutingRangeQuotientEnd A (1 + T) ((Commute.one_right A).add_right commute) =
      1 + commutingRangeQuotientEnd A T commute := by
  apply LinearMap.ext
  intro v
  obtain ⟨w, rfl⟩ := (LinearMap.range A).mkQ_surjective v
  simp only [commuting_range_quotient_apply_mk, LinearMap.add_apply, Module.End.one_apply,
    map_add]

/-- The full cyclic relation on the quotient is literally induced by
the full cyclic relation on the original module; this is an equality
of actual maps, not a replacement model. -/
theorem commuting_quotient_cyclic_relation (A T : Module.End R M)
    (commute : Commute A T) (n : ℕ) :
    commutingRangeQuotientEnd A ((1 + T) ^ n - 1) (cyclic_relation_commute A T commute n) =
      (1 + commutingRangeQuotientEnd A T commute) ^ n - 1 := by
  apply LinearMap.ext
  intro v
  obtain ⟨w, rfl⟩ := (LinearMap.range A).mkQ_surjective v
  have powers := commuting_range_quotient_pow_apply_mk A (1 + T)
    ((Commute.one_right A).add_right commute) n w
  rw [commuting_range_quotient_one_add A T commute] at powers
  simp only [commuting_range_quotient_apply_mk, LinearMap.sub_apply,
    Module.End.one_apply, map_sub]
  rw [powers]

end Litt3.Deformations
