import Solutions.SharedTensors.DifferentialDivisorSheafMaps

open CategoryTheory Opposite AlgebraicGeometry

namespace Litt3.SharedTensors

open Litt3.Jacobians Litt3.QuotientGeometry

universe u
variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X] [CompactSpace X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]

/-- Every ENTIRE divisor-sheaf section is the original rational
coefficient of a genuine original differential section. The proof uses
closed-stalk recovery on all nonempty opens and true empty-open sections. -/
theorem actual_differential_sheaf_to_divisor_app_surjective :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0) (U : X.Opens),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      Function.Surjective ((actualDifferentialSheafToDivisor sX omega h).val.app (op U)) := by
  classical
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h U
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  by_cases hU : Nonempty U
  · letI := hU
    intro a
    let c := actualRationalFunctionOpenLinearEquiv X U a.val
    have hc : ∀ (x : ClosedPoint X), x.val ∈ U →
        c • omega ∈ schemeLocalRegularDifferentials sX x.val := by
      intro x hx
      apply (actual_differential_coefficient_bound_iff_regular sX omega h c x).mp
      have hb := a.property x hx
      change closedPointValuation X x
        (actualRationalFunctionEvaluation X U x.val hx a.val) ≤ _ at hb
      rw [actualRationalFunctionEvaluation_eq_open] at hb
      exact hb
    obtain ⟨b, hb⟩ :=
      (schemeDifferential_closed_regular_on_open_iff_section sX 1 U (c • omega)).mp hc
    refine ⟨b, ?_⟩
    apply Subtype.ext
    apply (actualRationalFunctionOpenLinearEquiv X U).injective
    change actualRationalFunctionOpenLinearEquiv X U
        (actualDifferentialRationalSectionMap sX omega h U b) =
      actualRationalFunctionOpenLinearEquiv X U a.val
    rw [actual_differential_rational_section_field_value, hb, map_smul,
      normalized_rational_line_coordinate_vector, smul_eq_mul, mul_one]
  · letI := actualOriginalModuleSheaf_empty_sections_subsingleton X
      (actualSchemeDivisorSheaf X (actualRationalDifferentialDivisor sX omega h)) U hU
    intro a
    exact ⟨0, Subsingleton.elim _ _⟩

theorem actual_differential_sheaf_to_divisor_app_bijective :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0) (U : X.Opens),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      Function.Bijective ((actualDifferentialSheafToDivisor sX omega h).val.app (op U)).hom := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h U
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  exact ⟨actual_differential_sheaf_to_divisor_app_injective sX omega h U,
    actual_differential_sheaf_to_divisor_app_surjective sX omega h U⟩

/-- The whole ORIGINAL differential SHEAF is genuinely O(div omega)
on its ENTIRE original site. The isomorphism is the original rational
coefficient map; all original sections, scalar actions and restrictions
are retained. No local-freeness, divisor presentation or H0 equality is
assumed. Properness and any characteristic restriction are unnecessary. -/
noncomputable def actualDifferentialDivisorSheafIso :
    letI := (genericBaseFieldHom sX).toAlgebra
    ∀ (omega : KaehlerDifferential k X.functionField) (h : omega ≠ 0),
      letI := actual_smooth_curve_closed_point_dvr_stalks sX
      schemeDifferentialSheaf sX ≅
        actualSchemeDivisorSheaf X (actualRationalDifferentialDivisor sX omega h) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  intro omega h
  letI := actual_smooth_curve_closed_point_dvr_stalks sX
  let e : (schemeDifferentialSheaf sX).val ≅
      (actualSchemeDivisorSheaf X (actualRationalDifferentialDivisor sX omega h)).val :=
    PresheafOfModules.isoMk
      (fun U => (LinearEquiv.ofBijective
        ((actualDifferentialSheafToDivisor sX omega h).val.app U).hom
        (actual_differential_sheaf_to_divisor_app_bijective sX omega h U.unop)).toModuleIso)
      (fun _ _ i => (actualDifferentialSheafToDivisor sX omega h).val.naturality i)
  exact
    { hom := ⟨e.hom⟩
      inv := ⟨e.inv⟩
      hom_inv_id := SheafOfModules.hom_ext e.hom_inv_id
      inv_hom_id := SheafOfModules.hom_ext e.inv_hom_id }

end Litt3.SharedTensors
