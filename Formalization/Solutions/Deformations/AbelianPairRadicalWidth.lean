import Theorems.Deformations.AbelianPairRadicalWidth
import Solutions.Deformations.AbelianPairRadicalHilbert
import Solutions.Deformations.AbelianPairWidthPolynomial

namespace Litt3.Deformations

variable {k : Type*} [Field k]

/-- The exact adjacent-layer maximum in the genuine group algebra
of two cyclic p-power factors, including the trivial exponent. -/
theorem actual_abelian_pair_radical_width (p a : ℕ) [Fact p.Prime] [CharP k p] :
    Specifications.ActualAbelianPairRadicalWidth (k := k) p a := by
  have windows : ∀ n, groupRadicalHilbertWindow (k := k)
      (G := Multiplicative (ZMod (p ^ a)) × Multiplicative (ZMod (p ^ a))) 2 n =
      (intervalPolynomial (p ^ a) ^ 2).coeff n +
        (intervalPolynomial (p ^ a) ^ 2).coeff (n + 1) := by
    intro n
    simp only [groupRadicalHilbertWindow, Finset.sum_range_succ,
      Finset.sum_range_zero, zero_add, Nat.add_zero]
    rw [actual_abelian_pair_radical_hilbert_polynomial p a a n,
      actual_abelian_pair_radical_hilbert_polynomial p a a (n + 1), pow_two]
  obtain ⟨upper, reached⟩ := abelian_pair_adjacent_hilbert_maximum (p ^ a)
    (pow_pos (Fact.out : p.Prime).pos a)
  refine ⟨?_, p ^ a - 1, ?_⟩
  · intro n
    rw [windows n]
    exact upper n
  · rw [windows (p ^ a - 1)]
    exact reached

end Litt3.Deformations
