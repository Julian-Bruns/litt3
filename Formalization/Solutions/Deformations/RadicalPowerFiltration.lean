import Theorems.Deformations.RadicalPowerFiltration
import Solutions.Deformations.MatrixFiltrationWidth

namespace Litt3.Deformations

variable {k A : Type*} [Field k] [Ring A] [Algebra k A]

theorem jacobson_radical_filtration_one :
    jacobsonRadicalFiltration (k := k) (A := A) 1 =
      jacobsonRadicalSubspace (k := k) (A := A) := by
  change jacobsonRadicalSubspace (k := k) (A := A) ^ 1 = _
  exact pow_one _

theorem positive_subspace_power_left_closed (J : Submodule k A)
    (left_closed : ∀ a x, x ∈ J → a * x ∈ J) :
    ∀ n a x, x ∈ J ^ (n + 1) → a * x ∈ J ^ (n + 1) := by
  intro n
  induction n with
  | zero =>
      intro a x hx
      simpa only [Nat.zero_add, pow_one] using
        left_closed a x (by simpa only [Nat.zero_add, pow_one] using hx)
  | succ n ih =>
      intro a x hx
      rw [pow_succ] at hx ⊢
      refine Submodule.mul_induction_on (C := fun z => a * z ∈ J ^ (n + 1) * J) hx ?_ ?_
      · intro u hu v hv
        simpa only [mul_assoc] using Submodule.mul_mem_mul (ih a u hu) hv
      · intro u v hu hv
        simpa only [mul_add] using (J ^ (n + 1) * J).add_mem hu hv

theorem positive_subspace_power_right_closed (J : Submodule k A)
    (right_closed : ∀ a x, x ∈ J → x * a ∈ J) :
    ∀ n a x, x ∈ J ^ (n + 1) → x * a ∈ J ^ (n + 1) := by
  intro n
  cases n with
  | zero =>
      intro a x hx
      simpa only [Nat.zero_add, pow_one] using
        right_closed a x (by simpa only [Nat.zero_add, pow_one] using hx)
  | succ n =>
      intro a x hx
      rw [pow_succ] at hx ⊢
      refine Submodule.mul_induction_on (C := fun z => z * a ∈ J ^ (n + 1) * J) hx ?_ ?_
      · intro u hu v hv
        simpa only [mul_assoc] using Submodule.mul_mem_mul hu (right_closed a v hv)
      · intro u v hu hv
        simpa only [add_mul] using (J ^ (n + 1) * J).add_mem hu hv

theorem subspace_ideal_power_filtration_descending (J : Submodule k A)
    (right_closed : ∀ a x, x ∈ J → x * a ∈ J) :
    ∀ i, subspaceIdealPowerFiltration J (i + 1) ≤ subspaceIdealPowerFiltration J i := by
  intro i
  cases i with
  | zero => exact le_top
  | succ i =>
      change J ^ (i + 1 + 1) ≤ J ^ (i + 1)
      rw [pow_succ]
      apply Submodule.mul_le.mpr
      intro x hx y _
      exact positive_subspace_power_right_closed J right_closed i y x hx

theorem subspace_ideal_power_filtration_multiplicative (J : Submodule k A)
    (left_closed : ∀ a x, x ∈ J → a * x ∈ J)
    (right_closed : ∀ a x, x ∈ J → x * a ∈ J) :
    IsMultiplicativeFiltration (subspaceIdealPowerFiltration J) := by
  intro i j x y hx hy
  cases i with
  | zero =>
      cases j with
      | zero => exact Submodule.mem_top
      | succ j =>
          rw [Nat.zero_add]
          exact positive_subspace_power_left_closed J left_closed j x y hy
  | succ i =>
      cases j with
      | zero => exact positive_subspace_power_right_closed J right_closed i y x hx
      | succ j =>
          change x * y ∈ J ^ ((i + 1) + (j + 1))
          rw [pow_add]
          exact Submodule.mul_mem_mul hx hy

theorem jacobson_radical_subspace_left_closed (a x : A)
    (hx : x ∈ jacobsonRadicalSubspace (k := k) (A := A)) :
    a * x ∈ jacobsonRadicalSubspace (k := k) (A := A) :=
  (Ring.jacobson A).smul_mem a hx

theorem jacobson_radical_subspace_right_closed (a x : A)
    (hx : x ∈ jacobsonRadicalSubspace (k := k) (A := A)) :
    x * a ∈ jacobsonRadicalSubspace (k := k) (A := A) :=
  Ideal.mul_mem_right a (Ring.jacobson A) hx

theorem jacobson_radical_filtration_descending :
    ∀ i, jacobsonRadicalFiltration (k := k) (A := A) (i + 1) ≤
      jacobsonRadicalFiltration (k := k) (A := A) i :=
  subspace_ideal_power_filtration_descending _ jacobson_radical_subspace_right_closed

theorem jacobson_radical_filtration_multiplicative :
    IsMultiplicativeFiltration (jacobsonRadicalFiltration (k := k) (A := A)) :=
  subspace_ideal_power_filtration_multiplicative _ jacobson_radical_subspace_left_closed
    jacobson_radical_subspace_right_closed

variable {ι : Type*} [Fintype ι] [FiniteDimensional k A]

/-- Every genuine radical-power matrix over any finite-dimensional
noncommutative algebra has all radical Hilbert-window lower bounds. -/
theorem actual_radical_matrix_width (lag : ℕ) (M : Matrix ι ι A)
    (order : ∀ i j, M i j ∈ jacobsonRadicalFiltration (k := k) (A := A) lag) :
    Specifications.ActualRadicalMatrixWidth (k := k) lag M :=
  matrix_filtration_width _ lag jacobson_radical_filtration_descending
    jacobson_radical_filtration_multiplicative M order

end Litt3.Deformations
