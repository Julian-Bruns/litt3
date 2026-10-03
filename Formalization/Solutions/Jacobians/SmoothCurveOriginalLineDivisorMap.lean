import Solutions.Jacobians.SmoothCurveOriginalLineSectionBounds
import Solutions.Jacobians.OriginalLineSheafRationalEmbedding
import Solutions.Jacobians.SchemeDivisorSheaves

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.Jacobians

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] [QuasiCompact sX]
  (M : X.Modules) (hM : ActualOriginalLineSheaf X M)

/-- The original rational embedding of ANY original line sheaf
lands in the literal section submodules of its DERIVED divisor on EVERY
original open, including empty opens. -/
theorem actualSmoothCurveOriginalLineRationalSection_mem_divisor
    (U : X.Opens) (a : M.val.obj (op U)) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    actualOriginalLineSheafRationalSectionMap X M hM U a ∈
      actualSchemeDivisorOpenSubmodule X
        (actualSmoothCurveOriginalLineDivisor sX M hM) (op U) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  intro x hx
  letI : Nonempty U := ⟨⟨x.val, hx⟩⟩
  change closedPointValuation X x
    (actualRationalFunctionEvaluation X U x.val hx
      (actualOriginalLineSheafRationalSectionMap X M hM U a)) ≤ _
  rw [actualRationalFunctionEvaluation_eq_open]
  change closedPointValuation X x
    (actualRationalFunctionOpenLinearEquiv X U
      (actualOriginalLineSheafRationalSectionMap X M hM U a)) ≤ _
  rw [actualOriginalLineSheafRationalSectionMap_field_value]
  exact actualSmoothCurveOriginalLine_section_valuation_bound sX M hM U a x hx

/-- The constructed genuine original GLOBAL line-to-divisor SHEAF
map. Its entire section maps are the literal original rational embedding
with proven true divisor bounds; EVERY restriction square is original. -/
noncomputable def actualSmoothCurveOriginalLineToDivisor :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    M ⟶ actualSchemeDivisorSheaf X (actualSmoothCurveOriginalLineDivisor sX M hM) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  exact
    { val :=
      { app := fun U => ModuleCat.ofHom
          (X := M.val.obj U)
          (Y := (actualSchemeDivisorSheaf X
            (actualSmoothCurveOriginalLineDivisor sX M hM)).val.obj U)
          ((actualOriginalLineSheafRationalSectionMap X M hM U.unop).codRestrict
            (actualSchemeDivisorOpenSubmodule X
              (actualSmoothCurveOriginalLineDivisor sX M hM) U)
            (actualSmoothCurveOriginalLineRationalSection_mem_divisor sX M hM U.unop))
        naturality := fun i => by
          apply ModuleCat.hom_ext
          apply LinearMap.ext
          intro a
          apply Subtype.ext
          exact CategoryTheory.congr_fun
            ((actualOriginalLineSheafToRational X M hM).val.naturality i) a } }

/-- The true original line-to-divisor map is injective on ENTIRE
section modules for ALL original opens, including the empty open. -/
theorem actualSmoothCurveOriginalLineToDivisor_app_injective
    (U : X.Opens) :
    letI : ClosedPointDVRStalks X :=
      Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
    Function.Injective ((actualSmoothCurveOriginalLineToDivisor sX M hM).val.app (op U)) := by
  letI : ClosedPointDVRStalks X :=
    Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr_stalks sX
  intro a b hab
  exact actualOriginalLineSheafToRational_app_injective X M hM U
    (congrArg Subtype.val hab)

end Litt3.Jacobians
