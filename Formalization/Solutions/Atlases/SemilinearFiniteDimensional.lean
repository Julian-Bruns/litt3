import Definitions.Atlases.SemilinearFiniteDimensional

namespace Litt3.Atlases

variable {K V : Type*} [DivisionRing K] [AddCommGroup V] [Module K V]
  [FiniteDimensional K V]

/-- Injectivity and surjectivity are equivalent for a semilinear
endomorphism over any scalar automorphism and any finite dimension. -/
theorem semilinear_injective_iff_surjective (σ : K ≃+* K)
    (f : V →ₛₗ[(↑σ : K →+* K)] V) :
    Function.Injective f ↔ Function.Surjective f := by
  letI := RingHomInvPair.of_ringEquiv σ
  letI := RingHomInvPair.symm (↑σ : K →+* K) (↑σ.symm : K →+* K)
  let e := basisScalarTwist (Module.finBasis K V) σ
  let g : V →ₗ[K] V := f.comp e.symm.toLinearMap
  have hinj : Function.Injective g ↔ Function.Injective f := by
    exact ⟨fun h => Function.Injective.of_comp_right
        (f := (f : V → V)) (g := (e.symm : V → V)) h e.symm.surjective,
      fun h => h.comp e.symm.injective⟩
  have hsurj : Function.Surjective g ↔ Function.Surjective f := by
    exact ⟨fun h => Function.Surjective.of_comp h,
      fun h => h.comp e.symm.surjective⟩
  rw [← hinj, ← hsurj]
  exact LinearMap.injective_iff_surjective

/-- The same equivalence applies on any actual invariant subspace,
using its finite dimension, with no scalar-linearity restriction. -/
theorem semilinear_injOn_iff_surjOn (σ : K ≃+* K)
    (f : V →ₛₗ[(↑σ : K →+* K)] V) (S : Submodule K V)
    (h : Set.MapsTo f S S) : Set.InjOn f S ↔ Set.SurjOn f S S := by
  let g : S →ₛₗ[(↑σ : K →+* K)] S :=
    { toFun := fun x => ⟨f x, h x.property⟩
      map_add' := fun x y => Subtype.ext (f.map_add x y)
      map_smul' := fun c x => Subtype.ext (f.map_smulₛₗ c x) }
  have hg := semilinear_injective_iff_surjective σ g
  constructor
  · intro hi y hy
    have hi' : Function.Injective g := by
      intro x z heq
      exact Subtype.ext (hi x.property z.property (congrArg Subtype.val heq))
    obtain ⟨x, hx⟩ := hg.mp hi' ⟨y, hy⟩
    exact ⟨x, x.property, congrArg Subtype.val hx⟩
  · intro hs x hx y hy heq
    have hs' : Function.Surjective g := by
      intro z
      obtain ⟨w, hw, he⟩ := hs z.property
      exact ⟨⟨w, hw⟩, Subtype.ext he⟩
    exact congrArg Subtype.val (hg.mpr hs' (Subtype.ext heq : g ⟨x, hx⟩ = g ⟨y, hy⟩))

end Litt3.Atlases
