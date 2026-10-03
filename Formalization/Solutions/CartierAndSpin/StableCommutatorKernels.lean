import Solutions.CartierAndSpin.CommutatorKernelSequence
import Solutions.CartierAndSpin.CommonEigenvectors

namespace Litt3.CartierAndSpin

variable {k M : Type*} [Field k] [AddCommGroup M] [Module k M]
variable [IsAlgClosed k] [FiniteDimensional k M]

/-- A nonzero adjacent equality of the genuine commutator kernel
sequence constructs an actual common eigenvector in the original space. -/
theorem stable_commutator_kernel_common_eigenvector (U V : Module.End k M) (d : ℕ)
    (heq : commutatorKernelSequence U V d = commutatorKernelSequence U V (d + 1))
    (hnonzero : commutatorKernelSequence U V d ≠ ⊥) :
    ∃ (a b : k) (x : M), x ≠ 0 ∧ U x = a • x ∧ V x = b • x := by
  let P := commutatorKernelSequence U V d
  letI : Nontrivial P := Submodule.nontrivial_iff_ne_bot.mpr hnonzero
  have hU : ∀ x ∈ P, U x ∈ P := by
    intro x hx
    have hxnext : x ∈ commutatorKernelSequence U V (d + 1) := by rw [← heq]; exact hx
    exact ((mem_commutator_kernel_sequence_succ U V d x).mp hxnext).2.1
  have hV : ∀ x ∈ P, V x ∈ P := by
    intro x hx
    have hxnext : x ∈ commutatorKernelSequence U V (d + 1) := by rw [← heq]; exact hx
    exact ((mem_commutator_kernel_sequence_succ U V d x).mp hxnext).2.2
  let U' : Module.End k P := U.restrict hU
  let V' : Module.End k P := V.restrict hV
  have hcomm : Commute U' V' := by
    ext x
    have hx0 := commutator_kernel_sequence_antitone U V (Nat.zero_le d) x.property
    have hzero : (U * V - V * U) x.val = 0 := hx0
    change U (V x.val) - V (U x.val) = 0 at hzero
    exact sub_eq_zero.mp hzero
  obtain ⟨a, b, x, hx, hUx, hVx⟩ := commuting_endomorphisms_common_eigenvector U' V' hcomm
  refine ⟨a, b, x.val, ?_, congrArg Subtype.val hUx, congrArg Subtype.val hVx⟩
  intro hzero
  exact hx (Subtype.ext hzero)

end Litt3.CartierAndSpin
