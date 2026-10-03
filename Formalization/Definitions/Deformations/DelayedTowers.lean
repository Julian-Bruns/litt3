import Definitions.Deformations.ObstructionTorsors

namespace Litt3.Deformations

variable (L : ℕ → Type*) (truncate : ∀ n, L (n + 1) → L n)

/-- A provisional object at level `n+2`, retaining all its actual
structures and markings. A separate predicate can encode the allowed
prefixes; no fixed group of responses is assumed. -/
def ReachedPrefix (allowed : ∀ n, L (n + 2) → Prop) (n : ℕ) :=
  {u : L (n + 2) // allowed n u}

/-- Advancing from `n+2` to `n+3` retains the prefix through `n`, while
allowing the two provisional later digits to change. -/
def PreservesDelayedPrefix (n : ℕ) (u : L (n + 2))
    (v : L ((n + 1) + 2)) : Prop :=
  truncate n (truncate (n + 1) (truncate (n + 2) v)) =
    truncate n (truncate (n + 1) u)

/-- The exact local extension property on every ACTUAL reached prefix.
This is a local predicate, not the existence of an infinite tower. -/
def DelayedLocalExtension (allowed : ∀ n, L (n + 2) → Prop) : Prop :=
  ∀ n (u : ReachedPrefix L allowed n),
    ∃ v : ReachedPrefix L allowed (n + 1),
      PreservesDelayedPrefix L truncate n u.val v.val

/-- The output is a compatible tower, not merely unrelated objects at
unbounded heights. -/
def CompatibleTower : Type _ :=
  {v : ∀ n, L n // ∀ n, truncate n (v (n + 1)) = v n}

/-- The actual permitted next-level objects over a fixed prefix. -/
def NextLevelFiber (permitted : ∀ n, L n → Prop) (n : ℕ) (u : L n) :=
  {v : L (n + 1) // truncate n v = u ∧ permitted (n + 1) v}

/-- Keep permittedness together with the full compatible tower. -/
def PermittedTower (permitted : ∀ n, L n → Prop) : Type _ :=
  {v : CompatibleTower L truncate // ∀ n, permitted n (v.val n)}

/-- Source interpretation of a reached prefix: it has an actual
allowed extension two levels further. This predicate is defined by
actual tuples and their literal truncations. -/
def HasAllowedTwoStepExtension (allowed : ∀ n, L (n + 2) → Prop)
    (n : ℕ) (u : L n) : Prop :=
  ∃ v : L (n + 2), truncate n (truncate (n + 1) v) = u ∧ allowed n v

section ArbitraryRestrictions

/-- All finite truncations and their compatibility laws, retaining
the actual level objects rather than an opaque height predicate. -/
structure TruncationSystem where
  restrict : ∀ m n, n ≤ m → L m → L n
  restrict_self : ∀ n (h : n ≤ n) (x : L n), restrict n n h x = x
  restrict_comp : ∀ m n j (hjn : j ≤ n) (hnm : n ≤ m) (x : L m),
    restrict n j hjn (restrict m n hnm x) =
      restrict m j (hjn.trans hnm) x

/-- A tower coherent under every finite truncation. -/
def FullCompatibleTower (system : TruncationSystem L) :=
  {v : ∀ n, L n // ∀ m n (h : n ≤ m), system.restrict m n h (v m) = v n}

end ArbitraryRestrictions

end Litt3.Deformations
