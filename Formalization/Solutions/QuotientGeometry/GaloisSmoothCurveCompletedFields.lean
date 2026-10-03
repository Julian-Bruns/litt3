import Solutions.QuotientGeometry.FiniteSmoothChartNormalization
import Solutions.QuotientGeometry.SmoothCurveAffineDedekind
import Solutions.QuotientGeometry.AffineChartFixedBaseMaps
import Solutions.QuotientGeometry.GaloisNormalAffineFibers
import Solutions.QuotientGeometry.DVRCompletionParameterTransport
import Solutions.QuotientGeometry.DVRCompletedDiagramTransport
import Solutions.QuotientGeometry.SchemeFixedSameSourceSquare
import Solutions.SharedTensors.SmoothCurveCompletions

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

universe u

/-- EVERY pair of original closed points over the SAME original
closed base point of a genuine finite Galois morphism of integral
smooth curves has equivalent ENTIRE completed stalk fields over
the SAME entire original completed base field. All local rings,
coefficients, affine normalization identifications, Galois actions,
local equivalences, parameters and completed maps are constructed.
Neither projectivity nor a supplied affine model is needed. -/
theorem actual_galois_smooth_curve_completed_fields_equivalent
    {k : Type u} [Field k] [IsAlgClosed k]
    {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
    (sX : X ⟶ Spec (.of k)) (sY : Y ⟶ Spec (.of k))
    [IsSmoothOfRelativeDimension 1 sX] [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [IsFinite f] [Surjective f]
    (hover : f ≫ sY = sX)
    (b : Litt3.SharedTensors.ClosedPoint Y)
    (p q : Litt3.SharedTensors.ClosedPoint X)
    (hp : b.val = f p.val) (hq : b.val = f q.val) :
    letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
    FiniteDimensional Y.functionField X.functionField →
    IsGalois Y.functionField X.functionField →
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY b
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sX p
    letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sX q
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sY b.val).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX p.val).toAlgebra
    letI := (Litt3.SharedTensors.stalkBaseFieldHom sX q.val).toAlgebra
    let dB := Litt3.SharedTensors.actualSmoothCurveCompletionParameters sY b
    let dP := Litt3.SharedTensors.actualSmoothCurveCompletionParameters sX p
    let dQ := Litt3.SharedTensors.actualSmoothCurveCompletionParameters sX q
    let χP := actualSchemeFixedBaseStalkMap f sX sY hover b.val p.val hp
    let χQ := actualSchemeFixedBaseStalkMap f sX sY hover b.val q.val hq
    ParameterFieldsEquivalent
      (completedDVRLaurentMap dB dP χP
        (actual_integral_fixed_base_scheme_stalk_injective f sX sY hover b.val p.val hp))
      (completedDVRLaurentMap dB dQ χQ
        (actual_integral_fixed_base_scheme_stalk_injective f sX sY hover b.val q.val hq)) := by
  letI := (Litt3.SharedTensors.schemeFunctionFieldPullback f).toAlgebra
  intro hfinite hgalois
  letI := hfinite
  letI := hgalois
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sY b
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sX p
  letI := Litt3.SharedTensors.actual_smooth_curve_closed_point_dvr sX q
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sY b.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX p.val).toAlgebra
  letI := (Litt3.SharedTensors.stalkBaseFieldHom sX q.val).toAlgebra
  let dB := Litt3.SharedTensors.actualSmoothCurveCompletionParameters sY b
  let dP := Litt3.SharedTensors.actualSmoothCurveCompletionParameters sX p
  let dQ := Litt3.SharedTensors.actualSmoothCurveCompletionParameters sX q
  let χP := actualSchemeFixedBaseStalkMap f sX sY hover b.val p.val hp
  let χQ := actualSchemeFixedBaseStalkMap f sX sY hover b.val q.val hq
  obtain ⟨U, hU, hbU, _⟩ := Litt3.SharedTensors.actual_smooth_point_chart sY 1 b.val
  let bU : U := ⟨b.val, hbU⟩
  let pV : f ⁻¹ᵁ U := ⟨p.val, by change f p.val ∈ U; rw [← hp]; exact hbU⟩
  let qV : f ⁻¹ᵁ U := ⟨q.val, by change f q.val ∈ U; rw [← hq]; exact hbU⟩
  letI : Nonempty U := ⟨bU⟩
  letI : Nonempty (f ⁻¹ᵁ U) := ⟨pV⟩
  let hV := hU.preimage f
  let A := Γ(Y, U)
  let R := Γ(X, f ⁻¹ᵁ U)
  letI : Algebra k A := (chartBaseFieldHom sY U).toAlgebra
  letI : Algebra k R := (chartBaseFieldHom sX (f ⁻¹ᵁ U)).toAlgebra
  letI : Algebra A R := (f.app U).hom.toAlgebra
  letI : IsScalarTower k A R := IsScalarTower.of_algebraMap_eq'
    (actual_affine_chart_pullback_coefficient_square f sX sY hover U).symm
  letI : Algebra A X.functionField :=
    ((Litt3.SharedTensors.schemeFunctionFieldPullback f).comp
      (algebraMap A Y.functionField)).toAlgebra
  letI : IsScalarTower A Y.functionField X.functionField :=
    IsScalarTower.of_algebraMap_eq' rfl
  letI : IsScalarTower A R X.functionField :=
    actual_function_field_chart_scalar_tower f U
  letI : IsFractionRing A Y.functionField :=
    functionField_isFractionRing_of_isAffineOpen Y U hU
  letI : IsFractionRing R X.functionField :=
    functionField_isFractionRing_of_isAffineOpen X (f ⁻¹ᵁ U) hV
  letI : IsIntegrallyClosed A := actual_smooth_curve_affine_chart_isIntegrallyClosed sY U hU
  letI : IsIntegrallyClosed R := actual_smooth_curve_affine_chart_isIntegrallyClosed sX (f ⁻¹ᵁ U) hV
  letI : Algebra.IsIntegral A R := actual_finite_map_affine_chart_integral f U hU
  let J := (hU.primeIdealOf bU).asIdeal
  let P := (hV.primeIdealOf pV).asIdeal
  let Q := (hV.primeIdealOf qV).asIdeal
  let eJ := actualAffineChartStalkCoefficientAlgEquiv sY U hU bU
  let eP := actualAffineChartStalkCoefficientAlgEquiv sX (f ⁻¹ᵁ U) hV pV
  let eQ := actualAffineChartStalkCoefficientAlgEquiv sX (f ⁻¹ᵁ U) hV qV
  letI : IsDiscreteValuationRing (Localization.AtPrime J) :=
    IsDiscreteValuationRing.RingEquivClass.isDiscreteValuationRing eJ
  letI : IsDiscreteValuationRing (Localization.AtPrime P) :=
    IsDiscreteValuationRing.RingEquivClass.isDiscreteValuationRing eP
  letI : IsDiscreteValuationRing (Localization.AtPrime Q) :=
    IsDiscreteValuationRing.RingEquivClass.isDiscreteValuationRing eQ
  let dJL := actualDVRCompletionParametersTransport dB eJ
  let dPL := actualDVRCompletionParametersTransport dP eP
  let dQL := actualDVRCompletionParametersTransport dQ eQ
  have hJP : J = P.comap (algebraMap A R) :=
    actual_affine_chart_fixed_prime_comap f U hU hV bU pV hp
  have hJQ : J = Q.comap (algebraMap A R) :=
    actual_affine_chart_fixed_prime_comap f U hU hV bU qV hq
  let θP := actualAffineChartFixedLocalizedBaseMap f sX sY hover U hU hV bU pV hp
  let θQ := actualAffineChartFixedLocalizedBaseMap f sX sY hover U hU hV bU qV hq
  have hi : Function.Injective (algebraMap A R) := by
    intro a c hac
    apply (Y.germToFunctionField_injective U)
    apply (Litt3.SharedTensors.schemeFunctionFieldPullback f).injective
    have hc := actual_function_field_pullback_chart f U
    exact (RingHom.congr_fun hc a).trans
      ((congrArg (algebraMap R X.functionField) hac).trans (RingHom.congr_fun hc c).symm)
  have hiP : Function.Injective θP := localizedCoefficientBaseMap_injective hi J P hJP
  have hiQ : Function.Injective θQ := localizedCoefficientBaseMap_injective hi J Q hJQ
  obtain ⟨e, _⟩ := actual_normal_affine_galois_fiber_local_equivalences
    (K := Y.functionField) (L := X.functionField) J P Q hJP hJQ
  have hfields := dvr_base_equiv_completed_fields dJL dPL dQL θP θQ hiP hiQ
    (e.restrictScalars k) (localized_equiv_coefficient_base_maps J P Q hJP hJQ e)
  exact actual_dvr_completed_field_comparison_transport dB dJL dP dQ dPL dQL
    χP χQ θP θQ
    (actual_integral_fixed_base_scheme_stalk_injective f sX sY hover b.val p.val hp)
    (actual_integral_fixed_base_scheme_stalk_injective f sX sY hover b.val q.val hq)
    hiP hiQ eJ eP eQ
    (actual_affine_chart_fixed_stalk_map_localization f sX sY hover U hU hV bU pV hp)
    (actual_affine_chart_fixed_stalk_map_localization f sX sY hover U hU hV bU qV hq)
    hfields

end Litt3.QuotientGeometry
