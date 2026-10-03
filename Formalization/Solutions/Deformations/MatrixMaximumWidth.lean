import Theorems.Deformations.MatrixMaximumWidth
import Solutions.Deformations.BoundedNaturalMaximum
import Solutions.Deformations.RadicalPowerFiltration

namespace Litt3.Deformations

variable {k A ι : Type*} [Field k] [Ring A] [Algebra k A] [Fintype ι]
    [FiniteDimensional k A]

/-- The full matrix bound with an actual attained maximum of all
filtration windows. Eventual radical vanishing is not needed. -/
theorem matrix_maximum_filtration_width (F : ℕ → Submodule k A) (lag : ℕ)
    (descending : ∀ i, F (i + 1) ≤ F i) (multiplicative : IsMultiplicativeFiltration F)
    (M : Matrix ι ι A) (order : ∀ i j, M i j ∈ F lag) :
    Specifications.MatrixMaximumFiltrationWidth F lag M := by
  let window := fun i => ∑ j ∈ Finset.range lag, Module.finrank k (FiltrationLayer F (i + j))
  have bounded : ∃ n, ∀ i, window i ≤ n := by
    refine ⟨Module.finrank k A, ?_⟩
    intro i
    dsimp only [window]
    rw [filtration_window_finrank F descending]
    exact (Nat.sub_le _ _).trans (Submodule.finrank_le (F i))
  obtain ⟨upper, i, hi⟩ := bounded_natural_maximum_attained window bounded
  refine ⟨boundedNaturalMaximum window bounded, upper, ⟨i, hi⟩, ?_⟩
  have h := matrix_filtration_width F lag descending multiplicative M order i
  change Fintype.card ι * window i ≤ _ at h
  rwa [hi] at h

/-- Every actual radical-power matrix has its size times the
actual attained radical Hilbert-window maximum as a lower bound. -/
theorem actual_radical_matrix_maximum_width (lag : ℕ) (M : Matrix ι ι A)
    (order : ∀ i j, M i j ∈ jacobsonRadicalFiltration (k := k) (A := A) lag) :
    Specifications.MatrixMaximumFiltrationWidth
      (jacobsonRadicalFiltration (k := k) (A := A)) lag M :=
  matrix_maximum_filtration_width _ lag jacobson_radical_filtration_descending
    jacobson_radical_filtration_multiplicative M order

end Litt3.Deformations
