import Solutions.CartierAndSpin.AnnihilatorPowerSpans
import Solutions.CartierAndSpin.CommutatorSpanExtension
import Solutions.CartierAndSpin.PowerCommutatorKernels

namespace Litt3.CartierAndSpin

open Matrix

variable {k n : Type*} [Field k] [Fintype n] [DecidableEq n]

theorem matrix_endomorphism_power_mem_initial_span (A : Matrix n n k) (j : ℕ) :
    (Matrix.toLinAlgEquiv' A) ^ j ∈ Submodule.span k
      (Set.range fun i : Fin (Fintype.card n) => (Matrix.toLinAlgEquiv' A) ^ i.val) := by
  have h := Submodule.mem_map_of_mem
    (f := (Matrix.toLinAlgEquiv' (R := k) (n := n)).toLinearMap)
    (matrix_power_mem_initial_span A j)
  rw [Submodule.map_span, ← Set.range_comp'] at h
  simpa only [LinearEquiv.coe_coe, AlgEquiv.toLinearMap_apply, map_pow] using h

theorem bounded_matrix_power_commutators_imply_all (U V : Matrix n n k) (x : n → k)
    (htest : ∀ i j : ℕ, 1 ≤ i → i ≤ Fintype.card n - 1 →
      1 ≤ j → j ≤ Fintype.card n - 1 →
      (U ^ i * V ^ j - V ^ j * U ^ i) *ᵥ x = 0) :
    x ∈ powerCommutatorKernel (Matrix.toLinAlgEquiv' U) (Matrix.toLinAlgEquiv' V) := by
  rw [mem_power_commutator_kernel]
  intro i j
  apply commutation_on_vector_extends_to_spans
    (Set.range fun a : Fin (Fintype.card n) => (Matrix.toLinAlgEquiv' U) ^ a.val)
    (Set.range fun b : Fin (Fintype.card n) => (Matrix.toLinAlgEquiv' V) ^ b.val) x
    ?_ (matrix_endomorphism_power_mem_initial_span U i)
    (matrix_endomorphism_power_mem_initial_span V j)
  rintro A ⟨a, rfl⟩ B ⟨b, rfl⟩
  by_cases ha : a.val = 0
  · simp [ha]
  by_cases hb : b.val = 0
  · simp [hb]
  have h := htest a.val b.val (by omega) (by omega) (by omega) (by omega)
  have h' : (((Matrix.toLinAlgEquiv' U) ^ a.val * (Matrix.toLinAlgEquiv' V) ^ b.val -
      (Matrix.toLinAlgEquiv' V) ^ b.val * (Matrix.toLinAlgEquiv' U) ^ a.val) x) = 0 := by
    simpa only [← map_mul, ← map_sub, ← map_pow, Matrix.toLinAlgEquiv'_apply] using h
  exact sub_eq_zero.mp h'

variable {M : Type*} [AddCommGroup M] [Module k M]

theorem eigenvector_endomorphism_power (U : Module.End k M) (a : k) (x : M)
    (hx : U x = a • x) (j : ℕ) : (U ^ j) x = a ^ j • x := by
  induction j with
  | zero => simp
  | succ j hj =>
    rw [pow_succ', Module.End.mul_apply, hj, map_smul, hx, smul_smul, pow_succ]

theorem common_eigenvector_mem_power_commutator_kernel (U V : Module.End k M)
    (a b : k) (x : M) (hU : U x = a • x) (hV : V x = b • x) :
    x ∈ powerCommutatorKernel U V := by
  rw [mem_power_commutator_kernel]
  intro i j
  simp only [eigenvector_endomorphism_power V b x hV j,
    eigenvector_endomorphism_power U a x hU i, map_smul, smul_smul, mul_comm]

variable [IsAlgClosed k]

/-- The original finite power-commutator intersection criterion, including
the empty intersection in dimension one, in every characteristic. -/
theorem matrix_bounded_power_commutator_criterion (U V : Matrix n n k) :
    (∃ x : n → k, x ≠ 0 ∧ ∀ i j : ℕ, 1 ≤ i → i ≤ Fintype.card n - 1 →
      1 ≤ j → j ≤ Fintype.card n - 1 →
      (U ^ i * V ^ j - V ^ j * U ^ i) *ᵥ x = 0) ↔
    ∃ (a b : k) (x : n → k), x ≠ 0 ∧ U *ᵥ x = a • x ∧ V *ᵥ x = b • x := by
  constructor
  · rintro ⟨x, hx, htest⟩
    have hm := bounded_matrix_power_commutators_imply_all U V x htest
    have hP : powerCommutatorKernel (Matrix.toLinAlgEquiv' U)
        (Matrix.toLinAlgEquiv' V) ≠ ⊥ := by
      intro hz
      rw [hz, Submodule.mem_bot] at hm
      exact hx hm
    exact all_power_commutator_kernel_common_eigenvector _ _ hP
  · rintro ⟨a, b, x, hx, hU, hV⟩
    refine ⟨x, hx, ?_⟩
    have hm := common_eigenvector_mem_power_commutator_kernel
      (Matrix.toLinAlgEquiv' U) (Matrix.toLinAlgEquiv' V) a b x hU hV
    intro i j _ _ _ _
    have heq := (mem_power_commutator_kernel _ _ x).mp hm i j
    have hz : (((Matrix.toLinAlgEquiv' U) ^ i * (Matrix.toLinAlgEquiv' V) ^ j -
        (Matrix.toLinAlgEquiv' V) ^ j * (Matrix.toLinAlgEquiv' U) ^ i) x) = 0 := by
      exact sub_eq_zero.mpr heq
    simpa only [← map_mul, ← map_sub, ← map_pow, Matrix.toLinAlgEquiv'_apply] using hz

end Litt3.CartierAndSpin
