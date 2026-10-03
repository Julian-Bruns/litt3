import Definitions.Deformations.ElementaryAugmentationDegreeSpan
import Solutions.Deformations.ElementaryPrimeWeightStructure
import Solutions.Deformations.ElementaryWeightStructure

namespace Litt3.Deformations

variable (R : Type*) [CommRing R] [Nontrivial R]

/-- Every original normal weight is an actual ideal of the full original
elementary group algebra; coefficient closure and deck closure are proved. -/
noncomputable def elementaryOriginalDegreeIdeal (p : ℕ) [Fact p.Prime] (r d : ℕ) :
    Ideal (AddMonoidAlgebra R (Fin r → ZMod p)) where
  carrier := {x | x ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r d}
  zero_mem' := by
    change (0 : AddMonoidAlgebra R (Fin r → ZMod p)) ∈
      elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r d
    exact Submodule.zero_mem _
  add_mem' := by
    intro x y hx hy
    change x ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r d at hx
    change y ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r d at hy
    change x + y ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r d
    exact Submodule.add_mem _ hx hy
  smul_mem' := by
    intro a x member
    have initial : a ∈ elementaryNormalWeightFiltration R p (Fact.out : p.Prime).pos r 0 := by
      rw [elementary_normal_weight_initial]
      exact Submodule.mem_top
    simpa only [smul_eq_mul, Nat.zero_add] using elementary_prime_normal_weight_mul
      (R := R) p (Fact.out : p.Prime) r 0 d a x initial member

end Litt3.Deformations
