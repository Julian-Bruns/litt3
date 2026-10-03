import Mathlib.Algebra.Category.ModuleCat.Sheaf
import Mathlib.Topology.Sheaves.SheafCondition.UniqueGluing

open CategoryTheory Opposite TopologicalSpace TopCat

namespace Litt3.Jacobians

universe u
variable {T : TopCat.{u}}
  {R : CategoryTheory.Sheaf (Opens.grothendieckTopology T) RingCat.{u}}
  (F : SheafOfModules.{u} R)
  (A : ∀ U : (Opens T)ᵒᵖ, Submodule (R.val.obj U) (F.val.obj U))
  (hres : ∀ {U V : (Opens T)ᵒᵖ} (i : U ⟶ V) (a : F.val.obj U),
    a ∈ A U → F.val.map i a ∈ A V)

/-- Actual submodules of every original sheaf section module, stable
under genuine restrictions, form a genuine module PRESHEAF. -/
noncomputable def actualSubmodulePresheaf : PresheafOfModules.{u} R.val where
  obj U := ModuleCat.of (R.val.obj U) (A U)
  map {U V} i := ModuleCat.ofHom
    (Y := (ModuleCat.restrictScalars (R.val.map i).hom).obj
      (ModuleCat.of (R.val.obj V) (A V)))
    { toFun := fun a => ⟨F.val.map i a.val, hres i a.val a.property⟩
      map_add' := fun a b => Subtype.ext ((F.val.map i).hom.map_add a.val b.val)
      map_smul' := fun r a => Subtype.ext (F.val.map_smul i r a.val) }
  map_id U := by
    apply ModuleCat.hom_ext
    apply DFunLike.ext
    intro a
    apply Subtype.ext
    exact CategoryTheory.congr_fun (F.val.map_id U) a.val
  map_comp i j := by
    apply ModuleCat.hom_ext
    apply DFunLike.ext
    intro a
    apply Subtype.ext
    exact CategoryTheory.congr_fun (F.val.map_comp i j) a.val

/-- Inclusion retains the original section and original restriction map. -/
noncomputable def actualSubmodulePresheafInclusion :
    actualSubmodulePresheaf F A hres ⟶ F.val where
  app U := ModuleCat.ofHom (A U).subtype
  naturality i := by
    apply ModuleCat.hom_ext
    apply LinearMap.ext
    intro a
    rfl

end Litt3.Jacobians
