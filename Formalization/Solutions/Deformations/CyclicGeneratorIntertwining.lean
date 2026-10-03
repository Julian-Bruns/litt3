import Mathlib.RepresentationTheory.Basic
import Mathlib.GroupTheory.SpecificGroups.Cyclic

namespace Litt3.Deformations

variable {k G V W : Type*} [CommRing k] [Group G] [Finite G]
    [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]

/-- Intertwining the actual generator intertwines the full finite
cyclic group action, for every linear map, without bijectivity. -/
theorem cyclic_generator_intertwining
    (ρ : Representation k G V) (σ : Representation k G W) (f : V →ₗ[k] W)
    (g : G) (generated : ∀ x : G, x ∈ Subgroup.zpowers g)
    (generator : ∀ v, f (ρ g v) = σ g (f v)) :
    ∀ x v, f (ρ x v) = σ x (f v) := by
  have powers : ∀ n v, f (ρ (g ^ n) v) = σ (g ^ n) (f v) := by
    intro n
    induction n with
    | zero => intro v; simp
    | succ n induction =>
      intro v
      simp only [pow_succ, map_mul, Module.End.mul_apply]
      rw [induction, generator]
  intro x v
  obtain ⟨n, rfl⟩ := (mem_powers_iff_mem_zpowers).mpr (generated x)
  exact powers n v

end Litt3.Deformations
