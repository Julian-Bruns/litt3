import Definitions.CartierAndSpin.CommutatorKernelSequence
import Solutions.CartierAndSpin.CommutatorWordCompression

namespace Litt3.CartierAndSpin

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

theorem commutator_kernel_sequence_step_le (U V : Module.End R M) (d : ℕ) :
    commutatorKernelSequence U V (d + 1) ≤ commutatorKernelSequence U V d := by
  exact (inf_le_left.trans inf_le_left)

theorem commutator_kernel_sequence_antitone (U V : Module.End R M) :
    Antitone (commutatorKernelSequence U V) :=
  antitone_nat_of_succ_le (commutator_kernel_sequence_step_le U V)

theorem mem_commutator_kernel_sequence_succ (U V : Module.End R M) (d : ℕ) (x : M) :
    x ∈ commutatorKernelSequence U V (d + 1) ↔
      x ∈ commutatorKernelSequence U V d ∧
        U x ∈ commutatorKernelSequence U V d ∧ V x ∈ commutatorKernelSequence U V d := by
  simp only [commutatorKernelSequence, Submodule.mem_inf, Submodule.mem_comap]
  tauto

/-- The recursive kernel sequence equals the actual common kernel of
all literal commutator words through the stated length. -/
theorem mem_commutator_kernel_sequence_iff_words (U V : Module.End R M) (d : ℕ) (x : M) :
    x ∈ commutatorKernelSequence U V d ↔
      ∀ w : List Bool, w.length ≤ d →
        ((U * V - V * U) * twoGeneratorWord U V w) x = 0 := by
  induction d generalizing x with
  | zero =>
      constructor
      · intro hx w hw
        have hw0 : w = [] := List.length_eq_zero_iff.mp (by omega)
        simpa only [hw0, twoGeneratorWord, List.map_nil, List.prod_nil, mul_one] using hx
      · intro hw
        simpa only [commutatorKernelSequence, LinearMap.mem_ker, twoGeneratorWord,
          List.map_nil, List.prod_nil, mul_one] using hw [] (by simp)
  | succ d ih =>
      rw [mem_commutator_kernel_sequence_succ, ih, ih, ih]
      constructor
      · rintro ⟨hx, hU, hV⟩ w hw
        induction w using List.reverseRecOn with
        | nil => exact hx [] (by simp)
        | append_singleton w i _ =>
            have hlen : w.length ≤ d := by
              simp only [List.length_append, List.length_singleton] at hw
              omega
            rw [two_generator_word_append]
            cases i
            · simpa [twoGeneratorWord, mul_assoc] using hU w hlen
            · simpa [twoGeneratorWord, mul_assoc] using hV w hlen
      · intro hw
        refine ⟨fun w hlen => hw w (by omega), ?_, ?_⟩
        · intro w hlen
          have h := hw (w ++ [false]) (by simpa using Nat.succ_le_succ hlen)
          simpa [two_generator_word_append, twoGeneratorWord, mul_assoc] using h
        · intro w hlen
          have h := hw (w ++ [true]) (by simpa using Nat.succ_le_succ hlen)
          simpa [two_generator_word_append, twoGeneratorWord, mul_assoc] using h

end Litt3.CartierAndSpin
