import Solutions.Jacobians.ActualRationalFunctionEvaluation

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X]

noncomputable local instance actualRationalTopNonempty : Nonempty (⊤ : X.Opens) :=
  ⟨⟨genericPoint X, trivial⟩⟩

/-- Every actual original rational function is an actual global section
of the honest rational-function ring SHEAF. -/
noncomputable def actualRationalFunctionGlobalSection (f : X.functionField) :
    (actualSchemeRationalFunctionRingSheaf X).val.obj (op (⊤ : X.Opens)) :=
  (actualSchemeRationalFunctionOpenIso X ⊤).inv f

/-- Restrict that actual rational section to every original open,
including the empty open, using the genuine sheaf restriction. -/
noncomputable def actualRationalFunctionScalar
    (f : X.functionField) (U : X.Opensᵒᵖ) :
    (actualSchemeRationalFunctionRingSheaf X).val.obj U :=
  (actualSchemeRationalFunctionRingSheaf X).val.map
    (homOfLE (show U.unop ≤ (⊤ : X.Opens) from le_top)).op
      (actualRationalFunctionGlobalSection X f)

theorem actualRationalFunctionScalar_restriction
    (f : X.functionField) {U V : X.Opensᵒᵖ} (i : U ⟶ V) :
    (actualSchemeRationalFunctionRingSheaf X).val.map i
      (actualRationalFunctionScalar X f U) = actualRationalFunctionScalar X f V := by
  unfold actualRationalFunctionScalar
  rw [← ConcreteCategory.comp_apply, ← (actualSchemeRationalFunctionRingSheaf X).val.map_comp]
  rfl

/-- Original-point evaluation of the honest rational scalar section
is exactly the original rational function. -/
theorem actualRationalFunctionScalar_evaluation
    (f : X.functionField) (U : X.Opens) (x : X) (hx : x ∈ U) :
    actualRationalFunctionEvaluation X U x hx (actualRationalFunctionScalar X f (op U)) = f := by
  have h := RingHom.congr_fun
    (actualRationalFunctionEvaluation_restriction X (homOfLE (show U ≤ ⊤ from le_top)) x hx)
    (actualRationalFunctionGlobalSection X f)
  change actualRationalFunctionEvaluation X U x hx
    (actualRationalFunctionScalar X f (op U)) =
      actualRationalFunctionEvaluation X ⊤ x trivial (actualRationalFunctionGlobalSection X f) at h
  rw [h, actualRationalFunctionEvaluation_eq_open]
  exact CategoryTheory.congr_fun (actualSchemeRationalFunctionOpenIso X ⊤).inv_hom_id f

/-- Genuine multiplication of rational functions is an actual original
O_X-module SHEAF endomorphism, natural on the entire original open site. -/
noncomputable def actualRationalFunctionSheafMultiply (f : X.functionField) :
    actualSchemeRationalFunctionModuleSheaf X ⟶ actualSchemeRationalFunctionModuleSheaf X where
  val :=
    { app := fun U => ModuleCat.ofHom
        (X := (actualSchemeRationalFunctionModuleSheaf X).val.obj U)
        (Y := (actualSchemeRationalFunctionModuleSheaf X).val.obj U)
        { toFun := fun a => actualRationalFunctionScalar X f U *
            (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a)
          map_add' := fun a b => by
            change actualRationalFunctionScalar X f U *
                ((show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a) +
                  (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from b)) =
              actualRationalFunctionScalar X f U *
                (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a) +
              actualRationalFunctionScalar X f U *
                (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from b)
            exact mul_add _ _ _
          map_smul' := fun r a => by
            change actualRationalFunctionScalar X f U *
              ((actualSchemeStructureToRationalFunctions X).val.app U r *
                (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a)) =
              (actualSchemeStructureToRationalFunctions X).val.app U r *
                (actualRationalFunctionScalar X f U *
                  (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a))
            exact mul_left_comm _ _ _ }
      naturality := fun {U V} i => by
        apply ModuleCat.hom_ext
        apply DFunLike.ext
        intro a
        change actualRationalFunctionScalar X f V *
          (actualSchemeRationalFunctionRingSheaf X).val.map i
            (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a) =
            (actualSchemeRationalFunctionRingSheaf X).val.map i
              (actualRationalFunctionScalar X f U *
                (show (actualSchemeRationalFunctionRingSheaf X).val.obj U from a))
        rw [(actualSchemeRationalFunctionRingSheaf X).val.map i |>.hom.map_mul,
          actualRationalFunctionScalar_restriction] }

end Litt3.Jacobians
