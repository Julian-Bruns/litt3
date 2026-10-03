import Mathlib.AlgebraicGeometry.Modules.Sheaf
import Mathlib.Topology.Sheaves.LocallySurjective

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) {M N : PresheafOfModules.{u} X.ringCatSheaf.val} (f : M ⟶ N)
  (h : ∀ x : X, ∃ W : X.Opens, x ∈ W ∧
    ∀ (V : X.Opens), Nonempty V → V ≤ W →
      Function.Bijective ((f.app (op V)).hom))

include h

/-- Actual entire-section bijections on all nonempty subopens of
an original neighborhood at every original point give TRUE site-local
injectivity for ANY original module PRESHEAF morphism. No sheaf premise
or assertion about the sheafification is assumed. -/
theorem actualSchemeModulePresheaf_neighborhood_locally_injective :
    PresheafOfModules.IsLocallyInjective (Opens.grothendieckTopology X) f := by
  constructor
  intro U a b hab
  intro x hx
  obtain ⟨W, hxW, hW⟩ := h x
  let V := U.unop ⊓ W
  let i : V ⟶ U.unop := homOfLE inf_le_left
  refine ⟨V, i, ?_, ⟨hx, hxW⟩⟩
  change M.map i.op a = M.map i.op b
  apply (hW V ⟨⟨x, hx, hxW⟩⟩ inf_le_right).injective
  rw [PresheafOfModules.naturality_apply, PresheafOfModules.naturality_apply]
  have hab' : f.app U a = f.app U b := hab
  exact congrArg (fun z : N.obj U => N.map i.op z) hab'

/-- Actual entire-section surjectivity on all neighborhood subopens
gives true site-local surjectivity for ANY original module PRESHEAF map. -/
theorem actualSchemeModulePresheaf_neighborhood_locally_surjective :
    PresheafOfModules.IsLocallySurjective (Opens.grothendieckTopology X) f := by
  constructor
  intro U a
  intro x hx
  obtain ⟨W, hxW, hW⟩ := h x
  let V := U ⊓ W
  let i : V ⟶ U := homOfLE inf_le_left
  refine ⟨V, i, ?_, ⟨hx, hxW⟩⟩
  change ∃ b : M.obj (op V), f.app (op V) b = N.map i.op a
  exact (hW V ⟨⟨x, hx, hxW⟩⟩ inf_le_right).surjective (N.map i.op a)

end Litt3.Jacobians
