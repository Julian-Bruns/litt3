import Definitions.Deformations.CommutingRangeQuotient

namespace Litt3.Deformations

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

@[simp] theorem commuting_range_quotient_apply_mk (A T : Module.End R M)
    (commute : Commute A T) (v : M) :
    commutingRangeQuotientEnd A T commute ((LinearMap.range A).mkQ v) =
      (LinearMap.range A).mkQ (T v) := rfl

/-- Every power of the actual quotient endomorphism retains the
literal power of the original commuting operator. -/
theorem commuting_range_quotient_pow_apply_mk (A T : Module.End R M)
    (commute : Commute A T) (n : ℕ) (v : M) :
    (commutingRangeQuotientEnd A T commute ^ n) ((LinearMap.range A).mkQ v) =
      (LinearMap.range A).mkQ ((T ^ n) v) := by
  induction n with
  | zero => rfl
  | succ n induction =>
    rw [pow_succ', Module.End.mul_apply, induction, commuting_range_quotient_apply_mk]
    rw [pow_succ', Module.End.mul_apply]

end Litt3.Deformations
