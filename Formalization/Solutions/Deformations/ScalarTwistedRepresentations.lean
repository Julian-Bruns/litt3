import Definitions.Deformations.ScalarTwistedRepresentations

namespace Litt3.Deformations

universe u

variable {k G V W : Type u} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

@[simp] theorem scalar_twisted_representation_apply (σ : k ≃+* k)
    (ρ : Representation k G V) (g : G) (x : ScalarTwist σ V) :
    (scalarTwistedRepresentation σ ρ g x).value = ρ g x.value := rfl

/-- Actual invariant points on the scalar twist have precisely the
original invariant underlying points. The scalar structures remain
distinct throughout this additive comparison. -/
theorem scalar_twisted_mem_invariants_iff (σ : k ≃+* k)
    (ρ : Representation k G V) (x : ScalarTwist σ V) :
    x ∈ (scalarTwistedRepresentation σ ρ).invariants ↔ x.value ∈ ρ.invariants := by
  rw [Representation.mem_invariants, Representation.mem_invariants]
  constructor
  · intro h g
    exact congrArg ScalarTwist.value (h g)
  · intro h g
    exact ScalarTwist.ext σ V (h g)

theorem scalar_twisted_pullback_injective (σ : k ≃+* k) (f : V →ₗ[k] W)
    (injective : Function.Injective f) : Function.Injective (scalarTwistedPullback σ f) := by
  intro x y h
  exact ScalarTwist.ext σ V (injective (congrArg ScalarTwist.value h))

/-- Full actual invariant descent is preserved by simultaneous
scalar transport on the source and target of the actual pullback. -/
theorem scalar_twisted_pullback_invariant_image (σ : k ≃+* k)
    (ρ : Representation k G W) (f : V →ₗ[k] W)
    (image : LinearMap.range f = ρ.invariants) :
    LinearMap.range (scalarTwistedPullback σ f) =
      (scalarTwistedRepresentation σ ρ).invariants := by
  ext x
  rw [scalar_twisted_mem_invariants_iff, ← image]
  constructor
  · rintro ⟨v, rfl⟩
    exact ⟨v.value, rfl⟩
  · rintro ⟨v, hv⟩
    exact ⟨⟨v⟩, ScalarTwist.ext σ W hv⟩

end Litt3.Deformations
