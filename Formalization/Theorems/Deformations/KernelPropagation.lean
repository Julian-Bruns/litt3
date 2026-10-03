import Definitions.Deformations.KernelPropagation

namespace Litt3.Deformations

variable {V : ℕ → Type*} [∀ n, AddCommGroup (V n)]

/-- Exact kernel stability, with distinct spaces at every height. -/
def NoNewKernel (f : ∀ n, V n →+ V (n + 1)) : Prop :=
  ∀ n (x : V 0), successiveMap f (n + 1) x = 0 ↔ f 0 x = 0

end Litt3.Deformations
