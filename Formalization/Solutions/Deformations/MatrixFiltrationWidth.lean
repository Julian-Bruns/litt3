import Theorems.Deformations.MatrixFiltrationWidth
import Solutions.Deformations.FiltrationWindows

namespace Litt3.Deformations

variable {k A ι : Type*} [Field k] [Ring A] [Algebra k A]

noncomputable def coordinateFiltrationEquiv (F : ℕ → Submodule k A) (i : ℕ) :
    coordinateFiltration (ι := ι) F i ≃ₗ[k] (ι → F i) where
  toFun x j := ⟨x.val j, (Submodule.mem_pi.mp x.property) j (Set.mem_univ _)⟩
  invFun x := ⟨fun j => (x j).val, by
    apply Submodule.mem_pi.mpr
    intro j _
    exact (x j).property⟩
  left_inv x := by apply Subtype.ext; rfl
  right_inv x := by funext j; apply Subtype.ext; rfl
  map_add' x y := by funext j; apply Subtype.ext; rfl
  map_smul' c x := by funext j; apply Subtype.ext; rfl

variable [Fintype ι]

theorem coordinate_filtration_finrank [FiniteDimensional k A]
    (F : ℕ → Submodule k A) (i : ℕ) :
    Module.finrank k (coordinateFiltration (ι := ι) F i) =
      Fintype.card ι * Module.finrank k (F i) := by
  rw [(coordinateFiltrationEquiv (ι := ι) F i).finrank_eq, Module.finrank_pi_fintype]
  simp only [Finset.sum_const, Finset.card_univ, smul_eq_mul]

theorem right_matrix_operator_apply (M : Matrix ι ι A) (x : ι → A) (j : ι) :
    rightMatrixOperator (k := k) M x j = ∑ i, x i * M i j := by
  simp only [rightMatrixOperator, LinearMap.pi_apply, LinearMap.sum_apply,
    LinearMap.comp_apply, LinearMap.proj_apply, LinearMap.mulRight_apply]

variable [FiniteDimensional k A]

/-- Every actual square matrix with entries in the actual
lag-th multiplicative filtration term has cokernel dimension
at least its size times every complete lag-wide Hilbert
window. Noncommutativity and noncentral entries are allowed. -/
theorem matrix_filtration_width (F : ℕ → Submodule k A) (lag : ℕ)
    (descending : ∀ i, F (i + 1) ≤ F i) (multiplicative : IsMultiplicativeFiltration F)
    (M : Matrix ι ι A) (order : ∀ i j, M i j ∈ F lag) :
    Specifications.MatrixFiltrationWidth F lag M := by
  have lowering : ∀ i x, x ∈ coordinateFiltration (ι := ι) F i →
      rightMatrixOperator (k := k) M x ∈ coordinateFiltration (ι := ι) F (i + lag) := by
    intro i x hx
    apply Submodule.mem_pi.mpr
    intro j _
    rw [right_matrix_operator_apply]
    apply (F (i + lag)).sum_mem
    intro l _
    exact multiplicative i lag (x l) (M l j)
      ((Submodule.mem_pi.mp hx) l (Set.mem_univ _)) (order l j)
  intro i
  have bound := step_lowering_dimension_bound (rightMatrixOperator (k := k) M)
    (coordinateFiltration (ι := ι) F) lag lowering i
  rw [coordinate_filtration_finrank, coordinate_filtration_finrank] at bound
  rw [filtration_window_finrank F descending, Nat.mul_sub_left_distrib]
  exact bound

end Litt3.Deformations
