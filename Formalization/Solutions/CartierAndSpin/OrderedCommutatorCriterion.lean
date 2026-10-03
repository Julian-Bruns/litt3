import Solutions.CartierAndSpin.FiniteCommutatorKernelCriterion
import Solutions.CartierAndSpin.OrderedCommutatorKernels

namespace Litt3.CartierAndSpin

variable {k M : Type*} [Field k] [AddCommGroup M] [Module k M]
variable [IsAlgClosed k] [FiniteDimensional k M] [Nontrivial M]

/-- The exact bounded ordered commutator criterion in every finite
dimension and every characteristic. -/
theorem ordered_commutator_common_eigenvector_criterion (U V : Module.End k M) :
    (∃ x : M, x ≠ 0 ∧ ∀ a b : ℕ, a + b ≤ Module.finrank k M - 1 →
      ((U * V - V * U) * U ^ a * V ^ b) x = 0) ↔
      ∃ (a b : k) (x : M), x ≠ 0 ∧ U x = a • x ∧ V x = b • x := by
  rw [← finite_commutator_kernel_criterion]
  constructor
  · rintro ⟨x, hx, hordered⟩ hzero
    have hmem := (mem_commutator_sequence_iff_ordered U V _ x).mpr hordered
    rw [hzero] at hmem
    exact hx hmem
  · intro hnonzero
    obtain ⟨x, hxmem, hx⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hnonzero
    exact ⟨x, hx, (mem_commutator_sequence_iff_ordered U V _ x).mp hxmem⟩

end Litt3.CartierAndSpin
