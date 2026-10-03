import Definitions.CartierAndSpin.PowerCommutatorKernels
import Solutions.CartierAndSpin.InvariantCommutingSubspaces

namespace Litt3.CartierAndSpin

variable {R M : Type*} [CommRing R] [AddCommGroup M] [Module R M]

theorem mem_power_commutator_kernel (U V : Module.End R M) (x : M) :
    x ∈ powerCommutatorKernel U V ↔
      ∀ i j : ℕ, (U ^ i) ((V ^ j) x) = (V ^ j) ((U ^ i) x) := by
  simp only [powerCommutatorKernel, Submodule.mem_iInf, LinearMap.mem_ker,
    LinearMap.sub_apply, Module.End.mul_apply, sub_eq_zero]

theorem power_commutator_kernel_U_invariant (U V : Module.End R M) :
    ∀ x ∈ powerCommutatorKernel U V, U x ∈ powerCommutatorKernel U V := by
  intro x hx
  rw [mem_power_commutator_kernel] at hx ⊢
  intro i j
  have h1 := hx 1 j
  simp only [pow_one] at h1
  calc
    (U ^ i) ((V ^ j) (U x)) = (U ^ i) (U ((V ^ j) x)) := by rw [h1]
    _ = (U ^ (i + 1)) ((V ^ j) x) := by rw [pow_succ, Module.End.mul_apply]
    _ = (V ^ j) ((U ^ (i + 1)) x) := hx (i + 1) j
    _ = (V ^ j) ((U ^ i) (U x)) := by rw [pow_succ, Module.End.mul_apply]

theorem power_commutator_kernel_V_invariant (U V : Module.End R M) :
    ∀ x ∈ powerCommutatorKernel U V, V x ∈ powerCommutatorKernel U V := by
  intro x hx
  rw [mem_power_commutator_kernel] at hx ⊢
  intro i j
  have h1 := hx i 1
  simp only [pow_one] at h1
  calc
    (U ^ i) ((V ^ j) (V x)) = (U ^ i) ((V ^ (j + 1)) x) := by
      rw [pow_succ, Module.End.mul_apply]
    _ = (V ^ (j + 1)) ((U ^ i) x) := hx i (j + 1)
    _ = (V ^ j) (V ((U ^ i) x)) := by rw [pow_succ, Module.End.mul_apply]
    _ = (V ^ j) ((U ^ i) (V x)) := by rw [h1]

variable {k : Type*} [Field k] [Module k M]
variable [IsAlgClosed k] [FiniteDimensional k M]

theorem all_power_commutator_kernel_common_eigenvector (U V : Module.End k M)
    (hP : powerCommutatorKernel U V ≠ ⊥) :
    ∃ (a b : k) (x : M), x ≠ 0 ∧ U x = a • x ∧ V x = b • x := by
  apply invariant_commuting_subspace_common_eigenvector U V
    (powerCommutatorKernel U V) hP
    (power_commutator_kernel_U_invariant U V)
    (power_commutator_kernel_V_invariant U V)
  intro x hx
  simpa only [pow_one] using (mem_power_commutator_kernel U V x).mp hx 1 1

end Litt3.CartierAndSpin
