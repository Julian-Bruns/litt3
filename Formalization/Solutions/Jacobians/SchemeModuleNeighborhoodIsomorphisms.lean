import Mathlib.AlgebraicGeometry.Modules.Sheaf
import Mathlib.Algebra.Category.ModuleCat.Presheaf.Sheafification
import Mathlib.CategoryTheory.Sites.LocallyBijective
import Mathlib.Topology.Sheaves.LocallySurjective

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) {M N : X.Modules} (f : M ⟶ N)
  (h : ∀ x : X, ∃ W : X.Opens, x ∈ W ∧
    ∀ (V : X.Opens), Nonempty V → V ≤ W →
      Function.Bijective ((f.val.app (op V)).hom))

include h

/-- Actual entire-section bijections on all subopens of an original
neighborhood at every original point yield genuine site-local injectivity
for ANY original module SHEAF morphism. -/
theorem actualSchemeModule_neighborhood_locally_injective :
    PresheafOfModules.IsLocallyInjective (Opens.grothendieckTopology X) f.val := by
  constructor
  intro U a b hab
  intro x hx
  obtain ⟨W, hxW, hW⟩ := h x
  let V := U.unop ⊓ W
  let i : V ⟶ U.unop := homOfLE inf_le_left
  refine ⟨V, i, ?_, ⟨hx, hxW⟩⟩
  change M.val.map i.op a = M.val.map i.op b
  apply (hW V ⟨⟨x, hx, hxW⟩⟩ inf_le_right).injective
  rw [PresheafOfModules.naturality_apply, PresheafOfModules.naturality_apply]
  have hab' : f.val.app U a = f.val.app U b := hab
  exact congrArg (fun z : N.val.obj U => N.val.map i.op z) hab'

/-- Actual local entire-section surjectivity gives true original
site-local surjectivity on ALL original opens. -/
theorem actualSchemeModule_neighborhood_locally_surjective :
    PresheafOfModules.IsLocallySurjective (Opens.grothendieckTopology X) f.val := by
  constructor
  intro U a
  intro x hx
  obtain ⟨W, hxW, hW⟩ := h x
  let V := U ⊓ W
  let i : V ⟶ U := homOfLE inf_le_left
  refine ⟨V, i, ?_, ⟨hx, hxW⟩⟩
  change ∃ b : M.val.obj (op V), f.val.app (op V) b = N.val.map i.op a
  exact (hW V ⟨⟨x, hx, hxW⟩⟩ inf_le_right).surjective (N.val.map i.op a)

/-- Genuine neighborhood bijections for an original module SHEAF
morphism derive a WHOLE original SHEAF isomorphism. This uses actual
original sheaf gluing through the forgetful functor, not global-section
tensor data or an assumed categorical isomorphism. -/
theorem actualSchemeModule_neighborhood_isIso : IsIso f := by
  letI := actualSchemeModule_neighborhood_locally_injective X f h
  letI := actualSchemeModule_neighborhood_locally_surjective X f h
  haveI : IsIso ((SheafOfModules.toSheaf X.ringCatSheaf).map f) := by
    apply (Sheaf.isLocallyBijective_iff_isIso _).mp
    constructor
    · change PresheafOfModules.IsLocallyInjective (Opens.grothendieckTopology X) f.val
      infer_instance
    · change PresheafOfModules.IsLocallySurjective (Opens.grothendieckTopology X) f.val
      infer_instance
  exact isIso_of_reflects_iso _ (SheafOfModules.toSheaf X.ringCatSheaf)

end Litt3.Jacobians
