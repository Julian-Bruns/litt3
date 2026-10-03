import Mathlib.Algebra.Group.Subgroup.Basic
import Mathlib.Tactic

namespace Litt3.Deformations

variable {X Y : Type*} [AddCommGroup X] [AddCommGroup Y]

/-- Finite successive correction gives an exact image for a merely
additive map. The correction submodule is fixed, so all lifts remain
in the required actual repair space. -/
theorem filtered_additive_exact_lift (F : ℕ → AddSubgroup Y)
    (D : AddSubgroup X) (L : X →+ Y) (start cutoff : ℕ)
    (bounded : start ≤ cutoff) (terminal : F cutoff = ⊥)
    (correction : ∀ d, start ≤ d → d < cutoff → ∀ y, y ∈ F d →
      ∃ x, x ∈ D ∧ y - L x ∈ F (d + 1))
    (y : Y) (member : y ∈ F start) : ∃ x, x ∈ D ∧ L x = y := by
  have lifts : ∀ n, n ≤ cutoff - start →
      ∃ x, x ∈ D ∧ y - L x ∈ F (start + n) := by
    intro n
    induction n with
    | zero =>
      intro _
      refine ⟨0, D.zero_mem, ?_⟩
      simpa only [map_zero, sub_zero, add_zero] using member
    | succ n induction =>
      intro bound
      obtain ⟨x, xMember, residual⟩ := induction (by omega)
      obtain ⟨z, zMember, corrected⟩ := correction (start + n) (by omega) (by omega)
        (y - L x) residual
      refine ⟨x + z, D.add_mem xMember zMember, ?_⟩
      rw [map_add, sub_add_eq_sub_sub]
      simpa only [Nat.succ_eq_add_one, Nat.add_assoc] using corrected
  obtain ⟨x, xMember, final⟩ := lifts (cutoff - start) le_rfl
  have index : start + (cutoff - start) = cutoff := by omega
  rw [index, terminal, AddSubgroup.mem_bot] at final
  exact ⟨x, xMember, (sub_eq_zero.mp final).symm⟩

/-- Successive leading-class injectivity forces every actual kernel
element to the asserted lower-weight threshold. -/
theorem filtered_additive_kernel_bound (F : ℕ → AddSubgroup X)
    (L : X →+ Y) (start cutoff : ℕ) (bounded : start ≤ cutoff)
    (leadingInjective : ∀ d, start ≤ d → d < cutoff → ∀ x,
      x ∈ F d → L x = 0 → x ∈ F (d + 1))
    (x : X) (member : x ∈ F start) (kernel : L x = 0) : x ∈ F cutoff := by
  have advance : ∀ n, n ≤ cutoff - start → x ∈ F (start + n) := by
    intro n
    induction n with
    | zero =>
      intro _
      simpa only [add_zero] using member
    | succ n induction =>
      intro bound
      have next := leadingInjective (start + n) (by omega) (by omega)
        x (induction (by omega)) kernel
      simpa only [Nat.succ_eq_add_one, Nat.add_assoc] using next
  have final := advance (cutoff - start) le_rfl
  simpa only [Nat.add_sub_of_le bounded] using final

end Litt3.Deformations
