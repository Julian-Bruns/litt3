import Theorems.Deformations.KernelPropagation

/-!
Computation-free homological kernel propagation. The spaces may change
at each step, as for relative Frobenius between twists. This does not
identify the first geometric kernel, or prove the later geometric maps
injective: those are the remaining inputs of the application.
-/

namespace Litt3.Deformations

variable {V : ℕ → Type*} [∀ n, AddCommGroup (V n)]

theorem successiveMap_succ (f : ∀ n, V n →+ V (n + 1))
    (n : ℕ) (x : V 0) :
    successiveMap f (n + 1) x = f n (successiveMap f n x) := rfl

/-- Injective later arrows introduce no new zero directions after the
first arrow. This is valid for semilinear Frobenius maps after viewing
them as additive maps; no fixed-space linearity is assumed. -/
theorem no_new_kernel (f : ∀ n, V n →+ V (n + 1))
    (injective_after_first : ∀ n, Function.Injective (f (n + 1)))
    (n : ℕ) (x : V 0) :
    successiveMap f (n + 1) x = 0 ↔ f 0 x = 0 := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [successiveMap_succ]
    constructor
    · intro h
      apply ih.mp
      exact injective_after_first n (h.trans (f (n + 1)).map_zero.symm)
    · intro h
      rw [ih.mpr h, (f (n + 1)).map_zero]

/-- In particular an initially nonzero kernel cannot disappear under
more Frobenius pullbacks, and its description stays exact. -/
theorem iterated_kernel_eq (f : ∀ n, V n →+ V (n + 1))
    (injective_after_first : ∀ n, Function.Injective (f (n + 1)))
    (n : ℕ) :
    {x : V 0 | successiveMap f (n + 1) x = 0} =
      {x : V 0 | f 0 x = 0} := by
  apply Set.ext
  intro x
  exact no_new_kernel f injective_after_first n x

end Litt3.Deformations
