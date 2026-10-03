import Definitions.SharedTensors.FiberClumps

namespace Litt3.SharedTensors

attribute [local instance] Classical.propDecidable

open Litt3.Jacobians

variable {X Y Z : Type*} (f : Z → X) (g : Z → Y)
  (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite)
  (hg : ∀ s : Set Y, s.Finite → (g ⁻¹' s).Finite)

theorem invariant_divisor_coefficients
    (a : (divisorRelationMap f g hf hg).ker) (z : Z) :
    a.val.1 (f z) = a.val.2 (g z) := by
  have h := congrArg (fun d : Divisor Z => d z) a.property
  exact sub_eq_zero.mp h

theorem invariant_pair_left_ne_zero
    (hgs : Function.Surjective g)
    (a : (divisorRelationMap f g hf hg).ker) (ha : a ≠ 0) : a.val.1 ≠ 0 := by
  intro hX
  have hY : a.val.2 = 0 := by
    ext y
    obtain ⟨z, rfl⟩ := hgs y
    rw [← invariant_divisor_coefficients f g hf hg a z, hX]
    rfl
  apply ha
  apply Subtype.ext
  exact Prod.ext hX hY

/-- A genuine nonzero coefficient level is a genuine finite clump.
Neither support saturation nor a component replacement is used. -/
noncomputable def invariantLevelClump
    (hfs : Function.Surjective f)
    (a : (divisorRelationMap f g hf hg).ker)
    (x : X) (hx : a.val.1 x ≠ 0) : FiberClump f g where
  left := {y | a.val.1 y = a.val.1 x}
  right := {y | a.val.2 y = a.val.1 x}
  left_finite := a.val.1.finite_support.subset (by
    intro y hy
    change a.val.1 y ≠ 0
    rwa [hy])
  right_finite := a.val.2.finite_support.subset (by
    intro y hy
    change a.val.2 y ≠ 0
    rwa [hy])
  left_nonempty := ⟨x, rfl⟩
  right_nonempty := by
    obtain ⟨z, hz⟩ := hfs x
    refine ⟨g z, ?_⟩
    change a.val.2 (g z) = a.val.1 x
    rw [← invariant_divisor_coefficients f g hf hg a z, hz]
  same_source := by
    ext z
    change a.val.1 (f z) = a.val.1 x ↔ a.val.2 (g z) = a.val.1 x
    rw [invariant_divisor_coefficients f g hf hg a z]

theorem clump_exists_of_nonzero_invariant_divisor
    (hfs : Function.Surjective f) (hgs : Function.Surjective g)
    (a : (divisorRelationMap f g hf hg).ker) (ha : a ≠ 0) :
    Nonempty (FiberClump f g) := by
  obtain ⟨x, hx⟩ := Finsupp.ne_iff.mp (invariant_pair_left_ne_zero f g hf hg hgs a ha)
  exact ⟨invariantLevelClump f g hf hg hfs a x hx⟩

@[simp] theorem reducedSetDivisor_apply (s : Set X) (hs : s.Finite) (x : X) :
    reducedSetDivisor s hs x = if x ∈ s then 1 else 0 := rfl

noncomputable def FiberClump.invariantDivisor (c : FiberClump f g) :
    (divisorRelationMap f g hf hg).ker :=
  ⟨(reducedSetDivisor c.left c.left_finite, reducedSetDivisor c.right c.right_finite), by
    classical
    ext z
    change (if f z ∈ c.left then (1 : ℤ) else 0) -
      (if g z ∈ c.right then 1 else 0) = 0
    have h : f z ∈ c.left ↔ g z ∈ c.right := Set.ext_iff.mp c.same_source z
    rw [h, sub_self]⟩

theorem FiberClump.invariantDivisor_ne_zero (c : FiberClump f g) :
    c.invariantDivisor f g hf hg ≠ 0 := by
  classical
  intro h
  obtain ⟨x, hx⟩ := c.left_nonempty
  have h' := congrArg (fun a : (divisorRelationMap f g hf hg).ker => a.val.1 x) h
  change (if x ∈ c.left then (1 : ℤ) else 0) = 0 at h'
  rw [if_pos hx] at h'
  exact one_ne_zero h'

/-- Absence of a clump is exactly vanishing of the actual integral
invariant-divisor group, for two surjective finite-fiber point maps. -/
theorem no_clump_iff_invariant_divisors_zero
    (hfs : Function.Surjective f) (hgs : Function.Surjective g) :
    IsEmpty (FiberClump f g) ↔ ∀ a : (divisorRelationMap f g hf hg).ker, a = 0 := by
  constructor
  · intro h a
    by_contra ha
    obtain ⟨c⟩ := clump_exists_of_nonzero_invariant_divisor f g hf hg hfs hgs a ha
    exact h.false c
  · intro h
    exact ⟨fun c => c.invariantDivisor_ne_zero f g hf hg (h _)⟩

end Litt3.SharedTensors
