import Mathlib.Algebra.Module.Projective
import Mathlib.LinearAlgebra.Quotient.Basic

namespace Litt3.Deformations

variable {R P M : Type*} [CommRing R] [AddCommGroup P] [Module R P]
    [Module.Projective R P] [AddCommGroup M] [Module R M]

/-- Every actual scalar-divisible linear map from a projective module
has an actual linear coefficient lift. Arbitrary free rank is included;
neither a matrix nor commuting coefficient operators are required. -/
theorem projective_scalar_divisible_map_lift (parameter : R) (T : P →ₗ[R] M)
    (divisible : LinearMap.range T ≤
      LinearMap.range (parameter • (LinearMap.id : M →ₗ[R] M))) :
    ∃ C : P →ₗ[R] M, parameter • C = T := by
  let f := parameter • (LinearMap.id : M →ₗ[R] M)
  let g := T.codRestrict (LinearMap.range f) (fun v => divisible ⟨v, rfl⟩)
  have onto : Function.Surjective f.rangeRestrict := by
    rintro ⟨v, w, same⟩
    exact ⟨w, Subtype.ext same⟩
  obtain ⟨C, same⟩ := Module.projective_lifting_property f.rangeRestrict g onto
  refine ⟨C, ?_⟩
  apply LinearMap.ext
  intro v
  have point := congrArg (fun u => (u v : LinearMap.range f).val) same
  exact point

theorem projective_scalar_divisible_map_iff (parameter : R) (T : P →ₗ[R] M) :
    (∃ C : P →ₗ[R] M, parameter • C = T) ↔
      LinearMap.range T ≤ LinearMap.range (parameter • (LinearMap.id : M →ₗ[R] M)) := by
  constructor
  · rintro ⟨C, rfl⟩ v ⟨w, rfl⟩
    exact ⟨C w, rfl⟩
  · exact projective_scalar_divisible_map_lift parameter T

end Litt3.Deformations
