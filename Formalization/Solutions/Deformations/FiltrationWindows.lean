import Theorems.Deformations.FiltrationWindows
import Solutions.Deformations.MultiplicativeFiltration

namespace Litt3.Deformations

variable {k V : Type*} [DivisionRing k] [AddCommGroup V] [Module k V]
variable [FiniteDimensional k V]

omit [FiniteDimensional k V] in
theorem descending_filtration_offset (F : ℕ → Submodule k V)
    (descending : ∀ i, F (i + 1) ≤ F i) (i lag : ℕ) : F (i + lag) ≤ F i := by
  induction lag with
  | zero => exact le_refl _
  | succ lag inductionHypothesis =>
    exact (descending (i + lag)).trans inductionHypothesis

/-- Every actual finite filtration window telescopes to
the exact dimension drop, including lag zero. -/
theorem filtration_window_finrank (F : ℕ → Submodule k V)
    (descending : ∀ i, F (i + 1) ≤ F i) (i lag : ℕ) :
    (∑ j ∈ Finset.range lag, Module.finrank k (FiltrationLayer F (i + j))) =
      Module.finrank k (F i) - Module.finrank k (F (i + lag)) := by
  induction lag with
  | zero => simp
  | succ lag inductionHypothesis =>
    rw [Finset.sum_range_succ, inductionHypothesis, filtration_layer_finrank F descending]
    have above := Submodule.finrank_mono (descending_filtration_offset F descending i lag)
    have next := Submodule.finrank_mono (descending (i + lag))
    change (Module.finrank k (F i) - Module.finrank k (F (i + lag))) +
      (Module.finrank k (F (i + lag)) - Module.finrank k (F (i + lag + 1))) =
        Module.finrank k (F i) - Module.finrank k (F (i + lag + 1))
    omega

/-- Every actual lag-lowering operator has actual cokernel
dimension at least every complete lag-wide window of its
genuine filtration layers, with no associated-graded rank
equality or computation required. -/
theorem window_filtration_width (T : V →ₗ[k] V) (F : ℕ → Submodule k V) (lag : ℕ)
    (descending : ∀ i, F (i + 1) ≤ F i)
    (lowers : ∀ i x, x ∈ F i → T x ∈ F (i + lag)) :
    Specifications.WindowFiltrationWidth T F lag := by
  intro i
  rw [filtration_window_finrank F descending]
  exact step_lowering_dimension_bound T F lag lowers i

end Litt3.Deformations
