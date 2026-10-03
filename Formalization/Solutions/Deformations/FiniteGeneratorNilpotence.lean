import Solutions.Deformations.FiniteIdealNilpotence

namespace Litt3.Deformations

variable {A I : Type*} [CommSemiring A] [Fintype I]

/-- Nilpotence of literal individual generators gives the sharp full
ideal cutoff, over any commutative semiring and without a basis input. -/
theorem finite_generator_ideal_nilpotent (E : I → A) (q : I → ℕ)
    (positive : ∀ i, 0 < q i) (nilpotent : ∀ i, E i ^ q i = 0) :
    Ideal.span (Set.range E) ^ ((∑ i, (q i - 1)) + 1) = ⊥ := by
  classical
  let J : I → Ideal A := fun i => Ideal.span {E i}
  have spanEq : Ideal.span (Set.range E) = Finset.univ.sup J := by
    apply le_antisymm
    · apply Ideal.span_le.mpr
      rintro x ⟨i, rfl⟩
      have inclusion : J i ≤ Finset.univ.sup J := Finset.le_sup (Finset.mem_univ i)
      exact inclusion (Ideal.subset_span (Set.mem_singleton _))
    · apply Finset.sup_le
      intro i member
      apply Ideal.span_le.mpr
      intro x singleton
      obtain rfl := Set.mem_singleton_iff.mp singleton
      exact Ideal.subset_span (Set.mem_range_self i)
  rw [spanEq]
  apply finite_ideal_sup_nilpotent _ J q (fun i _ => positive i)
  intro i member
  dsimp only [J]
  rw [Ideal.span_singleton_pow, nilpotent, Ideal.span_singleton_zero]

end Litt3.Deformations
