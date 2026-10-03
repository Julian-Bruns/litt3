import Solutions.CartierAndSpin.CommutatorKernelSequence

namespace Litt3.CartierAndSpin

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

/-- Endomorphisms killing a specified actual vector form a genuine
left ideal. Right multiplication is deliberately not presumed. -/
def vectorAnnihilatorLeftIdeal (x : M) : Ideal (Module.End R M) where
  carrier := {f | f x = 0}
  zero_mem' := rfl
  add_mem' := fun {f g} hf hg => by
    change f x = 0 at hf
    change g x = 0 at hg
    change (f + g) x = 0
    rw [LinearMap.add_apply, hf, hg, add_zero]
  smul_mem' := fun a f hf => by
    change f x = 0 at hf
    change a (f x) = 0
    rw [hf, map_zero]

/-- The actual bounded common kernels of all words and of ordered
words agree. This implication retains arbitrary original coefficients. -/
theorem commutator_word_kernel_iff_ordered (U V : Module.End R M) (d : ℕ) (x : M) :
    (∀ w : List Bool, w.length ≤ d → ((U * V - V * U) * twoGeneratorWord U V w) x = 0) ↔
      ∀ a b : ℕ, a + b ≤ d → ((U * V - V * U) * U ^ a * V ^ b) x = 0 := by
  constructor
  · intro hw a b hab
    have h := hw (List.replicate a false ++ List.replicate b true) (by simpa using hab)
    simpa only [two_generator_word_ordered, mul_assoc] using h
  · intro hordered w hw
    have hle : orderedCommutatorIdeal U V d ≤ vectorAnnihilatorLeftIdeal x := by
      apply Ideal.span_le.mpr
      rintro f ⟨a, b, hab, rfl⟩
      exact hordered a b hab
    exact hle (ordered_commutator_ideal_mono U V hw (commutator_word_mem_ordered_ideal U V w))

theorem mem_commutator_sequence_iff_ordered (U V : Module.End R M) (d : ℕ) (x : M) :
    x ∈ commutatorKernelSequence U V d ↔
      ∀ a b : ℕ, a + b ≤ d → ((U * V - V * U) * U ^ a * V ^ b) x = 0 :=
  (mem_commutator_kernel_sequence_iff_words U V d x).trans
    (commutator_word_kernel_iff_ordered U V d x)

end Litt3.CartierAndSpin
