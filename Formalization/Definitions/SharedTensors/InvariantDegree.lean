import Mathlib.Algebra.Group.Subgroup.Defs
import Mathlib.Algebra.Group.End
import Mathlib.Algebra.Group.Subgroup.Ker

namespace Litt3.SharedTensors

variable {G A B : Type*} [Group G] [AddCommGroup A] [AddCommGroup B]

/-- The actual subgroup fixed by a group of additive automorphisms. -/
def degreeFixedSubgroup (rho : G →* AddAut A) : AddSubgroup A where
  carrier := {a | ∀ g, rho g a = a}
  zero_mem' := by intro g; exact map_zero (rho g)
  add_mem' := by
    intro a b ha hb g
    rw [map_add, ha g, hb g]
  neg_mem' := by
    intro a ha g
    rw [map_neg, ha g]

/-- The genuine degree map restricted to its invariant subgroup. -/
def fixedDegreeMap (d : A →+ B) (rho : G →* AddAut A) :
    degreeFixedSubgroup rho →+ B := d.comp (degreeFixedSubgroup rho).subtype

/-- The difference between a translate and the original point lies in
the actual degree kernel when degree is invariant. -/
def actionDegreeDifference (d : A →+ B) (rho : G →* AddAut A)
    (hd : ∀ g a, d (rho g a) = d a) (g : G) (a : A) : d.ker :=
  ⟨rho g a - a, by change d (rho g a - a) = 0; rw [map_sub, hd, sub_self]⟩

end Litt3.SharedTensors
