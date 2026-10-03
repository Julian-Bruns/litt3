import Mathlib.LinearAlgebra.Quotient.Basic

namespace Litt3.Deformations

variable {R M N : Type*} [CommRing R] [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]

theorem linear_equiv_conjugate_pow (e : M ≃ₗ[R] N) (T : Module.End R M) (n : ℕ) :
    e.conj (T ^ n) = e.conj T ^ n := by
  change e.conjRingEquiv (T ^ n) = e.conjRingEquiv T ^ n
  exact map_pow _ _ _

theorem linear_equiv_conjugate_commute (e : M ≃ₗ[R] N) (A T : Module.End R M)
    (commute : Commute A T) : Commute (e.conj A) (e.conj T) := by
  change e.conjRingEquiv A * e.conjRingEquiv T = e.conjRingEquiv T * e.conjRingEquiv A
  rw [← map_mul, ← map_mul, commute.eq]

theorem linear_equiv_conjugate_scalar_range (e : M ≃ₗ[R] N) (T : Module.End R M)
    (r : R) (divisible : LinearMap.range T ≤
      LinearMap.range (r • (LinearMap.id : Module.End R M))) :
    LinearMap.range (e.conj T) ≤ LinearMap.range (r • (LinearMap.id : Module.End R N)) := by
  rintro v ⟨w, rfl⟩
  obtain ⟨z, same⟩ := divisible ⟨e.symm w, rfl⟩
  refine ⟨e z, ?_⟩
  change r • e z = e (T (e.symm w))
  rw [← map_smul]
  exact congrArg e same

theorem linear_equiv_conjugate_solvable (e : M ≃ₗ[R] N) (A : Module.End R M) (target : M) :
    (∃ v, A v = target) ↔ ∃ w, e.conj A w = e target := by
  constructor
  · rintro ⟨v, rfl⟩
    exact ⟨e v, by rw [LinearEquiv.conj_apply_apply, LinearEquiv.symm_apply_apply]⟩
  · rintro ⟨w, same⟩
    refine ⟨e.symm w, e.injective same⟩

end Litt3.Deformations
