import Theorems.Deformations.TameAveraging
import Theorems.Deformations.FiniteTriangular
import Theorems.Deformations.DelayedTowers

/-!
Exact clause index for the abstract source theorem
`Theorems/deformations/marked_obstruction_torsors.md`.

The proof module discharges the named clauses below, together with the
fixed-point, full zero, residual, and delayed-response specifications in
their individual modules. No geometry or existence of Witt lifts is
encoded as an opaque proposition in these targets.
-/

namespace Litt3.Deformations.Specifications

variable {K O : ℕ → Type*} [∀ n, AddCommGroup (O n)] [∀ n, Zero (K n)]

/-- The complete pointed triangular system, with the absent variable
explicit and with every finite length included. -/
def PointedTriangularFreeFiber (diagonal : ∀ n, K n ≃ O n)
    (tail : ∀ n, BlockPrefix K n → O n) : Prop :=
  (∀ n, diagonal n 0 = 0) → (∀ n, tail n 0 = 0) →
    ∀ (Z : Type*) n (x : BlockPrefix K n × Z),
      finiteTriangularEquiv diagonal tail n x.1 = 0 ↔ x.1 = 0

section Towers

variable {L : ℕ → Type*} (truncate : ∀ n, L (n + 1) → L n)
variable (permitted : ∀ n, L n → Prop)

/-- Exact uniqueness above the initial prefix only. Later provisional
digits are not required to be retained as fixed initial choices. -/
def MarkedTowerUniqueness : Prop :=
  (∀ n (u : L n), permitted n u →
    Subsingleton (NextLevelFiber L truncate permitted n u)) →
  ∀ v w : PermittedTower L truncate permitted,
    v.val.val 0 = w.val.val 0 → v = w

end Towers

end Litt3.Deformations.Specifications
