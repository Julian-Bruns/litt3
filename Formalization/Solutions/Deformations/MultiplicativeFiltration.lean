import Theorems.Deformations.MultiplicativeFiltration
import Solutions.Deformations.FiltrationWidth

namespace Litt3.Deformations

/-- The rank-nullity filtration estimate works for every lowering
length, without requiring a strict filtration or a matrix model. -/
theorem step_lowering_dimension_bound {k V : Type*} [DivisionRing k]
    [AddCommGroup V] [Module k V] [FiniteDimensional k V]
    (T : V →ₗ[k] V) (F : ℕ → Submodule k V) (lag : ℕ)
    (lowers : ∀ i x, x ∈ F i → T x ∈ F (i + lag)) (i : ℕ) :
    Module.finrank k (F i) - Module.finrank k (F (i + lag)) ≤
      Module.finrank k (EndomorphismCokernel T) := by
  have h := lowered_subspace_kernel_bound T (F i) (F (i + lag)) (lowers i)
  rw [kernel_cokernel_finrank_eq T] at h
  omega

variable {k A : Type*} [Field k] [Ring A] [Algebra k A] [FiniteDimensional k A]

/-- Actual multiplication supplies the lowering hypothesis. This
remains true without commutativity of the algebra or centrality of f. -/
theorem multiplicative_filtration_width (F : ℕ → Submodule k A)
    (descending : ∀ i, F (i + 1) ≤ F i)
    (multiplicative : IsMultiplicativeFiltration F)
    (f : A) (quadratic : f ∈ F 2) :
    Specifications.MultiplicativeFiltrationWidth F f := by
  apply adjacent_filtration_width (LinearMap.mulRight k f) F descending
  intro i x hx
  exact multiplicative i 2 x f hx quadratic

theorem right_multiplication_filtration_dimension_bound (F : ℕ → Submodule k A)
    (multiplicative : IsMultiplicativeFiltration F)
    (lag : ℕ) (f : A) (order : f ∈ F lag) (i : ℕ) :
    Module.finrank k (F i) - Module.finrank k (F (i + lag)) ≤
      Module.finrank k (A ⧸ LinearMap.range (LinearMap.mulRight k f)) := by
  apply step_lowering_dimension_bound (LinearMap.mulRight k f) F lag
  intro j x hx
  exact multiplicative j lag x f hx order

end Litt3.Deformations
