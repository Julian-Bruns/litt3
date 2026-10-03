import Definitions.Deformations.InvariantCokernelObstruction
import Mathlib.Algebra.Module.TransferInstance

namespace Litt3.Deformations

universe u

variable {k : Type u} [CommRing k]

/-- A distinct scalar-twisted module. Its addition is the original
addition, and scalar a acts through the actual scalar automorphism σ. -/
structure ScalarTwist (σ : k ≃+* k) (V : Type u) where
  value : V

namespace ScalarTwist

variable (σ : k ≃+* k) (V : Type u)

def valueEquiv : ScalarTwist σ V ≃ V where
  toFun := value
  invFun := mk
  left_inv _ := rfl
  right_inv _ := rfl

instance [AddCommGroup V] : AddCommGroup (ScalarTwist σ V) :=
  (valueEquiv σ V).addCommGroup

instance [AddCommGroup V] [Module k V] : Module k (ScalarTwist σ V) := by
  letI := Module.compHom V σ.toRingHom
  exact (valueEquiv σ V).module k

@[simp] theorem value_zero [AddCommGroup V] : (0 : ScalarTwist σ V).value = 0 := rfl
@[simp] theorem value_add [AddCommGroup V] (x y : ScalarTwist σ V) :
    (x + y).value = x.value + y.value := rfl
@[simp] theorem value_sub [AddCommGroup V] (x y : ScalarTwist σ V) :
    (x - y).value = x.value - y.value := rfl
@[simp] theorem value_smul [AddCommGroup V] [Module k V] (a : k) (x : ScalarTwist σ V) :
    (a • x).value = σ a • x.value := rfl

@[ext] theorem ext {x y : ScalarTwist σ V} (h : x.value = y.value) : x = y :=
  (valueEquiv σ V).injective h

end ScalarTwist

variable {G V W : Type u} [Group G]
    [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

/-- An actual σ-semilinear map becomes linear into the distinct
σ-twisted target. No basis or identification of the twist is chosen. -/
def scalarTwistedLinearMap (σ : k ≃+* k) (f : V →ₛₗ[σ.toRingHom] W) :
    V →ₗ[k] ScalarTwist σ W where
  toFun x := ⟨f x⟩
  map_add' x y := ScalarTwist.ext σ W (f.map_add x y)
  map_smul' a x := ScalarTwist.ext σ W (f.map_smulₛₗ a x)

/-- Actual linear pullback maps also act on both scalar-twisted
spaces, through precisely their original underlying additive maps. -/
def scalarTwistedPullback (σ : k ≃+* k) (f : V →ₗ[k] W) :
    ScalarTwist σ V →ₗ[k] ScalarTwist σ W where
  toFun x := ⟨f x.value⟩
  map_add' x y := ScalarTwist.ext σ W (f.map_add x.value y.value)
  map_smul' a x := ScalarTwist.ext σ W (f.map_smul (σ a) x.value)

/-- The genuine deck representation on the distinct scalar twist,
with the original underlying group action. -/
def scalarTwistedRepresentation (σ : k ≃+* k) (ρ : Representation k G V) :
    Representation k G (ScalarTwist σ V) where
  toFun g := {
    toFun x := ⟨ρ g x.value⟩
    map_add' x y := ScalarTwist.ext σ V ((ρ g).map_add x.value y.value)
    map_smul' a x := ScalarTwist.ext σ V ((ρ g).map_smul (σ a) x.value) }
  map_one' := by
    apply LinearMap.ext
    intro x
    apply ScalarTwist.ext
    change ρ 1 x.value = x.value
    rw [map_one, Module.End.one_apply]
  map_mul' g h := by
    apply LinearMap.ext
    intro x
    apply ScalarTwist.ext
    change ρ (g * h) x.value = ρ g (ρ h x.value)
    rw [map_mul, Module.End.mul_apply]

end Litt3.Deformations
