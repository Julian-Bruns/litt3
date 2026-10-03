import Solutions.SharedTensors.DifferentialDivisorCoefficientBounds
import Solutions.SharedTensors.DifferentialRationalCoefficientSheaves
import Solutions.SharedTensors.SchemeDifferentialOpenRecovery
import Solutions.Jacobians.SchemeDivisorSheaves

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] [CompactSpace X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- The actual original coefficient of every genuine differential
section satisfies the derived divisor bounds on EVERY original open. -/
theorem actual_differential_rational_section_mem_divisor :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (U : X.Opens) (a : (schemeDifferentialSheaf sX).val.obj (op U)),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      actualDifferentialRationalSectionMap sX omega h U a ∈
        actualSchemeDivisorOpenSubmodule X (actualRationalDifferentialDivisor sX omega h) (op U) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h U a
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  intro x hx
  letI : Nonempty U := ⟨⟨x.val, hx⟩⟩
  change closedPointValuation X x
    (actualRationalFunctionEvaluation X U x.val hx
      (actualDifferentialRationalSectionMap sX omega h U a)) ≤ _
  rw [actualRationalFunctionEvaluation_eq_open]
  change closedPointValuation X x
    (actualRationalFunctionOpenLinearEquiv X U
      (actualDifferentialRationalSectionMap sX omega h U a)) ≤ _
  rw [actual_differential_rational_section_field_value]
  apply (actual_differential_coefficient_bound_iff_regular sX omega h _ x).mpr
  rw [normalized_rational_line_coordinate_reconstruction]
  exact schemeDifferentialSheafOpenToFunctionField_mem_local sX U ⟨x.val, hx⟩ a

/-- The GLOBAL original module-sheaf map to the constructed divisor
sheaf, with literal original coefficient maps and every restriction square. -/
noncomputable def actualDifferentialSheafToDivisor :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      schemeDifferentialSheaf sX ⟶
        actualSchemeDivisorSheaf X (actualRationalDifferentialDivisor sX omega h) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  exact
    { val :=
      { app := fun U => ModuleCat.ofHom
          (X := (schemeDifferentialSheaf sX).val.obj U)
          (Y := (actualSchemeDivisorSheaf X
            (actualRationalDifferentialDivisor sX omega h)).val.obj U)
          ((actualDifferentialRationalSectionMap sX omega h U.unop).codRestrict
            (actualSchemeDivisorOpenSubmodule X
              (actualRationalDifferentialDivisor sX omega h) U)
            (actual_differential_rational_section_mem_divisor sX omega h U.unop))
        naturality := fun i => by
          apply ModuleCat.hom_ext
          apply LinearMap.ext
          intro a
          apply Subtype.ext
          exact CategoryTheory.congr_fun
            ((actualDifferentialSheafToRational sX omega h).val.naturality i) a } }

/-- Injectivity is genuine generic realization and actual field-line
injectivity, including the true zero section module on empty opens. -/
theorem actual_differential_sheaf_to_divisor_app_injective :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0) (U : X.Opens),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      Function.Injective ((actualDifferentialSheafToDivisor sX omega h).val.app (op U)) := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h U
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  by_cases hU : Nonempty U
  · letI := hU
    intro a b hab
    have hv := congrArg (fun c => actualRationalFunctionOpenLinearEquiv X U c.val) hab
    change actualRationalFunctionOpenLinearEquiv X U
        (actualDifferentialRationalSectionMap sX omega h U a) =
      actualRationalFunctionOpenLinearEquiv X U
        (actualDifferentialRationalSectionMap sX omega h U b) at hv
    rw [actual_differential_rational_section_field_value,
      actual_differential_rational_section_field_value] at hv
    exact schemeDifferentialSheafOpenToFunctionField_injective sX 1 U
      ((normalizedRationalLineCoordinate (actualSmoothCurveKaehlerCoordinate sX) omega h).injective hv)
  · letI := actualOriginalModuleSheaf_empty_sections_subsingleton X (schemeDifferentialSheaf sX) U hU
    intro a b _
    exact Subsingleton.elim _ _

end Litt3.SharedTensors
