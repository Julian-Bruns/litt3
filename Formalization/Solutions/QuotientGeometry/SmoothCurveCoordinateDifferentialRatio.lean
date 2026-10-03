import Solutions.QuotientGeometry.OriginalCoordinateDifferentialRatio
import Solutions.SharedTensors.SchemeRegularDifferentials

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

/-- On the ORIGINAL smooth curve stalk, a nonvanishing form dz/y
constructs the genuine coordinate derivation, proves F_z is an actual
unit, and computes sigma/dF in the ACTUAL residue field. No polynomial
presentation of F or supplied local differential frame is needed. -/
theorem actual_smooth_curve_coordinate_differential_residue_ratio
    {k : Type u} [Field k] [IsAlgClosed k]
    {X : Scheme.{u}} [IsIntegral X]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    {p : ℕ} [Fact p.Prime] [CharP k p] (x : ClosedPoint X) :
    letI := (stalkBaseFieldHom sX x.val).toAlgebra
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
      IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
    letI := actual_smooth_curve_closed_point_dvr sX x
    ∀ (d : DVRCompletionParameters k (X.presheaf.stalk x.val))
      (z : X.presheaf.stalk x.val) (y : (X.presheaf.stalk x.val)ˣ)
      (sigma : KaehlerDifferential k X.functionField),
      sigma ∈ schemeLocalRegularDifferentials sX x.val →
      (∀ omega : KaehlerDifferential k (X.presheaf.stalk x.val),
        KaehlerDifferential.map k k (X.presheaf.stalk x.val) X.functionField omega = sigma →
        omega ∉ IsLocalRing.maximalIdeal (X.presheaf.stalk x.val) •
          (⊤ : Submodule (X.presheaf.stalk x.val)
            (KaehlerDifferential k (X.presheaf.stalk x.val)))) →
      sigma =
        algebraMap (X.presheaf.stalk x.val) X.functionField (y⁻¹ : (X.presheaf.stalk x.val)ˣ).val •
          KaehlerDifferential.D k X.functionField
            (algebraMap (X.presheaf.stalk x.val) X.functionField z) →
      ∃ (S v : (X.presheaf.stalk x.val)ˣ)
        (D : Derivation k (X.presheaf.stalk x.val) (X.presheaf.stalk x.val)),
        D z = 1 ∧ D d.parameter = v.val ∧
        KaehlerDifferential.map k k (X.presheaf.stalk x.val) X.functionField
          (S.val • KaehlerDifferential.D k (X.presheaf.stalk x.val) d.parameter) = sigma ∧
        dvrResidueValue d S.val =
          (dvrResidueValue d y.val * dvrResidueValue d v.val)⁻¹ := by
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI := actual_smooth_curve_closed_point_dvr sX x
  intro d z y sigma hregular hnonvanishing hcoordinate
  obtain ⟨omega, hmap⟩ := (mem_schemeLocalRegularDifferentials_iff sX x.val sigma).mp hregular
  obtain ⟨S, hS, homega⟩ := actual_smooth_curve_original_nonvanishing_unit_slope
    (p := p) sX x d omega (hnonvanishing omega hmap)
  rcases hS with ⟨S, rfl⟩
  obtain ⟨e, he⟩ := actual_smooth_curve_original_parameter_differential_frame (p := p) sX x d
  have hmapS : KaehlerDifferential.map k k (X.presheaf.stalk x.val) X.functionField
      (S.val • KaehlerDifferential.D k (X.presheaf.stalk x.val) d.parameter) = sigma := by
    rw [← homega]
    exact hmap
  have hlocal : (y⁻¹ : (X.presheaf.stalk x.val)ˣ).val •
      KaehlerDifferential.D k (X.presheaf.stalk x.val) z =
      S.val • KaehlerDifferential.D k (X.presheaf.stalk x.val) d.parameter := by
    apply actual_smooth_stalk_differential_map_injective sX 1 x.val
    rw [hmapS, map_smul, KaehlerDifferential.map_D,
      ← IsScalarTower.algebraMap_smul X.functionField]
    exact hcoordinate.symm
  obtain ⟨D, hDz, v, hDt, hSv⟩ :=
    original_uniformizer_coordinate_derivative d.parameter z e he y S hlocal
  exact ⟨S, v, D, hDz, hDt, hmapS,
    original_coordinate_differential_residue_ratio d y v S hSv⟩

end Litt3.QuotientGeometry
