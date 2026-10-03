import Theorems.Deformations.DelayedTowers
import Solutions.Deformations.ObstructionTorsors

namespace Litt3.Deformations

section DelayedExtension

variable {L : ℕ → Type*} (truncate : ∀ n, L (n + 1) → L n)
variable (allowed : ∀ n, L (n + 2) → Prop)

/-- Choose one advance for each reached prefix. This invokes only
ordinary classical choice, rather than any lifting axiom. -/
noncomputable def chosenDelayedAdvance
    (local_extension : DelayedLocalExtension L truncate allowed)
    (n : ℕ) (u : ReachedPrefix L allowed n) :
    ReachedPrefix L allowed (n + 1) :=
  Classical.choose (local_extension n u)

theorem chosenDelayedAdvance_preserves
    (local_extension : DelayedLocalExtension L truncate allowed)
    (n : ℕ) (u : ReachedPrefix L allowed n) :
    PreservesDelayedPrefix L truncate n u.val
      (chosenDelayedAdvance truncate allowed local_extension n u).val :=
  Classical.choose_spec (local_extension n u)

/-- Recursive provisional tuples, whose last two digits can vary. -/
noncomputable def provisionalSequence
    (local_extension : DelayedLocalExtension L truncate allowed)
    (initial : ReachedPrefix L allowed 0) :
    ∀ n, ReachedPrefix L allowed n
  | 0 => initial
  | n + 1 => chosenDelayedAdvance truncate allowed local_extension n
      (provisionalSequence local_extension initial n)

theorem provisionalSequence_preserves
    (local_extension : DelayedLocalExtension L truncate allowed)
    (initial : ReachedPrefix L allowed 0) (n : ℕ) :
    PreservesDelayedPrefix L truncate n
      (provisionalSequence truncate allowed local_extension initial n).val
      (provisionalSequence truncate allowed local_extension initial (n + 1)).val :=
  chosenDelayedAdvance_preserves truncate allowed local_extension n _

/-- Local delayed solvability on all reached prefixes yields an actual
compatible infinite tower after stabilizing the two provisional digits. -/
theorem compatible_tower_of_delayed_extension
    (local_extension : DelayedLocalExtension L truncate allowed)
    (initial : ReachedPrefix L allowed 0) :
    DelayedTowerExists truncate initial.val := by
  let U : ∀ n, L (n + 2) := fun n =>
    (provisionalSequence truncate allowed local_extension initial n).val
  have hU : ∀ n,
      truncate n (truncate (n + 1) (truncate (n + 2) (U (n + 1)))) =
        truncate n (truncate (n + 1) (U n)) := fun n =>
    provisionalSequence_preserves truncate allowed local_extension initial n
  refine ⟨⟨stabilizedLevel truncate U,
    stabilized_levels_compatible truncate U hU⟩, ?_⟩
  rfl

/-- If actual provisional tuples have permitted retained prefixes,
the stabilized tower retains permittedness at every reached level. -/
theorem permitted_tower_of_delayed_extension
    (local_extension : DelayedLocalExtension L truncate allowed)
    (permitted : ∀ n, L n → Prop)
    (retained_permitted : ∀ n (u : ReachedPrefix L allowed n),
      permitted n (truncate n (truncate (n + 1) u.val)))
    (initial : ReachedPrefix L allowed 0) :
    ∃ tower : PermittedTower L truncate permitted,
      tower.val.val 0 = truncate 0 (truncate 1 initial.val) := by
  let U : ∀ n, L (n + 2) := fun n =>
    (provisionalSequence truncate allowed local_extension initial n).val
  have hU : ∀ n,
      truncate n (truncate (n + 1) (truncate (n + 2) (U (n + 1)))) =
        truncate n (truncate (n + 1) (U n)) := fun n =>
    provisionalSequence_preserves truncate allowed local_extension initial n
  refine ⟨⟨⟨stabilizedLevel truncate U,
    stabilized_levels_compatible truncate U hU⟩, ?_⟩, ?_⟩
  · intro n
    exact retained_permitted n
      (provisionalSequence truncate allowed local_extension initial n)
  · rfl

/-- The intended two-step extendability predicate is retained
automatically by the construction; no lower-prefix closedness of an
arbitrary extra predicate is inferred. -/
theorem two_step_permitted_tower_of_delayed_extension
    (local_extension : DelayedLocalExtension L truncate allowed)
    (initial : ReachedPrefix L allowed 0) :
    ∃ tower : PermittedTower L truncate
      (HasAllowedTwoStepExtension L truncate allowed),
      tower.val.val 0 = truncate 0 (truncate 1 initial.val) := by
  apply permitted_tower_of_delayed_extension truncate allowed local_extension
    (HasAllowedTwoStepExtension L truncate allowed) _ initial
  intro n u
  exact ⟨u.val, rfl, u.property⟩

end DelayedExtension

section AffineLocalExtension

variable {L : ℕ → Type*} (truncate : ∀ n, L (n + 1) → L n)
variable (allowed : ∀ n, L (n + 2) → Prop)
variable (K O A : ∀ n, ReachedPrefix L allowed n → Type*)
variable [∀ n u, AddCommGroup (K n u)] [∀ n u, AddCommGroup (O n u)]
variable [∀ n u, AddTorsor (K n u) (A n u)]

/-- Actual complete affine response data can vary with height and
prefix. Solving each response constructs local advances and then a
compatible tower; no tower is assumed as input. -/
theorem delayed_tower_of_surjective_responses
    (response : ∀ n u, K n u →+ O n u)
    (obstruction : ∀ n u, A n u → O n u)
    (affine : ∀ n u, IsAffineObstruction (response n u) (obstruction n u))
    (surjective : ∀ n u, Function.Surjective (response n u))
    (zero_is_extension : ∀ n u (a : A n u), obstruction n u a = 0 →
      ∃ v : ReachedPrefix L allowed (n + 1),
        PreservesDelayedPrefix L truncate n u.val v.val)
    (initial : ReachedPrefix L allowed 0) :
    DelayedTowerExists truncate initial.val := by
  apply compatible_tower_of_delayed_extension truncate allowed _ initial
  intro n u
  obtain ⟨a, ha⟩ := obstruction_surjective (response n u) (obstruction n u)
    (affine n u) (surjective n u) 0
  exact zero_is_extension n u a ha

end AffineLocalExtension

section Uniqueness

variable {L : ℕ → Type*} (truncate : ∀ n, L (n + 1) → L n)
variable (permitted : ∀ n, L n → Prop)

/-- Unique actual next fibers imply unique compatible towers above a
fixed initial level. All markings must be present in the level types. -/
theorem permitted_tower_unique
    (unique_fiber : ∀ n (u : L n), permitted n u →
      Subsingleton (NextLevelFiber L truncate permitted n u))
    (v w : PermittedTower L truncate permitted)
    (initial_equal : v.val.val 0 = w.val.val 0) : v = w := by
  apply Subtype.ext
  apply Subtype.ext
  funext n
  induction n with
  | zero => exact initial_equal
  | succ n ih =>
    let vn : NextLevelFiber L truncate permitted n (v.val.val n) :=
      ⟨v.val.val (n + 1), v.val.property n, v.property (n + 1)⟩
    let wn : NextLevelFiber L truncate permitted n (v.val.val n) :=
      ⟨w.val.val (n + 1), (w.val.property n).trans ih.symm,
        w.property (n + 1)⟩
    exact congrArg Subtype.val
      (@Subsingleton.elim _ (unique_fiber n _ (v.property n)) vn wn)

/-- The zeros of an injective complete affine response are at most
one actual torsor point. -/
theorem obstruction_zero_subsingleton
    {K O A : Type*} [AddCommGroup K] [AddCommGroup O] [AddTorsor K A]
    (R : K →+ O) (c : A → O) (affine : IsAffineObstruction R c)
    (injective : Function.Injective R) :
    Subsingleton {a : A // c a = 0} := by
  constructor
  intro a b
  apply Subtype.ext
  exact obstruction_injective R c affine injective
    (a.property.trans b.property.symm)

/-- An exact marked-fiber equivalence identifies uniqueness of response
zeros with uniqueness of the next original level, not merely of a
curve coordinate or of a scalar invariant. -/
theorem next_fiber_unique_of_injective_response
    {K O A : Type*} [AddCommGroup K] [AddCommGroup O] [AddTorsor K A]
    (n : ℕ) (u : L n) (R : K →+ O) (c : A → O)
    (affine : IsAffineObstruction R c) (injective : Function.Injective R)
    (exact_marked_choices : NextLevelFiber L truncate permitted n u ≃
      {a : A // c a = 0}) :
    Subsingleton (NextLevelFiber L truncate permitted n u) := by
  have hz := obstruction_zero_subsingleton R c affine injective
  constructor
  intro a b
  apply exact_marked_choices.injective
  exact @Subsingleton.elim _ hz _ _

/-- All response groups may depend on the actual reached prefix. An
injective complete response together with the exact marked fiber
description proves uniqueness of the original compatible tower. -/
theorem permitted_tower_unique_of_injective_responses
    (K O A : ∀ n, {u : L n // permitted n u} → Type*)
    [∀ n u, AddCommGroup (K n u)] [∀ n u, AddCommGroup (O n u)]
    [∀ n u, AddTorsor (K n u) (A n u)]
    (response : ∀ n u, K n u →+ O n u)
    (obstruction : ∀ n u, A n u → O n u)
    (affine : ∀ n u, IsAffineObstruction (response n u) (obstruction n u))
    (injective : ∀ n u, Function.Injective (response n u))
    (exact_marked_choices : ∀ n u,
      NextLevelFiber L truncate permitted n u.val ≃
        {a : A n u // obstruction n u a = 0})
    (v w : PermittedTower L truncate permitted)
    (initial_equal : v.val.val 0 = w.val.val 0) : v = w := by
  apply permitted_tower_unique truncate permitted _ v w initial_equal
  intro n u hu
  let reached : {u : L n // permitted n u} := ⟨u, hu⟩
  exact next_fiber_unique_of_injective_response truncate permitted n u
    (response n reached) (obstruction n reached) (affine n reached)
    (injective n reached) (exact_marked_choices n reached)

end Uniqueness

section CofinalCompatibility

variable {L : ℕ → Type*} (system : TruncationSystem L)

/-- Unique finite-level marked objects at arbitrarily high levels
assemble into a compatible infinite tower, even if the supplied
objects were not initially chosen coherently. -/
theorem cofinal_unique_levels_assemble
    (unique_level : ∀ n, Subsingleton (L n))
    (cofinal : ∀ n, ∃ m, n ≤ m ∧ Nonempty (L m)) :
    Nonempty (FullCompatibleTower L system) := by
  classical
  have inhabited : ∀ n, Nonempty (L n) := by
    intro n
    obtain ⟨m, hnm, hm⟩ := cofinal n
    exact ⟨system.restrict m n hnm (Classical.choice hm)⟩
  let tower : ∀ n, L n := fun n => Classical.choice (inhabited n)
  refine ⟨⟨tower, ?_⟩⟩
  intro m n h
  exact @Subsingleton.elim _ (unique_level n) _ _

theorem full_compatible_tower_unique
    (unique_level : ∀ n, Subsingleton (L n)) :
    Subsingleton (FullCompatibleTower L system) := by
  constructor
  intro v w
  apply Subtype.ext
  funext n
  exact @Subsingleton.elim _ (unique_level n) _ _

end CofinalCompatibility

end Litt3.Deformations
