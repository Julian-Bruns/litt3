import Mathlib.RepresentationTheory.Invariants
import Mathlib.LinearAlgebra.Projection

namespace Litt3.Deformations

variable {k G V W : Type*} [CommRing k] [Group G]
    [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

/-- Right translation on the full function module, with trivial
coefficient action. This uses an actual group, with no finiteness assumption. -/
def regularFunctionRepresentation : Representation k G (G → W) where
  toFun g := {
    toFun f x := f (x * g)
    map_add' _ _ := rfl
    map_smul' _ _ := rfl }
  map_one' := by ext f x; simp
  map_mul' g h := by ext f x; simp [Module.End.mul_apply, mul_assoc]

/-- A chosen ordinary linear projection creates the genuine orbit-function
map. The projection need not be equivariant. -/
def projectedOrbitMap (ρ : Representation k G V) (π : V →ₗ[k] W) : V →ₗ[k] (G → W) where
  toFun v g := π (ρ g v)
  map_add' v w := by ext g; simp
  map_smul' c v := by ext g; simp

end Litt3.Deformations
