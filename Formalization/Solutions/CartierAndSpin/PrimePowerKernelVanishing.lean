import Definitions.CartierAndSpin.LogarithmicQuotientBoundary
import Mathlib.GroupTheory.Torsion

namespace Litt3.CartierAndSpin

variable {A : Type*} [AddCommGroup A]

/-- Injectivity at zero of actual p-multiplication propagates to
every actual p^n-multiplication. No group finiteness or prime premise
is needed. -/
theorem actual_power_kernel_vanishing (p : ℕ)
    (hkernel : ∀ a : A, p • a = 0 → a = 0)
    (n : ℕ) (a : A) (ha : p ^ n • a = 0) : a = 0 := by
  induction n generalizing a with
  | zero => simpa only [pow_zero, one_nsmul] using ha
  | succ n hn =>
    apply hkernel a
    apply hn (p • a)
    rw [← mul_nsmul, ← pow_succ']
    exact ha

/-- Vanishing of the literal p-kernel kills the entire actual
p-primary subgroup, even if the ambient group is infinite. -/
theorem actual_primary_subgroup_vanishes_of_prime_kernel_zero
    (p : ℕ) [Fact p.Prime]
    (hz : powerTorsionSubgroup A p = ⊥) :
    AddCommGroup.primaryComponent A p = ⊥ := by
  have hkernel : ∀ a : A, p • a = 0 → a = 0 := by
    intro a ha
    have hmem : a ∈ powerTorsionSubgroup A p := ha
    rwa [hz] at hmem
  apply le_antisymm
  · intro a ha
    obtain ⟨n, hn⟩ := ha
    have hzero : p ^ n • a = 0 := by
      rw [← hn]
      exact addOrderOf_nsmul_eq_zero a
    exact actual_power_kernel_vanishing p hkernel n a hzero
  · exact bot_le

end Litt3.CartierAndSpin
