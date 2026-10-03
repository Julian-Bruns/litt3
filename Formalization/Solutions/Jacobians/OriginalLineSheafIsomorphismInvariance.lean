import Definitions.Jacobians.OriginalLineSheaves

open CategoryTheory AlgebraicGeometry

namespace Litt3.Jacobians

universe u

/-- Genuine ORIGINAL line-sheaf local freeness is invariant under
ACTUAL whole original SHEAF isomorphism, on ANY scheme. -/
theorem actualOriginalLineSheaf_of_iso
    (X : Scheme.{u}) {M N : X.Modules} (e : M ≅ N)
    (hM : ActualOriginalLineSheaf X M) : ActualOriginalLineSheaf X N := by
  intro x
  obtain ⟨U, hx, ⟨eU⟩⟩ := hM x
  let F : X.Modules ⥤ SheafOfModules (X.ringCatSheaf.over U) :=
    SheafOfModules.pushforward (F := Over.forget U) (𝟙 _)
  exact ⟨U, hx, ⟨F.mapIso e.symm ≪≫ eU⟩⟩

/-- The TRUE original structure SHEAF module is locally free of
rank one on the ENTIRE original neighborhood sites of ANY scheme. -/
theorem actualOriginalStructureSheaf_is_line (X : Scheme.{u}) :
    ActualOriginalLineSheaf X (SheafOfModules.unit X.ringCatSheaf) :=
  fun x => ⟨⊤, trivial, ⟨Iso.refl _⟩⟩

end Litt3.Jacobians
