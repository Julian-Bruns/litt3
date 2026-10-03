import Solutions.QuotientGeometry.OriginalCoordinateDifferentialRatio
import Solutions.SharedTensors.SchemeRegularDifferentials

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

/-- Rational-coordinate differentiation is normalized in the genuine
function field. Although y and F_z may each have a zero or pole, their
product is the image of the inverse ORIGINAL unit slope of sigma/dF. -/
theorem rational_coordinate_differential_product
    {k R K : Type*} [Field k] [CommRing R] [Field K]
    [Algebra k R] [Algebra k K] [Algebra R K] [IsScalarTower k R K]
    (t : R) (z y : K) (hy : y ≠ 0) (S : Rˣ)
    (eK : KaehlerDifferential k K ≃ₗ[K] K)
    (heK : eK (KaehlerDifferential.D k K (algebraMap R K t)) = 1)
    (hcoordinate : y⁻¹ • KaehlerDifferential.D k K z =
      algebraMap R K S.val • KaehlerDifferential.D k K (algebraMap R K t)) :
    ∃ D : Derivation k K K, D z = 1 ∧
      algebraMap R K (S⁻¹ : Rˣ).val = y * D (algebraMap R K t) := by
  let yU : Kˣ := Units.mk0 y hy
  let SU : Kˣ := Units.map (algebraMap R K) S
  have he : ∀ r : K, eK.symm r =
      r • KaehlerDifferential.D k K (algebraMap R K t) := by
    intro r
    apply eK.injective
    simp [heK]
  have hcoord : (yU⁻¹ : Kˣ).val • KaehlerDifferential.D k K z =
      SU.val • KaehlerDifferential.D k K (algebraMap R K t) := by
    simpa [yU, SU, Units.val_inv_eq_inv_val] using hcoordinate
  obtain ⟨D, hDz, v, hDt, hSv⟩ :=
    original_uniformizer_coordinate_derivative
      (algebraMap R K t) z eK.symm he yU SU hcoord
  refine ⟨D, hDz, ?_⟩
  have hu : SU = (yU * v)⁻¹ := Units.ext hSv
  have hprod : (SU⁻¹ : Kˣ).val = y * D (algebraMap R K t) := by
    rw [hDt]
    change (SU⁻¹ : Kˣ).val = (yU * v).val
    rw [hu]
    simp
  simpa [SU] using hprod

/-- The dz/y expression is allowed at a Weierstrass point. It is only
the PRODUCT y F_z which is shown to lie in the original stalk and have
a nonzero residue; no residue of either rational factor is presumed. -/
theorem actual_smooth_curve_rational_coordinate_differential_product
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
      (z y : X.functionField) (sigma : KaehlerDifferential k X.functionField),
      y ≠ 0 → sigma ∈ schemeLocalRegularDifferentials sX x.val →
      (∀ omega : KaehlerDifferential k (X.presheaf.stalk x.val),
        KaehlerDifferential.map k k (X.presheaf.stalk x.val) X.functionField omega = sigma →
        omega ∉ IsLocalRing.maximalIdeal (X.presheaf.stalk x.val) •
          (⊤ : Submodule (X.presheaf.stalk x.val)
            (KaehlerDifferential k (X.presheaf.stalk x.val)))) →
      sigma = y⁻¹ • KaehlerDifferential.D k X.functionField z →
      ∃ (S W : (X.presheaf.stalk x.val)ˣ)
        (D : Derivation k X.functionField X.functionField),
        D z = 1 ∧
        algebraMap (X.presheaf.stalk x.val) X.functionField W.val =
          y * D (algebraMap (X.presheaf.stalk x.val) X.functionField d.parameter) ∧
        KaehlerDifferential.map k k (X.presheaf.stalk x.val) X.functionField
          (S.val • KaehlerDifferential.D k (X.presheaf.stalk x.val) d.parameter) = sigma ∧
        dvrResidueValue d S.val = (dvrResidueValue d W.val)⁻¹ := by
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI := actual_smooth_curve_closed_point_dvr sX x
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  letI : IsSmooth sX := IsSmoothOfRelativeDimension.isSmooth 1 sX
  intro d z y sigma hy hregular hnonvanishing hcoordinate
  obtain ⟨omega, hmap⟩ := (mem_schemeLocalRegularDifferentials_iff sX x.val sigma).mp hregular
  obtain ⟨S, hS, homega⟩ := actual_smooth_curve_original_nonvanishing_unit_slope
    (p := p) sX x d omega (hnonvanishing omega hmap)
  rcases hS with ⟨S, rfl⟩
  have hmapS : KaehlerDifferential.map k k (X.presheaf.stalk x.val) X.functionField
      (S.val • KaehlerDifferential.D k (X.presheaf.stalk x.val) d.parameter) = sigma := by
    rw [← homega]
    exact hmap
  have hcoord : y⁻¹ • KaehlerDifferential.D k X.functionField z =
      algebraMap (X.presheaf.stalk x.val) X.functionField S.val •
        KaehlerDifferential.D k X.functionField
          (algebraMap (X.presheaf.stalk x.val) X.functionField d.parameter) := by
    rw [← hcoordinate, ← hmapS, map_smul, KaehlerDifferential.map_D,
      ← IsScalarTower.algebraMap_smul X.functionField]
  have hfg := actual_locally_finite_type_function_field_finitely_generated sX
  have htrdeg := actual_smooth_function_field_transcendence_degree sX 1
  obtain ⟨eK, heK⟩ := original_dvr_parameter_field_coordinate_exists
    (p := p) (K := X.functionField) d hfg htrdeg
  obtain ⟨D, hDz, hproduct⟩ := rational_coordinate_differential_product
    d.parameter z y hy S eK heK hcoord
  refine ⟨S, S⁻¹, D, hDz, hproduct, hmapS, ?_⟩
  have hratio := original_coordinate_differential_residue_ratio d 1 S⁻¹ S (by simp)
  simpa using hratio

end Litt3.QuotientGeometry
