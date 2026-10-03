import Solutions.CartierAndSpin.FinitePrimaryCyclicity

namespace Litt3.CartierAndSpin

variable {A : Type*} [AddCommGroup A]
variable (p : ℕ) [Fact p.Prime] [Finite (powerTorsionSubgroup A p)]

/-- Every finite-height primary kernel is genuinely finite and cyclic
when the ORIGINAL ambient p-kernel has at most p points. The ambient
group and its full primary subgroup may both be infinite. -/
theorem actual_higher_prime_kernel_finite_cyclic
    (hp : Nat.card (powerTorsionSubgroup A p) ≤ p) (n : ℕ) :
    Finite (powerTorsionSubgroup A (p ^ n)) ∧
      IsAddCyclic (powerTorsionSubgroup A (p ^ n)) ∧
      Nat.card (powerTorsionSubgroup A (p ^ n)) ≤ p ^ n := by
  letI : Finite (powerTorsionSubgroup A (p ^ n)) := actual_power_kernel_finite p n
  refine ⟨inferInstance, ?_, actual_power_kernel_cardinality_bound p hp n⟩
  apply actual_finite_primary_group_is_cyclic p
  · intro a
    obtain ⟨m, hm⟩ := exists_addOrderOf_eq_prime_pow_iff.mpr
      (show ∃ j : ℕ, p ^ j • a.val = 0 from ⟨n, a.property⟩)
    exact ⟨m, (AddSubgroup.addOrderOf_coe a).symm.trans hm⟩
  · let j : powerTorsionSubgroup (powerTorsionSubgroup A (p ^ n)) p →
        powerTorsionSubgroup A p := fun a =>
      ⟨a.val.val, congrArg Subtype.val a.property⟩
    have hj : Function.Injective j := by
      intro a b h
      have hv : a.val.val = b.val.val :=
        congrArg (fun z : powerTorsionSubgroup A p => z.val) h
      exact Subtype.ext (Subtype.ext hv)
    exact (Nat.card_le_card_of_injective j hj).trans hp

end Litt3.CartierAndSpin
