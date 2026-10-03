import Solutions.Jacobians.OriginalLineSheafFrames
import Mathlib.AlgebraicGeometry.FunctionField
import Mathlib.Topology.Sheaves.SheafCondition.UniqueGluing

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] (M : X.Modules)

/-- On an ORIGINAL local line frame, restricting to ANY nonempty
smaller original open is injective. This is derived from the full frame
square and injectivity of original integral-scheme ring restrictions. -/
theorem actualOriginalLineFrame_restriction_injective
    (U : X.Opens)
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    {V W : X.Opens} [Nonempty W]
    (i : V ⟶ U) (j : W ⟶ U) (k : W ⟶ V) :
    Function.Injective (M.val.map k.op) := by
  intro a b hab
  apply (actualOriginalLineFrameSectionEquiv X M U e V i).injective
  apply map_injective_of_isIntegral X k
  have h := congrArg (actualOriginalLineFrameSectionEquiv X M U e W j) hab
  rw [actualOriginalLineFrameSectionEquiv_restriction,
    actualOriginalLineFrameSectionEquiv_restriction] at h
  exact h

/-- Every ACTUAL original locally free rank-one sheaf over ANY
integral scheme has injective restrictions to EVERY nonempty original
open. All local frames and all section equalities are derived on the
ENTIRE original sheaf site; no generic embedding or torsion-free module
hypothesis is supplied. -/
theorem actualOriginalLineSheaf_restriction_injective
    (hM : ActualOriginalLineSheaf X M)
    {U V : X.Opens} [Nonempty V] (i : V ⟶ U) :
    Function.Injective (M.val.map i.op) := by
  classical
  choose frameOpen hpoint hframe using hM
  let frame (x : X) : M.over (frameOpen x) ≅
      (SheafOfModules.unit X.ringCatSheaf).over (frameOpen x) :=
    Classical.choice (hframe x)
  let W (x : U) : X.Opens := U ⊓ frameOpen x.val
  let iWU (x : U) : W x ⟶ U := homOfLE inf_le_left
  have hcover : U ≤ iSup W := by
    intro x hx
    exact Opens.mem_iSup.mpr ⟨⟨x, hx⟩, hx, hpoint x⟩
  intro a b hab
  let F : TopCat.Sheaf AddCommGrpCat X := ⟨M.val.presheaf, M.isSheaf⟩
  apply F.eq_of_locally_eq' W U iWU hcover a b
  intro x
  let T : X.Opens := W x ⊓ V
  have hgW : genericPoint X ∈ W x :=
    ((genericPoint_spec X).mem_open_set_iff (W x).isOpen).mpr
      (by exact ⟨x.val, trivial, x.property, hpoint x.val⟩)
  have hgV : genericPoint X ∈ V :=
    ((genericPoint_spec X).mem_open_set_iff V.isOpen).mpr
      (by simpa using (inferInstance : Nonempty V))
  letI : Nonempty T := ⟨⟨genericPoint X, hgW, hgV⟩⟩
  let iTW : T ⟶ W x := homOfLE inf_le_left
  let iTV : T ⟶ V := homOfLE inf_le_right
  let iWF : W x ⟶ frameOpen x.val := homOfLE inf_le_right
  let iTF : T ⟶ frameOpen x.val := iTW ≫ iWF
  apply actualOriginalLineFrame_restriction_injective X M
    (frameOpen x.val) (frame x.val) iWF iTF iTW
  have hab' : M.val.presheaf.map i.op a = M.val.presheaf.map i.op b := hab
  have h := congrArg (fun s => M.val.presheaf.map iTV.op s) hab'
  change M.val.presheaf.map iTW.op (M.val.presheaf.map (iWU x).op a) =
    M.val.presheaf.map iTW.op (M.val.presheaf.map (iWU x).op b)
  simpa only [← ConcreteCategory.comp_apply, ← M.val.presheaf.map_comp] using h

end Litt3.Jacobians
