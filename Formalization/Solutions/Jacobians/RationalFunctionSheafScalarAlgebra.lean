import Solutions.Jacobians.RationalFunctionSheafScalars

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X]

noncomputable local instance actualRationalScalarTopNonempty : Nonempty (⊤ : X.Opens) :=
  ⟨⟨genericPoint X, trivial⟩⟩

theorem actualRationalFunctionScalar_one (U : X.Opensᵒᵖ) :
    actualRationalFunctionScalar X 1 U =
      (1 : (actualSchemeRationalFunctionRingSheaf X).val.obj U) := by
  unfold actualRationalFunctionScalar actualRationalFunctionGlobalSection
  exact (congrArg
    ((actualSchemeRationalFunctionRingSheaf X).val.map
      (homOfLE (show U.unop ≤ (⊤ : X.Opens) from le_top)).op)
    (actualSchemeRationalFunctionOpenIso X ⊤).inv.hom.map_one).trans
      ((actualSchemeRationalFunctionRingSheaf X).val.map _).hom.map_one

theorem actualRationalFunctionScalar_mul (f g : X.functionField) (U : X.Opensᵒᵖ) :
    actualRationalFunctionScalar X (f * g) U =
      actualRationalFunctionScalar X f U * actualRationalFunctionScalar X g U := by
  unfold actualRationalFunctionScalar actualRationalFunctionGlobalSection
  exact (congrArg
    ((actualSchemeRationalFunctionRingSheaf X).val.map
      (homOfLE (show U.unop ≤ (⊤ : X.Opens) from le_top)).op)
    ((actualSchemeRationalFunctionOpenIso X ⊤).inv.hom.map_mul f g)).trans
      (((actualSchemeRationalFunctionRingSheaf X).val.map _).hom.map_mul _ _)

theorem actualRationalFunctionSheafMultiply_one :
    actualRationalFunctionSheafMultiply X 1 =
      𝟙 (actualSchemeRationalFunctionModuleSheaf X) := by
  apply SheafOfModules.hom_ext
  apply PresheafOfModules.hom_ext
  intro U
  apply ModuleCat.hom_ext
  apply DFunLike.ext
  intro a
  change actualRationalFunctionScalar X 1 U *
    (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a) = a
  rw [actualRationalFunctionScalar_one, one_mul]

theorem actualRationalFunctionSheafMultiply_mul (f g : X.functionField) :
    actualRationalFunctionSheafMultiply X (f * g) =
      actualRationalFunctionSheafMultiply X f ≫ actualRationalFunctionSheafMultiply X g := by
  apply SheafOfModules.hom_ext
  apply PresheafOfModules.hom_ext
  intro U
  apply ModuleCat.hom_ext
  apply DFunLike.ext
  intro a
  change actualRationalFunctionScalar X (f * g) U *
    (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a) =
      actualRationalFunctionScalar X g U *
        (actualRationalFunctionScalar X f U *
          (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a))
  rw [actualRationalFunctionScalar_mul]
  ac_rfl

/-- Every original nonzero rational function gives a genuine actual
O_X-module SHEAF automorphism of rational functions, with its literal
inverse rational function and no finite-dimensionality premise. -/
noncomputable def actualRationalFunctionUnitSheafIso (f : X.functionFieldˣ) :
    actualSchemeRationalFunctionModuleSheaf X ≅ actualSchemeRationalFunctionModuleSheaf X where
  hom := actualRationalFunctionSheafMultiply X f.val
  inv := actualRationalFunctionSheafMultiply X f⁻¹.val
  hom_inv_id := by
    rw [← actualRationalFunctionSheafMultiply_mul]
    simpa using actualRationalFunctionSheafMultiply_one X
  inv_hom_id := by
    rw [← actualRationalFunctionSheafMultiply_mul]
    simpa using actualRationalFunctionSheafMultiply_one X

end Litt3.Jacobians
