import Definitions.Deformations.RegularFunctionRepresentation
import Mathlib.GroupTheory.PGroup

namespace Litt3.Deformations.Specifications

variable {k G V W : Type*} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

def PGroupEquivariantInjectivity (ρ : Representation k G V) (σ : Representation k G W)
    (f : V →ₗ[k] W) : Prop :=
  (∀ g v, f (ρ g v) = σ g (f v)) →
  (∀ v, (∀ g, ρ g v = v) → f v = 0 → v = 0) → Function.Injective f

end Litt3.Deformations.Specifications
