import Solutions.Jacobians.ActualSubmodulePresheaves

open CategoryTheory Opposite TopologicalSpace TopCat

namespace Litt3.Jacobians

universe u
variable {T : TopCat.{u}}
  {R : CategoryTheory.Sheaf (Opens.grothendieckTopology T) RingCat.{u}}
  (F : SheafOfModules.{u} R)
  (A : ∀ U : (Opens T)ᵒᵖ, Submodule (R.val.obj U) (F.val.obj U))
  (hres : ∀ {U V : (Opens T)ᵒᵖ} (i : U ⟶ V) (a : F.val.obj U),
    a ∈ A U → F.val.map i a ∈ A V)
  (hlocal : ∀ {ι : Type u} (U : ι → Opens T) (a : F.val.obj (op (iSup U))),
    (∀ i, F.val.map (Opens.leSupr U i).op a ∈ A (op (U i))) → a ∈ A (op (iSup U)))

include hlocal

/-- Local membership in ACTUAL section submodules derives the genuine
SHEAF condition from the ambient sheaf's original unique gluing. -/
theorem actualSubmodulePresheaf_isSheaf :
    CategoryTheory.Presheaf.IsSheaf (Opens.grothendieckTopology T)
      (actualSubmodulePresheaf F A hres).presheaf := by
  apply (TopCat.Presheaf.isSheaf_iff_isSheafUniqueGluing _).mpr
  intro ι U sf hc
  let sfF : ∀ i, F.val.presheaf.obj (op (U i)) := fun i => (sf i).val
  have hcF : TopCat.Presheaf.IsCompatible F.val.presheaf U sfF := by
    intro i j
    exact congrArg Subtype.val (hc i j)
  obtain ⟨a, ha, hua⟩ :=
    TopCat.Presheaf.IsSheaf.isSheafUniqueGluing F.isSheaf U sfF hcF
  have hA : a ∈ A (op (iSup U)) := by
    apply hlocal U a
    intro i
    change F.val.presheaf.map (Opens.leSupr U i).op a ∈ A (op (U i))
    rw [ha i]
    exact (sf i).property
  refine ⟨⟨a, hA⟩, ?_, ?_⟩
  · intro i
    apply Subtype.ext
    exact ha i
  · intro b hb
    apply Subtype.ext
    apply hua b.val
    intro i
    exact congrArg Subtype.val (hb i)

/-- Actual section submodules with local membership define a true
module SHEAF, with the original sections and restriction maps. -/
noncomputable def actualSubmoduleSheaf : SheafOfModules.{u} R where
  val := actualSubmodulePresheaf F A hres
  isSheaf := actualSubmodulePresheaf_isSheaf F A hres hlocal

noncomputable def actualSubmoduleSheafInclusion :
    actualSubmoduleSheaf F A hres hlocal ⟶ F :=
  ⟨actualSubmodulePresheafInclusion F A hres⟩

end Litt3.Jacobians
