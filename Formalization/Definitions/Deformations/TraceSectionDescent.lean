import Definitions.Deformations.PGroupNormFreeness

namespace Litt3.Deformations

variable (k G V D : Type*) [CommRing k] [Group G] [Fintype G]
    [AddCommGroup V] [Module k V] [AddCommGroup D] [Module k D]

/-- The literal pullback and full trace on actual coefficient sections.
The norm identity uses every deck element. No trace-surjectivity,
group-algebra freeness or cohomology vanishing is assumed here. -/
structure TraceSectionDescentData where
  action : Representation k G V
  pullback : D →ₗ[k] V
  pullbackInjective : Function.Injective pullback
  invariantImage : LinearMap.range pullback = action.invariants
  trace : V →ₗ[k] D
  fullNormIdentity : pullback.comp trace = action.norm

end Litt3.Deformations
