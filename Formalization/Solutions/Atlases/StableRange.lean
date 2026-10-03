import Theorems.Atlases.StableRange
import Mathlib.Data.Set.Function

namespace Litt3.Atlases

variable {K V : Type*} [DivisionRing K] [AddCommGroup V] [Module K V]
variable [FiniteDimensional K V]

omit [FiniteDimensional K V] in
theorem range_decreases (f : Module.End K V) (e : ℕ) :
    LinearMap.range (f ^ (e + 1)) ≤ LinearMap.range (f ^ e) := by
  intro x hx
  obtain ⟨y, rfl⟩ := hx
  refine ⟨f y, ?_⟩
  simp only [pow_succ, Module.End.mul_apply]

theorem exact_rank_plateau_range_eq (f : Module.End K V) (e : ℕ)
    (h : ExactRangePlateau f e) :
    LinearMap.range (f ^ (e + 1)) = LinearMap.range (f ^ e) :=
  Submodule.eq_of_le_of_finrank_eq (range_decreases f e) h.symm

omit [FiniteDimensional K V] in
theorem stable_range_mapsTo (f : Module.End K V) (e : ℕ) :
    Set.MapsTo f (LinearMap.range (f ^ e)) (LinearMap.range (f ^ e)) := by
  intro x hx
  obtain ⟨y, rfl⟩ := hx
  apply range_decreases f e
  refine ⟨y, ?_⟩
  simp only [pow_succ', Module.End.mul_apply]

theorem exact_rank_plateau_surjOn (f : Module.End K V) (e : ℕ)
    (h : ExactRangePlateau f e) :
    Set.SurjOn f (LinearMap.range (f ^ e)) (LinearMap.range (f ^ e)) := by
  intro x hx
  have hx' : x ∈ LinearMap.range (f ^ (e + 1)) :=
    (exact_rank_plateau_range_eq f e h).symm ▸ hx
  obtain ⟨y, hy⟩ := hx'
  refine ⟨(f ^ e) y, ⟨y, rfl⟩, ?_⟩
  simpa only [pow_succ', Module.End.mul_apply] using hy

/-- Equality of consecutive image ranks already makes the actual image
restriction injective; no prescribed waiting exponent is needed. -/
theorem exact_rank_plateau_injOn (f : Module.End K V) (e : ℕ)
    (h : ExactRangePlateau f e) :
    Set.InjOn f (LinearMap.range (f ^ e)) :=
  (LinearMap.injOn_iff_surjOn (stable_range_mapsTo f e)).mpr
    (exact_rank_plateau_surjOn f e h)

/-- Every vector in the certified stable image killed by any iterate is zero,
including a rank plateau at exponent zero. -/
theorem stable_range_has_no_nilpotent_vector (f : Module.End K V) (e : ℕ)
    (h : ExactRangePlateau f e) (x : V) (hx : x ∈ LinearMap.range (f ^ e))
    (n : ℕ) (hn : (f ^ n) x = 0) : x = 0 := by
  apply (exact_rank_plateau_injOn f e h).iterate (stable_range_mapsTo f e) n hx
    (LinearMap.range (f ^ e)).zero_mem
  simpa only [← Module.End.pow_apply, map_zero] using hn

end Litt3.Atlases
