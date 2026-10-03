import Mathlib.GroupTheory.QuotientGroup.Basic
import Mathlib.Algebra.Group.Hom.Instances

namespace Litt3.CartierAndSpin

variable {A B C X : Type*} [AddCommGroup A] [AddCommGroup B]
  [AddCommGroup C] [AddCommGroup X]

/-- The literal subgroup killed by a positive multiple. This definition
also makes sense for arbitrary natural numbers and arbitrary groups. -/
def powerTorsionSubgroup (A : Type*) [AddCommGroup A] (p : ℕ) : AddSubgroup A where
  carrier := {a | p • a = 0}
  zero_mem' := nsmul_zero p
  add_mem' := by
    intro a b ha hb
    change p • a = 0 at ha
    change p • b = 0 at hb
    change p • (a + b) = 0
    rw [nsmul_add, ha, hb, add_zero]
  neg_mem' := by
    intro a ha
    change p • a = 0 at ha
    change p • (-a) = 0
    have h := congrArg (fun x : A => p • x) (add_neg_cancel a)
    dsimp only at h
    rw [nsmul_add, nsmul_zero, ha, zero_add] at h
    exact h

/-- The full two-leg relation map, retaining both endpoint groups. -/
def twoLegRelationHom (φ : B →+ A) (ψ : C →+ A) : (B × C) →+ A :=
  φ.comp (AddMonoidHom.fst B C) - ψ.comp (AddMonoidHom.snd B C)

abbrev TwoLegRelationQuotient (φ : B →+ A) (ψ : C →+ A) :=
  A ⧸ (twoLegRelationHom φ ψ).range

/-- Shared logarithmic forms are literal intersections of the two
actual endpoint images, without extending scalars. -/
def sharedLogarithmicImage (ℓ : A →+ X) (φ : B →+ A) (ψ : C →+ A) :
    AddSubgroup X := (ℓ.comp φ).range ⊓ (ℓ.comp ψ).range

end Litt3.CartierAndSpin
