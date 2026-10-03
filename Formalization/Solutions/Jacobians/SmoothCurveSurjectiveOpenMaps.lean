import Solutions.Jacobians.SmoothCurveOpenFiniteComplements
import Definitions.SharedTensors.SchemeFunctionFields

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u

/-- ANY actual surjective morphism from a quasi-compact smooth
integral curve to a smooth integral curve is an open map. This uses
the actual finite complement of each nonempty source open and the true
closed-or-generic target point stratification. No flatness, etaleness,
finiteness or compatibility with the structure morphisms is required. -/
theorem actual_smooth_curve_surjective_isOpenMap
    {k : Type u} [Field k] [IsAlgClosed k]
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    [IsSmoothOfRelativeDimension 1 sX] [IsSmoothOfRelativeDimension 1 sY]
    [QuasiCompact sX] (f : X ⟶ Y) [Surjective f] : IsOpenMap f.base := by
  intro U hU
  by_cases hEmpty : U = ∅
  · subst U
    simp
  let W : X.Opens := ⟨U, hU⟩
  letI : Nonempty W := by
    obtain ⟨x, hx⟩ := Set.nonempty_iff_ne_empty.mpr hEmpty
    exact ⟨⟨x, hx⟩⟩
  have hfinite : (f '' Uᶜ).Finite :=
    (actual_smooth_curve_nonempty_open_complement_finite sX W).image f
  have hsubset : (f '' U)ᶜ ⊆ f '' Uᶜ := by
    intro y hy
    obtain ⟨x, rfl⟩ := f.surjective y
    refine ⟨x, ?_, rfl⟩
    intro hx
    exact hy ⟨x, hx, rfl⟩
  have hcompfinite := hfinite.subset hsubset
  have hclosed : IsClosed ((f '' U)ᶜ) := by
    rw [← Set.biUnion_of_singleton ((f '' U)ᶜ)]
    apply hcompfinite.isClosed_biUnion
    intro y hy
    rcases Litt3.SharedTensors.actual_smooth_curve_point_closed_or_generic sY y with hc | hg
    · exact hc
    · subst y
      have hgX : genericPoint X ∈ W :=
        ((genericPoint_spec X).mem_open_set_iff W.isOpen).mpr
          (by simpa using (inferInstance : Nonempty W))
      exact False.elim (hy ⟨genericPoint X, hgX,
        Litt3.SharedTensors.scheme_genericPoint_eq_of_surjective f⟩)
  exact isClosed_compl_iff.mp hclosed

end Litt3.Jacobians
