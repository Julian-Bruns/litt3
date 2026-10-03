import Theorems.Deformations.FilteredQuotients

namespace Litt3.Deformations

variable {k V W : Type*} [DivisionRing k]
variable [AddCommGroup V] [Module k V] [AddCommGroup W] [Module k W]
variable {F : ℕ → Submodule k V} {E : ℕ → Submodule k W}

theorem filtration_restriction_surjective (f : FilteredLinearMap F E)
    (images : ∀ i, (F i).map f.toLinearMap = E i) (i : ℕ) :
    Function.Surjective (f.restriction i) := by
  intro y
  have hy : y.val ∈ (F i).map f.toLinearMap := (images i).symm ▸ y.property
  obtain ⟨x, hx, hxy⟩ := hy
  refine ⟨⟨x, hx⟩, ?_⟩
  exact Subtype.ext hxy

/-- Every actual associated-graded quotient map is surjective
when the genuine map is surjective on each filtration term. -/
theorem filtration_layer_map_surjective (f : FilteredLinearMap F E)
    (images : ∀ i, (F i).map f.toLinearMap = E i) (i : ℕ) :
    Function.Surjective (f.layerMap i) := by
  intro q
  obtain ⟨y, rfl⟩ := ((E (i + 1)).comap (E i).subtype).mkQ_surjective q
  obtain ⟨x, hx⟩ := filtration_restriction_surjective f images i y
  refine ⟨((F (i + 1)).comap (F i).subtype).mkQ x, ?_⟩
  change ((E (i + 1)).comap (E i).subtype).mkQ (f.restriction i x) = _
  rw [hx]

variable [FiniteDimensional k V]

theorem filtration_hilbert_dimension_monotone (f : FilteredLinearMap F E)
    (images : ∀ i, (F i).map f.toLinearMap = E i) :
    Specifications.FiltrationHilbertMonotone f := by
  intro i
  have h := (f.layerMap i).finrank_range_le
  rw [LinearMap.range_eq_top.mpr (filtration_layer_map_surjective f images i), finrank_top] at h
  exact h

theorem filtration_windows_dimension_monotone (f : FilteredLinearMap F E)
    (images : ∀ i, (F i).map f.toLinearMap = E i) :
    Specifications.FiltrationWindowMonotone f := by
  intro i lag
  apply Finset.sum_le_sum
  intro j _
  exact filtration_hilbert_dimension_monotone f images (i + j)

end Litt3.Deformations
