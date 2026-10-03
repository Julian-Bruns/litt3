import Definitions.Deformations.ObstructionTorsors
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Group.Action.Basic
import Mathlib.Algebra.Group.Subgroup.Defs
import Mathlib.Algebra.GroupWithZero.Action.Defs
import Mathlib.Data.Fintype.Card

namespace Litt3.Deformations

open scoped BigOperators

variable {G K : Type*} [Group G] [Fintype G] [AddCommGroup K]
variable [DistribMulAction G K]

/-- The additive homomorphism underlying the action of a group element. -/
def actionAddHom (g : G) : K →+ K where
  toFun x := g • x
  map_zero' := smul_zero g
  map_add' := smul_add g

/-- Actual invariant elements, as an additive subgroup. -/
def invariantSubgroup (G K : Type*) [Group G] [AddCommGroup K]
    [DistribMulAction G K] : AddSubgroup K where
  carrier := {x | ∀ g : G, g • x = x}
  zero_mem' := by intro g; exact smul_zero g
  add_mem' := by
    intro x y hx hy g
    rw [smul_add, hx, hy]
  neg_mem' := by
    intro x hx g
    rw [smul_neg, hx]

/-- Division by the finite group order exists exactly under the stated
bijectivity hypothesis. No field structure is used. -/
noncomputable def divideByOrder
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x)) (x : K) : K :=
  (Equiv.ofBijective (fun x : K => Fintype.card G • x) invertibleOrder).symm x

variable {A : Type*} [AddTorsor K A] [MulAction G A]

/-- The torsor average is constructed from differences at an arbitrary
origin; the group order is inverted only in the additive point group. -/
noncomputable def averageTorsorPoint
    (invertibleOrder : Function.Bijective
      (fun x : K => Fintype.card G • x)) (a : A) : A :=
  divideByOrder (G := G) invertibleOrder
    (∑ g : G, (g • a -ᵥ a : K)) +ᵥ a

section RestrictedObstruction

variable {O : Type*} [AddCommGroup O] [DistribMulAction G O]

/-- The response restricted to ACTUAL invariant points. -/
def invariantResponse (R : K →+ O)
    (response_equivariant : ∀ (g : G) (x : K), R (g • x) = g • R x) :
    invariantSubgroup G K →+ invariantSubgroup G O where
  toFun x := ⟨R x, by
    intro g
    rw [← response_equivariant, x.property g]⟩
  map_zero' := by apply Subtype.ext; exact R.map_zero
  map_add' := by intro x y; apply Subtype.ext; exact R.map_add x y

/-- The full obstruction value at a fixed torsor point belongs to the
actual invariant obstruction group. -/
def invariantObstructionValue (c : A → O)
    (equivariant : ∀ (g : G) (a : A), c (g • a) = g • c a)
    (a : A) (fixed : ∀ g : G, g • a = a) : invariantSubgroup G O :=
  ⟨c a, by
    intro g
    rw [← equivariant, fixed g]⟩

end RestrictedObstruction

end Litt3.Deformations
