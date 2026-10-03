import Definitions.CartierAndSpin.PowerCommutatorStacks
import Solutions.CartierAndSpin.MatrixPowerCommutatorCriterion
import Solutions.CartierAndSpin.OrderedCommutatorStacks

namespace Litt3.CartierAndSpin

open Matrix

variable {R n : Type*} [CommRing R] [Fintype n] [DecidableEq n]

theorem power_commutator_stack_kernel (U V : Matrix n n R) (x : n → R) :
    powerCommutatorStack U V *ᵥ x = 0 ↔
      ∀ i j : ℕ, 1 ≤ i → i ≤ Fintype.card n - 1 →
      1 ≤ j → j ≤ Fintype.card n - 1 →
      (U ^ i * V ^ j - V ^ j * U ^ i) *ᵥ x = 0 := by
  constructor
  · intro h i j hi hin hj hjn
    let a : Fin (Fintype.card n - 1) := ⟨i - 1, by omega⟩
    let b : Fin (Fintype.card n - 1) := ⟨j - 1, by omega⟩
    funext r
    have hrow := congrFun h ((a, b), r)
    have hai : a.val + 1 = i := by dsimp [a]; omega
    have hbj : b.val + 1 = j := by dsimp [b]; omega
    change ((U ^ (a.val + 1) * V ^ (b.val + 1) -
      V ^ (b.val + 1) * U ^ (a.val + 1)) *ᵥ x) r = 0 at hrow
    simpa only [hai, hbj] using hrow
  · intro h
    funext r
    exact congrFun (h (r.1.1.val + 1) (r.1.2.val + 1) (by omega)
      (by have hi := r.1.1.isLt; omega) (by omega)
      (by have hj := r.1.2.isLt; omega)) r.2

theorem bounded_power_commutator_kernel_eq_stack_kernel (U V : Matrix n n R) :
    boundedPowerCommutatorKernel U V = LinearMap.ker (Matrix.toLin' (powerCommutatorStack U V)) := by
  ext x
  simp only [boundedPowerCommutatorKernel, Submodule.mem_iInf, LinearMap.mem_ker,
    Matrix.toLin'_apply]
  constructor
  · intro h
    funext r
    exact congrFun (h r.1.1 r.1.2) r.2
  · intro h i j
    funext r
    exact congrFun h ((i, j), r)

theorem one_dimensional_bounded_power_kernel (U V : Matrix (Fin 1) (Fin 1) R) :
    boundedPowerCommutatorKernel U V = ⊤ := by
  apply top_unique
  intro x _
  simp only [boundedPowerCommutatorKernel, Submodule.mem_iInf]
  intro i
  have hi : i.val < 0 := by simpa using i.isLt
  omega

variable {k : Type*} [Field k] [IsAlgClosed k]

theorem matrix_power_commutator_rank_criterion (U V : Matrix n n k) :
    (powerCommutatorStack U V).rank < Fintype.card n ↔
      ∃ (a b : k) (x : n → k), x ≠ 0 ∧ U *ᵥ x = a • x ∧ V *ᵥ x = b • x := by
  rw [matrix_rank_lt_columns_iff_kernel]
  simp_rw [power_commutator_stack_kernel]
  exact matrix_bounded_power_commutator_criterion U V

theorem matrix_bounded_power_kernel_criterion (U V : Matrix n n k) :
    boundedPowerCommutatorKernel U V ≠ ⊥ ↔
      ∃ (a b : k) (x : n → k), x ≠ 0 ∧ U *ᵥ x = a • x ∧ V *ᵥ x = b • x := by
  rw [bounded_power_commutator_kernel_eq_stack_kernel]
  rw [← matrix_power_commutator_rank_criterion]
  rw [matrix_rank_lt_columns_iff_kernel]
  constructor
  · intro h
    obtain ⟨x, hx, hx0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot h
    exact ⟨x, hx0, hx⟩
  · rintro ⟨x, hx0, hx⟩ hzero
    have hm : x ∈ LinearMap.ker (Matrix.toLin' (powerCommutatorStack U V)) := hx
    rw [hzero, Submodule.mem_bot] at hm
    exact hx0 hm

end Litt3.CartierAndSpin
