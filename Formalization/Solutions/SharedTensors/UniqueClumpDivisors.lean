import Solutions.SharedTensors.FiberClumps

namespace Litt3.SharedTensors

open Litt3.Jacobians
attribute [local instance] Classical.propDecidable

variable {X Y Z : Type*} (f : Z → X) (g : Z → Y)
  (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite)
  (hg : ∀ s : Set Y, s.Finite → (g ⁻¹' s).Finite)

/-- The precise one-clump input concerns the actual finite endpoint
sets. The rank-one divisor conclusion is derived, rather than assumed. -/
def UniqueFiberClump (c : FiberClump f g) : Prop :=
  ∀ b : FiberClump f g, b.left = c.left ∧ b.right = c.right

theorem unique_clump_generates_invariant_divisors
    (hfs : Function.Surjective f) (hgs : Function.Surjective g)
    (c : FiberClump f g) (hc : UniqueFiberClump f g c)
    (a : (divisorRelationMap f g hf hg).ker) :
    ∃ n : ℤ, a = n • c.invariantDivisor f g hf hg := by
  by_cases ha : a = 0
  · exact ⟨0, by simp [ha]⟩
  obtain ⟨x, hx⟩ := Finsupp.ne_iff.mp (invariant_pair_left_ne_zero f g hf hg hgs a ha)
  let n := a.val.1 x
  let b := invariantLevelClump f g hf hg hfs a x hx
  have hleft : b.left = c.left := (hc b).1
  have hright : b.right = c.right := (hc b).2
  have hX : ∀ y, a.val.1 y = if y ∈ c.left then n else 0 := by
    intro y
    by_cases hy : y ∈ c.left
    · rw [if_pos hy]
      exact (show y ∈ b.left from hleft.symm ▸ hy)
    · rw [if_neg hy]
      by_contra hzero
      let b' := invariantLevelClump f g hf hg hfs a y hzero
      have heq : b'.left = c.left := (hc b').1
      exact hy (heq ▸ (show y ∈ b'.left from rfl))
  have hY : ∀ y, a.val.2 y = if y ∈ c.right then n else 0 := by
    intro y
    by_cases hy : y ∈ c.right
    · rw [if_pos hy]
      exact (show y ∈ b.right from hright.symm ▸ hy)
    · rw [if_neg hy]
      by_contra hzero
      obtain ⟨z, hz⟩ := hgs y
      have hnonzero : a.val.1 (f z) ≠ 0 := by
        rw [invariant_divisor_coefficients f g hf hg a z, hz]
        exact hzero
      let b' := invariantLevelClump f g hf hg hfs a (f z) hnonzero
      have heq : b'.right = c.right := (hc b').2
      apply hy
      rw [← heq]
      change a.val.2 y = a.val.1 (f z)
      rw [invariant_divisor_coefficients f g hf hg a z, hz]
  refine ⟨n, Subtype.ext (Prod.ext ?_ ?_)⟩
  · ext y
    change a.val.1 y = n • (if y ∈ c.left then (1 : ℤ) else 0)
    rw [hX]
    split_ifs <;> simp
  · ext y
    change a.val.2 y = n • (if y ∈ c.right then (1 : ℤ) else 0)
    rw [hY]
    split_ifs <;> simp

noncomputable def FiberClump.generatorHom (c : FiberClump f g) :
    ℤ →+ (divisorRelationMap f g hf hg).ker where
  toFun n := n • c.invariantDivisor f g hf hg
  map_zero' := zero_zsmul _
  map_add' := fun _ _ => add_zsmul _ _ _

theorem FiberClump.generatorHom_injective (c : FiberClump f g) :
    Function.Injective (c.generatorHom f g hf hg) := by
  obtain ⟨x, hx⟩ := c.left_nonempty
  intro n m h
  have heq := congrArg (fun a : (divisorRelationMap f g hf hg).ker => a.val.1 x) h
  change n • (if x ∈ c.left then (1 : ℤ) else 0) =
    m • (if x ∈ c.left then (1 : ℤ) else 0) at heq
  simpa [hx, zsmul_eq_mul] using heq

/-- The actual invariant-divisor group is canonically infinite cyclic
when its actual finite fiber clump is unique. -/
noncomputable def FiberClump.invariantDivisorsEquivInt
    (hfs : Function.Surjective f) (hgs : Function.Surjective g)
    (c : FiberClump f g) (hc : UniqueFiberClump f g c) :
    (divisorRelationMap f g hf hg).ker ≃+ ℤ :=
  (AddEquiv.ofBijective (c.generatorHom f g hf hg)
    ⟨c.generatorHom_injective f g hf hg, by
      intro a
      obtain ⟨n, hn⟩ := unique_clump_generates_invariant_divisors f g hf hg hfs hgs c hc a
      exact ⟨n, hn.symm⟩⟩).symm

end Litt3.SharedTensors
