import Definitions.Jacobians.OriginalLineSheaves

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) (M : X.Modules) (U : X.Opens)

/-- An actual original local SHEAF frame gives the entire original
section-module equivalence on EVERY smaller original open. -/
noncomputable def actualOriginalLineFrameSectionEquiv
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (V : X.Opens) (i : V ⟶ U) :
    M.val.obj (op V) ≃ₗ[Γ(X, V)] Γ(X, V) :=
  ((SheafOfModules.evaluation (X.ringCatSheaf.over U) (op (Over.mk i))).mapIso e).toLinearEquiv

/-- The actual frame equivalences commute with ALL original
restrictions; this is the full original sheaf isomorphism square. -/
theorem actualOriginalLineFrameSectionEquiv_restriction
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    {V W : X.Opens} (i : V ⟶ U) (j : W ⟶ U) (k : W ⟶ V)
    (a : M.val.obj (op V)) :
    actualOriginalLineFrameSectionEquiv X M U e W j (M.val.map k.op a) =
      X.presheaf.map k.op (actualOriginalLineFrameSectionEquiv X M U e V i a) := by
  let h : Over.mk j ⟶ Over.mk i := Over.homMk k (Subsingleton.elim _ _)
  exact CategoryTheory.congr_fun (e.hom.val.naturality h.op) a

/-- The inverse actual frame also commutes with every original
restriction on the ENTIRE original section modules. -/
theorem actualOriginalLineFrameSectionEquiv_symm_restriction
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    {V W : X.Opens} (i : V ⟶ U) (j : W ⟶ U) (k : W ⟶ V)
    (a : Γ(X, V)) :
    (actualOriginalLineFrameSectionEquiv X M U e W j).symm (X.presheaf.map k.op a) =
      M.val.map k.op ((actualOriginalLineFrameSectionEquiv X M U e V i).symm a) := by
  let h : Over.mk j ⟶ Over.mk i := Over.homMk k (Subsingleton.elim _ _)
  exact CategoryTheory.congr_fun (e.inv.val.naturality h.op) a

/-- Genuine whole-site local frames give actual bijections of the
ENTIRE original section spaces, without finite-generation assumptions. -/
theorem actualOriginalLineFrameSectionEquiv_bijective
    (e : M.over U ≅ (SheafOfModules.unit X.ringCatSheaf).over U)
    (V : X.Opens) (i : V ⟶ U) :
    Function.Bijective (actualOriginalLineFrameSectionEquiv X M U e V i) :=
  (actualOriginalLineFrameSectionEquiv X M U e V i).bijective

end Litt3.Jacobians
