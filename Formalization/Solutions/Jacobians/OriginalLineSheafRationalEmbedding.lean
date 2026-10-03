import Solutions.Jacobians.OriginalLineSheafGenericRestrictions
import Solutions.Jacobians.OriginalModuleSheafEmptySections
import Solutions.Jacobians.RationalFunctionOpenLinearEquivalence
import Solutions.Jacobians.RationalFunctionOpenValues

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable (X : Scheme.{u}) [IsIntegral X] (M : X.Modules)
  (hM : ActualOriginalLineSheaf X M)

/-- Literal ORIGINAL rational sections from arbitrary actual
line-sheaf sections on EVERY original open, including the genuine
zero module on the empty open. -/
noncomputable def actualOriginalLineSheafRationalSectionMap
    (U : X.Opens) :
    M.val.obj (op U) →ₗ[Γ(X, U)]
      (actualSchemeRationalFunctionModuleSheaf X).val.obj (op U) := by
  classical
  exact if h : Nonempty U then
    letI := h
    (actualRationalFunctionOpenLinearEquiv X U).symm.toLinearMap.comp
      (actualOriginalLineSheafGenericValue X M hM U)
    else 0

theorem actualOriginalLineSheafRationalSectionMap_field_value
    (U : X.Opens) [Nonempty U] (a : M.val.obj (op U)) :
    actualRationalFunctionOpenLinearEquiv X U
      (actualOriginalLineSheafRationalSectionMap X M hM U a) =
        actualOriginalLineSheafGenericValue X M hM U a := by
  classical
  simp only [actualOriginalLineSheafRationalSectionMap,
    dif_pos (inferInstance : Nonempty U), LinearMap.comp_apply]
  exact (actualRationalFunctionOpenLinearEquiv X U).apply_symm_apply _

/-- An arbitrary ACTUAL original line SHEAF on ANY integral Scheme
has a constructed genuine GLOBAL module-SHEAF map into the original
rational-function SHEAF. The original generic frame and every restriction
square are DERIVED from local freeness, including the empty-open square. -/
noncomputable def actualOriginalLineSheafToRational :
    M ⟶ actualSchemeRationalFunctionModuleSheaf X where
  val :=
    { app := fun U => ModuleCat.ofHom
        (X := M.val.obj U)
        (Y := (actualSchemeRationalFunctionModuleSheaf X).val.obj U)
        (actualOriginalLineSheafRationalSectionMap X M hM U.unop)
      naturality := fun {U V} i => by
        classical
        apply ModuleCat.hom_ext
        apply LinearMap.ext
        intro a
        by_cases hV : Nonempty V.unop
        · letI := hV
          let x : V.unop := Classical.arbitrary V.unop
          letI : Nonempty U.unop := ⟨⟨x.val, i.unop.le x.property⟩⟩
          apply (actualRationalFunctionOpenLinearEquiv X V.unop).injective
          change actualRationalFunctionOpenLinearEquiv X V.unop
              (actualOriginalLineSheafRationalSectionMap X M hM V.unop (M.val.map i a)) =
            actualRationalFunctionOpenLinearEquiv X V.unop
              ((actualSchemeRationalFunctionModuleSheaf X).val.map i
                (actualOriginalLineSheafRationalSectionMap X M hM U.unop a))
          rw [actualOriginalLineSheafRationalSectionMap_field_value]
          have hgeneric :
              actualOriginalLineSheafGenericValue X M hM V.unop (M.val.map i a) =
                actualOriginalLineSheafGenericValue X M hM U.unop a :=
            actualOriginalLineSheafGenericValue_restriction X M hM i.unop a
          rw [hgeneric]
          have hres := actualRationalFunctionOpenValue_restriction X i.unop
            (actualOriginalLineSheafRationalSectionMap X M hM U.unop a)
          change actualRationalFunctionOpenLinearEquiv X V.unop
              ((actualSchemeRationalFunctionModuleSheaf X).val.map i
                (actualOriginalLineSheafRationalSectionMap X M hM U.unop a)) =
            actualRationalFunctionOpenLinearEquiv X U.unop
              (actualOriginalLineSheafRationalSectionMap X M hM U.unop a) at hres
          rw [hres, actualOriginalLineSheafRationalSectionMap_field_value]
        · letI := actualOriginalModuleSheaf_empty_sections_subsingleton X
            (actualSchemeRationalFunctionModuleSheaf X) V.unop hV
          exact @Subsingleton.elim
            ((actualSchemeRationalFunctionModuleSheaf X).val.obj V) inferInstance _ _ }

/-- The constructed genuine GLOBAL rational embedding is injective
on EVERY ENTIRE original section module, including the empty open. -/
theorem actualOriginalLineSheafToRational_app_injective
    (U : X.Opens) :
    Function.Injective ((actualOriginalLineSheafToRational X M hM).val.app (op U)) := by
  classical
  by_cases hU : Nonempty U
  · letI := hU
    intro a b hab
    apply actualOriginalLineSheafGenericValue_injective X M hM U
    have h := congrArg (actualRationalFunctionOpenLinearEquiv X U) hab
    change actualRationalFunctionOpenLinearEquiv X U
        (actualOriginalLineSheafRationalSectionMap X M hM U a) =
      actualRationalFunctionOpenLinearEquiv X U
        (actualOriginalLineSheafRationalSectionMap X M hM U b) at h
    rwa [actualOriginalLineSheafRationalSectionMap_field_value,
      actualOriginalLineSheafRationalSectionMap_field_value] at h
  · letI := actualOriginalModuleSheaf_empty_sections_subsingleton X M U hU
    intro a b _
    exact Subsingleton.elim _ _

end Litt3.Jacobians
