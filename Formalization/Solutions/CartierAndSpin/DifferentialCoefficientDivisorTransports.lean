import Solutions.SharedTensors.DifferentialDivisorSheafIsomorphisms
import Solutions.CartierAndSpin.SmoothEtaleDifferentialSheafPullbacks

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.Jacobians Litt3.QuotientGeometry

section Fields

variable {k F E : Type*} [Field k] [Field F] [Field E]
  [Algebra k F] [Algebra k E] [Algebra F E] [IsScalarTower k F E]

/-- Normalizing by the ORIGINAL pulled reference form makes rational
coefficients commute with the literal universal map. The two genuine
field coordinates may be arbitrary; no compatible-frame input is used. -/
theorem actual_normalized_differential_coefficient_pullback
    (eF : KaehlerDifferential k F ≃ₗ[F] F)
    (eE : KaehlerDifferential k E ≃ₗ[E] E)
    (omega : KaehlerDifferential k F) (h : omega ≠ 0)
    (hmap : KaehlerDifferential.map k k F E omega ≠ 0)
    (eta : KaehlerDifferential k F) :
    normalizedRationalLineCoordinate eE
        (KaehlerDifferential.map k k F E omega) hmap
        (KaehlerDifferential.map k k F E eta) =
      algebraMap F E (normalizedRationalLineCoordinate eF omega h eta) := by
  have hform := normalized_rational_line_coordinate_reconstruction eF omega h eta
  conv_lhs => rw [← hform]
  rw [map_smul, ← IsScalarTower.algebraMap_smul (R := F) E,
    map_smul, normalized_rational_line_coordinate_vector, smul_eq_mul, mul_one]

end Fields

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] [CompactSpace X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- Transport the literal original differential coefficient map to an
equal divisor. Equality is only bookkeeping in this helper; actual
finite-etale divisor transport supplies it in the application. -/
noncomputable def actualDifferentialSheafToEqualDivisor :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (D : Divisor (ClosedPoint X)) (hD : actualRationalDifferentialDivisor sX omega h = D),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      schemeDifferentialSheaf sX ⟶ actualSchemeDivisorSheaf X D := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h D hD
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  exact
    { val :=
      { app := fun U => ModuleCat.ofHom
          (X := (schemeDifferentialSheaf sX).val.obj U)
          (Y := (actualSchemeDivisorSheaf X D).val.obj U)
          ((actualDifferentialRationalSectionMap sX omega h U.unop).codRestrict
            (actualSchemeDivisorOpenSubmodule X D U) (by
              intro a
              rw [← hD]
              exact actual_differential_rational_section_mem_divisor sX omega h U.unop a))
        naturality := fun i => by
          apply ModuleCat.hom_ext
          apply LinearMap.ext
          intro a
          apply Subtype.ext
          exact CategoryTheory.congr_fun
            ((actualDifferentialSheafToRational sX omega h).val.naturality i) a } }

theorem actual_differential_equal_divisor_app_bijective :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (D : Divisor (ClosedPoint X)) (hD : actualRationalDifferentialDivisor sX omega h = D)
      (U : X.Opens),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      Function.Bijective ((actualDifferentialSheafToEqualDivisor sX omega h D hD).val.app
        (op U)).hom := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h D hD U
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  subst D
  exact actual_differential_sheaf_to_divisor_app_bijective sX omega h U

/-- The same original normalized coefficient map is a genuine
whole-sheaf isomorphism after transport to an equal divisor. -/
noncomputable def actualDifferentialEqualDivisorSheafIso :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (D : Divisor (ClosedPoint X)) (hD : actualRationalDifferentialDivisor sX omega h = D),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      schemeDifferentialSheaf sX ≅ actualSchemeDivisorSheaf X D := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h D hD
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  let theta := actualDifferentialSheafToEqualDivisor sX omega h D hD
  let e : (schemeDifferentialSheaf sX).val ≅ (actualSchemeDivisorSheaf X D).val :=
    PresheafOfModules.isoMk
      (fun U => (LinearEquiv.ofBijective (theta.val.app U).hom
        (actual_differential_equal_divisor_app_bijective sX omega h D hD U.unop)).toModuleIso)
      (fun _ _ i => theta.val.naturality i)
  exact
    { hom := ⟨e.hom⟩
      inv := ⟨e.inv⟩
      hom_inv_id := SheafOfModules.hom_ext e.hom_inv_id
      inv_hom_id := SheafOfModules.hom_ext e.inv_hom_id }

theorem actualDifferentialEqualDivisorSheafIso_hom :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0)
      (D : Divisor (ClosedPoint X)) (hD : actualRationalDifferentialDivisor sX omega h = D),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      (actualDifferentialEqualDivisorSheafIso sX omega h D hD).hom =
        actualDifferentialSheafToEqualDivisor sX omega h D hD := by
  intros
  rfl

end Litt3.CartierAndSpin
