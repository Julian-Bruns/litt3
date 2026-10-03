import Mathlib.Algebra.Group.Hom.Basic

namespace Litt3.Deformations

variable {V : ℕ → Type*} [∀ n, AddCommGroup (V n)]

/-- Compose additive maps whose spaces change with the height. -/
def successiveMap (f : ∀ n, V n →+ V (n + 1)) :
    ∀ n, V 0 →+ V n
  | 0 => AddMonoidHom.id _
  | n + 1 => (f n).comp (successiveMap f n)

end Litt3.Deformations
