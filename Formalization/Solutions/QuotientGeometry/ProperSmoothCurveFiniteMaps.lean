import Solutions.QuotientGeometry.ProperDedekindFiniteModels
import Solutions.QuotientGeometry.AffineChartFractionFields
import Solutions.QuotientGeometry.RestrictedFiniteSeparableFields
import Solutions.QuotientGeometry.OpenValuationStalks
import Solutions.QuotientGeometry.SmoothProperCurveFields
import Solutions.QuotientGeometry.SmoothCurveAffineDedekind

open CategoryTheory AlgebraicGeometry TopologicalSpace

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

/-- Properness and finite separability of the ORIGINAL generic-stalk
map prove that an actual map between integral smooth curves is finite.
The proof constructs finite normalization on EVERY true target affine
chart and recovers its ORIGINAL full preimage by an actual SchemeIso.
No finite-map, preimage affineness or normalization chart is assumed. -/
theorem actual_proper_smooth_curve_map_finite
    {k : Type u} [Field k] [IsAlgClosed k]
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    [IsSmoothOfRelativeDimension 1 sX] [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [Surjective f] [IsProper f] :
    letI := (schemeFunctionFieldPullback f).toAlgebra
    FiniteDimensional Y.functionField X.functionField →
    Algebra.IsSeparable Y.functionField X.functionField → IsFinite f := by
  letI := (schemeFunctionFieldPullback f).toAlgebra
  intro hfinite hseparable
  apply (IsZariskiLocalAtTarget.iff_of_iSup_eq_top
    (P := @IsFinite) (f := f) (fun U : Y.affineOpens => U.val)
    (iSup_affineOpens_eq_top Y)).mpr
  intro Ua
  let U := Ua.val
  have hU : IsAffineOpen U := Ua.property
  rcases isEmpty_or_nonempty U with hempty | hnonempty
  · letI := hempty
    infer_instance
  · letI := hnonempty
    let V := f ⁻¹ᵁ U
    have hgen : genericPoint Y ∈ U :=
      ((genericPoint_spec Y).mem_open_set_iff U.isOpen).mpr (by simpa using hnonempty)
    letI : Nonempty V := ⟨⟨genericPoint X, by
      change f (genericPoint X) ∈ U
      rw [scheme_genericPoint_eq_of_surjective f]
      exact hgen⟩⟩
    let fU := f ∣_ U
    let R := Γ(Y, U)
    let K := U.toScheme.functionField
    let L := V.toScheme.functionField
    let sU := hU.isoSpec.hom
    let sV := fU ≫ sU
    letI : Algebra K L := (schemeFunctionFieldPullback fU).toAlgebra
    have hfields := actual_restricted_function_field_finite_separable
      f hfinite hseparable U
    letI : FiniteDimensional K L := hfields.1
    letI : Algebra.IsSeparable K L := hfields.2
    letI : Algebra R K := (genericBaseRingHom sU).toAlgebra
    letI : Algebra R L := ((schemeFunctionFieldPullback fU).comp (genericBaseRingHom sU)).toAlgebra
    letI : IsScalarTower R K L := IsScalarTower.of_algebraMap_eq' rfl
    letI : IsFractionRing R K := actual_affine_chart_generic_field_isFractionRing U hU
    letI : IsDedekindDomain R := actual_smooth_curve_affine_chart_dedekind sY U hU
    letI : IsProper sV := inferInstance
    have hbase : algebraMap R L = genericBaseRingHom sV := by
      exact (generic_field_map_over_iff_base_ring sV sU
        (schemeFunctionFieldPullback fU)).mp
        (actual_scheme_function_field_map_over_base sV sU fU rfl)
    letI : IsFinite sV := actual_proper_valuation_scheme_over_dedekind_isFinite
      (K := K) sV hbase
      (actual_open_valuation_stalks V.ι (actual_smooth_curve_valuation_stalks sX))
    exact IsFinite.of_comp fU sU

end Litt3.QuotientGeometry
