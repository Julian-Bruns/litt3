import Theorems.Deformations.NilpotentPerturbation

namespace Litt3.Deformations

variable {R A : Type*} [CommRing R] [Ring A] [Algebra R A]

/-- A nilpotent scalar makes every scalar multiple nilpotent,
including a noncommutative matrix correction. -/
theorem nilpotent_scalar_multiple (parameter : R) (nilpotent : IsNilpotent parameter)
    (correction : A) : IsNilpotent (parameter • correction) := by
  obtain ⟨n, hn⟩ := nilpotent
  refine ⟨n, ?_⟩
  rw [smul_pow, hn, zero_smul]

/-- An actual unit lifts through every nilpotent scalar correction.
The correction need not commute with the original unit. -/
theorem unit_survives_nilpotent_scalar (original : A) (unit : IsUnit original)
    (parameter : R) (nilpotent : IsNilpotent parameter) :
    Specifications.UnitSurvivesNilpotentScalar original parameter := by
  obtain ⟨u, rfl⟩ := unit
  intro correction
  have hnil := nilpotent_scalar_multiple parameter nilpotent ((u⁻¹ : Aˣ) * correction)
  have hunit := u.isUnit.mul hnil.isUnit_one_add
  have hinverse : (u : A) * (u⁻¹ : Aˣ) = 1 := u.val_inv
  have heq : (u : A) * (1 + parameter • ((u⁻¹ : Aˣ) * correction)) =
      scalarPerturbation (u : A) parameter correction := by
    unfold scalarPerturbation
    rw [mul_add, mul_one, mul_smul_comm, ← mul_assoc, hinverse, one_mul]
  exact heq ▸ hunit

end Litt3.Deformations
