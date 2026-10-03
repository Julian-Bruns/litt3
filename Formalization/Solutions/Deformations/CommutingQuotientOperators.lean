import Solutions.Deformations.CommutingRangeQuotient

namespace Litt3.Deformations

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- Commutation descends through the literal common quotient. -/
theorem commuting_range_quotient_operators_commute (A T V : Module.End R M)
    (AT : Commute A T) (AV : Commute A V) (TV : Commute T V) :
    Commute (commutingRangeQuotientEnd A T AT) (commutingRangeQuotientEnd A V AV) := by
  apply LinearMap.ext
  intro v
  obtain ⟨w, rfl⟩ := (LinearMap.range A).mkQ_surjective v
  simp only [Module.End.mul_apply, commuting_range_quotient_apply_mk]
  exact congrArg (LinearMap.range A).mkQ (LinearMap.congr_fun TV.eq w)

end Litt3.Deformations
