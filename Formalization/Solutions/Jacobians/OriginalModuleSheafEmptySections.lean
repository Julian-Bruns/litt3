import Mathlib.AlgebraicGeometry.Modules.Sheaf
import Mathlib.Topology.Sheaves.SheafCondition.UniqueGluing

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u

/-- EVERY actual original module SHEAF has exactly one section
on EVERY empty original open, derived from its true empty-cover gluing
condition. No integral, curve, local-freeness or affine hypothesis is
needed, and the empty-open value is not replaced by a rational field. -/
theorem actualOriginalModuleSheaf_empty_sections_subsingleton
    (X : Scheme.{u}) (M : X.Modules) (U : X.Opens)
    (hU : ¬ Nonempty U) : Subsingleton (M.val.obj (op U)) := by
  have hbot : U = ⊥ := (Opens.not_nonempty_iff_eq_bot U).mp
    (fun ⟨x, hx⟩ => hU ⟨⟨x, hx⟩⟩)
  let F : TopCat.Sheaf AddCommGrpCat X := ⟨M.val.presheaf, M.isSheaf⟩
  let emptyCover : PEmpty.{u + 1} → X.Opens := fun i => PEmpty.elim i
  refine ⟨fun a b => F.eq_of_locally_eq' emptyCover U
    (fun i => PEmpty.elim i) ?_ a b (fun i => PEmpty.elim i)⟩
  rw [hbot]
  exact bot_le

end Litt3.Jacobians
