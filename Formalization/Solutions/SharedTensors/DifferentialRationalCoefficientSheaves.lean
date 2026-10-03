import Solutions.SharedTensors.RationalLineCoordinates
import Solutions.SharedTensors.SmoothSchemeDifferentials
import Solutions.SharedTensors.SchemeDifferentialSheafLinearity
import Solutions.Jacobians.RationalFunctionOpenLinearEquivalence
import Solutions.Jacobians.RationalFunctionOpenValues
import Solutions.Jacobians.OriginalModuleSheafEmptySections

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u
variable {k : Type u} [Field k] {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- The coefficient of an ORIGINAL sheaf differential relative to the
SAME nonzero original rational form, linear over the original open ring. -/
noncomputable def actualDifferentialRationalCoefficient :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (U : X.Opens) [Nonempty U],
      (schemeDifferentialSheaf sX).val.obj (op U) →ₗ[Γ(X, U)] X.functionField := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h U _
  let e := normalizedRationalLineCoordinate (actualSmoothCurveKaehlerCoordinate sX) omega h
  exact
    { toFun := fun a => e (schemeDifferentialSheafOpenToFunctionField sX U a)
      map_add' := by intro a b; rw [map_add, map_add]
      map_smul' := by
        intro r a
        rw [schemeDifferentialSheafOpenToFunctionField_smul, map_smul]
        rfl }

/-- The actual rational-function SHEAF receives the original differential
coefficient on EVERY open, including the true zero section on empty opens. -/
noncomputable def actualDifferentialRationalSectionMap :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (U : X.Opens),
      (schemeDifferentialSheaf sX).val.obj (op U) →ₗ[Γ(X, U)]
        (actualSchemeRationalFunctionModuleSheaf X).val.obj (op U) := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h U
  exact if hU : Nonempty U then
    letI := hU
    (actualRationalFunctionOpenLinearEquiv X U).symm.toLinearMap.comp
      (actualDifferentialRationalCoefficient sX omega h U)
    else 0

theorem actual_differential_rational_section_field_value :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (U : X.Opens) [Nonempty U] (a : (schemeDifferentialSheaf sX).val.obj (op U)),
      actualRationalFunctionOpenLinearEquiv X U
          (actualDifferentialRationalSectionMap sX omega h U a) =
        normalizedRationalLineCoordinate (actualSmoothCurveKaehlerCoordinate sX) omega h
          (schemeDifferentialSheafOpenToFunctionField sX U a) := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h U _ a
  simp only [actualDifferentialRationalSectionMap,
    dif_pos (inferInstance : Nonempty U), LinearMap.comp_apply]
  exact (actualRationalFunctionOpenLinearEquiv X U).apply_symm_apply _

/-- Genuine global ORIGINAL module-sheaf map to rational coefficients,
with every original restriction square proved. No local freeness of the
differential SHEAF or sheaf/divisor identification is an input. -/
noncomputable def actualDifferentialSheafToRational :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0),
      schemeDifferentialSheaf sX ⟶ actualSchemeRationalFunctionModuleSheaf X := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h
  exact
    { val :=
      { app := fun U => ModuleCat.ofHom
          (X := (schemeDifferentialSheaf sX).val.obj U)
          (Y := (actualSchemeRationalFunctionModuleSheaf X).val.obj U)
          (actualDifferentialRationalSectionMap sX omega h U.unop)
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
                (actualDifferentialRationalSectionMap sX omega h V.unop
                  ((schemeDifferentialSheaf sX).val.map i a)) =
              actualRationalFunctionOpenLinearEquiv X V.unop
                ((actualSchemeRationalFunctionModuleSheaf X).val.map i
                  (actualDifferentialRationalSectionMap sX omega h U.unop a))
            rw [actual_differential_rational_section_field_value]
            have hres := actualRationalFunctionOpenValue_restriction X i.unop
              (actualDifferentialRationalSectionMap sX omega h U.unop a)
            change actualRationalFunctionOpenLinearEquiv X V.unop
                ((actualSchemeRationalFunctionModuleSheaf X).val.map i
                  (actualDifferentialRationalSectionMap sX omega h U.unop a)) =
              actualRationalFunctionOpenLinearEquiv X U.unop
                (actualDifferentialRationalSectionMap sX omega h U.unop a) at hres
            rw [hres, actual_differential_rational_section_field_value]
            apply congrArg (normalizedRationalLineCoordinate
              (actualSmoothCurveKaehlerCoordinate sX) omega h)
            exact congrArg (fun f => f.hom a)
              (schemeDifferentialSheafOpenToFunctionField_restriction sX i.unop)
          · letI := actualOriginalModuleSheaf_empty_sections_subsingleton X
              (actualSchemeRationalFunctionModuleSheaf X) V.unop hV
            exact @Subsingleton.elim
              ((actualSchemeRationalFunctionModuleSheaf X).val.obj V) inferInstance _ _ } }

end Litt3.SharedTensors
