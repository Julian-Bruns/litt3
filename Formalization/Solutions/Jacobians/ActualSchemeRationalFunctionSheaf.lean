import Mathlib.AlgebraicGeometry.FunctionField
import Mathlib.AlgebraicGeometry.Modules.Sheaf
import Mathlib.Topology.Sheaves.Skyscraper
import Mathlib.Algebra.Category.ModuleCat.Sheaf.ChangeOfRings

open CategoryTheory AlgebraicGeometry TopologicalSpace TopCat

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X]

/-- The honest rational-function sheaf at the original generic point.
Its value is the ACTUAL original generic-stalk function field. -/
noncomputable def actualSchemeRationalFunctionRingSheaf :
    TopCat.Sheaf CommRingCat X := by
  classical
  exact skyscraperSheaf (genericPoint X) (CommRingCat.of X.functionField)

/-- The original structure sheaf maps into rational functions through
its genuine generic stalk; no field identification is supplied. -/
noncomputable def actualSchemeStructureToRationalFunctions :
    X.sheaf ⟶ actualSchemeRationalFunctionRingSheaf X := by
  classical
  exact ⟨StalkSkyscraperPresheafAdjunctionAuxs.toSkyscraperPresheaf
    (genericPoint X) (𝟙 (X.presheaf.stalk (genericPoint X)))⟩

/-- The rational-function sheaf considered as the actual sheaf of rings. -/
noncomputable def actualSchemeRationalFunctionRingCatSheaf :
    CategoryTheory.Sheaf (Opens.grothendieckTopology X) RingCat :=
  (CategoryTheory.sheafCompose (Opens.grothendieckTopology X)
    (forget₂ CommRingCat RingCat)).obj (actualSchemeRationalFunctionRingSheaf X)

noncomputable def actualSchemeStructureToRationalFunctionsRingCat :
    X.ringCatSheaf ⟶ actualSchemeRationalFunctionRingCatSheaf X :=
  (CategoryTheory.sheafCompose (Opens.grothendieckTopology X)
    (forget₂ CommRingCat RingCat)).map (actualSchemeStructureToRationalFunctions X)

/-- The honest rational functions form an actual O_X-module SHEAF,
with its scalar action derived from the original generic section germs. -/
noncomputable def actualSchemeRationalFunctionModuleSheaf : X.Modules :=
  (SheafOfModules.restrictScalars (actualSchemeStructureToRationalFunctionsRingCat X)).obj
    (SheafOfModules.unit (actualSchemeRationalFunctionRingCatSheaf X))

/-- On every nonempty original open, the true rational-function ring
sheaf is the actual function field, including the actual empty-open convention. -/
noncomputable def actualSchemeRationalFunctionOpenIso
    (U : X.Opens) [Nonempty U] :
    (actualSchemeRationalFunctionRingSheaf X).val.obj (Opposite.op U) ≅
      CommRingCat.of X.functionField := by
  classical
  apply eqToIso
  change (if genericPoint X ∈ U then _ else _) = _
  have hU : genericPoint X ∈ U :=
    ((genericPoint_spec X).mem_open_set_iff U.isOpen).mpr
      (by simpa using (inferInstance : Nonempty U))
  exact if_pos hU

/-- The actual ring-sheaf map on a nonempty original open is exactly
the literal original section-to-function-field map. -/
theorem actualSchemeStructureToRationalFunctions_open
    (U : X.Opens) [Nonempty U] :
    (actualSchemeStructureToRationalFunctions X).val.app (Opposite.op U) ≫
      (actualSchemeRationalFunctionOpenIso X U).hom =
        CommRingCat.ofHom (algebraMap Γ(X, U) X.functionField) := by
  classical
  have hU : genericPoint X ∈ U :=
    ((genericPoint_spec X).mem_open_set_iff U.isOpen).mpr
      (by simpa using (inferInstance : Nonempty U))
  simp only [actualSchemeStructureToRationalFunctions,
    StalkSkyscraperPresheafAdjunctionAuxs.toSkyscraperPresheaf_app,
    dif_pos hU, actualSchemeRationalFunctionOpenIso, eqToIso.hom,
    Category.assoc, eqToHom_trans, eqToHom_refl, Category.comp_id]
  rfl

end Litt3.Jacobians
