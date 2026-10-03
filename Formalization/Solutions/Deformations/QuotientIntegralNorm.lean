import Solutions.Deformations.QuotientCyclicRelation
import Definitions.Deformations.PreparedCyclicLogNorm

namespace Litt3.Deformations

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

theorem integral_cyclic_norm_commute (A T : Module.End R M) (commute : Commute A T)
    (p a : ℕ) :
    Commute A (integralCyclicNormValue (R := R) p a T) := by
  unfold integralCyclicNormValue
  apply Commute.sum_right
  intro j member
  exact (commute.pow_right (j - 1)).smul_right _

/-- The original full integral norm induces exactly the same full
norm polynomial in the actual quotient augmentation map. -/
theorem commuting_quotient_integral_norm (A T : Module.End R M)
    (commute : Commute A T) (p a : ℕ) :
    commutingRangeQuotientEnd A (integralCyclicNormValue (R := R) p a T)
        (integral_cyclic_norm_commute A T commute p a) =
      integralCyclicNormValue (R := R) p a (commutingRangeQuotientEnd A T commute) := by
  apply LinearMap.ext
  intro v
  obtain ⟨w, rfl⟩ := (LinearMap.range A).mkQ_surjective v
  simp only [commuting_range_quotient_apply_mk, integralCyclicNormValue, LinearMap.sum_apply,
    LinearMap.smul_apply, map_sum, map_smul, commuting_range_quotient_pow_apply_mk]

theorem commuting_quotient_integral_norm_apply (A T : Module.End R M)
    (commute : Commute A T) (p a : ℕ) (v : M) :
    (LinearMap.range A).mkQ (integralCyclicNormValue (R := R) p a T v) =
      integralCyclicNormValue (R := R) p a (commutingRangeQuotientEnd A T commute)
        ((LinearMap.range A).mkQ v) := by
  rw [← commuting_quotient_integral_norm A T commute p a,
    commuting_range_quotient_apply_mk]

end Litt3.Deformations
