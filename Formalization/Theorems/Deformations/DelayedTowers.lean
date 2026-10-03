import Definitions.Deformations.DelayedTowers

namespace Litt3.Deformations

variable {L : ℕ → Type*} (truncate : ∀ n, L (n + 1) → L n)

/-- Exact stabilized extension above the original first prefix. -/
def DelayedTowerExists (initial : L 2) : Prop :=
  ∃ tower : CompatibleTower L truncate,
    tower.val 0 = truncate 0 (truncate 1 initial)

end Litt3.Deformations
