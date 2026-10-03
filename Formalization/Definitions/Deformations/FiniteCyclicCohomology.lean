import Definitions.Deformations.RepresentationCocycles
import Mathlib.RepresentationTheory.Homological.FiniteCyclic

namespace Litt3.Deformations

universe u

variable {k G V : Type u} [CommRing k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V]

/-- The genuine cyclic difference operator lands in the kernel of
the genuine full finite-group norm. -/
def cyclicDifferenceToNormKernel (ρ : Representation k G V) (g : G) :
    V →ₗ[k] LinearMap.ker ρ.norm :=
  (ρ g - LinearMap.id).codRestrict _ (by
    intro v
    change ρ.norm (ρ g v - v) = 0
    rw [map_sub, Representation.norm_self_apply, sub_self])

/-- The actual cyclic degree-one cohomology quotient, built from
the actual full norm and actual generator difference maps. -/
abbrev CyclicOneCohomologyQuotient (ρ : Representation k G V) (g : G) :=
  LinearMap.ker ρ.norm ⧸ LinearMap.range (cyclicDifferenceToNormKernel ρ g)

end Litt3.Deformations
