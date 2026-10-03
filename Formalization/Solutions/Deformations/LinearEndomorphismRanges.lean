import Mathlib.LinearAlgebra.Quotient.Basic
import Mathlib.LinearAlgebra.Pi

namespace Litt3.Deformations

variable {R M N : Type*} [CommRing R] [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]

/-- Postcomposing by an actual unit does not change the full range. -/
theorem linear_endomorphism_range_mul_unit (T U : Module.End R M) (unit : IsUnit U) :
    LinearMap.range (T * U) = LinearMap.range T := by
  ext v
  constructor
  · rintro ⟨w, rfl⟩
    exact ⟨U w, rfl⟩
  · rintro ⟨w, rfl⟩
    obtain ⟨z, same⟩ := ((Module.End.isUnit_iff U).mp unit).2 w
    exact ⟨z, by simp only [Module.End.mul_apply, same]⟩

/-- Full ranges transport through literal conjugation by the actual
linear equivalence. -/
theorem linear_equiv_map_range_conjugate (e : M ≃ₗ[R] N) (T : Module.End R M) :
    (LinearMap.range T).map e.toLinearMap = LinearMap.range (e.conj T) := by
  rw [LinearEquiv.conj_apply, e.symm.range_comp]
  exact (LinearMap.range_comp T e.toLinearMap).symm

/-- Equality after multiplication by one central scalar propagates
to every actual operator power, even when the two operators do not
commute with one another. -/
theorem scalar_times_operator_powers_equal (scalar : R) (T U : Module.End R M)
    (same : scalar • T = scalar • U) (n : ℕ) :
    scalar • T ^ n = scalar • U ^ n := by
  induction n with
  | zero => rfl
  | succ n induction =>
    calc
      scalar • T ^ (n + 1) = (scalar • T ^ n) * T := by rw [pow_succ, smul_mul_assoc]
      _ = (scalar • U ^ n) * T := by rw [induction]
      _ = U ^ n * (scalar • T) := by rw [smul_mul_assoc, mul_smul_comm]
      _ = U ^ n * (scalar • U) := by rw [same]
      _ = scalar • U ^ (n + 1) := by rw [mul_smul_comm, ← pow_succ]

end Litt3.Deformations
