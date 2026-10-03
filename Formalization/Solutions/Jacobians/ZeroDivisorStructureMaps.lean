import Solutions.Jacobians.SchemeDivisorSheaves

open CategoryTheory Opposite AlgebraicGeometry
open scoped WithZero

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] [ClosedPointDVRStalks X]

/-- The original structure sheaf genuinely maps to the zero-divisor
sheaf through its actual generic germs; its actual sections satisfy
the required true closed-stalk bounds. -/
noncomputable def actualStructureToZeroDivisorSheaf :
    SheafOfModules.unit X.ringCatSheaf ⟶ actualSchemeDivisorSheaf X 0 where
  val :=
    { app := fun U => ModuleCat.ofHom
        (Y := (actualSchemeDivisorSheaf X 0).val.obj U)
        { toFun := fun r => ⟨(actualSchemeStructureToRationalFunctions X).val.app U r, by
            intro x hx
            letI : Nonempty U.unop := ⟨⟨x.val, hx⟩⟩
            change closedPointValuation X x
              (actualRationalFunctionEvaluation X U.unop x.val hx
                ((actualSchemeStructureToRationalFunctions X).val.app U r)) ≤ WithZero.exp (0 : ℤ)
            rw [actualRationalFunctionEvaluation_eq_open]
            have h := CategoryTheory.congr_fun
              (actualSchemeStructureToRationalFunctions_open X U.unop) r
            change (actualSchemeRationalFunctionOpenIso X U.unop).hom
              ((actualSchemeStructureToRationalFunctions X).val.app U r) =
                algebraMap Γ(X, U.unop) X.functionField r at h
            rw [h]
            simpa only [WithZero.exp_zero] using
              actual_section_function_field_valuation_le_one X U.unop r x hx⟩
          map_add' := fun r s => Subtype.ext
            (((actualSchemeStructureToRationalFunctions X).val.app U).hom.map_add r s)
          map_smul' := fun r s => Subtype.ext
            (((actualSchemeStructureToRationalFunctions X).val.app U).hom.map_mul r s) }
      naturality := fun {U V} i => by
        apply ModuleCat.hom_ext
        apply DFunLike.ext
        intro r
        apply Subtype.ext
        exact CategoryTheory.congr_fun ((actualSchemeStructureToRationalFunctions X).val.naturality i) r }

end Litt3.Jacobians
