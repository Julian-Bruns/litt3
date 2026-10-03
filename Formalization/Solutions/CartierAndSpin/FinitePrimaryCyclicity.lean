import Solutions.CartierAndSpin.PrimePowerKernelCardinality
import Mathlib.GroupTheory.Torsion
import Mathlib.GroupTheory.SpecificGroups.Cyclic

namespace Litt3.CartierAndSpin

variable {A : Type*} [AddCommGroup A] [Finite A]

/-- A finite primary abelian group with at most p elements killed by
p is cyclic. Actual exponent realization and the genuine successive
kernel count replace a supplied cyclic decomposition or classification. -/
theorem actual_finite_primary_group_is_cyclic
    (p : ℕ) (hprimary : ∀ a : A, ∃ n : ℕ, addOrderOf a = p ^ n)
    (hp : Nat.card (powerTorsionSubgroup A p) ≤ p) : IsAddCyclic A := by
  obtain ⟨a, ha⟩ := AddMonoid.exists_addOrderOf_eq_exponent
    (AddMonoid.ExponentExists.of_finite (G := A))
  obtain ⟨n, hn⟩ := hprimary a
  have he : AddMonoid.exponent A = p ^ n := ha.symm.trans hn
  have hall : ∀ b : A, p ^ n • b = 0 := by
    intro b
    have hd : addOrderOf b ∣ p ^ n := by
      rw [← he]
      exact AddMonoid.addOrder_dvd_exponent b
    exact addOrderOf_dvd_iff_nsmul_eq_zero.mp hd
  have htop : powerTorsionSubgroup A (p ^ n) = ⊤ := by
    ext b
    exact iff_of_true (hall b) (by trivial)
  have hc := actual_power_kernel_cardinality_bound p hp n
  rw [htop, AddSubgroup.card_top] at hc
  apply isAddCyclic_of_addOrderOf_eq_card a
  apply le_antisymm addOrderOf_le_card
  rw [hn]
  exact hc

/-- A finite literal primary subgroup inherits its p-kernel bound
from the original ambient group's actual p-kernel. -/
theorem actual_primary_subgroup_is_cyclic
    {B : Type*} [AddCommGroup B] (p : ℕ) [Fact p.Prime]
    [Finite (AddCommGroup.primaryComponent B p)]
    [Finite (powerTorsionSubgroup B p)]
    (hp : Nat.card (powerTorsionSubgroup B p) ≤ p) :
    IsAddCyclic (AddCommGroup.primaryComponent B p) := by
  apply actual_finite_primary_group_is_cyclic p
  · intro b
    obtain ⟨n, hn⟩ := b.property
    refine ⟨n, ?_⟩
    simpa only [AddSubgroup.addOrderOf_coe] using hn
  · let j : powerTorsionSubgroup (AddCommGroup.primaryComponent B p) p →
        powerTorsionSubgroup B p := fun b =>
      ⟨b.val.val, congrArg Subtype.val b.property⟩
    have hj : Function.Injective j := by
      intro b c h
      have hv : b.val.val = c.val.val :=
        congrArg (fun z : powerTorsionSubgroup B p => z.val) h
      exact Subtype.ext (Subtype.ext hv)
    exact (Nat.card_le_card_of_injective j hj).trans hp

end Litt3.CartierAndSpin
