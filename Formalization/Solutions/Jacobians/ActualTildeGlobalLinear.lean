import Solutions.Jacobians.ActualTildeUnit
import Solutions.Jacobians.ActualTildeOriginalSections

open CategoryTheory Opposite TopologicalSpace AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {R : Type u} [CommRing R]

noncomputable def actualTildeOriginalGlobalLinearMap (M : ModuleCat.{u} R) :
    M →ₗ[R] M.tildeInModuleCat.obj (op ⊤) where
  toFun := actualTildeOriginalGlobalSection M
  map_add' a b := by apply Subtype.ext; funext x; exact map_add _ _ _
  map_smul' r m := by
    apply Subtype.ext
    funext x
    exact (LocalizedModule.mkLinearMap x.1.asIdeal.primeCompl M).map_smul r m

theorem actualTildeRingSectionMap_original (r : R) :
    actualTildeRingSectionMap R (op ⊤)
      (actualTildeOriginalGlobalSection (ModuleCat.of R R) r) =
        StructureSheaf.toOpen R ⊤ r := by
  apply Subtype.ext
  funext x
  exact actualLocalizedRingModuleEquiv_original R x.1 r

theorem actualTildeRingGlobalSections_surjective :
    Function.Surjective (actualTildeOriginalGlobalSection (ModuleCat.of R R)) := by
  intro s
  let r := (StructureSheaf.globalSectionsIso R).inv (actualTildeRingSectionMap R (op ⊤) s)
  have hr : StructureSheaf.toOpen R ⊤ r = actualTildeRingSectionMap R (op ⊤) s :=
    CategoryTheory.congr_fun (StructureSheaf.globalSectionsIso R).inv_hom_id _
  refine ⟨r, ?_⟩
  apply (actualTildeRingSectionEquiv R (op ⊤)).injective
  change actualTildeRingSectionMap R (op ⊤) _ = actualTildeRingSectionMap R (op ⊤) s
  rw [actualTildeRingSectionMap_original]
  exact hr

end Litt3.Jacobians
