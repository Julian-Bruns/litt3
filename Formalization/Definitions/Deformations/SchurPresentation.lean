import Mathlib.LinearAlgebra.Isomorphisms

namespace Litt3.Deformations

variable {R V W : Type*} [Ring R] [AddCommGroup V] [AddCommGroup W]
variable [Module R V] [Module R W]

/-- The complete original block operator. The coefficient ring may
be noncommutative; every map is a map of left modules. -/
def schurResponse (A : V ≃ₗ[R] V) (b : W →ₗ[R] V)
    (c : V →ₗ[R] W) (d : W →ₗ[R] W) : V × W →ₗ[R] V × W :=
  (A.toLinearMap.comp (LinearMap.fst R V W) + b.comp (LinearMap.snd R V W)).prod
    (c.comp (LinearMap.fst R V W) + d.comp (LinearMap.snd R V W))

/-- The scalar or lower-block Schur entry, derived from the given
complete operator rather than supplied independently. -/
def schurEntry (A : V ≃ₗ[R] V) (b : W →ₗ[R] V)
    (c : V →ₗ[R] W) (d : W →ₗ[R] W) : W →ₗ[R] W :=
  d - c.comp (A.symm.toLinearMap.comp b)

/-- Actual residual of a target of the complete operator. -/
def schurResidual (A : V ≃ₗ[R] V) (c : V →ₗ[R] W) : V × W →ₗ[R] W :=
  LinearMap.snd R V W - c.comp (A.symm.toLinearMap.comp (LinearMap.fst R V W))

def schurQuotientProjection (A : V ≃ₗ[R] V) (b : W →ₗ[R] V)
    (c : V →ₗ[R] W) (d : W →ₗ[R] W) :
    V × W →ₗ[R] W ⧸ LinearMap.range (schurEntry A b c d) :=
  (LinearMap.range (schurEntry A b c d)).mkQ.comp (schurResidual A c)

end Litt3.Deformations
