import Solutions.CartierAndSpin.OrderedCommutatorIdeals

namespace Litt3.CartierAndSpin

variable {A : Type*} [Ring A]

theorem two_generator_word_append (U V : A) (w z : List Bool) :
    twoGeneratorWord U V (w ++ z) = twoGeneratorWord U V w * twoGeneratorWord U V z := by
  simp [twoGeneratorWord, List.prod_append]

theorem two_generator_word_ordered (U V : A) (a b : ℕ) :
    twoGeneratorWord U V (List.replicate a false ++ List.replicate b true) = U ^ a * V ^ b := by
  simp [twoGeneratorWord, List.prod_append]

/-- Every literal commutator word lies in the actual left ideal of
ordered commutator words of no greater degree. This gives a symbolic
normal ordering in arbitrary rings, including all matrix coefficient rings. -/
theorem commutator_word_mem_ordered_ideal (U V : A) (w : List Bool) :
    (U * V - V * U) * twoGeneratorWord U V w ∈ orderedCommutatorIdeal U V w.length := by
  induction w using List.reverseRecOn with
  | nil => simpa [twoGeneratorWord] using commutator_mem_ordered_ideal U V 0
  | append_singleton w i ih =>
      rw [two_generator_word_append]
      cases i
      · simpa only [twoGeneratorWord, List.map_singleton, Bool.false_eq_true,
          if_false, List.prod_singleton, List.length_append, List.length_singleton, mul_assoc] using
          ordered_commutator_right_U U V w.length ih
      · simpa only [twoGeneratorWord, List.map_singleton, if_true,
          List.prod_singleton, List.length_append, List.length_singleton, mul_assoc] using
          ordered_commutator_right_V U V w.length ih

theorem commutator_word_ideal_eq_ordered (U V : A) (d : ℕ) :
    wordCommutatorIdeal U V d = orderedCommutatorIdeal U V d := by
  apply le_antisymm
  · apply Ideal.span_le.mpr
    rintro m ⟨w, hw, rfl⟩
    exact ordered_commutator_ideal_mono U V hw (commutator_word_mem_ordered_ideal U V w)
  · apply Ideal.span_le.mpr
    rintro m ⟨a, b, hab, rfl⟩
    apply Ideal.subset_span
    refine ⟨List.replicate a false ++ List.replicate b true, by simpa using hab, ?_⟩
    rw [two_generator_word_ordered, mul_assoc]

end Litt3.CartierAndSpin
