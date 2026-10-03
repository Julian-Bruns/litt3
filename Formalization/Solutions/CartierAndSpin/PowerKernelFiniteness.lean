import Definitions.CartierAndSpin.PowerKernelSteps
import Mathlib.GroupTheory.Index

namespace Litt3.CartierAndSpin

variable {A : Type*} [AddCommGroup A]

theorem actual_power_kernel_step_inclusion_injective (p n : ℕ) :
    Function.Injective (powerKernelStepKernelInclusion A p n) := by
  intro x y h
  have hv : x.val.val = y.val.val :=
    congrArg (fun z : powerTorsionSubgroup A p => z.val) h
  exact Subtype.ext (Subtype.ext hv)

/-- Finiteness of the ACTUAL p-kernel forces finiteness at every
finite primary height, with no finite ambient group hypothesis.
The true successive multiplication map supplies the kernel/image
extension; no finite cardinality label is presumed. -/
theorem actual_power_kernel_finite (p : ℕ)
    [Finite (powerTorsionSubgroup A p)] (n : ℕ) :
    Finite (powerTorsionSubgroup A (p ^ n)) := by
  induction n with
  | zero =>
    have hsub : Subsingleton (powerTorsionSubgroup A 1) := by
      constructor
      intro x y
      apply Subtype.ext
      have hx : 1 • x.val = 0 := x.property
      have hy : 1 • y.val = 0 := y.property
      simpa only [one_nsmul] using hx.trans hy.symm
    rw [pow_zero]
    letI := hsub
    infer_instance
  | succ n hn =>
    letI := hn
    let f := powerKernelStep A p n
    letI : Finite f.ker := Finite.of_injective (powerKernelStepKernelInclusion A p n)
      (actual_power_kernel_step_inclusion_injective p n)
    letI : Finite f.range := inferInstance
    exact (AddMonoidHom.finite_iff_finite_ker_range f).mpr ⟨inferInstance, inferInstance⟩

end Litt3.CartierAndSpin
