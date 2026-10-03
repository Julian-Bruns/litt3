import Theorems.Deformations.MarkedObstructionTorsors
import Solutions.Deformations.TameAveraging
import Solutions.Deformations.FiniteTriangular
import Solutions.Deformations.DelayedTowers

namespace Litt3.Deformations

variable {K O : ℕ → Type*} [∀ n, AddCommGroup (O n)] [∀ n, Zero (K n)]

theorem pointed_triangular_free_fiber (diagonal : ∀ n, K n ≃ O n)
    (tail : ∀ n, BlockPrefix K n → O n) :
    Specifications.PointedTriangularFreeFiber diagonal tail := by
  intro hdiag htail Z n x
  exact finite_triangular_zero_fiber diagonal tail hdiag htail n x

theorem marked_tower_uniqueness
    {L : ℕ → Type*} (truncate : ∀ n, L (n + 1) → L n)
    (permitted : ∀ n, L n → Prop) :
    Specifications.MarkedTowerUniqueness truncate permitted :=
  permitted_tower_unique truncate permitted

/-- Reindexing realizes every initial Witt level `m₀`; the construction
retains the original `m₀` prefix and may change its last two provisional
digits. All objects and markings remain in the original level types. -/
theorem delayed_tower_from_arbitrary_initial_level
    {L : ℕ → Type*} (truncate : ∀ n, L (n + 1) → L n)
    (m₀ : ℕ)
    (allowed : ∀ n, L (m₀ + (n + 2)) → Prop)
    (local_extension : DelayedLocalExtension (fun n => L (m₀ + n))
      (fun n => truncate (m₀ + n)) allowed)
    (initial : ReachedPrefix (fun n => L (m₀ + n)) allowed 0) :
    DelayedTowerExists (L := fun n => L (m₀ + n))
      (fun n => truncate (m₀ + n)) initial.val :=
  compatible_tower_of_delayed_extension (L := fun n => L (m₀ + n))
    (fun n => truncate (m₀ + n))
    allowed local_extension initial

end Litt3.Deformations
