import Definitions.Deformations.RegularFunctionRepresentation

namespace Litt3.Deformations

variable {k G V W : Type*} [CommRing k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

/-- Every genuine equivariant coefficient-linear map commutes with
the actual full finite-group norm. -/
theorem equivariant_map_norm (ρ : Representation k G V) (σ : Representation k G W)
    (f : V →ₗ[k] W) (equivariant : ∀ g v, f (ρ g v) = σ g (f v)) (v : V) :
    f (ρ.norm v) = σ.norm (f v) := by
  simp only [Representation.norm, LinearMap.sum_apply, map_sum, equivariant]

end Litt3.Deformations
