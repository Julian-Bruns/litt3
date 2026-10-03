import Solutions.CartierAndSpin.FinitePrimaryKernelProfile
import Solutions.CartierAndSpin.PrimePowerKernelVanishing

namespace Litt3.CartierAndSpin

variable {A : Type*} [AddCommGroup A]

/-- Every actual prime-power kernel lies in the literal primary
subgroup. This is an isomorphism of the TRUE kernels, not a supplied
primary decomposition. -/
def actualAmbientPrimaryPowerKernelEquiv
    (p : ℕ) [Fact p.Prime] (n : ℕ) :
    powerTorsionSubgroup A (p ^ n) ≃+
      powerTorsionSubgroup (AddCommGroup.primaryComponent A p) (p ^ n) where
  toFun a := ⟨⟨a.val, exists_addOrderOf_eq_prime_pow_iff.mpr ⟨n, a.property⟩⟩,
    Subtype.ext a.property⟩
  invFun a := ⟨a.val.val, congrArg Subtype.val a.property⟩
  left_inv a := rfl
  right_inv a := rfl
  map_add' a b := rfl

/-- If the entire actual primary subgroup is finite, one height gives
the exact cardinality of EVERY ambient prime-power kernel. The
ambient group itself need not be finite. -/
theorem actual_finite_primary_ambient_kernel_profile
    (p : ℕ) [Fact p.Prime]
    [Finite (AddCommGroup.primaryComponent A p)]
    (hp : Nat.card (powerTorsionSubgroup A p) ≤ p) :
    ∃ height : ℕ, Nat.card (AddCommGroup.primaryComponent A p) = p ^ height ∧
      ∀ n : ℕ, Nat.card (powerTorsionSubgroup A (p ^ n)) =
        p ^ min height n := by
  have hsmall : Nat.card (powerTorsionSubgroup
      (AddCommGroup.primaryComponent A p) p) ≤ p := by
    have h := Nat.card_congr (actualAmbientPrimaryPowerKernelEquiv (A := A) p 1).toEquiv
    have heq : Nat.card (powerTorsionSubgroup
        (AddCommGroup.primaryComponent A p) p) =
        Nat.card (powerTorsionSubgroup A p) := by
      simpa only [pow_one] using h.symm
    exact heq.trans_le hp
  obtain ⟨height, hheight, hprofile⟩ := actual_finite_primary_kernel_profile p
    (fun a => by
      obtain ⟨n, hn⟩ := a.property
      exact ⟨n, by simpa only [AddSubgroup.addOrderOf_coe] using hn⟩) hsmall
  refine ⟨height, hheight, fun n => ?_⟩
  exact (Nat.card_congr (actualAmbientPrimaryPowerKernelEquiv (A := A) p n).toEquiv).trans
    (hprofile n)

/-- Vanishing of the actual entire primary subgroup is equivalent to
vanishing of its FIRST ambient kernel, with no finiteness hypothesis. -/
theorem actual_primary_zero_iff_prime_kernel_zero
    (p : ℕ) [Fact p.Prime] :
    AddCommGroup.primaryComponent A p = ⊥ ↔ powerTorsionSubgroup A p = ⊥ := by
  refine ⟨fun h => ?_, actual_primary_subgroup_vanishes_of_prime_kernel_zero p⟩
  apply le_antisymm
  · intro a ha
    have hmem : a ∈ AddCommGroup.primaryComponent A p :=
      exists_addOrderOf_eq_prime_pow_iff.mpr ⟨1, by simpa only [pow_one] using ha⟩
    rwa [h] at hmem
  · exact bot_le

end Litt3.CartierAndSpin
