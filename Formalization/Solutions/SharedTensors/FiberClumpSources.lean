import Solutions.SharedTensors.FiberClumps

namespace Litt3.SharedTensors

variable {X Y Z : Type*} {f : Z → X} {g : Z → Y}

def FiberClump.source (c : FiberClump f g) : Set Z := f ⁻¹' c.left

theorem FiberClump.source_eq_right (c : FiberClump f g) : c.source = g ⁻¹' c.right :=
  c.same_source

theorem FiberClump.source_finite (c : FiberClump f g)
    (hf : ∀ s : Set X, s.Finite → (f ⁻¹' s).Finite) : c.source.Finite :=
  hf c.left c.left_finite

theorem FiberClump.source_nonempty (c : FiberClump f g) (hf : Function.Surjective f) :
    c.source.Nonempty := by
  obtain ⟨x, hx⟩ := c.left_nonempty
  obtain ⟨z, rfl⟩ := hf x
  exact ⟨z, hx⟩

theorem FiberClump.source_left_image (c : FiberClump f g) (hf : Function.Surjective f) :
    f '' c.source = c.left := Set.image_preimage_eq _ hf

theorem FiberClump.source_right_image (c : FiberClump f g) (hg : Function.Surjective g) :
    g '' c.source = c.right := by
  rw [c.source_eq_right]
  exact Set.image_preimage_eq _ hg

end Litt3.SharedTensors
