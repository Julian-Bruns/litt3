import Definitions.Deformations.ScalarTwistedRepresentations

namespace Litt3.Deformations

universe u

variable {k G V D : Type u} [Field k] [Group G]
    [AddCommGroup V] [Module k V] [AddCommGroup D] [Module k D]

/-- Actual equivariant semilinear operators on an upper space and
a downstairs space, with the actual pullback realizing all upper
invariants. The scalar automorphism is retained as data. -/
structure SemilinearInvariantDescentData (σ : k ≃+* k) where
  action : Representation k G V
  pullback : D →ₗ[k] V
  pullbackInjective : Function.Injective pullback
  invariantImage : LinearMap.range pullback = action.invariants
  upperOperator : V →ₛₗ[σ.toRingHom] V
  lowerOperator : D →ₛₗ[σ.toRingHom] D
  operatorEquivariant : ∀ g v, upperOperator (action g v) = action g (upperOperator v)
  operatorCommutes : ∀ d, upperOperator (pullback d) = pullback (lowerOperator d)

end Litt3.Deformations
