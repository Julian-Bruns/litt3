import Mathlib.LinearAlgebra.Isomorphisms

namespace Litt3.Deformations

variable {R V W Z Z' : Type*} [Ring R]
variable [AddCommGroup V] [Module R V] [AddCommGroup W] [Module R W]
variable [AddCommGroup Z] [Module R Z] [AddCommGroup Z'] [Module R Z']

/-- An actual operator after actual invertible changes of
domain and codomain. -/
def transportedLinearMap (T : V →ₗ[R] Z) (domain : W ≃ₗ[R] V) (codomain : Z ≃ₗ[R] Z') :
    W →ₗ[R] Z' :=
  codomain.toLinearMap.comp (T.comp domain.toLinearMap)

end Litt3.Deformations
