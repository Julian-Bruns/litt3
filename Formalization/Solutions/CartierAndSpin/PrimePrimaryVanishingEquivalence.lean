import Solutions.CartierAndSpin.PrimePowerKernelVanishing

namespace Litt3.CartierAndSpin

variable {A : Type*} [AddCommGroup A] (p : ℕ) [Fact p.Prime]

/-- In ANY abelian group, literal prime-kernel vanishing is equivalent
to vanishing of the ENTIRE actual primary component. No ambient or
primary finiteness, exponent bound or cyclicity premise is required. -/
theorem actual_primary_zero_iff_prime_kernel_zero :
    AddCommGroup.primaryComponent A p = ⊥ ↔ powerTorsionSubgroup A p = ⊥ := by
  constructor
  · intro hprimary
    apply le_antisymm
    · intro a ha
      have hm : a ∈ AddCommGroup.primaryComponent A p :=
        exists_addOrderOf_eq_prime_pow_iff.mpr ⟨1, by
          simpa only [pow_one] using ha⟩
      rwa [hprimary] at hm
    · exact bot_le
  · exact actual_primary_subgroup_vanishes_of_prime_kernel_zero p

end Litt3.CartierAndSpin
