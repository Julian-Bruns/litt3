import Solutions.CartierAndSpin.FiniteKernelStabilization
import Solutions.CartierAndSpin.StableCommutatorKernels

namespace Litt3.CartierAndSpin

variable {k M : Type*} [Field k] [AddCommGroup M] [Module k M]

theorem common_eigenvector_mem_commutator_sequence
    (U V : Module.End k M) (a b : k) (x : M)
    (hUx : U x = a • x) (hVx : V x = b • x) (d : ℕ) :
    x ∈ commutatorKernelSequence U V d := by
  induction d with
  | zero =>
      change U (V x) - V (U x) = 0
      rw [hUx, hVx, map_smul, map_smul, hUx, hVx]
      simp only [smul_smul, mul_comm b a, sub_self]
  | succ d ih =>
      apply (mem_commutator_kernel_sequence_succ U V d x).mpr
      exact ⟨ih, hUx ▸ (commutatorKernelSequence U V d).smul_mem a ih,
        hVx ▸ (commutatorKernelSequence U V d).smul_mem b ih⟩

variable [IsAlgClosed k] [FiniteDimensional k M] [Nontrivial M]

/-- The exact all-word commutator criterion uses only words through
dimension minus one. It constructs an actual common eigenvector,
including dimension one and every characteristic. -/
theorem finite_commutator_kernel_criterion (U V : Module.End k M) :
    commutatorKernelSequence U V (Module.finrank k M - 1) ≠ ⊥ ↔
      ∃ (a b : k) (x : M), x ≠ 0 ∧ U x = a • x ∧ V x = b • x := by
  constructor
  · intro hnonzero
    by_cases hC : U * V - V * U = 0
    · exact commuting_endomorphisms_common_eigenvector U V (sub_eq_zero.mp hC)
    · let N := Module.finrank k M - 1
      have hker : LinearMap.ker (U * V - V * U) ≠ ⊤ :=
        fun h => hC (LinearMap.ker_eq_top.mp h)
      have hstart : Module.finrank k (commutatorKernelSequence U V 0) ≤ N := by
        have hlt := Submodule.finrank_lt_finrank_of_lt (lt_top_iff_ne_top.mpr hker)
        rw [finrank_top] at hlt
        change Module.finrank k (LinearMap.ker (U * V - V * U)) ≤ Module.finrank k M - 1
        omega
      obtain ⟨d, hd, heq⟩ := nonzero_antitone_kernel_chain_stabilizes
        (commutatorKernelSequence U V) (commutator_kernel_sequence_antitone U V)
        N hstart hnonzero
      have hdnonzero : commutatorKernelSequence U V d ≠ ⊥ := by
        intro hzero
        apply hnonzero
        apply le_antisymm _ bot_le
        rw [← hzero]
        exact commutator_kernel_sequence_antitone U V (Nat.le_of_lt hd)
      exact stable_commutator_kernel_common_eigenvector U V d heq hdnonzero
  · rintro ⟨a, b, x, hx, hUx, hVx⟩ hzero
    have hmem := common_eigenvector_mem_commutator_sequence U V a b x hUx hVx
      (Module.finrank k M - 1)
    rw [hzero] at hmem
    exact hx hmem

end Litt3.CartierAndSpin
