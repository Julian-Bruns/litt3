import Solutions.CartierAndSpin.DifferentialCoefficientDivisorTransports
import Solutions.Jacobians.SmoothCurveDivisorCategoricalPullbacks

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 100000

open CategoryTheory Opposite AlgebraicGeometry TopologicalSpace

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry Litt3.Jacobians

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
  (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
  (hover : f ≫ sY = sX)

/-- The TRUE categorical original differential pullback map, obtained
from the actual original section/sheaf map by its genuine adjunction. -/
noncomputable def actualSmoothEtaleDifferentialCategoricalPullbackMap :
    (actualSchemeModulePullback f).obj (schemeDifferentialSheaf sY) ⟶
      schemeDifferentialSheaf sX :=
  ((SheafOfModules.pullbackPushforwardAdjunction (actualSchemeRingSheafMap f)).homEquiv
    _ _).symm (actualSmoothEtaleDifferentialSheafPullbackMap sX sY f hover)

variable [CompactSpace X] [CompactSpace Y]

/-- The actual differential SHEAF map and the original divisor SHEAF
map commute with their ENTIRE original normalized coefficient maps.
The reference on the source is the actual pulled original form, and its
divisor transport is derived. No chosen-map compatibility is supplied. -/
theorem actual_smooth_etale_differential_coefficient_sheaf_square :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI := (genericBaseFieldHom sY).toAlgebra
    letI := (schemeFunctionFieldPullback f).toAlgebra
    letI := actualFunctionFieldBaseTower f sY sX hover
    letI := actual_smooth_curve_closed_point_dvr_stalks sX
    letI := actual_smooth_curve_closed_point_dvr_stalks sY
    ∀ (omega : KaehlerDifferential k Y.functionField) (h : omega ≠ 0),
      actualDifferentialSheafToEqualDivisor sY omega h
          (actualRationalDifferentialDivisor sY omega h) rfl ≫
        actualSchemeDivisorSheafToPushforward f (actualRationalDifferentialDivisor sY omega h) =
      actualSmoothEtaleDifferentialSheafPullbackMap sX sY f hover ≫
        (SheafOfModules.pushforward (actualSchemeRingSheafMap f)).map
          (actualDifferentialSheafToEqualDivisor sX
            (KaehlerDifferential.map k k Y.functionField X.functionField omega)
            (actual_smooth_etale_rational_differential_pullback_ne_zero sX sY f hover omega h)
            (schemeDivisorPullback f (actualRationalDifferentialDivisor sY omega h))
            (actual_smooth_etale_rational_differential_divisor_pullback sX sY f hover omega h)) := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sY
  intro omega h
  apply SheafOfModules.hom_ext
  apply PresheafOfModules.hom_ext
  intro U
  apply ModuleCat.hom_ext
  apply LinearMap.ext
  intro a
  by_cases hU : Nonempty U.unop
  · letI := hU
    letI := actualSchemeNonemptyPreimageOpen f U.unop
    apply Subtype.ext
    apply (actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ U.unop)).injective
    change actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ U.unop)
        (actualSchemeDivisorSectionPullbackMap f (actualRationalDifferentialDivisor sY omega h)
          U.unop ((actualDifferentialSheafToEqualDivisor sY omega h
            (actualRationalDifferentialDivisor sY omega h) rfl).val.app U a)).val =
      actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ U.unop)
        (actualDifferentialRationalSectionMap sX
          (KaehlerDifferential.map k k Y.functionField X.functionField omega)
          (actual_smooth_etale_rational_differential_pullback_ne_zero sX sY f hover omega h)
          (f ⁻¹ᵁ U.unop) (actualSmoothEtaleDifferentialOpenPullback sX sY f hover U.unop a))
    rw [actualSchemeDivisorSectionPullbackMap_rational_value]
    change actualRationalFunctionOpenLinearEquiv X (f ⁻¹ᵁ U.unop)
        (actualSchemeRationalSectionPullback f U.unop
          (actualDifferentialRationalSectionMap sY omega h U.unop a)) = _
    rw [actualSchemeRationalSectionPullback_field_value,
      actual_differential_rational_section_field_value,
      actual_differential_rational_section_field_value,
      actualSmoothEtaleDifferentialOpenPullback_rational]
    exact (actual_normalized_differential_coefficient_pullback
      (actualSmoothCurveKaehlerCoordinate sY) (actualSmoothCurveKaehlerCoordinate sX)
      omega h (actual_smooth_etale_rational_differential_pullback_ne_zero sX sY f hover omega h)
      (schemeDifferentialSheafOpenToFunctionField sY U.unop a)).symm
  · have hpre : ¬Nonempty (f ⁻¹ᵁ U.unop) := by
      rintro ⟨x⟩
      exact hU ⟨⟨f x.val, x.property⟩⟩
    letI := actualOriginalModuleSheaf_empty_sections_subsingleton X
      (actualSchemeDivisorSheaf X
        (schemeDivisorPullback f (actualRationalDifferentialDivisor sY omega h)))
      (f ⁻¹ᵁ U.unop) hpre
    letI : Subsingleton ↑(((SheafOfModules.pushforward (actualSchemeRingSheafMap f)).obj
        (actualSchemeDivisorSheaf X
          (schemeDivisorPullback f (actualRationalDifferentialDivisor sY omega h)))).val.obj U) := by
      change Subsingleton ↑((actualSchemeDivisorSheaf X
        (schemeDivisorPullback f (actualRationalDifferentialDivisor sY omega h))).val.obj
          (op (f ⁻¹ᵁ U.unop)))
      infer_instance
    exact Subsingleton.elim _ _

/-- The ACTUAL adjoint of the original universal differential SHEAF
map is a whole-sheaf isomorphism. Original coefficient-map compatibility,
derived differential divisor transport and the true categorical divisor
pullback isomorphism prove this for the canonical morphism itself. -/
theorem actual_smooth_etale_differential_categorical_pullback_map_isIso :
    IsIso (actualSmoothEtaleDifferentialCategoricalPullbackMap sX sY f hover) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI := (genericBaseFieldHom sY).toAlgebra
  letI := (schemeFunctionFieldPullback f).toAlgebra
  letI := actualFunctionFieldBaseTower f sY sX hover
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  letI := actual_smooth_curve_closed_point_dvr_stalks sY
  letI : QuasiCompact sX := inferInstance
  letI : QuasiCompact sY := inferInstance
  let e := actualSmoothCurveKaehlerCoordinate sY
  let omega := e.symm 1
  have h : omega ≠ 0 := by
    intro hz
    have hh := congrArg e hz
    simp only [omega, e.apply_symm_apply, map_zero] at hh
    exact one_ne_zero hh
  let D := actualRationalDifferentialDivisor sY omega h
  let thetaY := actualDifferentialSheafToEqualDivisor sY omega h D rfl
  let thetaX := actualDifferentialSheafToEqualDivisor sX
    (KaehlerDifferential.map k k Y.functionField X.functionField omega)
    (actual_smooth_etale_rational_differential_pullback_ne_zero sX sY f hover omega h)
    (schemeDivisorPullback f D)
    (actual_smooth_etale_rational_differential_divisor_pullback sX sY f hover omega h)
  letI : IsIso thetaY := by
    dsimp only [thetaY]
    rw [← actualDifferentialEqualDivisorSheafIso_hom sY omega h D rfl]
    infer_instance
  letI : IsIso thetaX := by
    dsimp only [thetaX]
    rw [← actualDifferentialEqualDivisorSheafIso_hom sX
      (KaehlerDifferential.map k k Y.functionField X.functionField omega)
      (actual_smooth_etale_rational_differential_pullback_ne_zero sX sY f hover omega h)
      (schemeDivisorPullback f D)
      (actual_smooth_etale_rational_differential_divisor_pullback sX sY f hover omega h)]
    infer_instance
  letI : IsIso (actualSchemeDivisorSheafPullbackMap f D) :=
    actual_smooth_curve_divisor_sheaf_pullback_map_isIso sX sY f D
  let adj := SheafOfModules.pullbackPushforwardAdjunction (actualSchemeRingSheafMap f)
  have hs := actual_smooth_etale_differential_coefficient_sheaf_square sX sY f hover omega h
  have hc := congrArg (fun g => (adj.homEquiv (schemeDifferentialSheaf sY)
    (actualSchemeDivisorSheaf X (schemeDivisorPullback f D))).symm g) hs
  dsimp only at hc
  rw [adj.homEquiv_naturality_left_symm, adj.homEquiv_naturality_right_symm] at hc
  change (actualSchemeModulePullback f).map thetaY ≫ actualSchemeDivisorSheafPullbackMap f D =
    actualSmoothEtaleDifferentialCategoricalPullbackMap sX sY f hover ≫ thetaX at hc
  letI : IsIso (actualSmoothEtaleDifferentialCategoricalPullbackMap sX sY f hover ≫ thetaX) := by
    rw [← hc]
    infer_instance
  exact IsIso.of_isIso_comp_right
    (actualSmoothEtaleDifferentialCategoricalPullbackMap sX sY f hover) thetaX

/-- The genuine categorical original differential SHEAF pullback iso
whose hom is the ACTUAL original universal differential adjunction map. -/
noncomputable def actualSmoothEtaleDifferentialCategoricalPullbackIso :
    (actualSchemeModulePullback f).obj (schemeDifferentialSheaf sY) ≅
      schemeDifferentialSheaf sX := by
  letI := actual_smooth_etale_differential_categorical_pullback_map_isIso sX sY f hover
  exact asIso (actualSmoothEtaleDifferentialCategoricalPullbackMap sX sY f hover)

theorem actualSmoothEtaleDifferentialCategoricalPullbackIso_hom :
    (actualSmoothEtaleDifferentialCategoricalPullbackIso sX sY f hover).hom =
      actualSmoothEtaleDifferentialCategoricalPullbackMap sX sY f hover := rfl

end Litt3.CartierAndSpin
