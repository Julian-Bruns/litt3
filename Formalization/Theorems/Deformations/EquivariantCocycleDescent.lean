import Definitions.Deformations.RepresentationCocycles

namespace Litt3.Deformations.Specifications

variable {k G V W : Type*} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

def EquivariantSurjectivityFromPrimitives
    (ρ : Representation k G V) (σ : Representation k G W) (f : V →ₗ[k] W) : Prop :=
  (∀ g v, f (ρ g v) = σ g (f v)) → Function.Injective f →
  (∀ w, (∀ g, σ g w = w) → w ∈ LinearMap.range f) →
  RepresentationCocyclePrimitives ρ → Function.Surjective f

end Litt3.Deformations.Specifications
